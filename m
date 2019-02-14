Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B69F222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ya1a+cpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394256AbfBNIIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:08:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36628 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfBNIIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:08:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so4416516ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUE3EVLdrtPM6TCnLkMXcWvIudWsHoogLziir6zdaRg=;
        b=Ya1a+cpJxy+G5yQzgsOZNvphBHk3bFY+7q5xJmV0pZzGwwgLRHHR0OfIc7e9mAOJ3r
         hctXJOuktQqBZPZDb09P8AgWKxvF1JkZ/VyBm0D2S3l/aySN3FV/lwq/Hie6GfbaJpah
         6dRQiS8wksXMfKNlBSw4NXybJylyphFEfgD7uW/t2Jsz9R8uB6gyLt9IXWALgqCZ3oQE
         8KCQKbmDd2jXpo7VRpunQPS2vCo+e0U8BxmYngXOzGLUpA7YuCM/j35pyrSeM6cTWLzw
         uDP18o9fMNOCs0cyn69oVfgQS3H+fUZNPhgddtI6X5zP2L549ILSyp7nOfofxo7A0YL/
         7Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUE3EVLdrtPM6TCnLkMXcWvIudWsHoogLziir6zdaRg=;
        b=DAFUgD7RF+dY2uNGVi8i9laMkQw73w/s+eWNYkSJNjirN9QDPiK0q66nqFBc3I5EmU
         qNqMahiHKd3N/LqyP8zJbunb5tR2O0/7aJqlO0ofGZH1nSuUsD1h3Ox4m/reFYKQnD+m
         T/jGBq4DFYaDuDAmKtheQfhvIQxykxAe5+YjCP43C1wz9xZWuJZs6lXdQiuh7MD5UfcI
         Q+Hej3NRIXTIdwgU+o7/FwOxfllLwJ+r9oSgHfTKvQOWUqzhfWXRniWihg3DHvsXgnbf
         zgj4xOBd4H3ZEq/zlVmYa9JL7ejP1APh9ZF6wAzIQq22RsyA/RaUDxnI6K8+NQzxmG+y
         y1Yg==
X-Gm-Message-State: AHQUAua9ZPGGyk4dPqWvlDEWi19RRADM5ZuFWpwu7c4/FtALugLpSply
        De8X7oWwk+TBf/djiFUqew8+4XdzVbXVMc8aCDBvyw==
X-Google-Smtp-Source: AHgI3Iau7/ILoMBs542cZUjYKQfooNo7+Ppf4x0josN3dVCKV73OjdIcAG6zp/0nBglGHK7+eNtAgvoq1ZqNkSd+tP0=
X-Received: by 2002:a2e:a0c8:: with SMTP id f8-v6mr1430735ljm.177.1550131715841;
 Thu, 14 Feb 2019 00:08:35 -0800 (PST)
MIME-Version: 1.0
References: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
 <1550049978-20705-2-git-send-email-yash.shah@sifive.com> <20190213203752.GA18326@bogus>
In-Reply-To: <20190213203752.GA18326@bogus>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Thu, 14 Feb 2019 13:37:59 +0530
Message-ID: <CAJ2_jOHwk3_5Z1=QD4HZjpWg0mx-RTKzq44gueFZQ2k2OaZOZw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
To:     Rob Herring <robh@kernel.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 2:07 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Feb 13, 2019 at 02:56:17PM +0530, Yash Shah wrote:
> > DT documentation for PWM controller added.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Compatible string update]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 30 ++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > new file mode 100644
> > index 0000000..3b9c64c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > @@ -0,0 +1,30 @@
> > +SiFive PWM controller
> > +
> > +Unlike most other PWM controllers, the SiFive PWM controller currently only
> > +supports one period for all channels in the PWM. All PWMs need to run at
> > +the same period. The period also has significant restrictions on the values
> > +it can achieve, which the driver rounds to the nearest achievable period.
> > +PWM RTL that corresponds to the IP block version numbers can be found
> > +here:
> > +
> > +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
> > +
> > +Required properties:
> > +- compatible: Should be "sifive,$socname-pwm" and "sifive,pwmX".
> > +  Please refer to sifive-blocks-ip-versioning.txt for details.
>
> Please specify what soc and IP version are used. Is sifive,pwm10 valid?

Does the below description seem fine?

should be "sifive,<chip>-pwm" and "sifive,pwm<version>".
Supported compatible strings are:
"sifive,fu540-c000-pwm" for the SiFive PWM v0 as
integrated onto the SiFive FU540 chip, and "sifive,pwm0"
for the SiFive PWM v0 IP block with no chip integration
tweaks. Please refer to sifive-blocks-ip-versioning.txt for details

>
> > +- reg: physical base address and length of the controller's registers
> > +- clocks: Should contain a clock identifier for the PWM's parent clock.
> > +- #pwm-cells: Should be 3. See pwm.txt in this directory
> > +  for a description of the cell format.
> > +- interrupts: one interrupt per PWM channel
> > +
> > +Examples:
> > +
> > +pwm:  pwm@10020000 {
> > +     compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
> > +     reg = <0x0 0x10020000 0x0 0x1000>;
> > +     clocks = <&tlclk>;
> > +     interrupt-parent = <&plic>;
> > +     interrupts = <42 43 44 45>;
> > +     #pwm-cells = <3>;
> > +};
> > --
> > 1.9.1
> >

Thanks for the comment
