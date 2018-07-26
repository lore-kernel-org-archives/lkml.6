Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABB2C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D1D2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugw3bIPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D1D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbeGZUYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:24:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34896 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbeGZUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:24:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so3095149wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQCaP3SBgSLbe/fE8Y0CHUTYPGZeqcJVXgXZwq9O6L0=;
        b=Ugw3bIPzh5EELTA1dDVeAwgmrvZaV4JG2kHNUkNAncVldKFznk8vIFaHnB/YlJOJxu
         im7jLzJ6gZ1LOftJPS8jSuB09aHAAAFp+WW82s4yhZ54ExEwtpELcRlVOJDEAKaJUUtf
         ln+gDofN855G8Uk/2MDcF+wJzYhb4kYviDhSfSfaFBSvrJd/fHf/zGftnX1Fx/2vTLba
         7Ha8a7gs/iLGWOV8P0ufMhLTPTUsl90h07uA05VQCPuWhd7BmM13LwhrwBIDENhjpcGJ
         FqoKl2z06odfudXBKgEoIqpaMAgF8fAvPiI/30JXsbpAvBaA6fprl+IYf1O9X1Vstzc0
         6aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQCaP3SBgSLbe/fE8Y0CHUTYPGZeqcJVXgXZwq9O6L0=;
        b=A96pDagnabnEzVNi0slHin7YWeTSrUubwbUwHDCbLRjDmbwZ/Tia5hfFt67jlcKmLM
         luywsc+mi89jWScfcNgM2BXlvKynE98QYwTi4qqTvQOZhKsufcdv4AJKujpQtq5Jh57g
         GzgHwQ+DQBMmQN8+D3182BKpGXPum3KFRSTlilu1XRQqBcl/JwPha0iWyMft/0BhNbVG
         c2TzerhslMHIi1pSEpdLMnbvr//o9Qj6CzEC4hVZ0/1BYD+44g+iwnjZf2w7QUv4OpZu
         8H+n6kpC1f9AfQYABBoxLbUQguskP0l25hcKvmRfGe5FabbxOW7O+yNwgAyvMH7MWsEx
         M3Pg==
X-Gm-Message-State: AOUpUlEZMQdAV4vLc4K1jl75WQg9LJAQC0EkXy4jODDYpDdNT4msramz
        YhQbnpt1W92v88vab/ty+MA=
X-Google-Smtp-Source: AAOMgpfEMkYWJAD8Sqm2rjDmrnKjHOdjxhOmsjky/2GR5FW8Tdlg6FJoT4IT3J2YOqx83APuCXkQqg==
X-Received: by 2002:a1c:ec86:: with SMTP id h6-v6mr2355387wmi.53.1532631996197;
        Thu, 26 Jul 2018 12:06:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j9-v6sm4671917wrv.5.2018.07.26.12.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 12:06:35 -0700 (PDT)
Date:   Thu, 26 Jul 2018 21:06:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Jan Beulich <JBeulich@suse.com>, mingo@elte.hu,
        rdunlap@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64: use 32-bit XOR to zero registers
Message-ID: <20180726190633.GA25081@gmail.com>
References: <5B30C32902000078001CD6D5@prv1-mh.provo.novell.com>
 <a68a703f-5d74-a2eb-4b26-0fe3e6e48705@infradead.org>
 <5B31DDFF02000078001CDC03@prv1-mh.provo.novell.com>
 <20180626113822.ch3erlyud5wsxvvg@khazad-dum.debian.net>
 <20180726091916.GA23471@amd>
 <20180726114537.GA12408@gmail.com>
 <20180726181750.GA4404@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726181750.GA4404@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> On Thu 2018-07-26 13:45:37, Ingo Molnar wrote:
> > 
> > * Pavel Machek <pavel@ucw.cz> wrote:
> > 
> > > On Tue 2018-06-26 08:38:22, Henrique de Moraes Holschuh wrote:
> > > > On Tue, 26 Jun 2018, Jan Beulich wrote:
> > > > > >>> On 25.06.18 at 18:33, <rdunlap@infradead.org> wrote:
> > > > > > On 06/25/2018 03:25 AM, Jan Beulich wrote:
> > > > > >> Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms - use
> > > > > >> 32-bit ones instead.
> > > > > > 
> > > > > > Hmph.  Is that considered a bug (errata)?
> > > > > 
> > > > > No.
> > > > > 
> > > > > > URL/references?
> > > > > 
> > > > > Intel's Optimization Reference Manual says so (in rev 040 this is in section
> > > > > 16.2.2.5 "Zeroing Idioms" as a subsection of the Goldmont/Silvermont
> > > > > descriptions).
> > > > > 
> > > > > > Are these changes really only zeroing the lower 32 bits of the register?
> > > > > > and that's all that the code cares about?
> > > > > 
> > > > > No - like all operations targeting a 32-bit register, the result is zero
> > > > > extended to the entire 64-bit destination register.
> > > > 
> > > > Missing information that would have been helpful in the commit message:
> > > > 
> > > > When the processor can recognize something as a zeroing idiom, it
> > > > optimizes that operation on the front-end.  Only 32-bit XOR r,r is
> > > > documented as a zeroing idiom according to the Intel optimization
> > > > manual.  While a few Intel processors recognize the 64-bit version of
> > > > XOR r,r as a zeroing idiom, many won't.
> > > > 
> > > > Note that the 32-bit operation extends to the high part of the 64-bit
> > > > register, so it will zero the entire 64-bit register.  The 32-bit
> > > > instruction is also one byte shorter.
> > > 
> > > Actually, I believe that should be comment in code.
> > 
> > Agreed - mind sending a patch that adds it?
> 
> Ok. Would /* write to low 32 bits clears high 32 bits, too */ be
> reasonable comment?

So I'd suggest putting the above description somewhere strategic - such as the top 
of entry_64.S, or calling.h, or so?

Thanks,

	Ingo
