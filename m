Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50512086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50512086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbeKPVpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:45:15 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:55810 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727638AbeKPVpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:45:15 -0500
Received: from mr2.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id wAGBXG7X011281
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 06:33:16 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id wAGBXBiM015610
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 06:33:16 -0500
Received: by mail-qk1-f197.google.com with SMTP id n68so50156269qkn.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 03:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=KdCU9cR/6rrVpfR2iOMAxz+zNi1nTDl2D3H0I5Jmhqg=;
        b=hDtw5Ldl8ILcQQfYYkL349A/E8Iyi8gReuD5iU1aR3R5fy1kJ0Q+IQbEcuS34TeXOy
         GN0VyDQXpnhxATKTFf1yKUJkQ7KKBpMJcjiK9DqGO9z5XNXcPLqgevdbFKbwwuHoBP6F
         fI4tCVRDGQ1KVUukBu+mFdGGOniUxhZSPdR5pFGkeUpimlBwZ/if3g+O779CuIft30T3
         cel9XQYy7hQeKFQvdM/z034AHfaVwoaZF5JKc1p/RxRcqrVWxDAy8GrhUt2TpYvFWxt9
         qNZPMGhJfzLxHDjHUcVeifSrg+VKvJhmaUru5zg7gMgFuycgjsLpoF99A1f8k1LXLPDB
         +naQ==
X-Gm-Message-State: AGRZ1gJFvwfm3VOw0LyOswl52dLyhC+x2PklWoz+HbbaWOdBhNc547q5
        VB9uUdIHIE4dZMGeJ0W3XOAuOZKycjga0FeEttVkWWiRxITMEoBAxN0CQG0sdWE+mAYU/bsew5/
        pkqw7D46I2wwysnEcmOSJFVwkf6CwBI8e07c=
X-Received: by 2002:ac8:3038:: with SMTP id f53mr9542882qte.45.1542367991088;
        Fri, 16 Nov 2018 03:33:11 -0800 (PST)
X-Google-Smtp-Source: AJdET5dwSUSpCyg+xZhUVNM5md23lmJVGG88lRcsEhIjPIFgmTT5ZFIyAGXtJiEg6iquybUO7tD4CA==
X-Received: by 2002:ac8:3038:: with SMTP id f53mr9542862qte.45.1542367990750;
        Fri, 16 Nov 2018 03:33:10 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4340::be3])
        by smtp.gmail.com with ESMTPSA id 24sm29304864qkp.65.2018.11.16.03.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 03:33:09 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pintu Agarwal <pintu.ping@gmail.com>
cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        kernelnewbies@kernelnewbies.org,
        Jungseok Lee <jungseoklee85@gmail.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        mark.rutland@arm.com, Sungjinn Chung <barami97@gmail.com>
Subject: Re: [ARM64] Printing IRQ stack usage information
In-reply-to: <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com> <28496.1542300549@turing-police.cc.vt.edu>
 <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 16 Nov 2018 06:33:08 -0500
Message-ID: <49219.1542367988@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 11:44:36 +0530, Pintu Agarwal said:

> > If your question is "Did one
> > of the CPUs blow out its IRQ stack (or come close to doing so)?" there's better
> > approaches.
> >
> Yes, exactly, this is what the main intention.
> If you have any better idea about this approach, please refer me.
> It will be of great help.

Look at the code controlled by '#ifdef CONFIG_DEBUG_STACK_USAGE'
which does the same thing for process stacks, or CONFIG_SCHED_STACK_END_CHECK
or the use of guard pages for detecting stack overrun....
