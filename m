Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D54ECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCE52087E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suX/wVnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCE52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIPC1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:27:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39987 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIPC1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:27:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id l63-v6so5918638pga.7;
        Sat, 15 Sep 2018 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fj0BsDTe0Vunlp169IKvL431u7kjnyVeeWMl6UD9plI=;
        b=suX/wVnnsH/9aRfvK8m+982q5dJO820/Pi8yR7432MHdjT4VOuwAI/jzGAYY6GyP9X
         bFLSEFJIPK8Uhyehf29p03KVEpQgs3DHyX4vfPWuHVFdWeV5dHsJzqx3XJuQmFkvQL0Q
         dTktlrPbTjkh3LzRXwrlhNrbS937BrP9jFMG2pexacWpW72wlwkV0qJiytxq5v3bEwba
         JxlOGRfrS2oGGUBwza6de46RSQvqjfED3wLLAHI/zxHHZkJvF43Q7dZw9dVlcEe+kOkD
         cPI+l968u5uFBKlSElJG/v61glXtfo7GYO58RndTHbY4/Cr04xaKRLrsU1M0M+eE12d9
         2N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fj0BsDTe0Vunlp169IKvL431u7kjnyVeeWMl6UD9plI=;
        b=qrGtmTJyIZQhvZZ4vylXPpR1YdFWWIV8ZHiCUvkFjqidOwHwHzpEyd53ZJiN7WUBFY
         dhI+CCi/JgkdTFkrlQaOypasSXQRZWBfCO/nLaRKGh87IpM+3OROpVwxL7V41oxTYIC6
         MthOnQtNwZsVQQvDJfUTCBpxu3/Cn1FiVCZcdcfFsv9tqChW3eutakH2/UKqm9nPpN3W
         xOKzU0TDdR16y9cnThzCMfSMv4BC1LiMrIh0FiPuiLgqf4jnxmoPgQXxT19QSnKys0MD
         2hkUuNUJ9P/LDbq8e2ozvN/rxVXNlN92JzoMqjxfTy/OnsGsNiaAzZ5ICaVX86yzUuf2
         0e6A==
X-Gm-Message-State: APzg51Aw1lmh0SGZuJuypIHjK6Gal4YQ2Z2wrKaV99QdPcc6BUxSvN6t
        qKDaFuxGGi6yzvX0KqGmI7k=
X-Google-Smtp-Source: ANB0VdaF2PXK+XTA0sy1I47uKo9MwrPGPtrjORO8MbNLcX1TeEECz/NamN+3p9g78QugiDzPUCnsMw==
X-Received: by 2002:a63:ce11:: with SMTP id y17-v6mr17331409pgf.201.1537045647616;
        Sat, 15 Sep 2018 14:07:27 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id z63-v6sm12681933pgd.69.2018.09.15.14.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:07:26 -0700 (PDT)
Subject: Re: [PATCH net-next v3 06/11] phy: add QSGMII and PCIE modes
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <52d9c9444175911a8f6ee3dfec8946646907135b.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e69b392a-86fa-7e8b-9803-aa1c529efca1@gmail.com>
Date:   Fri, 14 Sep 2018 19:27:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <52d9c9444175911a8f6ee3dfec8946646907135b.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/18 01:16, Quentin Schulz wrote:
> Prepare for upcoming phys that'll handle QSGMII or PCIe.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
