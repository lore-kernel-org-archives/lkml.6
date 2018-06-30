Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2341FC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66682623C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WirAMidX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66682623C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936972AbeF3MkU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 08:40:20 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40510 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936548AbeF3MkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 08:40:17 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so5423874pfe.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 05:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SbdordiGgAbo8vsmROACkR76LlbdL5fCGhUjGO6kq2g=;
        b=WirAMidXqtcd0AcMK2m5aBclnRyuuL8Y8Ov3Dz4R/ajmHzOYLs+E+X868VfqTmKDQS
         bUORLLsF4LEuoWT48MNienfBs69HkkRzIP4MkHlzhS9hW5Y5LVfVECOeu++4W9mpgqXN
         C96SGe8T7gu29yhhHKMQ1Vs7WrWQoHZEvhUOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SbdordiGgAbo8vsmROACkR76LlbdL5fCGhUjGO6kq2g=;
        b=r2+uieXLVTu+RX86ruzhvSWfae0rAwZ8uNq6J8X5iotGuAtQ3+GF6tXVDAFMcDz1Dm
         GoCPnfiuaHxEyrIDeOrQuQEYmaM44s4WSssYvSC3+6s3nKinR6P3aNb+79C+6H5GWGXo
         uSv4swhWE2NY4hVPrjvG9lmygEe5Nu4kmK6yo/2AK9B5DPMaK3XsyWGekLLv2HkwaNbZ
         uxPRwo46HT2UYzfaXaQO4h+50DuGvwEjWZhYN6CiDOtZptiR8QPDduk7GGX0wcFuhHll
         qFEvxdl1ToG2ajbWom6VITF7hMkxgZXVdQHjjAeZzHdPwzVfmcaQTKiFJ8K9GNcrkerw
         lY1A==
X-Gm-Message-State: APt69E0IbjiUQBJCOTsqB0jhgtdh49FWIFD3AzHK5DpeICDy9D8ZG0kU
        qMoQi1WV2GcZce8GWgG6isGo
X-Google-Smtp-Source: AAOMgpd0b21tHsLxplTpyQRDj6fqXk2oNsis1TgBjFTMSO5dslOCTX1cwQpojH4FohGR/SmRNTTPmA==
X-Received: by 2002:a62:640b:: with SMTP id y11-v6mr18295320pfb.204.1530362416345;
        Sat, 30 Jun 2018 05:40:16 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:73ca:b257:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id z123-v6sm17143352pfz.16.2018.06.30.05.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 05:40:15 -0700 (PDT)
Date:   Sat, 30 Jun 2018 18:10:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     wsa@the-dreams.de, robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-i2c@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com
Subject: Re: [PATCH v2 1/6] dt-bindings: i2c: Add binding for Actions Semi
 OWL I2C controller
Message-ID: <20180630124003.GA16775@Mani-XPS-13-9360>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
 <20180628181042.2239-2-manivannan.sadhasivam@linaro.org>
 <6809cab8-da3f-618c-05da-9935a99c1e1d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6809cab8-da3f-618c-05da-9935a99c1e1d@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Sat, Jun 30, 2018 at 02:23:30PM +0200, Andreas Färber wrote:
> Am 28.06.2018 um 20:10 schrieb Manivannan Sadhasivam:
> > Add devicetree binding for Actions Semi OWL I2C controller
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/i2c/i2c-owl.txt       | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> > new file mode 100644
> > index 000000000000..9b691968cffd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> > @@ -0,0 +1,27 @@
> > +OWL I2C controller
> 
> As mentioned elsewhere, please fix all subjects, commit messages and
> bindings to say Owl, not OWL. There's no need to upper-case it besides
> defines.
> 
> Also, this title should mention Actions Semiconductor please, not just
> the codename Owl.
> 

Sure

> > +
> > +Required properties:
> > +
> > +- compatible        : Should be "actions,s900-i2c".
> 
> What about S500? Are you expecting it to carry an S900 compatible? That
> seems strange. Are there any differences in the implementations?
> 

I haven't tested it on S500 eventhough the implementation looks same. But
anyway if we want to add support for S500 or S700 we can just do the
modifications (if any) slightly and add a separate compatible like we
did for other drivers.

Thanks,
Mani

> Otherwise looks okay.
> 
> Thanks,
> Andreas
> 
> > +- reg               : Offset and length of the register set for the device.
> > +- #address-cells    : Should be 1.
> > +- #size-cells       : Should be 0.
> > +- interrupts        : A single interrupt specifier.
> > +- clocks            : Phandle of the clock feeding the I2C controller.
> > +
> > +Optional properties:
> > +
> > +- clock-frequency   : Desired I2C bus clock frequency in Hz. As only Normal and
> > +                      Fast modes are supported, possible values are 100000 and
> > +                      400000.
> > +Examples:
> > +
> > +        i2c0: i2c@e0170000 {
> > +                compatible = "actions,s900-i2c";
> > +                reg = <0 0xe0170000 0 0x1000>;
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +                interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks = <&clock CLK_I2C0>;
> > +                clock-frequency = <100000>;
> > +        };
> > 
> 
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
