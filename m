Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBD9C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425DB21532
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMG8BTV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425DB21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJUDhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 23:37:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33051 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeJUDhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 23:37:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id u1-v6so4937683wrn.0;
        Sat, 20 Oct 2018 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6X2S5HlseArU112GwqmFAe1k1Fd2wenyhiTZGp/h4cg=;
        b=GMG8BTV8hvOIY2pukF4RrF3rLieHaOW6l7Hs97fTJNSHuS2U5DduUXWfMuM8PSOrkr
         5R0Arj76IZDSIzeA7Svrsf2hGX66zgkUX5TqdfLv+TYp9GSRYSsaYhcNq1le8WIwouHE
         /Ut8IDTxc8EwVfpFGaTAfd4oIeLaXQ/LXlJRX3ADcZjtRydNeAmdJzIw6Mqry464Dwku
         Bt7UBJKwWXjb58xOQRhIbjz4u0a0jw2ZjwB2aW5Eoj0/gm9u0HTeVnxlwINWRLAG7OC2
         Zd60xpF1MCE7o4mnqGQnxcMPsDTHqygDCddt61Rsw9jLEGwu05RtUzyum/pE1ZuDvfE0
         nrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6X2S5HlseArU112GwqmFAe1k1Fd2wenyhiTZGp/h4cg=;
        b=Ocax7Xw/lfbTM2R8fNRCm/T6+eZ18SDKY+liA7Of3IBbaNch5jI6amlLxNSTKd1NQ7
         bJjWB/2G2XgowYMdqyz6gIVZD84CRtVYCy2aUfY1RFyrO1jymiZZPgyWuvuELaxlIHeC
         TBSZta0+EzjSnFVyFeAHcs83RNf8Ss+/+D+WlhDUZr1oIXsbVscvyx3ED3h8yqCT6lGc
         jnMKlRDyo9mLD4VczPCeMvvtr2J5IOZnfeXwFBWlosR7WrQzCLwqn8pADUsh8NzvpORy
         J+COL0pTfuVZWNriOC/+3pSjqE0DAfukCyEA08c3n48gqY/RWp5ibxxWeLILGs+1m9yx
         Kp8g==
X-Gm-Message-State: ABuFfojmUPJapY1lpE7bJjDYVWIkPj8ydfusv3dOCBSE7/iIb7sfgRVw
        zbiQni9Hb5vuPzNHAi4EWVv8YckIrCg=
X-Google-Smtp-Source: ACcGV608AtK/tFaTubeZBTAoOGFK7BXIvArwI/eJ+t02vbGOF05UfQWYBNPS/A8/VWtKSXUay1dl5Q==
X-Received: by 2002:adf:9e09:: with SMTP id u9-v6mr37909595wre.51.1540063570101;
        Sat, 20 Oct 2018 12:26:10 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:3f00:3970:25a3:55ad:948? (p200300EA8BD43F00397025A355AD0948.dip0.t-ipconnect.de. [2003:ea:8bd4:3f00:3970:25a3:55ad:948])
        by smtp.googlemail.com with ESMTPSA id c8-v6sm37064668wrb.6.2018.10.20.12.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 12:26:09 -0700 (PDT)
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        LABBE Corentin <clabbe@baylibre.com>, davem@davemloft.net,
        fugang.duan@nxp.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com>
 <20181018184715.GA31736@Red> <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com>
 <20181018191612.GB31736@Red> <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com>
 <20181018195909.GA11317@Red> <1b784f69-3ec2-feb2-81e1-9a335cf477c3@gmail.com>
 <f1933c0a-d124-a7ac-afab-2fa8f88907ab@gmail.com>
 <20181020153922.GC1596@lunn.ch>
 <c8f4f203-b2b6-81ba-2c79-85501a640948@gmail.com>
 <20181020185947.GA6615@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <1153d0a5-1c23-1e14-7ebd-459886af957a@gmail.com>
Date:   Sat, 20 Oct 2018 21:26:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181020185947.GA6615@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.2018 20:59, Andrew Lunn wrote:
>> I dare to dispute here ;) Above code snippet from phy_probe() will
>> (try to) set also SUPPORTED_Asym_Pause, because phydrv->features
>> doesn't include any of the two pause flags.
>> The statement in bcm63xx_config_init you refer to seems to be a
>> no-op to me therefore.
>>
>> I'd say the correct way is to change the PHY config like this:
>> .features	= PHY_BASIC_FEATURES | SUPPORTED_Pause;
>> It's exactly the use case the code snippet above covers.
> 
> Yes, you are correct.
> 
> But it is no longer possible to just do PHY_BASIC_FEATURES |
> SUPPORTED_Pause because .features is no loner a u32 but a linux
> bitmap.
> 
Ahh, missed that.

> We need to keep the same idea, allow the PHY driver to indicate it
> supports a subset of Pause, and if not, enable pause by default.
> 
Could the PHY driver define its own bitmap instead of pointing to
one of the predefined ones?

> Maybe the easiest way is to move this chunk of code to after the probe
> function is called.
> 
> 	 Andrew
> 

