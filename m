Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8289FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3968820645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWblsL0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3968820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeH3Mo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:44:57 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42661 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbeH3Mo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:44:57 -0400
Received: by mail-io0-f194.google.com with SMTP id n18-v6so6858838ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5J1BTzAeVNKsETRKMBuA+D+cqeEwKWTxg5mDg5iOGZ8=;
        b=PWblsL0SwO6scsD2Zx5st1Wl/R2doSLtXBawxASSinWcUNbboyZV3OrgOiJO5l/ga4
         IelWcjneyh2WKdBXKI9exUcRRvhh1MVwRHzHMBOv6MACPnjVcHvKiG4Qx7zjxtyp23oL
         s88uEQogifL0fpXi5aNUt6s04WEmDrz59ybeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5J1BTzAeVNKsETRKMBuA+D+cqeEwKWTxg5mDg5iOGZ8=;
        b=Bh3yb5yUdX37vca0fA2u63fbmbki+zs8t60c1ol1ZKvnwtQupyf/u0jf4p3hRMChzf
         /YezWXF9YZanUrwgRpg9uXmVHyOXy+BQabLTtTjJsoJFkhDs5UbGmSmCvE68xOAQjpyh
         x/ntYvX7b89IFYCyJi2rq7rycs5ARLhZ+nXtDUuRvQO9StUZlbV6XCmEMSWi9ClG14to
         ctC0y9Ok+c/3VUStbm4JQtZuOA7dbuDD7Ord/6F7axMCG/c1MVt0wcjyE7mL9cC6CDhs
         gYNBw3Oyzly2xhPVjTZtIk098a6ci04Ov4SpX6t8dpoFH7KkV+HzycGK2S+D7pswI0ml
         jxTg==
X-Gm-Message-State: APzg51DzGjIPqYI3RQd4grBGIAKL+gjyn9YHgPlkWrm3FkIYRE7eLw4Z
        rn8QW1uHlbQ8Feby79lxXegqXBVSfe+4B4h48vNuWw==
X-Google-Smtp-Source: ANB0VdZlHWPDAObEPX5M3wkR67Xy3MXCdMW/bJ1ZJ5a8faLYQUrlWAWBqpUDr3GZoZdCYiAfNssOVgrHn0jN17cAL6k=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr7694752ioa.277.1535618634004;
 Thu, 30 Aug 2018 01:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180828112721.28178-1-Eugeniy.Paltsev@synopsys.com> <20180828112721.28178-3-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20180828112721.28178-3-Eugeniy.Paltsev@synopsys.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Aug 2018 10:43:42 +0200
Message-ID: <CACRpkdbQryY-R+14GvYAEkLH+7Tr4Pvb6YohWouTwug7qEGbDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Document the Synopsys GPIO via CREG bindings
To:     Eugeniy.Paltsev@synopsys.com
Cc:     "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 1:27 PM Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:

> +++ b/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
> @@ -0,0 +1,49 @@
> +GPIO via CREG (Control REGisers) driver

Speling

Also should be "Synopsys GPIO via CREG" as this is likely just
for Synopsys and not general purpose.

> +This is is single-register MMIO GPIO driver to control such strangely mapped
> +outputs:
> +
> +31            11        8         7        5         0   < bit number
> +|              |        |         |        |         |
> +[   not used   | gpio-1 | shift-1 | gpio-0 | shift-0 ]   < 32 bit MMIO register
> +                   ^                  ^
> +                   |                  |
> +                   |           write 0x2 == set output to "1" (on)
> +                   |           write 0x3 == set output to "0" (off)
> +                   |
> +            write 0x1 == set output to "1" (on)
> +            write 0x4 == set output to "0" (off)

Move this documentation into the driver instead.

> +Required properties:
> +- compatible : "snps,creg-gpio"
> +- reg : Exactly one register range with length 0x4.
> +- #gpio-cells : Should be one - the pin number.
> +- gpio-controller : Marks the device node as a GPIO controller.

OK

> +- snps,ngpios: Number of GPIO pins.

Use the existing ngpios attribute for this, see gpio.txt

> +- snps,bit-per-line: Number of bits per each gpio line (see picture).
> +  Array the size of "snps,ngpios"
> +- snps,shift: Shift (in bits) of the each GPIO field from the previous one in
> +  register (see picture). Array the size of "snps,ngpios"
> +- snps,on-val: Value should be set in corresponding field to set
> +  output to "1" (see picture). Array the size of "snps,ngpios"
> +- snps,off-val: Value should be set in corresponding field to set
> +  output to "0" (see picture). Array the size of "snps,ngpios"

Move this into a lookup table in the driver instead, and match
the lookup table to the compatible string. The format of the
register is known for a certain compatible, right?

> +Optional properties:
> +- snps,default-val: default output field values. Array the size of "snps,ngpios"

Default values for different lines can be achieved by hogs
if it's OK to tie them up perpetually, else work on creating generic
inialization values in gpio.txt and implement that in
gpiolib-of.c for everyone. This discussion comes up from time
to time.

Yours,
Linus Walleij
