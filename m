Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70210C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2466320671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUxnOqIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2466320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeGYU4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:56:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46802 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbeGYU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:56:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so5947091pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 12:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Rr0DGf258LtpsVligxZ3mbAGceSMKOhw9gr7Ekbzz6o=;
        b=WUxnOqImF5IuqKhi7lwDk2FGjpVzW3TULS4dToSIyZn358xW8fEBsGii/UkXFmp1jR
         al351D5dIdd7Fgzr7r5MSBvvmR98KroPjojWms2rqOLKjKSIIsMbBUvoLz8qRzcaaeFt
         keBwU1vDqEor/noqllou82uY1lA+UvgfxgKKeH8/Ck4UwCvdZPMEPcqhKC3Yfirlx+BM
         qNqW0G+BrCiKifPmbEJX8xA6XEwmGzffaIt38bfSDHDpeEMja+IJHu/pjPg9baNe9xNs
         c3oX218YD7+FcBwxZSq8PzZcobKcw2pjyzlhm2Zv8O6hF/f5tldDxkd4aVF35wDHPfGE
         gqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Rr0DGf258LtpsVligxZ3mbAGceSMKOhw9gr7Ekbzz6o=;
        b=mApmHglQpQlV2I2eTZiAyMrlEhkHKPiOcZ4w5zBuQeWfSPvFvLjT+276l2noojOiZh
         RRitotPKQcZiipJHV1fTI8BagunQvm+7h+wgw+RAPZ8iDg2q43/4NLKxUlehEoEeDRWN
         47LICoLiugu5aUFmiy2GS02xRS0bg2UJf3g7seIfwXtiPVJhW0L2JTU5WCENfD5a2mPd
         dTua2AEeU7fqzX3d9HJ7LfuafJH1wroC+8BoyPrL7QdwLlf7s3DYcEMtqYGt07tiLNaD
         3odlrv4Aqtgyu3l4LGWs8UqCNdIHP6PU1IIzAl9p+CSRy2pGTqYp+mcYmpv9HyTyd/og
         Xljg==
X-Gm-Message-State: AOUpUlHt1OKwnv9gABQoqoHGthXMmUYSkz8vhBXmnJRHVW/7qRihZlF+
        NMqK4e05GHGvWEVA1OR6dq+EsQ==
X-Google-Smtp-Source: AAOMgpdnnE5hfIrIQg7035BqxhgQx0HDZikO5IMIUsihqB8/z63aPQqlH4+ll9rR5M+Esd84BePkhw==
X-Received: by 2002:a62:b29c:: with SMTP id z28-v6mr23708075pfl.8.1532547779409;
        Wed, 25 Jul 2018 12:42:59 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 13-v6sm21481135pfw.131.2018.07.25.12.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 12:42:58 -0700 (PDT)
Date:   Wed, 25 Jul 2018 12:42:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Georgi Nikolov <gnikolov@icdsoft.com>
cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: cgroups iptables-restor: vmalloc: allocation failure
In-Reply-To: <a1a4eb7c-e85c-dc6d-cfac-6d40af302182@icdsoft.com>
Message-ID: <alpine.DEB.2.21.1807251241380.201050@chino.kir.corp.google.com>
References: <a1a4eb7c-e85c-dc6d-cfac-6d40af302182@icdsoft.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018, Georgi Nikolov wrote:

> Hello,
> 
> I posted a kernel bug https://bugzilla.kernel.org/show_bug.cgi?id=200651 and
> i hope this is the correct place to discuss this.
> 

Could you post the full allocation failure from the kernel log?  It's not 
possible to vmalloc any additional memory due to the memory pressure, so 
this is expected to fail but I'm curious as to the actual allocation that 
is triggering it.
