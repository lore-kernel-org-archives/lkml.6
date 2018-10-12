Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A419AC67869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C0221470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openedev.com header.i=@openedev.com header.b="faTk2yBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C0221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=openedev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeJLPpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:45:16 -0400
Received: from se14t.web-hosting.com ([162.255.118.155]:39415 "EHLO
        se14t.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeJLPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:45:15 -0400
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se14.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <jagan@openedev.com>)
        id 1gAsZv-0002gk-8s; Fri, 12 Oct 2018 01:13:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2qZ0yO314+uRs4ZbA83oirCC5ZHBaxebdR2ekB3ILwg=; b=faTk2yBd8y63+AZaQ325LU9TBC
        r6f5QyVre2O9bZ44J90aZN5K5ak6Jl9iB/LMrQacRAU7IVXe3wTw90WMpgH4TBqLK9j7Fs43ltNbt
        0QAnPFvwG/HSAcyDHVDNfQMfRcAdvbDIFaUd5IPY6ucZBoyc/7gBGEQJFubh0plepXr4YHTiigfxB
        agCYvQxFHTMFR8EmeGWh4Vg+TIQHd0k55pfgZym0+B4aonM7H2dbkjElL93mcSPGEyao+5DAXOem6
        z3L5oure/8pFmSB3xCf8qLXrnIs64ZTxdcWkt098IhL+CB2k+MARG9aWqCaFjw3MecBJVZ6mzj9Dj
        HTsVLhOQ==;
Received: from [49.206.202.241] (port=26906 helo=[192.168.0.105])
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <jagan@openedev.com>)
        id 1gAsZm-000YtB-7V; Fri, 12 Oct 2018 04:13:39 -0400
Subject: Re: [linux-sunxi] [PATCH v2 04/29] clk: sunxi-ng: h6: Set video PLLs
 limits
To:     jernej.skrabec@siol.net, maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-5-jernej.skrabec@siol.net>
From:   Jagan Teki <jagan@openedev.com>
Message-ID: <a303145c-b123-d912-91d7-9830dec3244e@openedev.com>
Date:   Fri, 12 Oct 2018 13:43:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181007093905.11253-5-jernej.skrabec@siol.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5juFmNWEu6SyB6Z3v/YcWUN602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO0Ma0zdKrj2HeYAO9pcN4rBgaa/6KAnDjbDW9Kfk8S67gDyB0Rr1aZOu2ETJCAhr9S3r
 fSN/u6jRArqnnAHY5E1E7WTOeiZ4MjemyjrWlXGsg1zyK//lZ4OMrmWVGgeyEFrgjN4S98vuZk6s
 966l0D98LN00Y2guNhbTSbk1sIe8Qm6kIVu+rxBu8P2UZI/wEczbg4Paoa3pNVQ0zl7t/+Usw8Yf
 HSKEcyFde+X1NeokD5ZjBdrsZwZr/AD9wOUz4wMEatvKUz7u+NpcIOQdEnbbKrxSQm1e9uGJRbp+
 9k98OHuIAN/6E+1uq7tSG4ule7FZJNoQSUtQavZXBMHwJDqECz8IchCpTqJR/6y9opO9+ahQJBc1
 xG2YJhzEo8wVhTtwGuZ/lHIB5Gt/74l483IXh4zNAVnVvpa7M5YsBkWuTr4NNMqkNBPJ+YAVdi8q
 tzJByJtlZm1yp+JPqRscYisz/jwzTAXP4KD8tpS+tSW5XHRCtjlavhOv146mDmzfaPuh5vLVS/qg
 PHFUQxPCRtJQMI/HFl863YYQL153U+0thnSdHpdaEi2Mdvq4w78cs5KJr04DvaF6HJAzFkoVHWL/
 v/tzqAvcnuxxqxvVM35DVa/Hj/lpqf8vwAdisrIBg9i/jMjCbN1nLKOgpWYnlOdkSCEqpL4zqxpZ
 xDy2HMG/CC/r/deZMNUsCgYG15N60Zrne/5jN+g8778EfDCT5bzxSpcIrAqlWdeOcUJ0iV+F3XLm
 xFz+88FWeB7miCnFrS+xkiYMmdOwRIKnLhTyDa4UjXwkRk5Bf8dTf2NBSVercYOXnSKFxqGFOfEA
 nhrlEtzLwEWH4m58mvCwqYpbpscMPcUiFO4CEpLcjvri0bLPSZBMZISYg+9loCdrbYZgp39q0aZI
 3qbhXsaDdLgW9bp6Um4E1VNazAubIQ+pRdkk8aOFlVsjdobHyzXogHFjbimQBM6G/ipCLK4ExBgf
 aFMamUdylUIKhf3z2GAHxH7I7KkQ9dt+Q3emwFGW8BUdx5D5uPPCd7JFgVkNJfmV28uqGko4aoNZ
 cT3zVao7hCeTC4jRXBTI0Wm8mQBWUwW/gXEEUbt+jPDvR6B+v3NAvgHdA/4rLlu25SDn6o2Y3ssb
 AMCzYv3oPBOMGj2Io7rQzhEVniihuDwEGDcmr6e3OPSbtqx47FszAzgVV1IW31/JvkZiMlva+Irp
 Twh7O0Brub5yhGgOxeTaDBlsZLwak1EPwEjAXFmuLp47Ubsbxskt4hxgZV9hhu9eE3Htv+LRStPU
 3PMjkDDa5G0wO0TCzxZT1TfaRDiRG7ESCBIWM99Kk8OBdTasq0gmGQXm0A+rYDE8KosCZrePVpG3
 E/EabezjB8UXGeaJsVRBiPSjqCxmir6FA1AcsbSOTVuRhno45M3yKweSF1+OM2W9DF+TDcR0RJWK
 Xd8nTfUZZr07KnJX
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 October 2018 03:08 PM, Jernej Skrabec wrote:
> Video PLL factors can be set in a way that final PLL rate is outside
> stable range. H6 user manual specifically says that N factor should not
> be below 12. While it doesn't says anything about maximum stable rate, it

Manual says "In application, PLL_FACTOR_N should be more than or equal 
to 11" can't it be 11?

> is clear that PLL doesn't work at 6.096 GHz (254 * 24 MHz).
> 
> Set minimum allowed PLL video rate to 288 MHz (12 * 24 MHz) and maximum
> to 2.4 GHz, which is maximum in BSP driver.

Is this max freq from here [1]

[1] 
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/drivers/clk/sunxi/clk-sun50iw6.c#L164

