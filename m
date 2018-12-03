Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09151214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09151214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeLCKmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:42:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38703 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCKmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:42:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so10293144ede.5;
        Mon, 03 Dec 2018 02:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Im80WWWkrd2/JvoAz7JLYb++LqOvBai9fapBNVVQADA=;
        b=NpU4DfHHKjDxh6BaFOvcLqphZvLP22IGM3wV8w2e31FJy4LydRQJS/nOJNQLM+P2T2
         89b5eYlQk3YkRxvVeMc/vTaSfGtNEztlB600Zx/TulUYvDDaUASxafOry2HRlk48tpFc
         zlsJOVktum+RH88R3pqqC+a4AmXSfGNegi1/eCVLSa+oAVcBNA8M3ttATTmieySq4gy0
         R2CTYMyD7CdwwhLEcvNWRHi/7RoKkz9xEW0PQALeaLzpFQ58nwKOfWNrzJUSUwY4bi1t
         OwM61hJlFr93KtXlt10LvwgFLcsOTEbF9sGxGkjsy2ec6j9KWU33VaXJ7HJxnZD+4zue
         JOIw==
X-Gm-Message-State: AA+aEWZR+Dbc98xjcMCzKixfc5fi0DuSnOu3D4aajIXvGUCXYHoFSZoX
        L9bCV4/stWd1upKVLp2i6KbALwfVuSgVyA==
X-Google-Smtp-Source: AFSGD/V3C/Hmm7pOvVpbM0WTSBNpSt3D38Wgv0YsiVaGboZ5awKr4QS71h23vT/Y5nDmGXbh+b0svQ==
X-Received: by 2002:a17:906:738b:: with SMTP id f11-v6mr12519377ejl.219.1543833712185;
        Mon, 03 Dec 2018 02:41:52 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id g37sm3970677edb.85.2018.12.03.02.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:41:51 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id a18so5125829wmj.1;
        Mon, 03 Dec 2018 02:41:51 -0800 (PST)
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr7543181wmh.124.1543833711378;
 Mon, 03 Dec 2018 02:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20181203101547.16835-1-jagan@amarulasolutions.com> <20181203101547.16835-5-jagan@amarulasolutions.com>
In-Reply-To: <20181203101547.16835-5-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 3 Dec 2018 18:41:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
Message-ID: <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: input: touchscreen: goodix: Document
 vcc-supply property
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 6:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> vcc-supply property is need for some Goodix CTP controller like GT5663
> where 3.3V external pull-up regulator connected via controller VCC pin.

"External pull-up regulator" sounds fishy. Chips have power supply
pins, either combined, or separate rails for analog, digital, and I/O.
For Goodix chips these are AVDD28, AVDD22, DVDD12, amd VDDIO. The name
and description you provide match none of these.

If a regulator is needed for pull-up resistors on the I2C bus, this
should be referenced in either the I2C bus master node, or if the I2C
bus goes through a pin controller, in the pin controller node.

Putting the reference in the slave device node is wrong, since it
doesn't actually use it. It becomes even clearer when you have multiple
slaves on the same bus, and you reference the same regulator in all
of them.

Or, as a last resort, you could mark it as always-on with a TODO note.

ChenYu


> So, document the same as optional property.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index f7e95c52f3c7..604766e347ce 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -23,6 +23,7 @@ Optional properties:
>   - touchscreen-inverted-y  : Y axis is inverted (boolean)
>   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
>                               (swapping is done after inverting the axis)
> + - vcc-supply          : 3v3 regulator phandle for controller VCC pin
>
>  Example:
>
> --
> 2.18.0.321.gffc6fa0e3
>
