Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2A7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD77520685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RraR06AC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfAJHzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:55:44 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51682 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfAJHzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:55:43 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so15983956ite.1;
        Wed, 09 Jan 2019 23:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yov8D8gjWhHIk/2X+MdgDF7F0r4fp0ReXoEM3MeFAxY=;
        b=RraR06AC/7qgLypkw/Kx5hZk6MdG1ggq119b/mzHf3G9LY+Lh8sakgHAbX8UNvUmPf
         Ir+J2Dz/DE/3q0jXGQB3vzOO8S2AaaFwrH9dfnn7CkAMh+vRyty+C6omAuqFf9G+J2kc
         Xi5rpx2l2htLjRFJggx27Yk24NAdUN+iO1tes9PpwDhcYqQBxSj9mhSnZGtnbWdbK/cB
         VNJHJXJnJe642jAPgXiwqmY4/LkuUFkx1xzpu2qfvdISNaQ4pB7Tvw6+ufbYWlgpXz1o
         XZA21Zl8lx+YTF8p4prtV2qIc7ztaq7NRO7P3ZJiPv14Ni0foxGoRfZEkFnQdfl/fGgQ
         HKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yov8D8gjWhHIk/2X+MdgDF7F0r4fp0ReXoEM3MeFAxY=;
        b=kFq/Wj1lQyxlcvp85N1DD5jpul6vj90BN+bjKtRmX1SJRJygBuAT4DTvRcR7JMv6nH
         NGYdGrdtcjZK7NHc2ku+1SeJIX1KD8NAVPZ9N87G4p3xvxaRdYrw9sTfOd2mEIeMa6T3
         bqfSkmYEME+Dyfg+huJCDPc+ayFPBSsUHNUWncx1sIYzAhsG6bciWCgctTGMnvPsPWzj
         20ULoJ5+IKBmXxB2yxw05E9Tkxvp0mxomESN3NabEmZkbgVkVzW8jb1b/wb6+6XkNJx9
         wKFN5H/auOPiBo+Qadx3YiyQ0g8GzzULEPvjlx4pu8re/HRqwT1CnK7ti2Xxz2H2EG2g
         Cg+g==
X-Gm-Message-State: AJcUukdhUDYOzXUDCq//sVmyP4Rh2w42mO5ON0IKwc/Tolk0adF1vkfe
        CT1RgOFCtQCA9iqi49vdVTAnchyajURx4K4zJ8U=
X-Google-Smtp-Source: ALg8bN6BdBASQyZr3JOAize8EhSV0zHdzwrPhboERUcM1OXmPnmxdRZINyRfeHSyYAh23sghjlFH/HHPy8y8horEIjc=
X-Received: by 2002:a24:b34f:: with SMTP id z15mr6062922iti.61.1547106942285;
 Wed, 09 Jan 2019 23:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-5-pawel.mikolaj.chmiel@gmail.com> <20190110070208.lvnrcd2nld3zthmk@vireshk-i7>
In-Reply-To: <20190110070208.lvnrcd2nld3zthmk@vireshk-i7>
From:   =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Date:   Thu, 10 Jan 2019 08:55:31 +0100
Message-ID: <CAKpie0TvS4bzdv82m8T24GaH_DrGsjdznCSQcugtt9DqKss_sg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: defconfig: s5pv210: Add cpufreq support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk,
        rjw@rjwysocki.net,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 10 sty 2019 o 08:02 Viresh Kumar <viresh.kumar@linaro.org> napisa=C5=
=82(a):
>
> On 08-01-19, 21:05, Pawe=C5=82 Chmiel wrote:
> > This commit enables cpufreq support for all s5pv210 devices.
> >
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  arch/arm/configs/s5pv210_defconfig | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv=
210_defconfig
> > index 951196bdf008..fd4f28aabda6 100644
> > --- a/arch/arm/configs/s5pv210_defconfig
> > +++ b/arch/arm/configs/s5pv210_defconfig
> > @@ -11,6 +11,12 @@ CONFIG_ARCH_S5PV210=3Dy
> >  CONFIG_VMSPLIT_2G=3Dy
> >  CONFIG_ARM_APPENDED_DTB=3Dy
> >  CONFIG_CMDLINE=3D"root=3D/dev/ram0 rw ramdisk=3D8192 initrd=3D0x208000=
00,8M console=3DttySAC1,115200 init=3D/linuxrc"
> > +CONFIG_CPU_FREQ=3Dy
> > +CONFIG_CPU_FREQ_STAT=3Dy
> > +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
> > +CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
> > +CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm
> > +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm
>
> You don't want to use schedutil ? That is the default governor for
> everyone now a days.
schedutil depends on SMP, which is not enabled on s5pv210 (it has only
one cpu core).
>
> --
> viresh
