Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0899C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEE621761
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="2BipiXw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEE621761
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbeHCOkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:40:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38832 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeHCOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:40:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so4847890ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ag6fi/Yanuluap/Giso2WXJimhEj5pmJ9TndvnKbm/o=;
        b=2BipiXw4t63O5iUEr2JQtp56WB3JMLr8PZe7Gq86np+zw9davJn2lXAC7h8XD37NXs
         IgB1mvF1uXN1Feap7ZsghiuByYRim1IIalclishPImuK6LZBhZgFgCzDISbPKyPk86Z2
         Sv9tRKsQj+/uVb1geoBayxnZ2OyXVlYmErUryxIEDb1lU7uqV58aGrH/WgvvHsF7WBHg
         vDZP9Z6CGbuRSLBaMjDaIrVAyzmet7Qij7ZVa4Q639dPx6DsnO/efTchHwed7yezcP1X
         /Y5/ItPXbIkDBqxsiCTds8FEeGWSsD9xNODg05MHk9tv16+N1GoO+yOspIL9SZJBcJuA
         QaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ag6fi/Yanuluap/Giso2WXJimhEj5pmJ9TndvnKbm/o=;
        b=RLAos7U8aB6hI8uFYKZS9AxfXpxy9TkxEMPfjsJ4Tx8QUkjAAAJ8kgo7jz9LbG0XsM
         RRcSNiPo+4yW0zPlUnVbccgKmi9RsbORJe239LaBXCQdRSqgHZHt2X/5xL693CeVaZOK
         sl1g5TYflUEb3F3pAnHlKfAFNpcVRmeecCxmFuEsnZ+cWPR+F3ZQJaXtVOMnXxC9RQn/
         slKXSAIooYQhZhf4XFm3WrNU7SEYojfa+ceMuWuWHpkrLhUnc2C8FtjBLz2KxDk2c2XW
         Cbqiih95J/mPey7Q+GRtaoh+5yzsTN+l5FWCO26aSJKyUBD0w84ZktiJiyK7iRFpWok2
         Aksg==
X-Gm-Message-State: AOUpUlHvOSnH+VaZhG40Z1Wzrh0R0f8k/MeMJDtP2rB2NjV0pgwxXQVQ
        +pRhTMlp2QQi52Q+qmhZzm8P5Rl4WzoQEg==
X-Google-Smtp-Source: AAOMgpcsBcH1h47dEpBME8QZ9RhG3AZRnGdqI8bDQJieDt+8qezONosizLIM/uGNi+32XBgvje2Yrw==
X-Received: by 2002:a2e:5d1c:: with SMTP id r28-v6mr5276206ljb.89.1533300242024;
        Fri, 03 Aug 2018 05:44:02 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id r73-v6sm893108ljb.16.2018.08.03.05.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 05:44:00 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: move device L2P detection to core
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180803085449.3436-1-mb@lightnvm.io>
 <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
 <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
 <C29BF7B1-4C9A-47C7-9E5F-AD63356B01BC@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <56562d7c-8deb-4597-4274-5a55ec9327f7@lightnvm.io>
Date:   Fri, 3 Aug 2018 14:43:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <C29BF7B1-4C9A-47C7-9E5F-AD63356B01BC@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 02:40 PM, Javier Gonzalez wrote:
>> On 3 Aug 2018, at 14.37, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/03/2018 02:16 PM, Javier Gonzalez wrote:
>>>> On 3 Aug 2018, at 10.54, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>>> A 1.2 device is able to manage the logical to physical mapping
>>>> table internally or leave it to the host.
>>>>
>>>> A target only supports one of those approaches, and therefore must
>>>> check on initialization. Move this check to core to avoid each target
>>>> implement the check.
>>>>
>>>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>>>> ---
>>> I see where you want to go with these changes, but the way targets are
>>> layered on top of the LightNVM subsystem does not align with it.
>>> LightNVM can support different OCSSD versions and capabilities, but that
>>> does not mean that a target (e.g., pblk) does. The way I see it, core
>>> should only check for (i) the drive to expose itself in a known revision
>>> and (ii) the reported structures to be consistent. However, specific
>>> functionality is not for core to check upo.
>>
>> Why try to initialize a target, if we already know that it is incompatible?
> 
> Yes, that is my point. But the one who knows if the targets supports
> something or not is the target, not the subsystem. Here, you are making
> an assumption knowing the pblk requires the L2P on the host, but that
> could change in the future...
> 

I don't believe it can. It is not supported by the 2.0 specification. 
1.2 is legacy.

I understand this from the perspective when checking for un-even 
configurations using the geometry. But this is a spec incompatibility, 
which I don't think the target should care about.
