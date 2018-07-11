Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAF6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425AB208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425AB208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbeGKN7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:59:03 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42680 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeGKN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:59:03 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so49364105oib.9;
        Wed, 11 Jul 2018 06:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RVcjjN1i8RR7iCSSyQEFcNNK3C1IApQ8w7sLerOGTP0=;
        b=Qet77dpB7Z8moXXaRCXsM8ChN1OPKd9Xac1HCx/Zpdeo0J9kMn6YzYns/OjUxRw2cr
         3ItN1bGuoGJiQ+RcxQgLXWzCzihrg4yMg/4T904vahppsp/ACblO09zj9Q2pzMIhXfpu
         oWNcis1mQfrvNP3GCnuoUqdINh7/TpK0xgHxhV6iobvowarr54zDKtZXHuXlOREoj1W7
         Fwi9sCEE1IsQvQg1JmfdMCfH6tXbQwguYxWXBRFVGRypsi0xBsIv1OZVJBCFdSwgypxQ
         2RwbMcFt1JhLioN/7KsyLkwZDIFI6O920wR3GyqlK1TscBA3m3RS/2FZGOUWQkzmXFYQ
         6wQg==
X-Gm-Message-State: APt69E0lLSI6PYeXwdofdLd6n9zPvrfcGa6c6A6mEl2SxqkmacmxJt5h
        UlK2ZybZp2OgRGU27n0Kgw==
X-Google-Smtp-Source: AAOMgpd2rEKGcSxNELrIm/T5fLSXlizeUCvntjECHdyWBnymYvg+VfS9uhjqU4plqm0TT8MSB/IMfw==
X-Received: by 2002:aca:401:: with SMTP id 1-v6mr11420740oie.28.1531317275632;
        Wed, 11 Jul 2018 06:54:35 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r131-v6sm12811647oih.16.2018.07.11.06.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 06:54:35 -0700 (PDT)
Date:   Wed, 11 Jul 2018 07:54:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: hx711: fix spurious unit-address in example
Message-ID: <20180711135432.GA16230@rob-hp-laptop>
References: <20180710181937.GA5398@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710181937.GA5398@arbeit>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 08:19:37PM +0200, Andreas Klinger wrote:
> Device tree compiler (dtc) gives a warning if a device node has "@" with a
> following number as it's name but no reg property.
> 
> Fix the example in the documentation of avia,hx711 to conform to dtc
> behavior.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
