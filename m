Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0628CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBF62171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY5Mf6e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfA1TbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:31:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39766 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfA1TbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:31:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so8465141pfc.6;
        Mon, 28 Jan 2019 11:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YgMMV+e4v4TdansTkPGDEqka+N3nOM7KtfnA0QzqkkU=;
        b=QY5Mf6e84IOFLWh7Rf4SEp5DEnya/lGhkQXJnrTdNOFxlQ2R9xzTEV6ydwd1ue4WEu
         9yEQHEDKdSksVMLzjDSPeZ7Q0vtDSLs+UPp8S9rnKoYwd19eMhurFRrdNFWMVDrG7Exr
         eQU7R2kFV0HL4o78paiV8rbLVoQlCYnVECtrk51kXllVKPAaV8bJ96L67UYlc+nE3j0z
         cgtUuLL43UqN4mWq+xK/ArU8116GV11tQbRIv+zHxp3zrA4k8nNkArwJD9OMdfelE7HQ
         KXimSYuVETjowkqDH7VM+u2kfJ9cS1pi9PkHZIcxSLLqBe8AeqD3sxe4iM6sVw0T+SRh
         qzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YgMMV+e4v4TdansTkPGDEqka+N3nOM7KtfnA0QzqkkU=;
        b=A8684nwOWGMtKisS0Sb/Uim92PdWGtRdA7uA790ik/5N59zEZbZQg0/8Gzgkk/ieHm
         QOJ/iAToihXwJ55P6JiU0QjzVNv4ocnbohXL1zbNvUKwFDGu/QCPSL49Iwnu3OlIYi7G
         b8nfIv9G+BI8FDr99r7V15wMXUmkJQNH/GxvM+qvDtBm+ILq0xMOVXkLgwkaznXrVEhU
         LoDfNsgCt9rk53kh2h/GOfXKZ1/S1P2uHyWX3ygA6sgqb2LrjlvVU/iszUIaLM0UCiss
         egi6tyjZPYTA7BWhNlmJwcRA+/6eAReifd1bHMCCw42Smq11glXRoFlAEcGDXPyxe9iR
         xr6A==
X-Gm-Message-State: AJcUukcT1Cu19z3VF95WBysAGDjrAG3hUDljlFyC0P9tQChm7cKCZqmi
        8QaOVG5HdV3puHWspZ81fDI=
X-Google-Smtp-Source: ALg8bN7aEuKQwSHIpK11CoXVBZ3Ydv1NncDgNdR6C8HDsLGTPmE+Lmr96+sztoMSpfDVoUYgl/+JKQ==
X-Received: by 2002:a62:5301:: with SMTP id h1mr22947005pfb.17.1548703869450;
        Mon, 28 Jan 2019 11:31:09 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s2sm61444679pfa.167.2019.01.28.11.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 11:31:08 -0800 (PST)
Date:   Mon, 28 Jan 2019 11:31:07 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] input: dt-bindings: Add binding for bma150 sensor
Message-ID: <20190128193107.GF34692@dtor-ws>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125184400.17669-4-pawel.mikolaj.chmiel@gmail.com>
 <20190126012802.GD212026@dtor-ws>
 <BYAPR02MB54950EDEEE82D5F06C7131CEA3940@BYAPR02MB5495.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR02MB54950EDEEE82D5F06C7131CEA3940@BYAPR02MB5495.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 03:39:17AM +0000, Jonathan Bakker wrote:
> 
> 
> On 2019-01-25 5:28 p.m., Dmitry Torokhov wrote:
> > On Fri, Jan 25, 2019 at 07:44:00PM +0100, Paweł Chmiel wrote:
> >> From: Jonathan Bakker <xc-racer2@live.ca>
> >>
> >> Add device tree bindings for Bosch BMA150 Accelerometer Sensor
> >>
> >> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> >> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> >> ---
> >>  .../bindings/input/bosch,bma150.txt           | 20 +++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/input/bosch,bma150.txt b/Documentation/devicetree/bindings/input/bosch,bma150.txt
> >> new file mode 100644
> >> index 000000000000..290c60e38c70
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/input/bosch,bma150.txt
> >> @@ -0,0 +1,20 @@
> >> +* Bosch BMA150 Accelerometer Sensor
> >> +
> >> +Also works for the SMB380 and BMA023 accelerometers
> >> +
> >> +Required properties:
> >> +- compatible : Should be "bosch,bma150"
> >> +- reg : The I2C address of the sensor
> >> +
> >> +Optional properties:
> >> +- interrupt-parent : should be the phandle for the interrupt controller
> >> +- interrupts : Interrupt mapping for IRQ.  If not present device will be polled
> >> +
> >> +Example:
> >> +
> >> +bma150@38 {
> >> +	compatible = "bosch,bma150";
> >> +	reg = <0x38>;
> >> +	interrupt-parent = <&gph0>;
> >> +	interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > Hmm, here you say that IRQ_TYPE_LEVEL_HIGH, so it is level interrupts,
> > but the driver overrides to rising edge unconditionally. Since you are
> > the first to add DT support please make separate patch to driver to drop
> > the ORQ trigger from request_theraded_irq() leaving only IRQF_ONESHOT.
> > 
> This was simply an oversight on my part, my device was using the the polled method as opposed to an interrupt.  I'll correct this in v2.
> > Also please create patch removing platform data support as noone is
> > using it upstream.
> > 
> Will do.
> > What about the rest of config parameters from bma150_cfg? They should be
> > handled as device properties too.
> > 
> Ok, I can add them as well.  I didn't bother as the comment in the source code says that the default values are the ones recommended by Bosch.

OK, if you do not need to handle them then we can leave this task to the
next user ;)

Thanks.

-- 
Dmitry
