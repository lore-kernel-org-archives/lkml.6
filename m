Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18BCC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8564820675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547674858;
	bh=OTp2nIulo/RBn8xZWus1RKDhpD+Q6SB/hcK9lr+Fz74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e4sHI3QZYZoVYVjXAbLguM903QssXohabFOQf+Awk0eKXftofHQyizXJIwnMP/unK
	 ROPhejzTK9hynZwjS/8T8z/1fwk3EMdClFTPBszmqjvMRQtePnJQg0AENHgJo9pSMF
	 IhKu8DJmc3ZWKScWEE17lQUoVB7XlAvMS3RMlpts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbfAPVk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:40:57 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41987 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfAPVk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:40:57 -0500
Received: by mail-ot1-f48.google.com with SMTP id v23so9167555otk.9;
        Wed, 16 Jan 2019 13:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DQ2nEF4GJXL+CBtlCXl6GU+saOaf/4f16zN5OoYLAxg=;
        b=NVsLhoWYQNjSDFXklsi8MuZoXkAwuka5pgGaDjQRA4lTMUF8EC/OTkfSuVREfEdhCw
         BvG91nOLKzpinHqvzkVPChmGdpvvyjNM2pzG2bakVIG5CKjfJnMPPyHsL+Ccegw8BAbJ
         hx+w0irecdf16GPBxdHG0NSDUHBeCUoKpTRA+9MKEEGyVcpGo5GaBuPQvH6H4aAMQuC4
         zwTeZ8Oea7CRhnL4odz0cn5tiaZyocHLACzSad//SCF3blV64srV/df5XocPiLIlUgNG
         9qd8y943rmF7bnorC3JPzu/bW/5wAaSt8ktZWLA40UwlB3HiTTg3T6KucakJQAWktISc
         z0Ew==
X-Gm-Message-State: AJcUukfiTSFoQDkQrVcNbSBRPlb9VoXN3mpIX96tyydwlRgAT1a3eO+s
        BRg3zi5tFbpeWEqnKZiiwg==
X-Google-Smtp-Source: ALg8bN4ta6KLEDnsarbAFfCMKSdl6xjuajp19zoiRhplWj98SFsaBX5dAS4qJlci3IbqkmeSv/61Wg==
X-Received: by 2002:a9d:64c8:: with SMTP id n8mr7181076otl.115.1547674856268;
        Wed, 16 Jan 2019 13:40:56 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t2sm3007409otl.4.2019.01.16.13.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 13:40:55 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:40:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan.popa@analog.com
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: Add docs for AD7768-1
Message-ID: <20190116214055.GA3346@bogus>
References: <1547555643-2248-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547555643-2248-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 14:34:03 +0200, Stefan Popa wrote:
> Document support for AD7768-1 Analog to Digital Converter.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2:
> 	- Added information regarding the simultaneous sampling of the SYNC-IN pin
> 	- Added the reset-gpios in the binding.
> 
>  .../devicetree/bindings/iio/adc/adi,ad7768-1.txt   | 41 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
