Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E3E20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVbqwHAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfARIz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:55:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36388 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfARIz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:55:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so14038870wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 00:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkDeWLdFRl+qyR8IG37QUbUZvFW/2Qmd3D1a9YdELGc=;
        b=BVbqwHAB1nGXfnBl4WAbQuCkxHT1NCFpoIiJ3ujwaNRJaHL60PyNjC6r7xWj/L66KV
         ZdEdW1R0aW6yFtmjr2L/VBH2Vi9tpcVh6MX0vvGwql1A+v1vunbtg7EC4wuatt4la3Lu
         /zWQ2bXMdgEblHAxT6v5LsCWBzWuEwXq2jRpl1lficOtNWtX9C3kiZOmupnBNT4anGa4
         cshrmRxjzOYqZZNfLVTLW3Bqy5zpKHFEMr4O/r7fi7LHO9Nh/T3vKFQLMqNvwLdBXtQE
         aVM3oZS9Iq28igJiwdZRNfDTHlGn6M2kknrNSPnr49+MaBf52pJtsINFfA8F7Z5ZSO54
         ihVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkDeWLdFRl+qyR8IG37QUbUZvFW/2Qmd3D1a9YdELGc=;
        b=Lh4Z9r1W+kdW+E4r0vItB8uF3+tzmGlmOZuYKp0r/JI7vP0xGIGbKHlgg2ck6JBGe1
         YRD6BGmlGDuetUeArcDANc0ntGqbU8xR+vTrRbks4fPJ0MVIVVhKYbv+4MNEWjiDbLTh
         AE7NXD2A74wwHAfrwbhtgncd59d9vks6fSCj3iGR4/9BlHf+mJcKD4dIwdvJjPZfhYFP
         n4Ff5Zw/Zu19Q452bDIR9FjxcmRxSKur22ZSfJ98is1QVDNhkW0J7V+zKQVUwo13pMuV
         IxXqWUF2y4+9mguTy5/E/kQQwWn2CV/wgg/YKqGpDk9kbhCjiKaVpB1IOd87dpv8H3Hb
         4HCg==
X-Gm-Message-State: AJcUukfiBM7vRiRs7vbPnCA3rRVn+kA2VTU36zkZUDjMt7tBMWAolVn+
        FarLaeNQe+OQ6mFHtVsht9DBfMpu
X-Google-Smtp-Source: ALg8bN5wnAdLjbHKA23RgKUJQdKi9aaByfcbM4DOsjZ39CGOc0FRaTtt4y/YyR4N66xWGiG1ElC7CQ==
X-Received: by 2002:adf:e1c3:: with SMTP id l3mr15730081wri.36.1547801724300;
        Fri, 18 Jan 2019 00:55:24 -0800 (PST)
Received: from nbbrfq.loc (85-127-81-11.dsl.dynamic.surfer.at. [85.127.81.11])
        by smtp.gmail.com with ESMTPSA id z7sm75938909wrw.22.2019.01.18.00.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 00:55:24 -0800 (PST)
Date:   Fri, 18 Jan 2019 09:54:56 +0100
From:   Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Subject: Re: [PATCH 1/2] checkstack.pl: Add blackfin support
Message-ID: <20190118095456.3f04b0cb@nbbrfq.loc>
In-Reply-To: <CAMuHMdVzqEhw0KTbToUkxiuovoaxoW_mw2hF_uh0qcXYf+POsQ@mail.gmail.com>
References: <20190117215836.26137-1-rep.dot.nop@gmail.com>
        <CAMuHMdVzqEhw0KTbToUkxiuovoaxoW_mw2hF_uh0qcXYf+POsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 08:54:15 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> A similar patch was merged in commit 1e9535a591cf003e ("Add stack
> checking for Blackfin").
> 
> In the mean time, blackfin support was removed from Linux in commit
> 4ba66a9760722ccb ("arch: remove blackfin port"), and from checkstack in
> commit e53a05a49e10c7cf ("scripts/checkstack.pl: remove blackfin support").
> 
> Nevertheless, I can imagine it's nice to have it, as I have used
> checkstack for non-Linux projects, too ;-)

Yea, so i'm retracting the patch, maybe you can revert e53a05a instead.
Please consider taking the 2/2 typo fix though.

thanks,
