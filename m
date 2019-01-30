Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5350FC282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BF221473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548867297;
	bh=lVkrOEHVja1GBPeUdh9sZN/uMruO3xCX9rNXQH0caDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FNAU5n+zfXEQB1D8Dl2bnNyB91lIPl8NOhAwXS8haZyMla228/5VQaY4J7Z6oKcMn
	 sbxYIytpDnDx0j0LGFbLPHbiyCOIG/rPFKM3VsKVUNVKGbyEeRIVM/ArhsjOYYHaRq
	 WHrhZHyn9pKUFNrRJWafcID4oqDOQKINr16nKdu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbfA3Qyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:54:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35084 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731496AbfA3Qyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:54:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so217679otj.2;
        Wed, 30 Jan 2019 08:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/wszIoHTZhNfUGj58N2thSx9Hgwfdg0kYhSMxdgX9ok=;
        b=bYxPTW9azGtaD33gquS6k1+SokAM0MMfFCQLKSahSW+wNB6lywTgvvpNo+Jc0AnH//
         KBmrm5+m9KTFp2BQNS7rWVSei6aqob/Rm6OYhUfe+mg1QgkIlDXjkCIqSxJb4ybKlU9+
         Wn4pzK8QljCc7DdEzzE0oI1U/xbikiWIYXhmOQTA+UF84SBVVr2c5W2f+G5wj14LBq3c
         W455erHEMGUpnzVOvJgmaxzepFyxs2xn9OLT8hl7ZxphegXU4ilTRktAMUwgRVk1rGCN
         DPWWApQrDzwPtVpQRPjvIb4KgaIehzmdQd7L7AQ3zvmtIN2wabx4EJu7vNKRqIqBi9de
         SG3w==
X-Gm-Message-State: AHQUAub+BEUgyt0QCvvYZ3ieTY6bcMlCXdc5SIVgTMIvSw3TeDKZ8oQx
        IyVXe+4lzyEeNf53yvocSDZS9lg=
X-Google-Smtp-Source: AHgI3IZ6eYxjzvklLYWrsbqD7pn/0KpWfasqLjCfhPbs4rRLl4CsNSXdwfQsyXcTrq0XVN+jW/yVIA==
X-Received: by 2002:a05:6830:2109:: with SMTP id i9mr13171430otc.190.1548867294214;
        Wed, 30 Jan 2019 08:54:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l204sm827755oia.54.2019.01.30.08.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:54:53 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:54:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Add device tree binding documentation for MAX44009
Message-ID: <20190130165452.GA16535@bogus>
References: <2b847f2b4ed5a94d21c41274395b97eed3ec39dd.1548580142.git.bobbyeshleman@gmail.com>
 <ab7652d06474f951bf764fdc087035554772d147.1548580142.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7652d06474f951bf764fdc087035554772d147.1548580142.git.bobbyeshleman@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 09:09:14AM -0800, Robert Eshleman wrote:
> This patch adds device tree documentation for the max44009 ambient light sensor.

Wrap long lines.

Follow the subject style used for the directory (git log --oneline 
<dir>). In this case, 'dt-bindings: iio: light: Add max44009'

> 
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
> ---
> Changes to v3:
> - None
> 
> Changes to v2:
> - Clean up style
> 
>  .../bindings/iio/light/max44009.txt           | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/max44009.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/max44009.txt b/Documentation/devicetree/bindings/iio/light/max44009.txt
> new file mode 100644
> index 000000000000..b287d7732e37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/max44009.txt
> @@ -0,0 +1,25 @@
> +* MAX44009 Ambient Light Sensor
> +
> +Required properties:
> +
> +- compatible: should be "maxim,max44009"
> +- reg: the I2C address of the device (default is <0x4a>)
> +
> +Optional properties:
> +
> +- interrupts: interrupt mapping for GPIO IRQ. Should be configured with
> +  IRQ_TYPE_EDGE_FALLING.
> +
> +Refer to interrupt-controller/interrupts.txt for generic interrupt client
> +node bindings.
> +
> +Example:
> +
> +max44009: max44009@4a {

light-sensor@4a

> +	compatible = "maxim,max44009";
> +	reg = <0x4a>;
> +
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
> +};
> +
> -- 
> 2.20.1
> 
