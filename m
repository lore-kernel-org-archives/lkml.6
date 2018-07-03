Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A030FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3DE24DE5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyEZ7OMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3DE24DE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeGCH5m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:57:42 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41065 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbeGCH5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:57:41 -0400
Received: by mail-wr0-f195.google.com with SMTP id h10-v6so900267wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3qzVUFGiCjX7Ln378T+vanPYWZn5eLUBmoWZ0/SMvbg=;
        b=JyEZ7OMv6Z0O5t0UyYDt4RfKKZJ736ZWI+CRlTr9v6wR8TEmzTehEZYoHNDGG2ikqL
         U9qSCeNdjrVkyAvuj4CtQD7kYEyQnQB1+X515chvIPCeCjNVCry8X8if+cylJ6ImGLmX
         ePUQJhA+R805mZDUupVlHEkfHRwngW3UZIaxYS/sR4EK0TwDYBxJ3koztXc9o7MivkRs
         sc4o1n1VijMlwrrnBkHaBSy+nF0pQoMFZOESWZKyGQG5aannZLVjeCEmS9xrUQz/sQWk
         yOe0zZMAHWJNfs/wYMOXAmU3y/R0ueUaYPyvVj5urbnLWe5MZKRLBiv9xZvGwGnxBbCZ
         PuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qzVUFGiCjX7Ln378T+vanPYWZn5eLUBmoWZ0/SMvbg=;
        b=NS6GI2pYNbJAW2KR8RBZLKTYVodUVOdhXrhNeGUO4Ke/rDGPwcgcENhnGlnSJQbtWn
         Qrif0uVcavXtgAz7U2g/UmYPpxxDInMQQI3YKFlwEJEp8wzvtZvwdfu8o6bjj9Ta8LLo
         HuL7Xi+ZSXddtTZ3sUubsBQgHGCSIXA0pBPYVkrtHJAdzQ2exwgjzgNEl8ql6IgWnEQx
         rhXhqnf3eazNOTN6V2DMQYH+QBwDA18VuK1pxdmxb9bOY5N0SL5jtClaMtZC7a9lV0MP
         e6IrBLFHalo9sME4h0bojQgvQJhnPobM/TnJ2ha1u7cKcFoc1nKY/SREFzoU7vCCMB1x
         zo7g==
X-Gm-Message-State: APt69E219Lraia0X0rhST4PZArob1Q5RDMCftlUQD3upDKJaCIZbjgXO
        u1YuN4YURbKjfrqCCkh4jz0=
X-Google-Smtp-Source: AAOMgpekG9ETmzRk0V21DR38y/Pwhy0PQpyKS6P21PDGCuwTVpwse9yRREe5NKVxK0gB9aeEl2tLDg==
X-Received: by 2002:adf:a907:: with SMTP id u7-v6mr10040331wrc.175.1530604660173;
        Tue, 03 Jul 2018 00:57:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t124-v6sm864539wmt.29.2018.07.03.00.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:57:39 -0700 (PDT)
Date:   Tue, 3 Jul 2018 09:57:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 0/2] x86/build/vdso: a little more Makefile cleanups
Message-ID: <20180703075737.GA18934@gmail.com>
References: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com>
 <2251685.NraJYuIFmt@blindfold>
 <20180703073533.GA6573@gmail.com>
 <5699106.FCe4rGpKHi@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5699106.FCe4rGpKHi@blindfold>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Richard Weinberger <richard@nod.at> wrote:

> Am Dienstag, 3. Juli 2018, 09:35:33 CEST schrieb Ingo Molnar:
> > 
> > * Richard Weinberger <richard@nod.at> wrote:
> > 
> > > Masahiro,
> > > 
> > > Am Dienstag, 3. Juli 2018, 03:50:12 CEST schrieb Masahiro Yamada:
> > > > 
> > > > At first, I sent the first patch to UML ML,
> > > > but they did not pick it up.
> > > > Instead, I was able to get Acked-by from Richard,
> > > > one of the UML maintainers.
> > > > 
> > > > https://patchwork.kernel.org/patch/10399787/
> > > > 
> > > > I am resending it to x86 ML.
> > > 
> > > Uhh, I thought you want to carry this via your tree?
> > > I don't mind picking up these patches.
> > 
> > I already picked them up, as one of them affects the x86 tree.
> > 
> > Is that OK?
> 
> Perfectly fine with me.

Thanks! Timing for upstream merge would be v4.18.

	Ingo
