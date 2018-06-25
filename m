Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E2BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3759E25DF4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihcEn1mw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3759E25DF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755126AbeFYQPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:15:12 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42912 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbeFYQPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:15:10 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so14276596wrk.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=34gELoRXu+CysP2xcjDDjb9xIR9pBEFyEyD/YumLD1E=;
        b=ihcEn1mw3fPFcEQermEomkyYUu5wTftiYfnL1wO0v/pYOIr7rvzwsSNhprQWYihM2P
         zHRhx/VWUTwqHbsvFqmot6QcGlt+1eg6vrmS5IJZDCoQE84wCq4ROgJcEkZnjtfSAJdQ
         fn9Hsq3QH/zj+XbUg2byK1yIIeFyqydgw1A+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=34gELoRXu+CysP2xcjDDjb9xIR9pBEFyEyD/YumLD1E=;
        b=qVTBEPh/ioXI0pQLxDQQFz/07XLzHLtmPmnLrkgCqQRsiAahJQQhAmUVtOwSuEtB68
         9DtVnAXhOenRsFqErVcJHL2M6Hwo8X2+o7JEQe/szSda4SsPYrvYiKVscgTnbeDlCWvC
         54oA1Qam+oeXMqEP1TWKuOTh61tA/m3X3J35WFffGIwfgeSw9vaaHn9RxVpOrRkrsjr+
         hpx0KErHgjJX1HFEP4l+OpdX4Iltc6adGvtQoJmIoZGAa55yj8sofaexMsKdTCiljPUk
         QOQGX6OUZU1QY857M8z0Rtbm4rXBORzPz3L+qh8Za77na5J3lhluWDlG4kUAdC5Za5U/
         JCKw==
X-Gm-Message-State: APt69E1cE/frkaCFoqu9D1dI7eA77be8+xbDJbaO0dHFixib5UTMoLXW
        yGz50KGtFC8VHMmIqu8q3Pm9QA==
X-Google-Smtp-Source: AAOMgpeMB0IwErndRiptcJWnk0y06xFUpwGgxcADZ5F7JL0etZrdrXkNQDhWcgIvSrRCwvyIeQJumQ==
X-Received: by 2002:adf:fa07:: with SMTP id m7-v6mr11275174wrr.228.1529943308937;
        Mon, 25 Jun 2018 09:15:08 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 74-v6sm14981612wmt.31.2018.06.25.09.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:15:08 -0700 (PDT)
Subject: Re: [PATCH 1/2] slimbus: stream: add stream support
To:     Stephen Boyd <sboyd@kernel.org>, broonie@kernel.org,
        gregkh@linuxfoundation.org
Cc:     sdharia@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        ctatlor97@gmail.com, vkoul@kernel.org
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-2-srinivas.kandagatla@linaro.org>
 <152994313712.143105.4349052596355647972@swboyd.mtv.corp.google.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <990d582d-4cfb-f6f3-6ca5-a54daef8b88c@linaro.org>
Date:   Mon, 25 Jun 2018 17:15:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <152994313712.143105.4349052596355647972@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen for review,

On 25/06/18 17:12, Stephen Boyd wrote:
> Quoting Srinivas Kandagatla (2018-06-21 06:40:08)
>> new file mode 100644
>> index 000000000000..f8af9474d286
>> --- /dev/null
>> +++ b/drivers/slimbus/stream.c
>> @@ -0,0 +1,493 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, Linaro Limited
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/slab.h>
>> +#include <linux/list.h>
>> +#include <linux/slimbus.h>
>> +#include "slimbus.h"
>> +
>> +/**
>> + * struct segdist_code - Segment Distributions code from
>> + *     Table 20 of SLIMbus Specs Version 2.0
>> + *
>> + * @ratem: Channel Rate Multipler(Segments per Superframe)
>> + * @seg_interval: Number of slots between the first Slot of Segment
>> + *             and the first slot of the next  consecutive Segment.
>> + * @segdist_code: Segment Distribution Code SD[11:0]
>> + * @seg_offset_mask: Segment offset mask in SD[11:0]
>> + * @segdist_codes: List of all possible Segmet Distribution codes.
>> + */
>> +static struct segdist_code {
> 
> const?
> 
Yep, Will fix this and presence rate in next version.!

>> +       int ratem;
>> +       int seg_interval;
>> +       int segdist_code;
>> +       u32 seg_offset_mask;
>> +
>> +} segdist_codes[] = {
>> +       {1,     1536,   0x200,   0xdff},
>> +       {2,     768,    0x100,   0xcff},
>> +       {4,     384,    0x080,   0xc7f},
>> +       {8,     192,    0x040,   0xc3f},
>> +       {16,    96,     0x020,   0xc1f},
>> +       {32,    48,     0x010,   0xc0f},
>> +       {64,    24,     0x008,   0xc07},
>> +       {128,   12,     0x004,   0xc03},
>> +       {256,   6,      0x002,   0xc01},
>> +       {512,   3,      0x001,   0xc00},
>> +       {3,     512,    0xe00,   0x1ff},
>> +       {6,     256,    0xd00,   0x0ff},
>> +       {12,    128,    0xc80,   0x07f},
>> +       {24,    64,     0xc40,   0x03f},
>> +       {48,    32,     0xc20,   0x01f},
>> +       {96,    16,     0xc10,   0x00f},
>> +       {192,   8,      0xc08,   0x007},
>> +       {364,   4,      0xc04,   0x003},
>> +       {768,   2,      0xc02,   0x001},
>> +};
>> +
>> +/**
>> + * struct slim_presence_rate - Presense Rate table for all Natural Frequencies
>> + *     The Presense rate of a constant bitrate stram is mean flow rate of the
>> + *     stream expressed in occupied Segments of that Data Channel per second.
>> + *     Table 66 from SLIMbus 2.0 Specs
>> + *
>> + * @rate: data rate
>> + * @pr_code: presence rate code PR[6:0]
>> + * @prate_table: All possible presence rate code for Natural Frequencies
>> + */
>> +static struct slim_presence_rate {
> 
> const?
> 
>> +       int rate;
>> +       int pr_code;
>> +} prate_table[] = {
