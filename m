Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AB2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49662208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZTale4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49662208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeFTI0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:26:17 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37982 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeFTI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:26:11 -0400
Received: by mail-ot0-f196.google.com with SMTP id p95-v6so2796556ota.5;
        Wed, 20 Jun 2018 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0tmXDAvqEHd/K8D09JFY4XHt7kQ44aitaf5QyvXW4Jc=;
        b=IZTale4eIywmyear8bV/inX2Sr4Vbyp+Wdihox2BfLuTOd/DIozWA+IsAn7A20qMuV
         Srj/drZlQ74YQsYEJTPV+9nvvOjVx+aNAaW2xTPxkvj0KEdUh6u86pX3T+PMd18c2Khd
         NAQLplvB3OQHG3EsjUgny6i1Cet1TJuKkFx85Oc8mc9iO2xuAKyHW3i0nkjgKyCcnqV4
         hurLWVTZTVi/4JOrDaGZsQf5o2EZ5stN5am9IZdV8GGng++3VSsDwsZMNFMTg+DOlbKU
         FpFnVS9yo77ZhCa2QYYx2kBsHmJhLTu1UkgJU4vMhBByuv0fNXHHavDrBBYzNsJL9na5
         vQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0tmXDAvqEHd/K8D09JFY4XHt7kQ44aitaf5QyvXW4Jc=;
        b=uIn/esRg1xtFWtMXVAWFnoc71hzIrI1OXX0WLo+grsYZv1I4J3pPJiKa/0FhqOGKVs
         UGFqH/iS63Wxa+m/6IInw173Re76tb7zGmUZ3gIHFSAeoR6NtCGi6T/gsTC+K0j+a5P1
         owof2d/IlE1Zxdi2SeBM1joI7HwfDSTODOemoNiQtl9Pqu1HTXqtvkOFSd1w5ml4DWac
         zy065fHIlJRsvZpyuHp994OYB9JWcFJOexLy0Y/h2b5WQWmNybq2oHfaAYf+5h1yUv5J
         mVMIVNgiQqX5mycH+PBmue4XYEfZyUkWJJ0GxPDljywYww5K1PN5f5RunU4RLTyEBtZQ
         1v5Q==
X-Gm-Message-State: APt69E1BgxWzE5GyroXNxuM+v6nzDxRd2EFTvL8hbAAvT52XMLf/ovTy
        /yHmBWK08GDMjRBEU1hgY5/y3JYvVIRpQa1scHmthg==
X-Google-Smtp-Source: ADUXVKL8PUGpsGZgRKNz5X0gb12tfK4wix0R45Yz1447Unff3/jmitH90HkgFgYm5RObuJJ80TXzO8uxuZ5O0q4p4Ug=
X-Received: by 2002:a9d:60d2:: with SMTP id b18-v6mr11621548otk.305.1529479720749;
 Wed, 20 Jun 2018 00:28:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 00:28:40
 -0700 (PDT)
In-Reply-To: <s5hy3fac6ao.wl-tiwai@suse.de>
References: <s5h8t7bfgnq.wl-tiwai@suse.de> <CAJZ5v0hidPav5kvTW05e0k5mouFyiUiyUW50=fDqVphbEBjQaA@mail.gmail.com>
 <s5hpo0ndvc5.wl-tiwai@suse.de> <s5hy3fac6ao.wl-tiwai@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Jun 2018 09:28:40 +0200
X-Google-Sender-Auth: z_miDO2213oCDToV3vp7SJP39Bo
Message-ID: <CAJZ5v0gWRfbtKG0w1UiM=KbtZYkhL2kj-W_9Q+PUP293sX35_Q@mail.gmail.com>
Subject: Re: [REGRESSION] 4.17 failed to probe ACPI PnP
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Noah Davis <noahadvs@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 8:37 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 19 Jun 2018 10:38:50 +0200,
> Takashi Iwai wrote:
>>
>> On Tue, 19 Jun 2018 10:28:42 +0200,
>> Rafael J. Wysocki wrote:
>> >
>> > On Tue, Jun 19, 2018 at 8:12 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > > Hi,
>> > >
>> > > there seems a regression regarding the probe of ACPI PnP devices.
>> > > The detailed logs are found in openSUSE bugzilla:
>> > >   https://bugzilla.opensuse.org/show_bug.cgi?id=1098074
>> >
>> > But that's on this particular machine, not in general, right?
>> >
>> > At least I don't see this on any of the systems in my office.
>>
>> Yes, it looks so.  4.17 and later works on my several machines, too.
>>
>> >
>> > > In short, since 4.17, the laptop keyboard is lost on ASUS K501UW.
>> > > Comparing the kernel messages and other logs indicates that the
>> > > complete lost of ACPI PnP devices:
>> > >
>> > > On 4.16:
>> > > [    0.390244] pnp: PnP ACPI: found 9 devices
>> > >
>> > > On 4.17:
>> > > [    0.263266] pnp: PnP ACPI: found 0 devices
>> > >
>> > > ... and this leads to the failure of PS/2 keyboard detection due to
>> > > the missing PNP030b entry as a result.
>> > >
>> > > Any hints for debugging this are appreciated.
>> >
>> > It looks like this may be related to the ACPICA changes that went in
>> > during the 4.17 cycle.
>> >
>> > I would try 4.18-rc1 as there is an ACPICA fix in it that may be
>> > related to this in theory.  If that doesn't help, I'd focus on the
>> > ACPICA changes.
>>
>> OK, Noah, could you test later the kernel in OBS Kernel:HEAD repo?
>> Now 4.18-rc1 kernel is being built there, and hopefully will finish
>> soon later.
>
> 4.18-rc1 was confirmed to work, so something had fixed it.

Please check this commit

5088814a6e93 ACPICA: AML parser: attempt to continue loading table after error

None of the other ACPICA commits that have gone in since 4.17 should
affect the behavior at hand.

> Also, the symptom appears not only on a single machine but on another
> (ASUS?) machine, according to the bug report.

OK

Thanks,
Rafael
