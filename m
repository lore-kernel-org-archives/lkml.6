Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C65C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767062085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548084317;
	bh=fvM+QgS8uckq47UGXWNzrw/rqzBOoT6/XNjq/kZX/Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rb8pBA6rmegL41deMM2GQXAW1Q9Xf8Z0t/fq0NV4c10/DU+QnNZt5gxO2Dl/eqh+b
	 lhaSLWSCqJF+tjwGJX132HLkWF6+bWnCJrV6lE2u+/VkQBypRs0W227Q45PfxJHATz
	 qr3wxBzQdOMv9cAI+H13sHgbTHtHOutbUuJ4QJak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfAUPZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:25:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40319 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfAUPZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:25:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so20825111oth.7;
        Mon, 21 Jan 2019 07:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X4+H9UPEzKgdDygsarEeI3EG7SNOo1HwXgFWdEUdE4s=;
        b=skBOBZi7FHbPlMu/APTlz8SHBsa7I2soCagSLca0XfhEi7YibWNelFU2Cu7TJmpcuB
         q9xhQEy81nLkW9OZVwDqQdNr+Adxeef+5ALJaAx/TDCduetJ3Wfbvwt8KHlGZJIl/Lwg
         PpuSX0sRKqoDobmw6nnqWu+qCsAGoZ7yriBfZmwwbmnVFEl8BxEzRiE+PrcmExMRaIYy
         qjRnCyCndw7NiNM6EBHNCPv19evmklEqgmiAr7XBETU8ZXi3uvDoHscG+shyR4coMkiy
         MdDedhhHrX5PtHCxJH4kWXpsAm0p4lHn2w/zOjy1zToE9hp6zUi9Eu43Byq0KGqmVFRl
         neMQ==
X-Gm-Message-State: AJcUukcDgsChMyY8beVdsSamgZ646uxH/UeiHZBAmXImLLX64J6WDwnt
        9d5Ru4UBeG/IBdyho+qa5Q==
X-Google-Smtp-Source: ALg8bN6DFIDRnHTkeVGXuHuqVTPmKXUDFxfo/FruXT/cIiCXOn3L/plO3FwyDIrf/LdhMdwtIwSyAA==
X-Received: by 2002:a05:6830:1689:: with SMTP id k9mr18286019otr.129.1548084314755;
        Mon, 21 Jan 2019 07:25:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l6sm5653675otk.51.2019.01.21.07.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:25:14 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:25:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v3 4/6] dt-binding: pcf85063: add xtal load capacitance
Message-ID: <20190121152513.GA29037@bogus>
References: <20190119090031.29147-1-sam@ravnborg.org>
 <20190119090031.29147-5-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190119090031.29147-5-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2019 10:00:29 +0100, Sam Ravnborg wrote:
> The NXP pcf85063 supports two different xtal load capacitance
> - 7000fF  (7pF)    HW default, Linux driver default
> - 12500fF (12.5pF) Minimum power consumption
> 
> To obtain a precise RTC the pcf85063 must be configured
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
> Cc: Urs Fässler <urs.fassler@bbv.ch>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/rtc/rtc.txt          |  1 -
>  2 files changed, 18 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
