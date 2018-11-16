Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DBBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D862086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D862086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeKQJIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:08:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44095 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:08:49 -0500
Received: by mail-ot1-f67.google.com with SMTP id z33so22785580otz.11;
        Fri, 16 Nov 2018 14:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qWxsm73hdnCUIRcqNmiXizK+kSIIxC7XaGtN2eUa0FM=;
        b=N/wX84hmtKPZAb7KqSZFZNSZTRWr2v/6l5JY515zTvBk24oOnN+WElm4nq+4FW8jck
         3pdpsMSlzoyNOjGlt0U+lKNMIzYkU4NKK+N1JoMr3TDTUcrsdM2zN6MEHMVS2xQc+HoK
         4ttjNk9gz/mUPlfA0YGgy1ZuwNwtiXNxFylKAQQ20BZGfSCYE0/RvK9ryhX9Iy14G+uq
         OPYsEh2J0YxfOKy/xWfHs+z8nCmKZ8ok8aWDTyB0ABj4u4zWuU/WD/MdC82PAFO3H4N4
         l5FF0mGz1aCpC/k18WhJh5RdtKDtIsornYWgzvRK9tvdysupBwTFOYWCnN3A7jd/OlNE
         qj9g==
X-Gm-Message-State: AGRZ1gI1bJ6aBhrytF7F0aNfvgJKJ4C44gmcm9pPCyr2PfXRg12YzH7A
        cyqMegFFjwo4YH/Ynhy6KQ==
X-Google-Smtp-Source: AJdET5d2Uumg84xIe77IoLqMslRQXdN0A3q1418N19x+GeiyrhMtT1W0h7JFgi0HKpp2Mi/qrzCe6A==
X-Received: by 2002:a9d:41ca:: with SMTP id v10mr8094409oti.101.1542408873431;
        Fri, 16 Nov 2018 14:54:33 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id o81-v6sm9711084oif.1.2018.11.16.14.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 14:54:32 -0800 (PST)
Date:   Fri, 16 Nov 2018 16:54:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan.popa@analog.com
Subject: Re: [PATCH v5 4/4] dt-bindings: iio: adc: Add docs for ad7124
Message-ID: <20181116225431.GA28284@bogus>
References: <1542108138-3711-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542108138-3711-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 13:22:18 +0200, Stefan Popa wrote:
> Add support for Analog Devices AD7124 4-channels and 8-channels ADC.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2:
> 	- Nothing changed.
> Changes in v3:
> 	- Removed the "adi,channels" property.
> 	- Used the "reg" property to get the channel number and "adi,diff-channels"
> 	  for the differential pins. The "adi,channel-number" property was removed.
> 	- adi,bipolar is of boolean type.
> Changes in v4:
> 	- Used the bipolar and diff-channels properties defined in the new adc.txt doc.
> Changes in v5:
> 	- Removed the gain and odr properties from the example.
> 
>  .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 75 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
