Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D96C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 13:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6740E217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 13:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbeLYN4V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 08:56:21 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21845 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLYN4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 08:56:20 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1545746157; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=nKqmsHNfwyYraCiCTFtpcRTockHn6MVVPY/BJnPfaWD2MhKxWizSk/gkgUe57AcHK1g6VabwAxsGUQX0QOX6c6vRKSFR89EzYZCZFgwclSxIqrBMT50E9QskbI/x8FTDOuPofVznL/vW362gyabVNaqbLFSdgx0wqujonCzRCAY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1545746157; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=BHZxkZn39lfr0uiMyMcRx+xa4q6jSOXxgtbTlGfgLtQ=; 
        b=DUbsWH2CuloLwen9Tf578lkrMwVKC79tMttn5TGL6cf3/LKnxonPZQimvnZ+fxMOuoI7ifQ9kOmE0KeqryJAD1ZdezEROoyfBSytGAznrFuQkMtcd7L+hBCizktqUNE5O8Hfn+ftLocLpjraMJ8A8mb0S6Fr5VKlZCbsCoc0U+0=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (p57A4C604.dip0.t-ipconnect.de [87.164.198.4]) by mx.zohomail.com
        with SMTPS id 1545746155346509.0447963905999; Tue, 25 Dec 2018 05:55:55 -0800 (PST)
Message-ID: <b75fd04643daf5aab5a1fc115e8fbfca9a381f8d.camel@mniewoehner.de>
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
In-Reply-To: <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
         <1545519232.3940.115.camel@linux.ibm.com>
         <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 25 Dec 2018 14:55:49 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-23 at 12:55 +0100, Michael Niewöhner wrote:
> Hi Mimi,
> 
> On Sat, 2018-12-22 at 17:53 -0500, Mimi Zohar wrote:
> > On Sat, 2018-12-22 at 14:47 +0100, Michael Niewöhner wrote:
> > 
> > > When I remove the timeout and boot directly to the linux kernel, I get
> > > that
> > > "2314 TPM-self test error" since it has not finished, yet. The TPM is
> > > detected
> > > by IMA and works fine then.
> > > 
> > > Some more tests showed that any delay before booting the kernel causes the
> > > TPM
> > > to not get detected. I tested, 10, 15, 20, 30, 60... seconds. Only in some
> > > very
> > > rare cases the TPM got detected.
> > > 
> > > I wanted to know if the TPM is in an well initialized state at the time of
> > > that
> > > error. Since I was not able to get some test/debug kernel patches working
> > > I
> > > decided to try kexec. It turned out that the TPM is indeed correctly
> > > working
> > > and
> > > will be detected just fine by linux after kexec!
> > 
> > No surprise here.  kexec would be the equivalent of a soft reboot.
> 
> Well, I am not that deep in kexec internals but isn't a soft reboot much more
> than a kexec? I thought kexec would "just" load the new kernel to memory and
> executes it while a soft reboot goes at least through some UEFI
> initialization.
> For example, my pwm fans - in fact the EC - get resetted on a soft reboot,
> while
> a kexec does not touch them.
> 
> That is why I wanted to test if there is a different behaviour on kexec
> compared
> to a "real" soft reboot. If there was such difference I would have assumed a
> UEFI bug that does not initialize the TPM correctly.
> Kexec AFAIK does not invoke any UEFI initialization, so the TPM should be in
> the
> same state as before kexec and since there is no difference between sr and
> kexec
> I have the feeling there is something wrong in the kernel.
> 
> Correct me if I am wrong here, please.
> 
> My current workaround is to do a machine_emergency_reboot() when TPM isn't
> detected correctly. That is a pretty hard workaround but it seems to work for
> now...
> 
> > 
> > > 
> > > Is there anyone having an idea what could be wrong here? I am willing to
> > > debug
> > > this but I have really no idea where to start :-(
> > 
> > A while ago, I was "playing" with a pi.  Commenting out
> > tpm2_do_selftest() seemed to resolve a similar problem, but that was
> > before James' patches.  I don't know if that would make a difference
> > now.
> 
> Hm, I will try that..
> 

Unfortunately this did not change anything

> 
> > Mimi
> > 
> 
> There is another issue but I don't know if both are related. Maybe that's just
> a
> timing issue...
> 
> root@debian:~# dd if=/dev/hwrng bs=1 count=1
> dd: error reading '/dev/hwrng': Operation not permitted
> 0+0 records in
> 0+0 records out
> 0 bytes copied, 0.755958 s, 0.0 kB/s
> root@debian:~# dd if=/dev/hwrng bs=1 count=1 | xxd; dd if=/dev/hwrng bs=1
> count=1 | xxd
> dd: error reading '/dev/hwrng': Operation not permitted
> 0+0 records in
> 0+0 records out
> 0 bytes copied, 0.755697 s, 0.0 kB/s
> 1+0 records in
> 1+0 records out
> 00000000: 52                                       R
> 1 byte copied, 0.0106268 s, 0.1 kB/s
> 
> 
> Michael


