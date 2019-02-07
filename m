Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBC0C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0D72086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2rlsooW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBGSWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:22:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39966 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGSWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:22:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id t14so615916lfk.7;
        Thu, 07 Feb 2019 10:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n6gNQy3qqvdmMYAWH6t15CIwErBxvMQ0etpWdbmoly4=;
        b=U2rlsooW9OC01te/NUo/dNN1gCg3lLfrmeZKIqFOj0vAlrKlDMZiAjUv5+8Gr2DIot
         /FhkSzTVr4ET0rZOR2baEttwNtsfbrMW0DolwFX7WLK/62QWB057Pt18cWRR8uyMDsp9
         2QtDcOCz7yy1fHRK71Y+Hb0GwN4PPu8ak7HhzQXG8OeY0u169YF6jUgjdj7Spi659Q2e
         uN7KDdFTuiQn6JA8ZeJF0pIKvevYF7c8tKZnvJhn1zEVLzLi6OMTXtLt6zvrge7pNX60
         +vOiC3EbtgwN2U3tOGUulDyhHEeOjGiBIXJxsmpkjOGhlUGzyOZy7R4zf70C74x5Wp8Y
         VG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n6gNQy3qqvdmMYAWH6t15CIwErBxvMQ0etpWdbmoly4=;
        b=F22923paGUo2hwNTzA9x/7UVPLXD7hTexCdASefhCWu0Ge457AkmEoAhRUsXFm4yhL
         EyuNdM75qmem2PkLiwC3MwPTnBmixoV7f8R8KBoYLDiaNQvBdjrXvT1OkPWN81ObcTRi
         ZwA5pL6zDmRgEFotjXMC2Bon73nUrVbgYZQ3wTGiCfFPEyB0Ysh1Nakz4YxZ9VfEPCXv
         +yoHcTI8TVuChcWg8rvo66R5eyfC7l6vpj0k6qC5NesUav+/lTD0TKrSsjm1PuTZOs9e
         4wVaY/vghubW8tuO6TFPpCjYZS7oOySTDrnHehYx86ivqYcJzcuOGnxJ/n0o+hMKuyNH
         hnQg==
X-Gm-Message-State: AHQUAuagMbuvgemucDDMBcapwptSKUeFHjZr7B/rvRCe3eh0e5DjMUYf
        a5p/e8AJJpfmLcI36MZEecGe3ZsH
X-Google-Smtp-Source: AHgI3IZMfK8I830MVjdgUi7rno7tMzROwvdusmg5AjkcsWw3heWDsdsn+mR3BjyZrDPAjlWEjMkhXw==
X-Received: by 2002:ac2:51a2:: with SMTP id f2mr10764313lfk.161.1549563725490;
        Thu, 07 Feb 2019 10:22:05 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id j12-v6sm4386344ljh.66.2019.02.07.10.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:22:04 -0800 (PST)
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <32b0b694-f912-044e-1a50-55b9c355d0c3@gmail.com>
 <BYAPR12MB3398350797241F90AE347FB5C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
 <0a7d62c4-9dcd-08dd-4e3f-877184848daa@gmail.com>
 <20190207160630.GB17445@ulmo>
 <BYAPR12MB3398D9CA36FCFF81BBC8E7B5C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
 <0b7963a4-ee9c-7296-1478-38235af7cd40@gmail.com>
 <BYAPR12MB33983F916E6DE23228B4EBD0C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <646d9963-ec2d-5210-d645-2b05da61d8cb@gmail.com>
Date:   Thu, 7 Feb 2019 21:22:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33983F916E6DE23228B4EBD0C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2019 21:02, Sowjanya Komatineni пишет:
> 
>>>>>>> It became apparent to me that there is a problem here. The size of dma_buf is 4096 bytes and maximum message length is 4096 too, we have pushed 12 bytes packet_header to the buffer >and now there are 4084 bytes left for the message in the buffer. Hence transfer of 4KB will cause buffer overflow and either crash kernel or corrupt memory. One solution is to just always >push packet_header using PIO, other to reduce max_write_len or increase dma_buf size.
>>>>>>
>>>>>> Yes, This is known to me and I will add separate patch for this to 
>>>>>> update quirks to take care for t186 and t194 to exclude packet hdr lengths There was separate patch when quirks were added and it got merged already from 5.0-rc1 but don’t want to sneak that here. Will send separate patch to take care of this.
>>>>>> Need to update quirk to exclude packet header
>>>>>>
>>>>>
>>>>> No. This is a bug of this patch, it must be fixed in this patch as well. 
>>>>>
>>>>
>>>>
>>>> I'm not sure we actually need this. My understanding is that it's really the payload size that's 4 KiB and 64 KiB, respectively. I don't think that includes the header.
>>>>
>>>> Thierry
>>>
>>> As per the design, Yes that’s including the HEADER. Its total transfer per packet including header.
>>>
>>
>> My understanding that I2C's max read/write sizes quirks are the payload limits, and so excluding the header size. Hence I'm not sure what you are trying to say, Thierry.
>>
>> Sowjanya, also.. it should be fine if you'll include the separate patch into this series, placing it before this DMA-patch. I just read your message as "patch separately from this series".
> 
> OK, Will add that prior to DMA patch. V15 will include max transfer limit update, dma resource releases on probe faiures, and other minor errors in V14 feedback.
> Will wait for any more feedbacks before releasing V15...
> 

Thanks, I'll add couple more minor comments then.
