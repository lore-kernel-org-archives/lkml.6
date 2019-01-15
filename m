Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BCBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756A9205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547586422;
	bh=iiRSQ6/YXWsrg7QNRO9LiN4tuhzIuCt4w419aI3LojM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t2YVa1C5tn2Gmit+ED3IWywxwi3/quYwneBk62/ZeM1VDdnqzeoK3qwfPwaGzLASe
	 fLyCDnwzguwTwiBFBVa5QYpskPpcFL9FgFI0Yhohh4SWjrllFHofY7ierjsQ29XxPe
	 D3Yiy164VHzlDSwyqpge293JxAigWtGab8hd2GIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbfAOVHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:07:01 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39678 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732849AbfAOVHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:07:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id i6so3293472oia.6;
        Tue, 15 Jan 2019 13:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BsLyQbaZ+Ul9+xTqL9g8Pc8gXDyIS2lUCf1BJjiDfmc=;
        b=ntNMQw3RG5KNgG5cDH4XMSaACdBaEKxuoH6AuXDJH8PHJIvvqP3VKT9bU73b4duPah
         DIA4fiEy2b78aKu2Astb0dbieVU79kvlkecTx3Rg1I/ejZelNaN1L4sovXo6nuKDVgjJ
         G5fZFyhaSKq6/ladCgzr8UdqqECNHuqHW8Nkm90lKuEu3F2em5qrq2/W2IphvWg+LmJG
         PgZ7sep+V/c35E7fzdYqB+5czf11QVTbUZOsmyE75ny79Uq4HIHEZEEP3iDcb6TB9IFA
         0zBhrnOM9BbodRaMhJJEvYiVHj477qx5YTa/aQ0G84yO5vXiKVOH7RaccNHrHBZXROFZ
         tnrQ==
X-Gm-Message-State: AJcUukezdB5smVShUCEGkf0Ocg99bFG4g54cuvZcMmu5W6WqdfPgkoqR
        daN8osADUf8vBT4oEOk8dQ==
X-Google-Smtp-Source: ALg8bN7M4ZAfEs+MlesDeGgyJlsb32vlzY8SZGxCX6dbWcReacVtMbMuR+waPg6jPwwLgmk7dy6N5Q==
X-Received: by 2002:aca:cc:: with SMTP id 195mr3011216oia.297.1547586419771;
        Tue, 15 Jan 2019 13:06:59 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id m89sm1949659otc.35.2019.01.15.13.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 13:06:59 -0800 (PST)
Date:   Tue, 15 Jan 2019 15:06:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v2 2/5] dt-binding: pcf8523: add xtal load capacitance
Message-ID: <20190115210657.GA24662@bogus>
References: <20190108185414.26922-1-sam@ravnborg.org>
 <20190108185414.26922-3-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108185414.26922-3-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Jan 2019 19:54:11 +0100, Sam Ravnborg wrote:
> The NXP pcf8523 supports two different xtal load capacitance
> - 7000fF  (7pF)    HW default
> - 12500fF (12.5pF) Minimum power consumption, driver default
> 
> To obtain a precise RTC the pcf8523 must be configured
> with the correct capacitance load of the xtal.
> 
> Add a property to specify the xtal capacitance load.
> The default value matches that of the current Linux driver.
> 
> With a dedicated binding remove the entry in rtc.txt
> 
> Signed-off-by: Søren Andersen <san@skov.dk>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/rtc/rtc.txt         |  1 -
>  2 files changed, 18 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
