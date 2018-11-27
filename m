Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02A2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1E0208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1E0208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeK0Msk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:48:40 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35064 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeK0Msk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:48:40 -0500
Received: by mail-oi1-f193.google.com with SMTP id v6so17889802oif.2;
        Mon, 26 Nov 2018 17:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CZcm17AUvT/DPa5ty8RFVNtthrxZqKOHSUvSWVXIRaQ=;
        b=CsuttVeza23vgyvqB81ZFZsxX2YPNUIpLFr/OfPktgo7SwOOsQARlNd/nAgGIPszwv
         +V3+myLVCLfHtaDXJR6CsHw8TmYVzf9VVfG9h+/c7ERAFM8rV0jbgS/rCvUbYlF7Wn0J
         5jLg1LwFe3R98DZYnFx4zYlgP5cwqaLvfnN4cVRkuA8VOeeAqAywWcrBpDjO5N3ole9B
         abHfh+IIsHFZOATEFFLNNbrZov+bqw+kMzLlvWBiqIqPK9yMLFmqHTPPWo2ehs6OHkIA
         WS3vyynO1jCWJ4EwIEKHxwHT/Kwc0Sl/cYF/mZToRqnlInEll2c0StrZeWABaVTpnE/z
         7RzA==
X-Gm-Message-State: AGRZ1gIZkC8ZRpVsPixEsDIB4ociSZ46NvqgI4qTPQAYH14cHdqMnEJ4
        XKnpwmsg/u2gl66mz8Dj2w==
X-Google-Smtp-Source: AJdET5cYUAMzEjZ7P6khayqxQvYreiqXn7QQYv0roDp1tTWB+LqYbp43s3HbM13Hou5CgisKgDXsrA==
X-Received: by 2002:aca:5117:: with SMTP id f23mr17532845oib.72.1543283549301;
        Mon, 26 Nov 2018 17:52:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a52sm749015otc.51.2018.11.26.17.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 17:52:28 -0800 (PST)
Date:   Mon, 26 Nov 2018 19:52:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: Re: [PATCH v3 4/7] dt-bindings:iio:resolver: Add docs for ad2s90
Message-ID: <20181127015227.GA11401@bogus>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
 <20181124002312.6923-5-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124002312.6923-5-matheus.bernardino@usp.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 22:23:09 -0200, Matheus Tavares wrote:
> This patch adds the device tree binding documentation for the ad2s90
> resolver-to-digital converter.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
> Changes in v3:
>  - Added reference to spi-bus documentation after spi properties, as
>  suggested by Alexandru Ardelean.
> 
> Changes in v2:
>  - Rewritten 'spi-cpol and spi-cpha' item to say that the device can
>  work in either mode (0,0) or (1,1) and explain how they should be
>  specified in DT.
> 
>  .../bindings/iio/resolver/ad2s90.txt          | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
