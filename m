Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE77C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B884620854
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dBIWHzrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfAXI7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:59:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46898 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfAXI7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:59:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so3680500lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+6CDhmFE5BUgJINfvBlE6kMfuKGKXOQt17aKaSC2CU=;
        b=dBIWHzrqrzUEmk0fPf31ioVvC5HLtg2oP6b6UPzvQvyUrCu7IHzda0phOLDGOFVUcF
         +LUQ9dim7l2j5yRewWPPX3yEi3SV+ZlfK12nMt9xvfxGWriQPm0GTlKdU9F+OIBDt85Z
         yYzRx7aP9IqbPmon3F17G8zIq+mMGD10aGqP4igCWWGEI3hWzWUahx/RLVhPTQQLzEWE
         z4VYASQRtb4+PyFNTNI+NvyZkzzNu1Dd9FmskDTRLlFFNehwI14jc4ye2wXiW1Onlww4
         prdfBAtLEbCcJfdvdyd+Mx1BASOZW62y2nJP0RWOCLy/L9Z9wUsgBTAj+KiYhKvcmy5/
         OhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+6CDhmFE5BUgJINfvBlE6kMfuKGKXOQt17aKaSC2CU=;
        b=Hab9qGz6IHavue/nbUDZfnolykt9Cg/KeUAL6uhqmgBFr0J54WD0PTRitGLmBme6WM
         b2BiG1v57M/PkNbAfQoCcjtZHUNM6/6FoYRQW2R1QQSe/s8oCjnxw9hkDySGw5wN5kNk
         5sKLlXjpFFrko1PU1GaGcu20R5LAcnPGln3McSiLU60Mwpak+EFffWFD7HbzdkGxFvnV
         Y+YtDtRH2bZMSVFN1Pna/xFy7GtEdsctJAM+sID/+Ce+oJAnuONAucBponihXWIRJlrh
         mZLlNvQsSTvNq3HCg9Q/Xy1g8QfDEGuFERluQ2I2FWd/lJ2QXTnFXAumgxLLw92cOokd
         PmiA==
X-Gm-Message-State: AJcUukcJ8IvAauS/XuF+iP/CJ7lTlXthXEhLC6fEAoV7prj/gDwEPW8c
        nguY4+WzCIZGr3ahQAwoYbm3IKN43thXJgIP3yKuWA==
X-Google-Smtp-Source: ALg8bN52LHHj0Rtr1xWGpXi2iK10lapJcU3T+NVduKsZj8oRNRzT9aTPbMWXVZI2sGMCWVV7V3uY9kCD+UDbF8sBpmM=
X-Received: by 2002:a19:d381:: with SMTP id k123mr4445479lfg.101.1548320361053;
 Thu, 24 Jan 2019 00:59:21 -0800 (PST)
MIME-Version: 1.0
References: <1548066043-1252-1-git-send-email-yash.shah@sifive.com>
 <1548066043-1252-2-git-send-email-yash.shah@sifive.com> <20190121145901.GA7547@bogus>
In-Reply-To: <20190121145901.GA7547@bogus>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Thu, 24 Jan 2019 14:28:44 +0530
Message-ID: <CAJ2_jOFMDkAv44Ck1HNxDQ8mfH=Zi3cxhLugoqBMDcueDw0O3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
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

On Mon, Jan 21, 2019 at 8:29 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jan 21, 2019 at 03:50:42PM +0530, Yash Shah wrote:
> > DT documentation for PWM controller added.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Compatible string update]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 37 ++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > new file mode 100644
> > index 0000000..b207908
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > @@ -0,0 +1,37 @@
> > +SiFive PWM controller
> > +
> > +Unlike most other PWM controllers, the SiFive PWM controller currently only
> > +supports one period for all channels in the PWM. This is set globally in DTS.
> > +The period also has significant restrictions on the values it can achieve,
> > +which the driver rounds to the nearest achievable frequency.
> > +
> > +Required properties:
> > +- compatible: Should be "sifive,pwmX" and "sifive,$socname-pwm".
>
> The order here is wrong.

Will fix the order.

>
> You still need to enumeration valid version numbers. Is 'sifive,pwm20'
> valid?

Yes

>
> > +  Please refer to sifive-blocks-ip-versioning.txt for details.
> > +- reg: physical base address and length of the controller's registers
> > +- clocks: Should contain a clock identifier for the PWM's parent clock.
> > +- #pwm-cells: Should be 2.
> > +  Refer to bindings/pwm/pwm.txt for details.
> > +- sifive,period-ns: the driver will get as close to this period as it can
> > +- interrupts: one interrupt per PWM channel
>
> How many channels? If variable, is the a max number?

Max 4 channels.

>
> > +
> > +PWM RTL that corresponds to the IP block version numbers can be found
> > +here:
> > +
> > +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
>
> Put this in the description at the top.

Sure.

>
> > +
> > +Further information on the format of the IP
> > +block-specific version numbers can be found in
> > +Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
>
> You already said this.

Will remove redundant info.

>
> > +
> > +Examples:
> > +
> > +pwm:  pwm@10020000 {
> > +     compatible = "sifive,fu540-c000-pwm","sifive,pwm0";
>
> Space after the ',' needed.

Sure

>
> > +     reg = <0x0 0x10020000 0x0 0x1000>;
> > +     clocks = <&tlclk>;
> > +     interrupt-parent = <&plic>;
> > +     interrupts = <42 43 44 45>;
> > +     #pwm-cells = <2>;
> > +     sifive,period-ns = <1000000>;
> > +};
> > --
> > 1.9.1
> >

Thanks for the feedback
