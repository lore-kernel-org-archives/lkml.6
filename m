Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C036DECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEC4208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmAqqo+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEC4208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbeGMHud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:50:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52829 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeGMHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:50:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so1911760wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=axNO+5/yxz153IiGsMQPYCLBWUijj1yu51n6iWbcsFM=;
        b=TmAqqo+MYQA9LcsC/NIIdCtDWMBwxy24mpKvemoHroidB0+cDAAEQzrwQxl8+NOMZX
         JHkPVF0v5Amk5wtRl0Vnq9YFR3jrumhdlc0PBY+qJL1VSEusIyHE+sNeh5ULs788Ijm7
         RZ82sucBZWCGdMesl8UJuS4SWReuDyzaDdg10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=axNO+5/yxz153IiGsMQPYCLBWUijj1yu51n6iWbcsFM=;
        b=ATSAXXEsvBr5L2xxWOVYTY4nCWemsXayL6MQwA3vOvcRKE/bJ1ikQBCjLP3GqpvJK/
         XcQJXBePAkFRXFSnTptRcFJunS/vQKPYHSHVOxbHE0LfhOEq3Yuw+48x8vEEvsSH6lqZ
         1qNd0twVo7mLY1LxATiUhL1BWByhM997OZR83kQJuQVD94uA3XklufjH80XebXjRo6RA
         snbSEmVkjr0ITDEt1auOIjb/dPWfCd6kXrWI27LZZJOiN+JPincpw4WD8Aeqz32QxbFb
         QvcPd89LM5oyGowxOwctGDmnMK4T7BJblsh9JZ+OxorDdW3ZE/1qy4W1MPJZnEMQg73R
         Gp+w==
X-Gm-Message-State: AOUpUlGR0o490i3n2yOCVQsPr3xXBUh8vlnjrOoWl3yO5WyHsNlvgEYb
        z6jPyBEDmYV4fxFqh3NTbUGlhg==
X-Google-Smtp-Source: AAOMgpfp/KzkpXRrAu7cXGZMtCzhtPanJBKIYMTyLgyS4ByobmvJD5KP551p3SkqauKwlWJDNB8SVw==
X-Received: by 2002:a1c:1d2:: with SMTP id 201-v6mr3001448wmb.4.1531467427668;
        Fri, 13 Jul 2018 00:37:07 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id b198-v6sm8140254wme.11.2018.07.13.00.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 00:37:06 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:37:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org,
        alexandre.belloni@bootlin.com, richard.genoud@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v10 0/6] Driver for at91 usart in spi mode
Message-ID: <20180713073705.GT4641@dell>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <aecba39e-deba-c64b-9542-a446e074e95e@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aecba39e-deba-c64b-9542-a446e074e95e@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018, Nicolas Ferre wrote:

> On 25/06/2018 at 19:22, Radu Pirea wrote:
> > Hello,
> > 
> > This is the second version of driver. I added a mfd driver which by
> > default probes atmel_serial driver and if in dt is specified to probe
> > the spi driver, then the spi-at91-usart driver will be probed. The
> > compatible for atmel_serial is now the compatible for at91-usart mfd
> > driver and compatilbe for atmel_serial driver was changed in order to
> > keep the bindings for serial as they are.
> > 
> > Changes in v10:
> > -fixed kbuild test robot warning
> > 
> > Changes in v9:
> > - minor changes
> > - rebased on top of broonie/for-4.19
> > 
> > Changes in v8:
> > - fixed passing an empty mfd cell if "atmel,usart-mode" value is invalid
> > 
> > Changes in v7:
> > - synced up  SPDIX license with module license
> > - numbering of usart modes starts from 0 insteand of 1
> > 
> > Changes in v6:
> > - removed unused compatible strings from serial and spi drivers
> > 
> > Changes in v5:
> > - fixed usage of stdout-path property with atmel_serial driver
> > 
> > Changes in v4:
> > - modified the spi driver to use cs gpio support form spi subsystem
> > - fixed dma transfers for serial driver
> > - squashed binding for spi and serial and moved them to mfd/atmel-usart.txt
> > 
> > Changes in v3:
> > - fixed spi slaves probing
> > 
> > Changes in v2:
> > - added at91-usart mfd driver
> > - modified spi-at91-usart driver to work as mfd driver child
> > - modified atmel_serial driver to work as mfd driver child
> > 
> > Changes in v1:
> > - added spi-at91-usart driver
> > 
> > 
> > Radu Pirea (6):
> >    MAINTAINERS: add at91 usart mfd driver
> >    dt-bindings: add binding for atmel-usart in SPI mode
> >    mfd: at91-usart: added mfd driver for usart
> >    MAINTAINERS: add at91 usart spi driver
> >    spi: at91-usart: add driver for at91-usart as spi
> >    tty/serial: atmel: change the driver to work under at91-usart mfd
> 
> For the record or if needed by the MAINTAINERS changes, you can add my:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> for the whole series.
> 
> Once the remarks by Mark are addressed, you can certainly re-send the series
> with all tags collected for Lee to take it, if he is okay with this process,
> of course...

That's fine.  No problem.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
