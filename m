Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD84CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744F42073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=secretlab-ca.20150623.gappssmtp.com header.i=@secretlab-ca.20150623.gappssmtp.com header.b="n04TrIix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744F42073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secretlab.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIEWcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:32:01 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41515 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIEWcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:32:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id t39-v6so9131054qtc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=secretlab-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82d7u6EIUkm3e8Al+ODyPM7ikSeXTKoy+eFfuvXToGE=;
        b=n04TrIixCYEhegktck3rz9lUjzPHgJJ8vLzw6Hw/5wmpZhOaff/qhvIVg92jT0SXDa
         c8b1/xjxG6A7GW32wCcw6xeFwJoETeO3P2cLKLDKLrsf5mooCAxEywhiJQpkFOJeVWo/
         dkGtVletFhad4Lq5+geMRyqmQkJQwyAZCDi94a93nl2ChCNjTPl3I39789mcn4+dtwQ3
         8Ly9tLifWKlyQ2+ZAFqYHPLgdphzvBW4a2KVTjpkvV8gOVRzsHnFMlszww5mX+OYrp7L
         QJRli3Qvb9cMjQJT7WeC6X5fKj5iqJG8mNc1Z6tDDZ9X4paMtlo5HB02drt2onj8kkGT
         d8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82d7u6EIUkm3e8Al+ODyPM7ikSeXTKoy+eFfuvXToGE=;
        b=PHHXKGnZb5DHFy80KFHh7oaJnc4NOvJKG1xV3AQULSdlup6Kk5xldeebLR8EXt1chc
         kUg8pUxOqWSB12gpViLPDDN5fnUqTbQIJyzI6TtEbJQi+imb1WXgQPos+0lH72i4Zfi/
         kHkxrl441edMlDTe90+wRTRhuBypiKSDRaKBl1pqlq9BI2s4LVlVHNH4c0n1NLUv0KSQ
         ina9p/j4c2VVgPkUxtLna2xWn9RWEDaeBFgDQSEdA066RELQD0pefBzMzlwwxJ2sY7wa
         HCqxpz2cD5IGo1C2S+rjJdWcq840lG+pnED6X8sewwk02KGpn5Hv+2eeP5TToVYpb2Fp
         Bghw==
X-Gm-Message-State: APzg51ArKYUIKY/OOBIESgA/uYINQxpz2pMICRYGaBmfgeHbUFLjt3qA
        rrk9azeUa8N8U0GgtRHSZCJJeBG0dt+2luxwG2d9sQ==
X-Google-Smtp-Source: ANB0VdbEFc+g7LpW2ibY6Gc0BFixIlvWEVRETyuTUIOf1+kjOt8Vz0LmEYahUgxe3AuAErfuQUkyN+lK8jf96DqhD6c=
X-Received: by 2002:ac8:1c06:: with SMTP id a6-v6mr34980694qtk.16.1536170444186;
 Wed, 05 Sep 2018 11:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com> <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
 <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
 <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com>
 <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com>
 <bf917897-1697-a6c4-7f77-8dfa74dddc8a@broadcom.com> <CAKv+Gu8FK9K0G-GJygdpkwqKYzjvpDDj8TyGTC2u0SRxK3ez_w@mail.gmail.com>
 <1f8095f1-1f0c-0791-31c4-c7b986c4ce1f@broadcom.com>
In-Reply-To: <1f8095f1-1f0c-0791-31c4-c7b986c4ce1f@broadcom.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Wed, 5 Sep 2018 19:00:33 +0100
Message-ID: <CACxGe6tbuDzEaBqOD7Z3nWMW0Nkcf22MFbD3BL+KBqnKEo2tQw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     scott.branden@broadcom.com
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 6:27 PM Scott Branden <scott.branden@broadcom.com> wrote:
>
>
>
> On 18-09-05 02:40 AM, Ard Biesheuvel wrote:
> > On 4 September 2018 at 19:19, Scott Branden <scott.branden@broadcom.com> wrote:
> >> Rather than introduce EFI_ARMSTUB_DTB_LOADER, why not have
> >> the efistub use CONFIG_OF to determine whether it supports dtb= or not?
> >>
> >> That way ACPI-only distros disable devicetree support entirely.
> >>
> > Unfortunately, CONFIG_OF cannot be disabled on arm64 even on ACPI-only builds.
> OF shouldn't be automatically selected in the arm64/Kconfig.  It should
> have a config
> parmaeter like other archs as mips and arm.  I can submit a patch so it
> functions the
> same way as other archs so it is not always selected.  It will be good
> to add a USE_OF
> config options like the other archs (or simply remove the select from
> the Kconfig and choose OF directly in the defconfig.
> This will have the added benefit of doing away with OF support when its
> not needed on an ARM64 platform.  ACPI is already not automatically
> selected for all ARM64 platforms, nor should devicetree.

We don't do that on Arm because a devicetree is always required at
boot time. Even on ACPI systems a tiny DTB is used containing just a
/chosen node for passing the kernel command line and the initrd
location.

g.

g.
