Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E8C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B8724171
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMHDeo3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B8724171
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeGEHMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:12:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38448 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752742AbeGEHMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:12:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id j33-v6so621784wrj.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 00:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=duIgFwZaHcCW2vkouk5QveosIX+2DpZMLkcrrDRZ/xc=;
        b=iMHDeo3QE4XwNi1ICq1weo0CnE7PTx98eVXgFqEYgcQD8DmWsEt/skQ9YatZW2edWe
         bU6pgOFUgQop+TTEdm0fJIL8qVFAQ0w86SxrAfvXBk7AVtl4mlN6KBf9HZm3bvQG5pIr
         1OO7+smTxkaBZxaIeY/08oQE1LU7UG1h8jwagXzd0JVyIjTM/M3OS0wXkwAs12a2PEIJ
         PyWGFk1Vc/W5jYOB3LQxZIByQyFG97llopAh/BuUw/mGSrqAzSqrMIEkXwZomn97qOQT
         rooI2OMvpx/CyCbVYxZwTwy55u3nHRM7vxGLP3nM3ojaazbwAlUwP+pRbo5Pnr9nGDt+
         kx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=duIgFwZaHcCW2vkouk5QveosIX+2DpZMLkcrrDRZ/xc=;
        b=G4PaVgePPk/lz2YXnntVYQsKgjlRqnh6CC+3s844TwOgfgW1h5GtZ8WGmkT6/6Q69C
         Z20dLFCU85GdXJ8o5SON1ZxfcooFgLFQrQsmLWbrXkOYxJWa6HAq/BmGJ0j17nHhA5nW
         bJslGM2lj7Z3WvT6WGU54095KYWFTFmzGInPL+sYJQFWYbnG6H2Nzrg/Fz6UfdtYq6e5
         rKiVwRocQHJK3+wi42bnXKXKVFaZdd+txk1JF2SQivWEVTudn0M9wuhRnnNRVBTZ7a+c
         NH3IuyhtR5C5NPiCzGFXfWrkE+gVtUxCXJ7mI0BLQrd9qfpbg0kGQltS87zlCAkLenaW
         5AMA==
X-Gm-Message-State: APt69E0cWh4D/O7JzGCDoY7FeCZ6bjlMpsXb9uDUNTFtiYTKrB+QMO21
        UwXwrX6ZDg0IuCYt+CS0VcI=
X-Google-Smtp-Source: AAOMgpfzQRb9il7y4BrWwfyPEPjYDKgRclQyh2JkGIBYxXkSSSWJmLNQZFMo5fIxmd9hkX6WVa7nSQ==
X-Received: by 2002:adf:e887:: with SMTP id d7-v6mr3743391wrm.43.1530774738924;
        Thu, 05 Jul 2018 00:12:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h2-v6sm6758804wmd.0.2018.07.05.00.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 00:12:18 -0700 (PDT)
Date:   Thu, 5 Jul 2018 09:12:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jan Beulich <JBeulich@suse.com>, mingo@elte.hu, tglx@linutronix.de,
        hpa@zytor.com, davem@davemloft.net, herbert@gondor.apana.org.au,
        rjw@rjwysocki.net, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, Alok Kataria <akataria@vmware.com>
Subject: Re: [PATCH v2] x86-64: use 32-bit XOR to zero registers
Message-ID: <20180705071215.GA29659@gmail.com>
References: <5B39FF1A02000078001CFB54@prv1-mh.provo.novell.com>
 <20180704202934.GB15246@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704202934.GB15246@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> On Mon 2018-07-02 04:31:54, Jan Beulich wrote:
> > Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms. Zeroing
> > idioms don't require execution bandwidth, as they're being taken care
> > of in the frontend (through register renaming). Use 32-bit XORs instead.
> > 
> > Signed-off-by: Jan Beulich <jbeulich@suse.com>
> 
> > @@ -702,7 +702,7 @@ _no_extra_mask_1_\@:
> >  
> >  	# GHASH computation for the last <16 Byte block
> >  	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
> > -	xor	%rax,%rax
> > +	xor	%eax, %eax
> >  
> >  	mov	%rax, PBlockLen(%arg2)
> >  	jmp	_dec_done_\@
> 
> This is rather subtle... and looks like a bug. To zero 64-bit
> register, you zero its lower half, relying on implicit zeroing of the
> upper half. Wow.
> 
> Perhaps we should get comments in the code? Because the explicit code
> is more readable...

The automatic zero-extension of 32-bit ops to the full 64-bit register is a basic, 
fundamental and well-known x86-64 idiom in use in literally hundreds of places in 
x86-64 assembly code.

We sometimes document zero-extension on entry boundaries where we want to make it 
really clear what information gets (and what doesn't get) into the kernel, but 
generally it only needs documentation is the (very rare) cases where it's *not* 
done.

Also, why would it be a bug?

Thanks,

	Ingo
