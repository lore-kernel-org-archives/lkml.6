Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3607EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92FE218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMudvtII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBKWFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:05:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37599 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfBKWFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:05:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so214469plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=r6d4Iq9ZUdFc3NnIATpKPSjP46QbD6fBw5BoX8ZKlj4=;
        b=SMudvtIIQZ2Qjf6A07EdIekS09Zz49tEvLEVj8Mp6+9XPQ+LRq6CtgkisQpNWKVn95
         Qnud8+l30hgiFqlVnp3ItCdPnuoV4VhoumGfpGxY4wtnclGfFx2MguWDI/O10GWVV7lX
         GZhrTf4XNngRHjnEwjlXnBul/nzn4IX4h5bWtkBtDwlSEH2wG5ejY1+J60lge46YXqz7
         As3lNpHaJFFS7fFjwHrpDQEBc9GZREsY/804z6q2lacooGXN9yVbxqGFm3igMnsuQ2W5
         W3xmFMbUvgInNA/kUGo1/eadq/RcWQf+Mb0Pk1VzT6lCCc4nxLhX5VpW+6nbJRBgHIGr
         l5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=r6d4Iq9ZUdFc3NnIATpKPSjP46QbD6fBw5BoX8ZKlj4=;
        b=sxSZE7AzAmbIYWkg0OG4FWS05jMl3Xiqq/605+veBuP7gPlPsi7hgsXCJaQRpA1Y91
         NVU8Tbzp5wYq9fcrdnd3XuRiRS68H1iZJzVqHgc4hxlZVCSkdRZoJvZ6pJkZfuBTYiyW
         IjMvptKDtAEinZi8bwfi0zZAkW3ZKlpSW1kcc0faG/xCozFolTM/sjMgS5CwFzPfv1Sj
         R1MCmTcco6S9LAHy673jTZE94DYhCn2xM6LXfhuZ/Kihn9sFKUBOXYMYuMamym3qkPHK
         sw/edekjenM2w8UJ92uGqaNgzbxyT548yCfLdN9Dj+PsM3Luf/t2v1qssXgBA6B43ZpS
         Go5A==
X-Gm-Message-State: AHQUAuZNfxzT3hVAw1e7yWWoEDJORX7GMXubUKZzVlbf3KJ1OXaLpBgl
        a7fZbvAM4hFwkfMyTxMMG4+u+w==
X-Google-Smtp-Source: AHgI3IY6AjfibVCuaERGdyQt8cPCcy3Jn1o+yMfVdWNVIhIMqQBt5rK2GYdelC+meQ8+Xacm/ocOkA==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr470925plb.55.1549922734389;
        Mon, 11 Feb 2019 14:05:34 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 64sm4006159pfl.83.2019.02.11.14.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:05:33 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:05:33 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Qian Cai <cai@lca.pw>
cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, labbott@fedoraproject.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: remove an unused addr argument
In-Reply-To: <20190211123214.35592-1-cai@lca.pw>
Message-ID: <alpine.DEB.2.21.1902111405210.177387@chino.kir.corp.google.com>
References: <20190211123214.35592-1-cai@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Qian Cai wrote:

> "addr" function argument is not used in alloc_consistency_checks() at
> all, so remove it.
> 
> Fixes: becfda68abca ("slub: convert SLAB_DEBUG_FREE to SLAB_CONSISTENCY_CHECKS")
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: David Rientjes <rientjes@google.com>
