Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21875C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C302077B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sn4odvhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfBHSVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:21:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43137 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfBHSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:21:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id f90so1832928plb.10;
        Fri, 08 Feb 2019 10:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cmVTaqERL/brTGUdKHqdh+Z6loMGPa1kk0LlpDYd7OI=;
        b=sn4odvhyVujVY34GjfTqwYAO1Jb26NzrNZSjUNxpoD0xWn62PhYdVk7+xj5ONC2r8J
         DBbC8+lKKOAzpNgAXE58h5Gtf3Z3RbuJhU+ath7T1lKSd8dauO34PZ9SS2bfGvSB407M
         MH8kXKgtUWgQ3IE5OU5tZ55clV/sPjNygYHcB5SbjRBG63AfEtmAXZaWqvRO8ooUbXGe
         Io9pwRgelrQQioe59Rm/KcJag/I+wFy1ye9YIYVVqmAR3VfS4PNer6oIAz1ckWIhlg0B
         JQ5srPKzHMxWEZ1KAlD3h7r7PxopkCH9A/cKEXPmh2/rfSPcm2NIahu8ewtEiTh2IWQM
         Tu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cmVTaqERL/brTGUdKHqdh+Z6loMGPa1kk0LlpDYd7OI=;
        b=Srj3vTy/opPpMxo7Wy/U2h9nv2X7buSQ/goJZCgtK+eeECacrEsJzHXuOIRyWEjYn7
         gGlfatlr6S/ZtGxcvsWCACgNFcL1nTm1Q1YBBwI2Z5v+T9Z7lapaXsZug59SB0ogQ5dD
         CzAVcR/zqdUJEtS+jwI8F/4vulmb5uxL6n6ZB7hNLNrpnhc/JaIRsgTsDTmL7WDPNKKd
         E4xEHiAa56cHz4GcFQfl87Webs7i93AiKThptDHQ91qGgPbjEi01kDpeFVZ9bwSkUImR
         SvAG6HUI4u1VIjjbLmuQhwGY1F2PH/CrzId2GCKMDKaJ4kDhrOKT6fNA5PdYCYnCk4DT
         hkNA==
X-Gm-Message-State: AHQUAuYup1hDS8bdUHh1WZ1zqyihE0TuvWviqdwQEZi9ohQ4J9Bh9+Tk
        CzndsIP054gLWdvnwgSJutw51I/Y
X-Google-Smtp-Source: AHgI3IY3sB1zwSt0/T285UkRuZE/TbSI5oWcmBPv+/povELgS0BZjU6egK+z4I2b69QHPjVNQMs7Xg==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr24653859pla.228.1549650080227;
        Fri, 08 Feb 2019 10:21:20 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id 196sm4477455pfc.77.2019.02.08.10.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:21:19 -0800 (PST)
Subject: Re: [PATCH V17 3/6] i2c: tegra: fix maximum transfer size
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "peda@axentia.se" <peda@axentia.se>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <1549648195-3989-1-git-send-email-skomatineni@nvidia.com>
 <1549648195-3989-3-git-send-email-skomatineni@nvidia.com>
 <0c30dfe0-1174-0056-5ef6-432b75de2353@gmail.com>
 <BYAPR12MB339810D394AC0A50934DD5EAC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3e4db3e9-8198-f1bf-f909-492bf1ff8c56@gmail.com>
Date:   Fri, 8 Feb 2019 21:21:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB339810D394AC0A50934DD5EAC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 21:17, Sowjanya Komatineni пишет:
> 
>>>  static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
>>>  	.flags = I2C_AQ_NO_ZERO_LEN,
>>> +	.max_write_len = 65535 - I2C_PACKET_HEADER_SIZE,
>>
>> Ideally it should be SZ_64K - I2C_PACKET_HEADER_SIZE to not miss the one byte, otherwise good to me:
>>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> 
> With SZ_64K - I2C_PACKET_HEADR_Size, When we compute dma_buf_size = max_write_len + I2C_PACKET_HEADER_SIZE, dma_buf_size will be SZ_64K which is 0x10000 apbdma dma count limit should be < 64K meaning 65535 max is allowed
> 

But it's for the GPCDMA, does it have the same 64K limit as APB DMA?
