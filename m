Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CA4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648D9204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vd5pxNTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648D9204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbeGKLSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:18:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35185 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732387AbeGKLSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:18:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so8527823wrt.2;
        Wed, 11 Jul 2018 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=drWDT5TTutYlMF3G7ae7Mxg2LUnWBK25kpWy1q6si1E=;
        b=vd5pxNTxVu0Hz69DC05oBwcDXVc/zR4Eaane84r7fu5mTYwwoW8l3xjgYpzTPZ7PV5
         ZWJ2+VCVtNL1iHnD5Bvn3P/ms8pSbRSXKpvF9WNF8skCnBnEG0wj/ignZ1b2EsjLYEgK
         dWt+JGTmJKqn0TFH4LnqnNHB8paI7TehH51Sj0VbbNjvoMLe3YcTFtxKDuwXbANMljMg
         2X74gZq+VwJDmR7He/hvO1uqVL8DVVujO43nRwSaeUsZ/V3vwzg3JbAHqGM57sm4WRe7
         P6NQXS26zOKlKSK7JPAyIvuIsLoMALCnFvc7OnSMPGmgg8zGfzFlJPTPSjdRNWCiZTy2
         UgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=drWDT5TTutYlMF3G7ae7Mxg2LUnWBK25kpWy1q6si1E=;
        b=RkgJWaSarR/CVuSaYz+QgbsuipTfAxd2L0lKDzV9wS7HV8cQlkGuIzgwGLeVSX8kiI
         +cr3HUHYSNNha026SVks+KfpDkTCBiiX6UZ5SGwQ0CwaKc7i2To4RE4Lmhon2ncfIY5Q
         8V8OatB6AhfDzoLn9RjNWvVWeHxCznIzsn9rR1uYVgY0xZ46yc+Y01uZrq6UM1atfhOR
         IruV2hM9vxrXVAZBCs+iem0Vuyc2ohVIgkYEqILxuaJIogQNedq6NDYKnb8EHkT5dh5y
         EVN15794VSb3+mD73Zfo2kE1D/7JAdT6ABIxZe565+SoXicewoF/oERIrMb+7X01zYgP
         uPZA==
X-Gm-Message-State: APt69E33rJ7lCOXrO1oGjlBdH5qBsEbKeAt5DryyBu7YHhu9qpkrUnKh
        fkJps6eHXA6zRqTi80nE6Qc=
X-Google-Smtp-Source: AAOMgpfUqx+bz3TGhCpj5nfMwcPkkRf0VW1i13VgnEBFoNneaeeIyN95EacEw/iUj6FB9IF9w42pKw==
X-Received: by 2002:adf:9485:: with SMTP id 5-v6mr21933944wrr.82.1531307670553;
        Wed, 11 Jul 2018 04:14:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h12-v6sm17510419wmb.3.2018.07.11.04.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 04:14:29 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:14:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
Subject: Re: [GIT PULL 0/1] EFI mixed mode fix for v4.18
Message-ID: <20180711111427.GA27216@gmail.com>
References: <20180711090235.9327-1-ard.biesheuvel@linaro.org>
 <20180711101303.GA8574@gmail.com>
 <CAKv+Gu8m4UgL0GyYDuu5z+dzEF=N--H4PkqoO_xqwyW2_A+RMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8m4UgL0GyYDuu5z+dzEF=N--H4PkqoO_xqwyW2_A+RMA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 11 July 2018 at 12:13, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> >> The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:
> >>
> >>   Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent
> >>
> >> for you to fetch changes up to d7f2e972e702d329fe11d6956df99dfc31211c25:
> >>
> >>   efi/x86: remove pointless call to PciIo->Attributes() (2018-07-11 10:52:46 +0200)
> >>
> >> ----------------------------------------------------------------
> >> A single fix for the x86 PCI I/O protocol handling code that got
> >> broken for mixed mode (64-bit Linux/x86 on 32-bit UEFI) after a
> >> fix was applied in -rc2 to fix it for ordinary 64-bit Linux/x86.
> >
> > Just curious, because it's unclear from the changelog, what was the symptom, a
> > boot hang, instant reboot, or some other misbehavior?
> 
> Hans reported that his mixed mode tablet would not boot at all any
> more, but enter a reboot loop without any logs printed by the kernel.
> 
> > Also, what's the scope of
> > the fix: were all 64-bit on 32-bit UEFI mixed-mode bootups affected, or only a
> > certain subset?
> >
> 
> Any mixed mode system with PCI is likely to be affected. I have added
> a QEMU mixed mode config to my boot test environment to catch errors
> like this one.

Ok, I've added this information to the commit - will be useful to backporters,
to judge the severity of the bug fixed.

> The unfortunate thing here is that this uncovered a fundamental issue with mixed 
> mode, i.e., that any UEFI protocol prototype involving 64-bit by-value 
> parameters needs to be special cased in the stub code, which is rather tedious. 
> There is one other call that is potentially affected, a file open call in the 
> initrd handling code, but that specific occurrence happens to work unmodified. 
> This patch removes the other one. Going forward, we will have to carefully 
> review UEFI protocol invocations for mixed mode compatibility.

Yeah. Is there any, more systematic way to detect such problems perhaps at an 
earlier stage, other than careful review which will often fail to find such bugs? 
Also, testing is good, but could we perhaps do something on a deeper level - 
automate the casting, generate a warning on suspicious patterns, etc. etc?

Thanks,

	Ingo
