Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B254C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C031C20BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C031C20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbeGKN6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:58:30 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40811 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeGKN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:58:30 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so49359662oie.7;
        Wed, 11 Jul 2018 06:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kssCaAcK07u0n6jgy4OvbfW9NhX3JXo3fx801E7DOE8=;
        b=SrJBbEdolufcIFmIFrfANKmdYHc+GWEbrKRkZJEBG6BJlkQDsSTBhRvuqUdsyL7pTb
         cuJ6UL1XxmjOXdxNgXFBwVqB3jy0vXA4BDwikXV3NTg6sNPmFbGJLAotC5ODJj7f8FWS
         /dtdfIi89h+cBvgmAKd2/ww+2FkjAfM/IGJ4ER6IRun3995/ACXDjlfcls/X8vhh/YQk
         0Yq+zbEYAgH6ifW2xGN9D1JMy/rylWe9F2eAvxqk/f7w8RRZXuFecLaZXv9KzrXwKpJQ
         9dbTG6yScM741oVrjDUM+Y9isSNSs8zTc+35spK80q5fTibTQKrDy5TKpjzSsg0OceCG
         pt9Q==
X-Gm-Message-State: APt69E3ceiEPt59V0p41CovWfmP/irMJ5Cbvg49Syyc95kU7BZcu9YHr
        2RWAUoGrzgX7BkQfjks/sQ==
X-Google-Smtp-Source: AAOMgpcsJS4C/vXQ4wXpAnBWSQ9MgQpO5Fe4Jw4SE8xRUMmAdfxBv/46SZ3K/uhb/iwmfHYfCYUvYw==
X-Received: by 2002:aca:3a03:: with SMTP id h3-v6mr6465269oia.270.1531317242493;
        Wed, 11 Jul 2018 06:54:02 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 1-v6sm5677796oir.19.2018.07.11.06.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 06:54:01 -0700 (PDT)
Date:   Wed, 11 Jul 2018 07:54:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] iio: hx711: add clock-frequency property in DT
Message-ID: <20180711135400.GA14723@rob-hp-laptop>
References: <20180710181831.GA5374@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710181831.GA5374@arbeit>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 08:18:31PM +0200, Andreas Klinger wrote:
> Add clock-frequency property for hx711 ADC. This is the frequency of
> PD_SCK.
> 
> After PD_SCK goes high DOUT is read just before PD_SCK goes down again.
> This is necessary because of parasitic capacitance on the wiring.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
