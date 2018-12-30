Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E72C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 13:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C496B2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 13:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeL3NWb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 08:22:31 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21831 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeL3NWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 08:22:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546176130; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=ExfAx4AfDzj5tXRCSpUpHkWlVLa1CrHTbtjfqrCyb965PcVUsed8oc7i9rZlGAah4OuntVeLIQzxHnNbQGTbrFZGl2qR68nagQ6jrgfIMmhsTmeb49MGpBp/ki+bWmdAKISjqeyqBkx0arB8IRUhjhkmDaVMOV5f2YDVs8rjQ0I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546176130; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=HXYVyPcZrO+JQcSuZpw61sSUN5OkfPcHJQ/xVYI4xvY=; 
        b=F/CIyPbSWlXYNDZ5MuEppIDcqG0yOy6inDxTuSQ0H2asvLoTdc9re3UMR4agTVxpvzCIJXAkz04mP7rECFDOJTj1BvDsYOqNx8C6VVyakvhPgCc6FIFeFZhE5awIf8pK/XxWfhyTkz0WkFUe6LJdJKJO3apBOkiIIgUfz1cdMX4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (151.217.223.1 [151.217.223.1]) by mx.zohomail.com
        with SMTPS id 1546176127465454.5605577829708; Sun, 30 Dec 2018 05:22:07 -0800 (PST)
Message-ID: <912668ea1d74f526f78f03f562fdaf17fc06f62c.camel@mniewoehner.de>
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <1546140837.4069.81.camel@linux.ibm.com>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
         <1545519232.3940.115.camel@linux.ibm.com>
         <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
         <b75fd04643daf5aab5a1fc115e8fbfca9a381f8d.camel@mniewoehner.de>
         <1546140837.4069.81.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 30 Dec 2018 14:22:02 +0100
Mime-Version: 1.0
User-Agent: Evolution 3.30.3 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-29 at 22:33 -0500, Mimi Zohar wrote:
> On Tue, 2018-12-25 at 14:55 +0100, Michael Niewöhner wrote:
> > On Sun, 2018-12-23 at 12:55 +0100, Michael Niewöhner wrote:
> > > Hi Mimi,
> > > 
> > > On Sat, 2018-12-22 at 17:53 -0500, Mimi Zohar wrote:
> > > > On Sat, 2018-12-22 at 14:47 +0100, Michael Niewöhner wrote:
> > > > 
> > > > > When I remove the timeout and boot directly to the linux kernel, I get
> > > > > that
> > > > > "2314 TPM-self test error" since it has not finished, yet. The TPM is
> > > > > detected
> > > > > by IMA and works fine then.
> > > > > 
> > > > > Some more tests showed that any delay before booting the kernel causes
> > > > > the
> > > > > TPM
> > > > > to not get detected. I tested, 10, 15, 20, 30, 60... seconds. Only in
> > > > > some
> > > > > very
> > > > > rare cases the TPM got detected.
> > > > > 
> > > > > I wanted to know if the TPM is in an well initialized state at the
> > > > > time of
> > > > > that
> > > > > error. Since I was not able to get some test/debug kernel patches
> > > > > working
> > > > > I
> > > > > decided to try kexec. It turned out that the TPM is indeed correctly
> > > > > working
> > > > > and
> > > > > will be detected just fine by linux after kexec!
> > > > 
> > > > No surprise here.  kexec would be the equivalent of a soft reboot.
> > > 
> > > Well, I am not that deep in kexec internals but isn't a soft reboot much
> > > more
> > > than a kexec? I thought kexec would "just" load the new kernel to memory
> > > and
> > > executes it while a soft reboot goes at least through some UEFI
> > > initialization.
> > > For example, my pwm fans - in fact the EC - get resetted on a soft reboot,
> > > while
> > > a kexec does not touch them.
> > > 
> 
> Similarly, the PCRs are not reset on kexec.
> 
> > > That is why I wanted to test if there is a different behaviour on kexec
> > > compared
> > > to a "real" soft reboot. If there was such difference I would have assumed
> > > a
> > > UEFI bug that does not initialize the TPM correctly.
> > > Kexec AFAIK does not invoke any UEFI initialization, so the TPM should be
> > > in
> > > the
> > > same state as before kexec and since there is no difference between sr and
> > > kexec
> > > I have the feeling there is something wrong in the kernel.
> > > 
> > > Correct me if I am wrong here, please.
> 
> But the problem you've described is on a cold boot, not a soft reboot.
>  Both the soft reboot and kexec are working properly.  It seems the

Exactly, soft reboot / warm boot works.
What I don't understand is WHY it works. If it was a hardware problem I would
expect it not to work after it previously failed after a cold boot but that is
not the case. The warm reboot / kexec does reinitialize anything.
That means maybe it would be sufficient to reinitialize that - whatever it is -
to get the TPM working instead of needing a full warm reboot.

> difference is that on a cold boot, the TPM takes longer to initialize.

Well, as I said. Waiting for 10, 20 or even 60 seconds in the boot manager does
not solve the problem. So the problem is NOT that the TPM takes longer to
initialize. Even adding a delay of 20 seconds before TPM init does not solve
that while that should be more than enough time.

> 
> > > My current workaround is to do a machine_emergency_reboot() when TPM isn't
> > > detected correctly. That is a pretty hard workaround but it seems to work
> > > for
> > > now...
> 
> This is a again soft reboot.
> 
> >  
> > > > > Is there anyone having an idea what could be wrong here? I am willing
> > > > > to
> > > > > debug
> > > > > this but I have really no idea where to start :-(
> > > > 
> > > > A while ago, I was "playing" with a pi.  Commenting out
> > > > tpm2_do_selftest() seemed to resolve a similar problem, but that was
> > > > before James' patches.  I don't know if that would make a difference
> > > > now.
> > > 
> > > Hm, I will try that..
> > > 
> > 
> > Unfortunately this did not change anything
> 
> Not much I can do now.  After vacation, I'll set up the pi to see if
> it is working properly with a recent kernel.
> 
> Mimi
> 


