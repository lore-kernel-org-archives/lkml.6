Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048D4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAFB218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548407285;
	bh=wKWkzlFVz/XVhTjd5gltj9sRGHDEu4kLBO5RKlJSVaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q1sNGZKsahQpb0TU/6wLWu82wnmTyc1xM59QAsTG/RFcDUoksdUgtXuHTuKLnMOSh
	 dpnsOWsLnOUACxKjVMs9tO5wcziVad4FqMyeD3lK07fcVqWWOjNMx9ZFpaXkdTTqY4
	 9MGfYGzJ52dF0RKS9mDjcns5hsfj1eJONlbqMP7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAYJID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:08:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39374 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfAYJID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:08:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so6394592lfh.6;
        Fri, 25 Jan 2019 01:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CtSiaZshpaEHWQ5nMsvhKse3z+gGNNoMcIPdg+hmKao=;
        b=Vw5Ua4RhQvLqWrYnd0MG2GnDsHeWcTcXYujjkNzxqVOXqkUhSrL4MMUvXM1mTaNx6y
         TNXzaM5lPuM4bNHv/Br+K7ohuPDgtZuq4jF02S6E7CAKXLc9ksozdPGrGhSLPocEo7Jp
         oRboKF7KM6Tf+alAiyVGOW6eRnHgdOA8pDAWmlEMOGtHZQsK9mKNgc4VyRvKnzo2FlOc
         LayxQw7/V7EInk2SQaOhtSlyYDvBFfrJyIyoOc8A8jF7HnwETGu3Tqhbbqy2p443QazI
         PWghXdkyySf18jXJ3rEIQGRz9LJCei8Uid0upH7qn2AYKzmO3VfIn1adMkHFnNPrHxEM
         lJKA==
X-Gm-Message-State: AJcUukeKEIU+1Q61UFTuMzDnrexI8/oPuJrxKeWcQkMnW4sPBtHQEfs6
        44guBdwKeYF82Lf4KekevaE=
X-Google-Smtp-Source: ALg8bN4hjUbb2J0veFYxOi3Xj3vFjhLPqZsi5bvN9C4W0SeD9l+Gh4TE6iiMo5YCkesO/U5cVC2hsA==
X-Received: by 2002:a19:3b45:: with SMTP id i66mr8315754lfa.28.1548407281364;
        Fri, 25 Jan 2019 01:08:01 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id n8-v6sm1524606lji.90.2019.01.25.01.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 01:08:00 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gmxSt-00085A-G3; Fri, 25 Jan 2019 10:07:56 +0100
Date:   Fri, 25 Jan 2019 10:07:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190125090755.GB3691@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 05:54:32PM +0100, Loys Ollivier wrote:
> Add binding for Mediatek-based GNSS receivers.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v2:
> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> Moved current-speed as an optional propertie.
> Removed the status line in the example.
> Added "mediatek,mt3339" compatible.
> 
>  .../devicetree/bindings/gnss/mediatek.txt          | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> 
> diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
> new file mode 100644
> index 000000000000..fd984b4a9a6d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> @@ -0,0 +1,39 @@
> +Mediatek-based GNSS Receiver DT binding
> +
> +Mediatek chipsets are used in GNSS-receiver modules produced by several
> +vendors and can use UART, SPI or I2C interfaces.
> +
> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> +properties.
> +
> +Required properties:
> +
> +- compatible	: Must be one of
> +
> +			"globaltop,pa6h"
> +			"mediatek,mt3339"

I'm not sure it makes sense to add the GPS chip itself as it cannot be
used stand-alone AFAIU, and either not way would require a lot more
resources to be defined than what you add to this binding.

> +
> +- vcc-supply	: Main voltage regulator (pin name: 3V3_IN, VCC, VDD)

The pin names in parenthesis were copied from the sirf-star binding and
were used to capture the various names given to this supply by different
vendors. Please drop as it doesn't apply here.

> +
> +Required properties (I2C):
> +- reg		: I2C slave address
> +
> +Required properties (SPI):
> +- reg		: SPI chip select address

While the mt3339 appears to support these interfaces, the globaltop one
does not.

Have you looked around for a small sample of mt3339-based receivers, to
see whether anyone actually provides these?

> +Optional properties:
> +
> +- timepulse-gpios	: Time pulse GPIO
> +- v-bckp-supply		: Backup voltage regulator
> +- current-speed		: Default UART baud rate

Looks like you forgot the optional NRESET input and 3D-FIX output (even
if the latter might be of limited use).

> +
> +Example:
> +
> +serial@1234 {
> +	compatible = "ns16550a";
> +
> +	gnss {
> +		compatible = "globaltop,pa6h";
> +		vcc-supply = <&vcc_3v3>;
> +	};
> +};

Johan
