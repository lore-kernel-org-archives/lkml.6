Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2F2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2DC20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzR8XeFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfBHSii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:38:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42432 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfBHSii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:38:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id s1so2083895plp.9;
        Fri, 08 Feb 2019 10:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LYGCo+XEmg29JqPM7gUuaZ8OGf8wDVXjcmoV8Acp9Ss=;
        b=mzR8XeFCpGNzL6arZYJCOFPjbuQdSngoI4l6ZHoWFNITUcnvzXIfs4iCaHn9kZdhKQ
         yDdVDSneyPiESbqcFo+yXVHiJSv7h9brDO8KbsKJ1XrJzpok/Fdl5i0ZXv/BkaNhiMN3
         4hAnmdkOMFJKraShsTH+sNe39x2B0oW53ia+hjuSBpY4eJOjpys1E0fSNNlZsg173koh
         /7WfdndVbmnYA5yr8QUgGjkE51afBbvIM8RR2FtCKlUIkMihShB5h5auH6KhpRRSiC0t
         lUS1/Q0Vhl+Fs3bgPDmxEbtUMl92hhHZZuQZkf3XBT/w/M+4AlpLcmC2BW656rP9Txmv
         Xz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LYGCo+XEmg29JqPM7gUuaZ8OGf8wDVXjcmoV8Acp9Ss=;
        b=eSBc5vPJKnsJoqnDBH/UfOgJ1GeBCXXD8KJ0qoHN9MRQ7DGzKtVZVr4iqLRXRkoElf
         KEsivpfChHO5HervhzlR4AEzX3BrORgJMLTycQk7Q/I3SG3P3aiQT0ewpI4qfVKoAmGj
         EY2HK+MHjYBWpO5aIw8TCVjdJL/0WSYo/UO7PrEADYW8KKT24BwY0r8Wm0KtDw1bB7gM
         joLz3gdxsBH0I/0m7iSUo0Y434EQwCKdHgHTMd2syZPqtDhoiVg/4qhbn4zfuF8183c2
         sNOUohPC0ZIpAh7GsLVhZvPbLeYEVnC8meodOiVwR3II2Hr5OsHJtkkcV0um1uMRsHp1
         tumA==
X-Gm-Message-State: AHQUAubdpA7V4zGYW4RdADKc5Pz28fYZ8ln4OtylzVXUVneTC9/N1uvJ
        MWeqgA684Lmk8uZNbk/aN3I6spxs
X-Google-Smtp-Source: AHgI3IZpfXuCsz02hfclLf3c0QMLnBSzsOM/wBDuYg4YaEjL6ZrxoQAFEHKZo6fZSL+AQ86pPGUnQQ==
X-Received: by 2002:a17:902:e90d:: with SMTP id cs13mr24445664plb.189.1549651117225;
        Fri, 08 Feb 2019 10:38:37 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id m198sm5287156pga.10.2019.02.08.10.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:38:36 -0800 (PST)
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
 <3e4db3e9-8198-f1bf-f909-492bf1ff8c56@gmail.com>
 <BYAPR12MB33981B3AD88271597CC4F7F5C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB3398429D6C403347C149B643C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33986FBB8B684F2E56948FBCC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB3398DAC18B36F12F20765354C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fbf4efd3-bd4d-5a65-d9d7-b4fe9f7ab5dc@gmail.com>
Date:   Fri, 8 Feb 2019 21:38:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398DAC18B36F12F20765354C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 21:37, Sowjanya Komatineni пишет:
>>>>>>  static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
>>>>>>  	.flags = I2C_AQ_NO_ZERO_LEN,
>>>>>> +	.max_write_len = 65535 - I2C_PACKET_HEADER_SIZE,
>>>>>
>>>>> Ideally it should be SZ_64K - I2C_PACKET_HEADER_SIZE to not miss the one byte, otherwise good to me:
>>>>>
>>>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>>>>  
>>>> With SZ_64K - I2C_PACKET_HEADR_Size, When we compute dma_buf_size 
>>>> = max_write_len + I2C_PACKET_HEADER_SIZE, dma_buf_size will be 
>>>> SZ_64K which is 0x10000 apbdma dma count limit should be < 64K 
>>>> meaning 65535 max is allowed
>>>>
>>>
>>> But it's for the GPCDMA, does it have the same 64K limit as APB DMA?
>>
>  64K limit is for APBDMA. This patch has APBDMA support only. No GPCDMA support so buf size limit is based on APBDMA.
>  GPCDMA supports upto 1GB. 
> 
>  I think dma_buf_size is only for buffer allocation so shouldn’t harm for exact 64K.
> Will take a look at dma driver...
> 
> All msg reads, max length is 65535
> All msg writes, max length requests is also limited to 65535 due to u16 type of msg.len So, In any case, we don’t need 65536 bytes.
> Confused, yeah with max write quirk, max transfer can be 64K.
> 
> Will change to 64K instead of 65535.
> 

Good, thank you! Everything else looks good to me.
