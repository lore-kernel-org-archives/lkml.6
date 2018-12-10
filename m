Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAA4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733752082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544480597;
	bh=TPoM3PgdtIYGs0n833gzNCdXvA6B3ziaxQb3ciWxDAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rf3E+T/ge4tMQfQIMvHJYXsGTJ7CmmuTcMJUbSjTBmeKFAJbOJSZ50H3z/CCd5BuI
	 ZGezrv+Yt5pGTlRReUXm2itxgp5KigHpZro2NjGQC+/yPJO0kp0FZSCgP4JRf0gYQD
	 SV/AiHB+tZS1drMq7pFbr4mBNMpOQeXP+0H4EtHg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733752082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeLJWXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:23:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42536 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJWXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:23:14 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so10379025oiw.9;
        Mon, 10 Dec 2018 14:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mtUeuRXuDLvGuErdQ06ThAwcPVD32TJqmEtgskAX2bI=;
        b=EefzWDSDEFXXgBYAeR3+xIUBv4R4fGw+q9hEyWxIwH5JMN2ZvLPO3GzlKoKYIZKn+8
         nHXLvKq3Ko3EHzaPnZKioWMiwGv9astmgblLCkYTBIkriVSqnjQDWpGGJu0LH6sDwXZk
         OB6/6dbDpewmmQEJM1Q8G+thnEUwNG3M+e8aHhdci665YP086lw9zv6QsXt9faZdAx+n
         n/4R7/H9mCNGL83yoZrBAzNFOx4T2faDZ8xc093uoDWs2xdkkFv9GTmzXrqiN3vrfghF
         OTlhaNXAXx1KD8fqVML3BTaIdALn/sZLK/wNo8rbvCYc+4pO0+unHDhME9XoX1EyYw18
         rARA==
X-Gm-Message-State: AA+aEWbjoQAIXJ7o9yN3Z0vkN+6SSAf7m0qf7coWsN4vuIWe82si/HOu
        K/GhpX93YHbW5uPgcoYi0g==
X-Google-Smtp-Source: AFSGD/WQYUqnuLFO93fp208ADDm8zPNJKUpi1Yoknu7UdQe+tAOZ9E7KXHtbPdXk+89kCvBapnM6zg==
X-Received: by 2002:aca:3541:: with SMTP id c62mr8008411oia.330.1544480594064;
        Mon, 10 Dec 2018 14:23:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f34sm6044601otb.25.2018.12.10.14.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 14:23:13 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:23:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan.popa@analog.com
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Message-ID: <20181210222312.GA30114@bogus>
References: <1544439865-22967-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544439865-22967-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 13:04:25 +0200, Stefan Popa wrote:
> Document support for AD7606 Analog to Digital Converter.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2:
> 	- fixed indentation issues.
> 	- used gpios instead of gpio.
> 	- added vendor prefix for conversion-start-gpios, first-data-gpios,
> 	and range-gpios.
> Changes in v3:
> 	- Added adi,oversampling-ratio-gpios.
> Changes in v4:
> 	- Specified if the gpios are active high or low and set the flag
> 	appropriately.
> 
>  .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 65 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
