Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594D6C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0439B2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/q135oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0439B2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeLIVdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:33:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45784 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLIVdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:33:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id b14so8533944wru.12;
        Sun, 09 Dec 2018 13:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=857ZMMoXI/CAkwGPUnJFZGF2TVpq19l2iPMEMaiv08w=;
        b=G/q135oqwjztASIzmlRBfwTihpy9EwGxvPUGoYHGKtiCdi7MPpiTRRELYNuz1trS1s
         tewoXrfZPIRgNirlyyAGmmg/CcvaAAWk2sea20t+5irziYkEcQG3TQtih8SRGPdZzQzn
         tjZP8M5OdZu98Q9I5PCjZdVp66DT3dpBn0PyQK329+twd8WUS0s0ak4i3M+lFAxdoBPX
         bFV3SCStLNE2QQjdHopflAqrTzMiee2SgykRiOaW/zxIS4hW1qOeW+s5rdxVhY7XC551
         nK39BScO+EpJXPYLMz3a4ug0LueIPksr19QXp/TzZ0p+APcoUwg49liiTXos0+OuwhT0
         0/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=857ZMMoXI/CAkwGPUnJFZGF2TVpq19l2iPMEMaiv08w=;
        b=PGvHOYa+po0aIWnog7b/1xboa3gilvaxQ/mJ/VsTZcvpcan0AFpRx1cYDb0nYqbInh
         0qtUIZ83fJSlvNdZS14nXZ6TfBAr5H8UZrmmhPt/2fJjnQz6i+gWuL6hJhPv8O/5czV7
         0Gj7kiGXbdAw6FmPWn4rRoi8mlwWBrdLziRDaucwCzDkKnREYwYGVCvYfuHKmSYK6OYd
         WbQkh15H18AM/2rXQvkJjgDf6D+690F82n8nZ2KShsqAFYcvW9K5bdI+IrjRWOtQ/h7a
         rLhi/qyz3DROMcaQfKwewSCtAzRYyj7amNarAlEW2GF1FVene6j/3sLxAAnqDidLwL+X
         BlLA==
X-Gm-Message-State: AA+aEWblc35PlGX+mQTSUmSgBy3A2G5QcTbCNnfLt+WHci4RJWuzHgpa
        nrhTu0j/K0F0l5OGR+f/x08=
X-Google-Smtp-Source: AFSGD/U0DLFmuLSeXjAfNtgngkUm1KSKIFpRGt+GL17mySchF8+h39abNamPXYQI1xG5rW1DTl1qeg==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr7686592wru.226.1544391202550;
        Sun, 09 Dec 2018 13:33:22 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:2cf2:1fe3:239e:489f? (p200300EA8BCFE3002CF21FE3239E489F.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:2cf2:1fe3:239e:489f])
        by smtp.googlemail.com with ESMTPSA id u204sm20878210wmu.30.2018.12.09.13.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 13:33:21 -0800 (PST)
Subject: Re: linux-next: Signed-off-by missing for commits in the net-next
 tree
To:     Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20181210080045.0e67ad79@canb.auug.org.au>
 <20181209211139.GB21186@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <011f5be3-4bc1-2e64-0ddf-b43b8dbc4dcd@gmail.com>
Date:   Sun, 9 Dec 2018 22:33:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181209211139.GB21186@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.2018 22:11, Andrew Lunn wrote:
> On Mon, Dec 10, 2018 at 08:00:45AM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Commits
>>
>>   dc9d38cec71c ("net: phy: mdio-gpio: Add phy_ignore_ta_mask to platform data")
>>   04fa26bab06d ("net: phy: mdio-gpio: Add platform_data support for phy_mask")
>>
>> are missing a Signed-off-by from their author.
> 
> Hi David.
> 
> Any idea what happened here? The version in my git repo has SOB.
> 
> https://patchwork.ozlabs.org/patch/1009811/ also has my SOB.
> 
Instead of
v2
--
int -> u32 in platform data structure

Signed-off-by: Andrew Lunn <andrew@lunn.ch>

shouldn't it be

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2
- int -> u32 in platform data structure

?

Heiner
>      Thanks
> 	Andrew
> 

