Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F28C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 17:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BE721888
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 17:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FuO2kYq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BE721888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeHETwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 15:52:50 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55608 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbeHETwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 15:52:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3DC7A8EE251;
        Sun,  5 Aug 2018 10:47:29 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9FvHIjfEqOLU; Sun,  5 Aug 2018 10:47:29 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1769F8EE0C7;
        Sun,  5 Aug 2018 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533491248;
        bh=w7pgO9ema1R8uKWcJYWQI8uKqMSkMzMRe7+2SDs01dY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FuO2kYq3TG/cDHKxKvpUr5YUqRWJ4SoFJ/i7i17trSfh8jk4BnhKnrEUFiGGxl+Sc
         R4LMi5ttb9KQkRXbk02dAbdAN8Ye5UJewogDtO7QEBAyC6Vp1EmCLM649AXq/lIuTj
         nVr3XVWQXGRraigtKMA3bryYVSqSCy+uwmuJAjYQ=
Message-ID: <1533491246.4087.1.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/6][RFC] Add EFI secure key to key retention service
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Sun, 05 Aug 2018 10:47:26 -0700
In-Reply-To: <CAKv+Gu81vEGNggcWv1NyPJsMeK0HRi_DanH2+Z_4metoNG=txA@mail.gmail.com>
References: <20180805032119.20485-1-jlee@suse.com>
         <CAKv+Gu81vEGNggcWv1NyPJsMeK0HRi_DanH2+Z_4metoNG=txA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-08-05 at 09:25 +0200, Ard Biesheuvel wrote:
> Hello Chun,yi,
> 
> On 5 August 2018 at 05:21, Lee, Chun-Yi <joeyli.kernel@gmail.com>
> wrote:
> > When secure boot is enabled, only signed EFI binary can access
> > EFI boot service variable before ExitBootService. Which means that
> > the EFI boot service variable is secure.
> > 
> 
> No it, isn't, and this is a very dangerous assumption to make.
> 
> 'Secure' means different things to different people. 'Secure boot' is
> a misnomer, since it is too vague: it should be called 'authenticated
> boot', and the catch is that authentication using public-key crypto
> does not involve secrets at all.

Hang on, let's not throw the baby out with the bathwater here.

The design of "secure boot" is to create a boot time environment where
only trusted code may execute.  We rely on this trust guarantee when we
pivot from the EFI to the MoK root of trust in shim.

The reason we in Linux trust this guarantee is that it pertains to the
boot environment only, so any violation would allow Windows boot to be
compromised as well and we trust Microsoft's Business interests in
securing windows far enough to think this would be dealt with very
severely and it's an outcome the ODMs (who also add secure boot keys)
are worried enough about to be very careful.

The rub (and this is where I'm agreeing with Ard) is that any use case
we come up with where a violation wouldn't cause a problem in windows
is a use case where we cannot rely on the guarantee because Microsoft
no longer has a strong business interest in policing it.  This, for
instance, is why we don't populate the Linux trusted keyrings with the
secure boot keys (we may trust them in the boot environment where
compromise would be shared with windows but we can't trust them in the
Linux OS environment where it wouldn't).  So this means we have to be
very careful coming up with uses for secure boot that aren't strictly
rooted in the guarantee as enforced by the business interests of
Microsoft and the ODMs.

>  The UEFI variable store was not designed with confidentiality in
> mind, and assuming [given the reputation of EFI on the implementation
> side] that you can use it to keep secrets is rather unwise imho.

Agree completely here: Microsoft doesn't use UEFI variables for
confidentiality, so we shouldn't either.  If you want confidentiality,
use a TPM (like Microsoft does for the bitlocker key).

James

