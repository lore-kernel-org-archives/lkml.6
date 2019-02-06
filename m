Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E858C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D358420844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmdZ4tkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfBFNX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:23:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41888 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbfBFNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:23:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id e27so5304989lfj.8;
        Wed, 06 Feb 2019 05:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bpQQpAbsD8hSVP28q4CvlhUkxdcolGWK48x4yYu34es=;
        b=cmdZ4tkQQ/9ZFIzqIxVRMv3nv8xwl7tc95ceApEq/+MVhdfDglSwi+HVFaYck3Fjcv
         0MJ2qCeHn3p0MtpelzW+ujCCeU3pjQWpDersbC5B0ibmOpwLb2WhV8CepkpoofAYy9bT
         lJRwzD3AqtSZQv/lpsvIAwpe5ojgRn49wAU5TII1m9rRLog9zkcPDikjKHpH6tK+sBK2
         aQP0BRd9KFaMZAeur5ceK7VlG3DQ35fNavRid8DeWAO1y2jdHoaOerIBxInYYL33GP1k
         4uAU+9bHXF9395G73fKf+gddAHBWICFCkWh4iPBRgjWUlOnLqulMfvD3JSVn5rDVidVq
         QLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpQQpAbsD8hSVP28q4CvlhUkxdcolGWK48x4yYu34es=;
        b=KEfubsS64eon0Pc5NvriNhy3wbgkn91e2nGTu5eaBgr4iI+XfpDlIxpWeQDBkPM1uI
         6b7slbJK8VEpVSmap44P/DOXR6wFPM3Z45/3Zxm3yN7sjC7zOT9X0q6RkRGnJMbWIjfM
         8xZgu7I7SLo1w8qEc5IeilsXdLb4zuNPVBbC3AcgFZp+HnNW47S+48mHpYteBfQJ65KP
         5sXVIzswy4VwLxQ8kFB3TUb350cuPHoV8n9JVwtgjhp1aX4nPrs9cVOjwPyuby1Lv1mx
         4VakkZBXKczTTfc5StcLD1+6pYeoGCra3ysKqV3pFShwxXtL6BBwocjCnOIiQf/VyhUE
         TdNA==
X-Gm-Message-State: AHQUAuYI2NCDtUBr0JJldqNs++YqaGfw2DZlXZ1xqLOs8FEpPiPTRvtj
        DPYsaXt/yDWRsaIaU5JqXVLiMXBc
X-Google-Smtp-Source: AHgI3Ib7mw4JiOSCPWAL/BG4WLpw43RZ1sjIx92GEH0t7P59jUeCP44KY9WiCIKuNXrP34Lv986arw==
X-Received: by 2002:a19:660a:: with SMTP id a10mr7158758lfc.146.1549459402975;
        Wed, 06 Feb 2019 05:23:22 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id h22-v6sm3845549ljg.24.2019.02.06.05.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 05:23:22 -0800 (PST)
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <c4f67e39-df72-cc56-216b-8e6014891b52@gmail.com>
 <BYAPR12MB3398E50ED1C6909D6BCB0DDFC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <304c1916-e836-fa95-5cec-887fef8f3eb2@gmail.com>
 <BYAPR12MB33986680570EB919369000F3C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <82f38909-94f1-7984-2b0f-df6231aee58f@gmail.com>
Date:   Wed, 6 Feb 2019 16:23:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33986680570EB919369000F3C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 16:17, Sowjanya Komatineni пишет:
> 
> 
>>>> BTW, I'm seeing "atmel_mxt_ts 0-004c: Warning: Info CRC error - device=0xF436DC file=0x000000" whithout making any modifications to the original patch as well and it shall not happen, hence there is bug somewhere. Probably FIFO triggers are still not set up correctly... ?
>>>>
>>>>
>>> In snippet you sent, I see you are forcing dma_burst to 1 always which is what set for fifo trigger levels as well and also you are forcing dma all the time.
>>> So always it will be 1 word dma burst and 1 word trigger level and that should not be an issue.
>>>
>>
>> I reverted that snippet, this log is collected with the yours original patch.
>>
> From atmel driver, looks like this warning is from maxt_update_cfg and due to CRC mismatch and above values shows read data CRC is 0Xf436dc which is compared against info_crc of all 0's 
> Info_crc is based on raw config file and somehow its all 0's. this is not based on data read thru i2c. 
> data->info_crc computed on data read is 0Xf436dc
> 
> This warning is not related to I2C transfer
> 

It doesn't happen with the I2C PIO mode. Seems it means that the I2C reads out the 0xF436DC value instead of 0x000000.. if I'm not missing anything.
