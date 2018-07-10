Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB5A20835
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVjRSXoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB5A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934410AbeGJQGD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:06:03 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40482 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933796AbeGJQGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:06:01 -0400
Received: by mail-yb0-f193.google.com with SMTP id y11-v6so8805575ybm.7;
        Tue, 10 Jul 2018 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yTk0n/NgKzUbEjfBuTldG0UqP4/DSDGQ7OliRuwyFMM=;
        b=BVjRSXoK6Qf7cYbrpUV5ItlK9HTn3Uf66vhcIZSLcJaouCX+NEQ1X7oCuklMG47ax/
         orzRWoIxas+o9qbjBhLHDCHkzJgwwsGXPtbWidD1ces/G64tO12yQWc5pLly4WVLXENZ
         g4YOTjhF0QWtdU/y17XLCP329wT1yrSXlnjgZqgfz4552+p3BLboTyS+k/G2HIo/2Mm6
         ecR7JH6DNJMyS8UNwoyhVGJLZvpJc/i8TDpZUDyQq0fCGLJbG/zlouof49DDnH9ipx14
         yKXZLSsSojn+6mbhdzyL98WAZq87I9iL4RG2gQ25wIuGD0/SmrAFxWvC77eckKystdnA
         FiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yTk0n/NgKzUbEjfBuTldG0UqP4/DSDGQ7OliRuwyFMM=;
        b=a7FEezi00YvylUemJcndKmLpAl2Ba2w5yfvRyiVHAWNP6hfSvaH+A104OTlr8iFVBd
         ypiEStwEVibV4jGg2LxvFRSRm2z6mNrOOXZBjmOyfvmrwZ7NGccg1VSzEIQizfH61rJx
         13H/TkEU1+KU/4aUhLB/lAIpGqhcYyAzCiJvbvX1pQ2dLtJEqBIT4aMd/jAACrm5nlBl
         FvDuN74VVTnrzAYip90LOEBX9Wyqu7uxMgqLFj5qN1CYVgLo1CipzIPNRodsrD21Al+C
         eHwMY0VP7F8gHOYmQnjk3f2/4VagLbxdQemTpc1DAxllJA16oMaSpMQrtxwY/5Jr4FBs
         3Q+A==
X-Gm-Message-State: APt69E0wDCImvwgEu2RHj6Q7Om/oCr5BWzLhNMeeSAYNo+ryk//EQgRg
        DqAjghgihoXiF8Z5Cra8P3ofp6KyVSC0YWLQNHE=
X-Google-Smtp-Source: AAOMgpfZrI8DhanSJIyLNkL86XcEJo3TWsyinwLfJQohHLZops/1MjY2+Sdxyk+N1AR2CKcUK811W79oVYPzw3T6nqw=
X-Received: by 2002:a25:8102:: with SMTP id o2-v6mr13270664ybk.379.1531238760497;
 Tue, 10 Jul 2018 09:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180611155001.3506-1-peron.clem@gmail.com> <CAJiuCcf3g2fzrR2_4mthjwKRcyZ8KVPX+EZ5_Uifh2E6TkzusQ@mail.gmail.com>
 <52591c2d-e9df-7078-7cdf-0fd8d06c9ee0@linaro.org> <CAJiuCcc-eGRr_RT01dNfhQso5PbXfWy+YZS4PHHcL=_yhA-3Sw@mail.gmail.com>
 <c9db3848-378f-8e1e-c194-53d878894716@linaro.org>
In-Reply-To: <c9db3848-378f-8e1e-c194-53d878894716@linaro.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 10 Jul 2018 18:05:49 +0200
Message-ID: <CAJiuCce7yBA+_s44RboKr9x-Ts5qk4T4vCXyVbVuUUxMSc+ScQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Reintroduce i.MX EPIT Timer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Daniel,


On Tue, 10 Jul 2018 at 17:37, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 10/07/2018 17:22, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Daniel,
> >
> > On Tue, 10 Jul 2018 at 17:12, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
> >>
> >> On 10/07/2018 16:55, Cl=C3=A9ment P=C3=A9ron wrote:
> >>> Hi,
> >>>
> >>> Is there still some remark against merging this ?
> >>
> >> How do you want this to be merged ?
> >>
> >> Shall I take the two patches related to the timer ? Or Ack them ?
> >
> > I'm not an expert on how submitting patches works, it's the first
> > driver I submit.
>
> Ok, so usually this is what happens when there is a set of changes:
>
>  1.  they all touch the same subsystem (eg. drivers/clocksource), you
> just send all the patches to the maintainer(s) + mailing list + related
> people
>
>  2. they touch different subsystems:
>
>    2.1) the changes are not connected (not related together), you have
> to split in smaller parts and send the patches to the right subsystem
> maintainer (so falling back to 1.)
>
>    2.2) the changes are connected:
>
>       2.2.1) Ask all the different subsystem maintainers to acknowledge
> the changes and submit the patches to arm-soc@
>
>       2.2.2) Ask each maintainer to take their part if the changes are
> connected but not interdependent (patches individually won't break the
> system)
>
>
> You are in the 2.2) situation. My question is do you want 2.2.1) or 2.2.2=
) ?

Thanks for the explanation, I think in 2.2.1 as I still need an Ack
for the "ARM: dts" patch

Regards,
Clement

>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
