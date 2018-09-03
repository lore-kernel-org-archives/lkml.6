Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F26FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F1F2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlztjuRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F1F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbeICVrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:47:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44710 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbeICVrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:47:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id ba4-v6so436650plb.11;
        Mon, 03 Sep 2018 10:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hw8KgC37zTzvlW4yLvc2BUW/W+tmG01g7nqDNVFPp1Q=;
        b=VlztjuRRJSFaknBRuJKpJy/NEKbPJ2iqc7H7J+38UzJJhMBHh5VG+bIYVLYz6QmLCE
         rEvSstZM26pYPzxUAciC83tpyuchImvBK2mCgWkQZIp92pDe360evRljpnSEP8tjtUiv
         FBdkdBiGW+z6lyLYwrDoMdTNCCKTrno565wNahFe2fCbiwSuU7oXHxzqijRYPgQGI2dr
         BD7E5jtptg2nsxaxfpZI0NPD4h1fDoNpV9RM6o9ynhvNkZcSku2Bixjtqm3qBlG//qTz
         D9j0fsJXhQp46maYT5gPNQ3T0VI3e/UCGB9woaXfOa3h3pI0ttEs/A0ZM0TaYxKeDZpg
         uUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hw8KgC37zTzvlW4yLvc2BUW/W+tmG01g7nqDNVFPp1Q=;
        b=kN3kayktnMr0m+6Ptv4IAPC/dZU7kGhuZYKtYyB74hWaz92oqU4UtOspNKouaQpW5E
         myb4YKFtLQeKanPfoIHQqosELommOWt2rmL4A3mWViwH+uPPcViTiqFJJaSgeeVEJ+wZ
         +6VIMuRRBxxQyrtnBfF30BpocXWRbk4OHMO8P6xYQuPeHGJ7/tZjyTfod/GLyEVxx+Er
         F2/SxPM9BI/Cr+3OI2YITEvCmgFgbk9PUDnZipqTDc9xSwWGEyXvGpT33WAUtgqwiY6x
         KZkc4O/L2YMQHh3eB1xa3N3LkuVsBUoQ6VgkbjD2e1VCcwN0peRUp5Pyzugt31X51TO5
         /yqQ==
X-Gm-Message-State: APzg51CqcZPd3L4qkcV69+dPc7TfmikaW2jlA+ILyT+5o1mnAX9X7FMW
        44MAigwHav7Xe0CSfKfjJLyJVmdF
X-Google-Smtp-Source: ANB0VdZR9znJgiUAwHxOQ2SvNTnVB7TeAv9caLfeufJF+71gZw0psksrDPMvyqTaba+2LxHG2UmA/g==
X-Received: by 2002:a17:902:bf46:: with SMTP id u6-v6mr29528511pls.85.1535995559173;
        Mon, 03 Sep 2018 10:25:59 -0700 (PDT)
Received: from [10.10.115.170] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id f4-v6sm34044294pfj.46.2018.09.03.10.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 10:25:58 -0700 (PDT)
Subject: Re: [PATCH net v2] net: bcmgenet: use MAC link status for fixed phy
To:     David Miller <davem@davemloft.net>, opendmb@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535567269-12534-1-git-send-email-opendmb@gmail.com>
 <20180831.225925.1256781245981355986.davem@davemloft.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56790b03-fa74-edb7-c6ea-3b591f2f557a@gmail.com>
Date:   Mon, 3 Sep 2018 10:25:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180831.225925.1256781245981355986.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2018 10:59 PM, David Miller wrote:
> From: Doug Berger <opendmb@gmail.com>
> Date: Wed, 29 Aug 2018 11:27:49 -0700
> 
>> When using the fixed PHY with GENET (e.g. MOCA) the PHY link
>> status can be determined from the internal link status captured
>> by the MAC. This allows the PHY state machine to use the correct
>> link state with the fixed PHY even if MAC link event interrupts
>> are missed when the net device is opened.
>>
>> Fixes: 8d88c6ebb34c ("net: bcmgenet: enable MoCA link state change detection")
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
>> v2: increased "Fixes" sha1 to 12 digits
> 
> This doesn't apply cleanly to the net tree.

You've applied and fixed the sha1 to 12 digits (thanks for doing that) 
of the v1 previously submitted:

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=c3c397c1f16c51601a3fac4fe0c63ad8aa85a904
-- 
Florian
