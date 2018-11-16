Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2375AC04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36F52089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36F52089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbeKQJHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:07:38 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38048 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:07:37 -0500
Received: by mail-oi1-f194.google.com with SMTP id a77so15042793oii.5;
        Fri, 16 Nov 2018 14:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T5VDYbaxaqH7laNVv1LZmk8yutXa0Ico8lW66bwv+NQ=;
        b=Pj/DlGMep5g9A5Swf9mRIFBMHbagGmLcxGG8FS52NDVl7DBBZsYW70nEMtk1ySPn91
         234/gbSaGhE0+mYvllmClG+5kJufXd2w9tsgiEXJuKSRODV1T5mPrFxgFo2T5aV5dNNC
         xmZbmDd9OzTMDqYDazY6aI23qNrDJn1SUYij950kEzrlSa+eGdsnhQqrJWI2ScB6rz26
         EFOvJairHAr5sYz3ze48hT5Fhq+oO2yoD5Trqs37riPZyzgaJUuIjs4azHTtjiOBNZxB
         mKHaGAeBbkbQT25gVUl/yOM2EGCQ7LsSixR52YdU2NMyY2phRHGXgCncVxKE8gZ7v+3u
         zWwg==
X-Gm-Message-State: AGRZ1gIEXqHWAXj8hI/W9t0+bduYi2kqlWtmVBv/IBbo0uKFcjsbBNQI
        /2G/+h+aee/+7E7o9DBseA==
X-Google-Smtp-Source: AJdET5e2nGBP3DtzhA+9LXUg0valsNROKMR0+3fHLzYzHSQknuCaOYB78CLwA9CjCxHMPKp29F4vbA==
X-Received: by 2002:aca:ed92:: with SMTP id l140mr1967724oih.112.1542408801126;
        Fri, 16 Nov 2018 14:53:21 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id p204-v6sm12174857oib.25.2018.11.16.14.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 14:53:20 -0800 (PST)
Date:   Fri, 16 Nov 2018 16:53:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan.popa@analog.com
Subject: Re: [PATCH v5 2/4] dt-bindings: iio: adc: Add common ADCs properties
 to a separate file
Message-ID: <20181116225319.GA26554@bogus>
References: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 13:21:01 +0200, Stefan Popa wrote:
> There are several ADC drivers that depend on the same device tree
> bindings. Rather than continue to duplicate the properties, this patch
> adds a common adc binding document that can be referenced. For beginning,
> only two properties are documented.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2, v3:
> 	- N/A.
> Changes in v4:
> 	- Added this commit.
> Changes in v5:
> 	- Nothing changed.
> 
>  Documentation/devicetree/bindings/iio/adc/adc.txt | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
