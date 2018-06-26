Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B392C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA39224940
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7s1Z9qJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA39224940
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeFZGti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:49:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41621 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeFZGtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:49:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so15951492wrq.8;
        Mon, 25 Jun 2018 23:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8BUtu2CN80g81knJE6Ebusy5tFXC3/NCEIOM92toX3k=;
        b=h7s1Z9qJ7EieINKMxVITcs9QrxPAlGFXQI6e1R621Zq973Kd2ZniD/VEYXWgN8cuE9
         qzSIOAwIvH3hRaVUurAsg12K2f86vBDM8rZeuURNQPS1T+cqwW48RrcK4QoVeD5gJVFh
         sGmNG2YgsMPS3jo/Q4ebGlNbOKS9ROB9jte2vzTLQ8ZUURGt7eyAJqNXeadciZ7TDv7h
         504cGT1NZexpU4B2041gz8BnLjMSMwo1guNBXW59S7B2a52vQ57Pewx6qbSVdayrk2oh
         osPON3Zon9wnSb7gD4ZRbDhoVAZ1h9GkOgX9uwbvOt9k6Y6t6PQjiTnySB0XjbzFc5VT
         b5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8BUtu2CN80g81knJE6Ebusy5tFXC3/NCEIOM92toX3k=;
        b=cWpIcctrMRXIaGZ/z0WVc6KfBGo+u+bad4PYdDr6QL8GzgATtOEsULSEiwLXmBZBMR
         ATxSXyaOnoufqugMIpAWLkOlnfpOx68qaNreE1jV7XcxN36hzO1G8Gufmnv/ttiANCt6
         rqoeSjjHl9MiIFtAEqkynNxlUM4/7EedCv2uO1hMucV4QLkpCguWOhfdPly/dX9qlEIY
         0ahjUaCWBUaWWOILDcUmoNKazvObDPwGUJ4jnwstarntI/wJ9MAiWlXuMt3uFkhpmnQZ
         oWvczarl/aL1y5Ivu4BxyQQXquDjO6qDxhdmI72UANkOwKJhJRczpn8giGuMNGkM6zyD
         dW6g==
X-Gm-Message-State: APt69E22qwdzemQ5PUnnnBmK2tMBbYtlxHbFXqbmhaQWKyhnokHANsZe
        SNoMwHZQW8MiBjtdD8mlAps=
X-Google-Smtp-Source: AAOMgpeZAKfPT9DM7MQE+W1ZEspnOisTr2qRKbuXDuAXX0yClIeluUCFASrMhCz/1nZUoMqapevYyQ==
X-Received: by 2002:adf:f482:: with SMTP id l2-v6mr251455wro.259.1529995773848;
        Mon, 25 Jun 2018 23:49:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z5-v6sm782567wrh.10.2018.06.25.23.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 23:49:33 -0700 (PDT)
Date:   Tue, 26 Jun 2018 08:49:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>, linux-crypto@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        tglx@linutronix.de, luto@kernel.org, peterz@infradead.org,
        brgerst@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/crypto: Add missing RETs
Message-ID: <20180626064930.GB25879@gmail.com>
References: <20180617120012.GB16877@zn.tnic>
 <1529242717.4472.3.camel@gmx.de>
 <1529244178.4674.1.camel@gmx.de>
 <20180617194747.GA21160@zn.tnic>
 <1529289279.31745.3.camel@gmx.de>
 <20180623103622.GA2760@zn.tnic>
 <20180624071105.GA29407@gmail.com>
 <20180624104449.GA20159@avx2>
 <20180625072438.GA19063@gmail.com>
 <20180625131932.sge43esxdb5ejoxg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625131932.sge43esxdb5ejoxg@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Mon, Jun 25, 2018 at 09:24:38AM +0200, Ingo Molnar wrote:
> > 
> > * Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > 
> > > On Sun, Jun 24, 2018 at 09:11:05AM +0200, Ingo Molnar wrote:
> > > > > Add explicit RETs to the tail calls of AEGIS and MORUS crypto algorithms
> > > > > otherwise they run into INT3 padding due to
> > > > > 
> > > > >   51bad67ffbce ("x86/asm: Pad assembly functions with INT3 instructions")
> > > > > 
> > > > > leading to spurious debug exceptions.
> > > > > 
> > > > > Mike Galbraith <efault@gmx.de> took care of all the remaining callsites.
> > > > 
> > > > Note that 51bad67ffbce has been zapped because it caused too many problems like 
> > > > this, but the explicit RETs make sense nevertheless.
> > > 
> > > So commit which found real bug(s) was zapped.
> > > 
> > > OK
> > 
> > No, what happened is that the commit was first moved into WIP.x86/debug showing 
> > its work-in-progress status, because it was incomplete and caused bugs:
> > 
> >    https://lore.kernel.org/lkml/20180518073644.GA8593@gmail.com/T/#u
> > 
> > ... and finally, after weeks of inaction I zapped it because I didn't see progress 
> > and you didn't answer my question.
> > 
> > If a fixed patch with updated tooling to detect these crashes before they occur on 
> > live systems is submitted we'll reconsider - it didn't get NAK-ed, it's just 
> > incomplete in the current form.
> 
> Hm, what happened to the objtool patch to detect these at build time?
> Did it not work?
> 
>   https://lore.kernel.org/lkml/20180517134934.eog2fgoby5azq5a7@treble

So that's still incomplete in that doesn't analyze the 32-bit build yet, right?

Thanks,

	Ingo
