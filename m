Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C226C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2489206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2489206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeKGG45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:56:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43350 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeKGG44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:56:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id k9so12861287otl.10;
        Tue, 06 Nov 2018 13:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Shi2t19x1/l9pWw+PJ4j1szVE7v45jhITMf+OngfgF4=;
        b=KMC93DtJ6rMmynA29ql/shAJgBiJ4yokzGy3vsxORk0BjCsJElMostnIys96/pDAEw
         mE+XpVRMoPNSfjOEHaOoaFE5J6lQgdq/4w1QCI1C3Sw9Eph/OWd7uSMne8awQ25EEjC8
         2Qg2Dd9XUfpdH0I0wgkOrR1hJcvURM/t++RMu7xisMbjAnMMzeM+jg7T87pIm+VMIPAA
         e3M6cmjenKfJcWT48SFjDR1fDhsiRTx6xR1UUPLJ0NByUmw2HgkWPKJJ7cYTuDCdy/+f
         PNMKoUXlMJMmcwMCiiG1JKZRX35T1q+E+4d/rSsSjb9DzIjMbbKvOR35e9eTVIXVpk2l
         1cWw==
X-Gm-Message-State: AGRZ1gIO9N3igTf2VWYwVrcYT5R9YJPwJWRHpHJY1eUf3Yiz0eJ6QRmY
        rljcoSAfsCXVpVEPkJSwug==
X-Google-Smtp-Source: AJdET5dH19pXZPXlNbsf+jGV1TWcsKTOpVyvbwL4PZRwDd6HE9d0nfDXQISqaxMMvlGkYyOx2GnOpg==
X-Received: by 2002:a9d:7097:: with SMTP id l23mr12064352otj.49.1541539782951;
        Tue, 06 Nov 2018 13:29:42 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e24sm3635608otd.63.2018.11.06.13.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 13:29:42 -0800 (PST)
Date:   Tue, 6 Nov 2018 15:29:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Carlos Iglesias <carlos.iglesias@emutex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dan O'Donovan <dan.odonovan@emutex.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: Add support for
 Honeywell HSC SPI sensors
Message-ID: <20181106212940.GA13434@bogus>
References: <20181026181406.14545-1-carlos.iglesias@emutex.com>
 <20181026181406.14545-2-carlos.iglesias@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026181406.14545-2-carlos.iglesias@emutex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 06:14:36PM +0000, Carlos Iglesias wrote:
> Add device tree bindings for the HSC pressure sensors.
> 
> Signed-off-by: Carlos Iglesias <carlos.iglesias@emutex.com>
> ---
>  .../bindings/iio/pressure/hsc_spi.txt         | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt b/Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt
> new file mode 100644
> index 000000000000..2302d6eef7c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt
> @@ -0,0 +1,85 @@
> +Honeywell HSC Series of Pressure Sensors
> +
> +Pressure sensors from Honeywell with analog, I2C and SPI interfaces

But you named the file with 'spi'. You expect 
> +
> +Required properties:
> +- compatible: selects the sensor model; must be one of the following
> +	"honeywell,hsc001baa"
> +	"honeywell,hsc001bab"
> +	"honeywell,hsc001bac"
> +	"honeywell,hsc001baf"

I normally tell people to imply things from compatible strings, but this 
may be a good case where some properties make sense. The last letter 
appears to be 'transfer function'. Maybe even the pressure range should 
be a property. I think it depends if there's any other s/w visible 
differences.

Plus this list doesn't even include the differential or gage parts and 
those lists are longer.

> +	"honeywell,hsc1_6baa"
> +	"honeywell,hsc1_6bab"
> +	"honeywell,hsc1_6bac"
> +	"honeywell,hsc1_6baf"
> +	"honeywell,hsc2_5baa"
> +	"honeywell,hsc2_5bab"
> +	"honeywell,hsc2_5bac"
> +	"honeywell,hsc2_5baf"
> +	"honeywell,hsc004baa"
> +	"honeywell,hsc004bab"
> +	"honeywell,hsc004bac"
> +	"honeywell,hsc004baf"
> +	"honeywell,hsc006baa"
> +	"honeywell,hsc006bab"
> +	"honeywell,hsc006bac"
> +	"honeywell,hsc006baf"
> +	"honeywell,hsc010baa"
> +	"honeywell,hsc010bab"
> +	"honeywell,hsc010bac"
> +	"honeywell,hsc010baf"
> +	"honeywell,hsc100kaa"
> +	"honeywell,hsc100kab"
> +	"honeywell,hsc100kac"
> +	"honeywell,hsc100kaf"
> +	"honeywell,hsc160kaa"
> +	"honeywell,hsc160kab"
> +	"honeywell,hsc160kac"
> +	"honeywell,hsc160kaf"
> +	"honeywell,hsc250kaa"
> +	"honeywell,hsc250kab"
> +	"honeywell,hsc250kac"
> +	"honeywell,hsc250kaf"
> +	"honeywell,hsc400kaa"
> +	"honeywell,hsc400kab"
> +	"honeywell,hsc400kac"
> +	"honeywell,hsc400kaf"
> +	"honeywell,hsc600kaa"
> +	"honeywell,hsc600kab"
> +	"honeywell,hsc600kac"
> +	"honeywell,hsc600kaf"
> +	"honeywell,hsc001gaa"
> +	"honeywell,hsc001gab"
> +	"honeywell,hsc001gac"
> +	"honeywell,hsc001gaf"
> +	"honeywell,hsc015paa"
> +	"honeywell,hsc015pab"
> +	"honeywell,hsc015pac"
> +	"honeywell,hsc015paf"
> +	"honeywell,hsc030paa"
> +	"honeywell,hsc030pab"
> +	"honeywell,hsc030pac"
> +	"honeywell,hsc030paf"
> +	"honeywell,hsc060paa"
> +	"honeywell,hsc060pab"
> +	"honeywell,hsc060pac"
> +	"honeywell,hsc060paf"
> +	"honeywell,hsc100paa"
> +	"honeywell,hsc100pab"
> +	"honeywell,hsc100pac"
> +	"honeywell,hsc100paf"
> +	"honeywell,hsc150paa"
> +	"honeywell,hsc150pab"
> +	"honeywell,hsc150pac"
> +	"honeywell,hsc150paf"
> +- reg: the SPI chip select number used by the sensor.
> +- spi-max-frequency: maximum clock frequency (Hz) used for the SPI bus.
> +  The maximum value supported by the sensors is 400000.
> +
> +Example:
> +
> +	hsc_spi0: hsc@0 {

pressure-sensor@0

> +		compatible = "honeywell,hsc010baa";
> +		reg = <0>;
> +		spi-max-frequency = <400000>;
> +	};
> -- 
> 2.19.1
> 
