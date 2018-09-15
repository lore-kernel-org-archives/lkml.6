Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11CAECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AF82087E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU09ZNAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AF82087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeIPC1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:27:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45527 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIPC1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:27:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id j8-v6so5669918pll.12;
        Sat, 15 Sep 2018 14:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+XkuEniWG8bSFclXKTX7622e8IxcVj+Pfp7AbtgPBFc=;
        b=fU09ZNARDuVgNUWguZqM7lyI+2OIkoKtJsTqp36DmHL1NMn90osQDmScHlF2B+GYCD
         +pFtJ8qGzZV66Rtf395WJ4GNoS1tG4lzFwswj+vch+yMoFWxchrRpo0bdM7jCBdt4uLG
         ZzVTNWA6gCB03wK/qyIS16myLJukxTI3KwJroFfFmfvIu12h6gpcq+M/r6EBMdW9NB4U
         y4pQPJUvrWNDY7H9/Wi8P6xv6uu1Y4cpYY8sYuaQC/rfXHvITn5NMzXvAVolpIIYLbFX
         p849Q+xSK+WNSY7VC0MTTW5vG4ZxVEoFrNLIS+GmunAag+SWH9hHYUqq8w15qY/nHVmY
         tt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+XkuEniWG8bSFclXKTX7622e8IxcVj+Pfp7AbtgPBFc=;
        b=hZTjUlAG4+hYKHEGLVPEC4EDt4mewVTEjw3BiuoWauyh5VC1o7XkJrHVc+L9fxNkg8
         Q5maHLnkfmSNqWhKzKw9Hghz6fwwU7/mzEOOSaKPq8ejssmlb6mu37yP50weWOsE/vKM
         feNnlWsvbWOrGgULpQ6VYvR/rO5mdKXM7coyi212nuECdU7VHRRjkyE6bWCnCMgB2NI4
         43xPsm6RkoMZcGczdmc1Qs5mJkl4LqZ0k3fPS+tLoX7fqJq4nac7yXFCqaxb76tLaWkg
         pKEUMFVMdzSIA5kySsk3gueV/NryelJ1NPA4Kp4nKUCR4k42AWDOaVpfKD2TcPgYlCv9
         uHDQ==
X-Gm-Message-State: APzg51Dujs94E2nZR3e5Z9wKx9Tz5nY1VpxmncOJKJdU85QBkrwKTAQ7
        MXXaXgLO1RBA/XaqptL+m1Jcxeab
X-Google-Smtp-Source: ANB0VdYUUb6JmhTOIUiqWqgiI4pMmNGQCG8TGOYVRWjazbS947Yf02c2/mgSDTJ8f8SQQk9gk9W4uw==
X-Received: by 2002:a17:902:b902:: with SMTP id bf2-v6mr18248189plb.185.1537045602772;
        Sat, 15 Sep 2018 14:06:42 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v72-v6sm18942615pfj.22.2018.09.15.14.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:06:41 -0700 (PDT)
Subject: Re: [PATCH net-next v3 05/11] net: mscc: ocelot: simplify register
 access for PLL5 configuration
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <b09eb1026a2870c6cc882997ac69e25fdf7a96d8.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c44a927b-013d-caff-0689-24d361ca4406@gmail.com>
Date:   Fri, 14 Sep 2018 19:26:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b09eb1026a2870c6cc882997ac69e25fdf7a96d8.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/18 01:16, Quentin Schulz wrote:
> Since HSIO address space can be accessed by different drivers, let's
> simplify the register address definitions so that it can be easily used
> by all drivers and put the register address definition in the
> include/soc/mscc/ocelot_hsio.h header file.
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
