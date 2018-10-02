Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C68C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E21205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAppgXql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E21205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJBRmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:42:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32940 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeJBRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:42:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id y140-v6so4608836wmd.0;
        Tue, 02 Oct 2018 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IxMoGMOopaKU4O2spWzG5Sda+wn+1DXaNBB5C1Kt5Y0=;
        b=gAppgXqlNKi9kGrMEi2Lz4nBjmKreN0RL+hvl9unMVtYvDHS5KGYU/ux5LDoqg8zE9
         D8whMPEY+70tVZmc6YOuycxJTz/xVBsBYoKJTJxYIpISwaFZaHR2oztN8Xe8PTc1vYb7
         8n4bWIsvzDL87jYRsA+Hz6gtERazvhbtjLUbBl7Fx6kXq8uepzYJmFftT1g5A9670yqG
         JSRPtQpKy+oPd5Rvl7L/bufMKkIClwEAmocKUYmzB5sPb81vlad9cbylpZJvS7bl5LPc
         TimknkzY8kS0KqZmFU7FrEfykLPcOe0E0gf8mWCq2ZBYM2GYNI30XRdtNuyqkR6BGdq1
         Pnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IxMoGMOopaKU4O2spWzG5Sda+wn+1DXaNBB5C1Kt5Y0=;
        b=cCiVpVIXMw9jE9k683kErC6Dmg1t2ijlz8ADZzyxYFvyl46OnV+N+bqbOboP+gWMIM
         0E0GlhJSgNQmMGngL7LGG4Sq+odl/SKLt0UhiYFlo7IsVCC63ushkTkto6kLbxJ6rY6U
         VcDJCxDicRlhGpencmt0SL+RLY71oIywZr58maUyF1CnLXsybavkO9qVKs4EXXIiMwip
         qcMwzoK5nAd+yInWyG+ahmcpThizPXbLKJ4387r0qnJvgWtonlCKQav9WWaERaBke2Jx
         tHVMgwRdEJcLzxsJmRfZfZ7jwMaxpITgw1jZQeKUWOCAlzhEVNTmyr3OqBP7/Dm6bn/b
         1tRQ==
X-Gm-Message-State: ABuFfohtdKWJJBLrMWIDNZanbUgGSg9KpeSSwRlkcSXMvwGbQW0NosMp
        kuiJK8MnBXmn7qZksDYi3AY=
X-Google-Smtp-Source: ACcGV61s2cTB/x4UDlv1Nwmbv9F+NymY/hG3Ow0GXTM+ysyanL43mPat9mSSHmonbmyKgdMY2XhQwA==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr1547198wmd.51.1538477995599;
        Tue, 02 Oct 2018 03:59:55 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z89-v6sm36806501wrb.3.2018.10.02.03.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 03:59:54 -0700 (PDT)
Date:   Tue, 2 Oct 2018 12:59:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v8 02/10] Makefile: Prepare for using macros for inline
 asm
Message-ID: <20181002105952.GA13611@gmail.com>
References: <20180918212847.199085-1-namit@vmware.com>
 <20180918212847.199085-3-namit@vmware.com>
 <1aa5a1f3-ef3d-5cd3-831c-2202d73d3c9e@rasmusvillemoes.dk>
 <307823F9-DCCF-4384-9FBE-28642FAD6B4E@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <307823F9-DCCF-4384-9FBE-28642FAD6B4E@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> at 1:58 AM, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
> > On 2018-09-18 23:28, Nadav Amit wrote:
> > 
> >> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> >> index 8f6e7eb8ae9f..944fa3bc9376 100644
> >> --- a/arch/x86/Makefile
> >> +++ b/arch/x86/Makefile
> >> @@ -214,8 +214,8 @@ ifdef CONFIG_X86_64
> >> KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
> >> endif
> >> 
> >> -# Speed up the build
> >> -KBUILD_CFLAGS += -pipe
> >> +# We cannot use -pipe flag since we give an additional .s file to the compiler
> >> +#KBUILD_CFLAGS += -pipe
> > 
> > Is this really necessary? The gas manual says that one can use -- to
> > name stdin, though that's probably a typo and should just be - . Doing
> > 
> > gcc -pipe -Wa,foo.s -Wa,-
> 
> Good idea. I didn’t think of it. Yes, this can do the trick. I’ll do it in
> v9.

Ok, will wait for v9.

Thanks,

	Ingo
