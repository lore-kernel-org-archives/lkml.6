Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91923C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F972145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnuNEal6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F972145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbeKNUWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:22:55 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35275 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeKNUWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:22:54 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so24739298qka.2;
        Wed, 14 Nov 2018 02:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dlSofOcssX2yPqieswXODMBZ03gxeXSdESaVcgrsb5M=;
        b=fnuNEal61tnlglehJtuRGIH1hx+YoJBdqdoIhQpTJHDdh2ejEvh+HQnrgSgGq80buu
         qlbfPDSZB6hh1eK12kFnhhiMWsZ4AyHKxGo2kVDN+MoEIUH/Dw4500IoQypMAnyykhdg
         vhg3uT1I1TXMiOZOriUAWBAajgSnTVH7wmPkjty94EjrvnoBG6vDtASkIt6tOS6qz67j
         LNIyoxQZq256/vFT9k0UgrZOwBvw+1hCgPDOhI8+pwBmNys3FIn6BfcJSzvdw8OWTxJE
         ZxAub5MnFyP4Kx6DeLbs9dKaDc86NS4xNa0SVwGEWEDFkuOk6btZu4GuF3a/PJYH2iST
         RYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dlSofOcssX2yPqieswXODMBZ03gxeXSdESaVcgrsb5M=;
        b=OncW7v9jqY3tbRlURKs/HtQmYXQVT2A5JC5XqlXtFsYVt/Y2FINGiO8T2v2kDejMpe
         aE3TzSZJxvLpcmppjpqSgIOSOPQXkEdO6GjSS6KfVbHonhObueS3vTvEEGhW1EV2giCR
         pU+/YANYRLfZdfZOcYvpNPVT0KXbB/k8Yh1aw0ceziqGhYQNKG+wcKcA09Hie+tmStwc
         uJvNLc5FjQutmDITNoArqElm5bfeN320lWuSG1xREWMIyc2TbSWQ9a0bV1bb4hlZBPyn
         dgCeZ2RuGJFnvpyNGbNXgnaSVjpBRMlgwBbZsuyM4zzAMz9Nh6+ovm+s9D9j2xAqxZJh
         7M/Q==
X-Gm-Message-State: AGRZ1gK2jGTcWRvwo35u3Pzxq4kYSP4Ncwe34zPVHGAaWZnvLt7wcj62
        lhdjHrALE9XJtjtkv/SJ6jE/oCFCV+FPwuxCSr0=
X-Google-Smtp-Source: AJdET5fQLpgqrj0ZXFrQZYDaPLR/djyKq9tAf9lZvV9yRiuEpQpc36jETaK3nWT/b+/pIbr0R+7baI5zZUx0VSIRhls=
X-Received: by 2002:aed:3e49:: with SMTP id m9mr986862qtf.99.1542190816140;
 Wed, 14 Nov 2018 02:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
 <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
 <5BE8C821.5080002@samsung.com> <5BEB63C3.1020504@samsung.com>
 <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
 <5BEBE741.6050101@samsung.com> <20181114093652.GK10650@smile.fi.intel.com> <5BEBEF7C.7060003@samsung.com>
In-Reply-To: <5BEBEF7C.7060003@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Nov 2018 12:20:04 +0200
Message-ID: <CAHp75VcJwR7S8t2jSyRvtjKCwaUA5Pu=EL3+MjCgf3SVWnChEQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device is
 not found
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 11:48 AM Chanwoo Choi <cw00.choi@samsung.com> wrote=
:
>
> On 2018=EB=85=84 11=EC=9B=94 14=EC=9D=BC 18:36, Andy Shevchenko wrote:
> > On Wed, Nov 14, 2018 at 06:13:37PM +0900, Chanwoo Choi wrote:
> >> On 2018=EB=85=84 11=EC=9B=94 14=EC=9D=BC 17:35, Andy Shevchenko wrote:
> >>> On Wed, Nov 14, 2018 at 1:53 AM Chanwoo Choi <cw00.choi@samsung.com> =
wrote:
> >>>
> >>>> I was thinking about again to change from NULL to EPROBE_DEFER.
> >>>>
> >>>> extcon_get_extcon_dev() function was almost called in the probe func=
tion.
> >>>> But, this function might be called on other position instead of prob=
e.
> >>>
> >>> *Might be* sounds like a theoretical thing, care to share what is in =
you mind?
> >>> Current users and more important the new coming one are *all* doing t=
he same.
> >>>
> >>>> ENODEV is more correct error instead of EPROBE_DEFER.
> >>>
> >>> So, you are proposing to continue duplicating conversion from ENODEV
> >>> to EPROBE_DEFER in *each* caller?
> >>
> >> The extcon core don't know the caller situation is in either probe() o=
r other position
> >> in the caller driver. The caller driver should decide the kind of erro=
r value
> >> by using the return value of extcon_get_extcon_dev().
> >>
> >> extcon_get_extcon_dev() function cannot be modified for only one case.
> >> If some device driver call extcon_get_extcon_dev() out of probe() fuct=
ion,
> >> EPROBE_DEFER is not always correct.
> >
> > I agree with this, but look at the current state of affairs. All users =
do the same.
> > If we need to have another case we may consider this later.
>
> Because we know the potential wrong case of this change, I can't agree th=
is change.
> If extcon_get_extcon_dev() returns ENODEV instead of EPROBE_DEFER,
> it is clear and then there are no problem on both current and future.

Changing NULL to -ENODEV is a trading bad to worse.
I would not go that way, so, it's your call.

> > API inside the kernel are not carved in the stone.

Only can repeat myself (see above). While I see *theoretical*
rationale on your side, mine has *practical* proofs.
So, I'm giving up on this and will duplicate same what it's done in 4
current callers.

--=20
With Best Regards,
Andy Shevchenko
