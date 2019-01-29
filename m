Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2CCC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAFA217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFO/i6rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfA2BmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:42:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38934 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfA2BmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:42:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so15932919wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 17:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CgA3sRNVMXk7js4c/E/CVOZKEVaE8DANGoI5NS4jIsA=;
        b=PFO/i6rhgf+YNrmRAo/R4/wZcZPGj6tRLfu+GLooakQVPwy4w3hgE1wFIEOX3TUidu
         FDuZuRhUsqVyTdGt7/Sbog4uLx+au2Wc+ki1mv2g4elLshnxy4VunOiv1wZdKdmDEooj
         JOvh0JdwciQX49Q6T7hVZg6bYAK8Sh6VQ46xUoP9EuImPbiODZTOhm75d0956bAayfRZ
         kiY6mkHGWMbxymUPtEmdYUaCiTnTc6R/Ad8Yuy+WeYXZNTn9WVnn6rPKPKbjEeiC1ah0
         ICDZMIsGrJvVazGVIpyYvnx1jfv4Z14alRWHdurPDC80P5jlxJYuua66USDLCuGzzmM8
         WKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CgA3sRNVMXk7js4c/E/CVOZKEVaE8DANGoI5NS4jIsA=;
        b=tl5rgVsfaV/aGwRvTOPnueusf8aws23ac1P5mrMQLCoFargUnJHWEE8RmJQwPsSzfq
         k/0fcImvs7TmETKbCmRPaQ+SV+b1TTTfBBCzlWUt36hcabONDNZrwK1SPs37n8tJLPfo
         SWMc33BH3wQqBy7gpsmXPu7xCg/YxtgaPrB3EtJqbIFOwlKl3xpybAUJHZeHm5Kr5thd
         hoqEMVviDpDHx2oeVl0daYW79mU4lGmXtGnWX+uvU5BVRuQVFUpapvrOCY4Al9BiKBn8
         L+RY1OZC4Q3QHRrzMeqsr+JptJ55HaghZhkh7/JXTo03zY0kZDmg9aPwFEgit/RN+ClA
         Wasw==
X-Gm-Message-State: AJcUukf0Ht0JXDdEX6Rc1MxzQJ5//0NY91wTLKVmWA/xPJGi1wXFZxGR
        FwU8HihrbZ2Q/9n9IlU5oRAtEA==
X-Google-Smtp-Source: ALg8bN6BYzwni8B73SnaSoCgIxcAaI59FvHE+qVEYDBAH8vUdjEBNZ7mKcIu14vwd6BG6o617Hezqg==
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr20341571wmf.69.1548726123691;
        Mon, 28 Jan 2019 17:42:03 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h1sm1237956wmb.0.2019.01.28.17.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 17:42:02 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:41:59 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Miles Chen <miles.chen@mediatek.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] mm/slub: introduce SLAB_WARN_ON_ERROR
In-Reply-To: <1548313223-17114-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <alpine.DEB.2.21.1901281739230.216488@chino.kir.corp.google.com>
References: <1548313223-17114-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019, miles.chen@mediatek.com wrote:

> From: Miles Chen <miles.chen@mediatek.com>
> 
> When debugging slab errors in slub.c, sometimes we have to trigger
> a panic in order to get the coredump file. Add a debug option
> SLAB_WARN_ON_ERROR to toggle WARN_ON() when the option is set.
> 

Wouldn't it be better to enable/disable this for all slab caches instead 
of individual caches at runtime?  I'm not sure excluding some caches 
because you know they'll WARN and trigger panic_on_warn unnecessarily is 
valid since it could be enabled for that cache as well through this 
interface.
