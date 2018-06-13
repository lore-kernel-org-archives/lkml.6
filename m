Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4D301C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0267020693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDCrE6LW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0267020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935998AbeFMQAc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:00:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41294 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935726AbeFMQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:00:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11-v6so1647135pff.8;
        Wed, 13 Jun 2018 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6uN8KLVLEeKgTySSIUdMQ7iszYPM8XSsACbggqROSvc=;
        b=qDCrE6LWSQyMKGb9wxgV0iSXHX9SQYq2KRzbH9kLvaa6+bazdhMlAjCm9Wb3eC7IQP
         DW/WKnsqlEPCHHeaUuwWZhhX7y/smQMNg3HNjUFjxb/ykeYeyob4w+bAItbmeZW0dd49
         YvAqYeiTgseXhHdUs7f7WYYk2G5wlCtLUY+eTDC874uYHLKKqOEPWaqarlVL1pZDb7xl
         U8bIg28+tGKLbgrytChycEG5naNxDiw/n3taac9pRYTITAThkTiMApa+COdak82lqP80
         //86Sk5nTfx6x6yDKpyplZ1yVsxDcY7u7yUMFM9rZUwYqLSAGSK25ISBH0kUnjdIPbCF
         YoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uN8KLVLEeKgTySSIUdMQ7iszYPM8XSsACbggqROSvc=;
        b=OgSEICT9Y8cq/je1kXwZrSon1AriwfPMYmqaKnNW0xTZq2h12LJ015VhuWQ09VNrbV
         Vlub20FmudJyOMgEC6BmOoK57NoclDH87GgG+SG1ZfO2tWmdqsyVFCdRAtduI6bHmslI
         JJx4bE+X4HvreSwKWyWKcLuQeivCvK7OR4UWIJgDmOc4ykapSeq5wHcbhx1ANvNIkKz4
         0+bCaLeBn6foaoWnQxwfmRdt8kmK8xd1beiANLlDpKpJcww4x7wZTKdjgHTzhb6L1I3g
         3B2wqM8Eswe4+KU8+f5Ix/7E7B6qUPlPYwJ8orGkRrHdAbU+GBnlRokji8ozFLV0Ar9E
         +rUw==
X-Gm-Message-State: APt69E2iE2KunGZXUVu2qXKeEqYgK91AEMZKNFlSlFikHs/KZ1UP4nda
        fMDQzkpyOxns2gPw2Y58Gw==
X-Google-Smtp-Source: ADUXVKKYVyz07QD/erf9V4J6ybVDgQdKbUeICYrI1kdyj22uSLf7f6UunEAip02k7xNwsgnhxS4Ajg==
X-Received: by 2002:a62:c8a:: with SMTP id 10-v6mr5465238pfm.27.1528905629825;
        Wed, 13 Jun 2018 09:00:29 -0700 (PDT)
Received: from arch (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.gmail.com with ESMTPSA id y23-v6sm6388903pfa.73.2018.06.13.09.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 09:00:29 -0700 (PDT)
Date:   Wed, 13 Jun 2018 17:00:18 +0100
From:   Craig Tatlor <ctatlor97@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Message-ID: <20180613160018.GB10090@arch>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180607181306.9766-1-ctatlor97@gmail.com>
 <20180607181306.9766-3-ctatlor97@gmail.com>
 <20180611181515.GA32546@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611181515.GA32546@rob-hp-laptop>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 12:15:15PM -0600, Rob Herring wrote:
> On Thu, Jun 07, 2018 at 07:12:51PM +0100, Craig Tatlor wrote:
> > Add bindings for the Qualcomm Battery Monitoring system.
> > 
> > Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> > ---
> > * Changes from v4:
> >   Uses proper units and expands some definitions,
> >   along with changing vadc@ to adc@.
> > 
> >  .../bindings/power/supply/qcom_bms.txt        | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/qcom_bms.txt b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> > new file mode 100644
> > index 000000000000..a1a32d6ab460
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> > @@ -0,0 +1,91 @@
> > +Qualcomm Battery Monitoring System
> > +
> > +The Qualcomm Battery Monitoring System is found inside of Qualcomm PM8941
> > +PMICs. It provides open circuit voltage (OCV) and coulomb counter registers
> > +that allow the OS to infer a capacity level.
> > +
> > +Required properties:
> > +- compatible:                   Should contain "qcom,pm8941-bms".
> > +- reg:                          Specifies the SPMI address and length of the
> > +				controller's registers.
> > +- interrupts:                   OCV threshold interrupt.
> > +- io-channels:                  Should contain IIO channel specifier for the
> > +				ADC channel that reports battery temperature.
> > +- io-channel-names:             Should contain "temp".
> > +- qcom,fcc-temp-legend-celcius: An array containing the temperature, in degC,
> > +				for each column of the full charge capacity
> > +				lookup table.
> > +- qcom,fcc-lut-microamp-hours:  An array of full charge capacity values in uah,
> > +				one entry for each temperature defined in in
> > +				qcom,fcc-temp-legend-celcius.
> > +- qcom,ocv-temp-legend-celcius: An array containing the temperature, in degC,
> > +				for each column of the OCV lookup table.
> > +- qcom,ocv-capacity-legend:     An array containing the capacity for each
> > +				row of the OCV lookup table.
> > +- qcom,ocv-lut-microvolt:       An array of OCV values in uV, one entry for each
> > +				capacity defined in qcom,ocv-capacity-legend.
> 
> Need to say which of these are 8-bit values.
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for the review, will mark as 8 bit in v6
