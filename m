Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E08C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B942190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LASn+pgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfBGQRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:17:46 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34728 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:17:46 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so332743lfc.1;
        Thu, 07 Feb 2019 08:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uXXFSfS3qwAfrpAOQHAXOdwBdRY3+psDP0LE0+4iPvE=;
        b=LASn+pgJ6rRz8uzjm5NItLQdaWbIrsMCTwbjd3GXJ97BEEZf67oMtlTxN51c7l2TwQ
         oAup8FVYyFS9INnIBsM3aloF122dNjXOWriV4Kc8+uULLWjwnnQtwtC2T/kjLhocZVry
         TXzCXmsEj+S3zne5mc6qCau/uSRUIuYJ9mAJrJuoZmfb573q9tLrizqWThlgUt8P35tb
         aorHz9ATygSNzNgb6XOBMzGQ3YFxWXdqy/wK9n+fCy+5dVRyDoqbbZbBBAKQPe3h/7Vo
         cBYgDPICzIMmsAcL3AyzVmuDQR1H8sq+VuXzuoBV9T3Zd07QC5N/j0M9TALPQuGvuR1+
         +PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uXXFSfS3qwAfrpAOQHAXOdwBdRY3+psDP0LE0+4iPvE=;
        b=VihRFcN5sjw/skdYT3FjHMxrZbnCZI8OU0kqEjbAERkJa41FIa/LTYJCp26+eIAn/N
         uD/GV0DSVVzEe5cT5k27NeTitH51k1tQGSECQLjniqfooYfNHUBULpW7GPC1g4LYz+8c
         LtSPkmcLBu5W+QcpCQVJJcpROqxpeK+XITiGoEsRUmVlqKPfeCIBWBy47qbu6/B2TtEe
         RvgZtGO5jiaWpYD2tUDqQu8Vl9ET2H4jfANXya79D4hmn6oBKkpzYd56SoKWJHb+KFBq
         KDldnzKj2MSq4qx15IIQRDSz4FhKIjaP4zm/LlMVcFKE/A0xxcwC4aZA3L0tvvX/bsQo
         pZKw==
X-Gm-Message-State: AHQUAuaqZipWaf2djkoC1Ui2t0W1Hg1sRhFbqCpfPSkOswOvVQueyikL
        jIRkf5DXeqtRhszfuCrDpUZazGL1
X-Google-Smtp-Source: AHgI3IYvVCMCXegkIxjxCLLHFl4x+iMCagyN0S/zFlL8eT+XiNoAmVnnQGK8BakT184KFjuEyu762Q==
X-Received: by 2002:ac2:5551:: with SMTP id l17mr11273565lfk.24.1549556263778;
        Thu, 07 Feb 2019 08:17:43 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id z4-v6sm1062542ljz.15.2019.02.07.08.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 08:17:43 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0b7963a4-ee9c-7296-1478-38235af7cd40@gmail.com>
Date:   Thu, 7 Feb 2019 19:17:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398D9CA36FCFF81BBC8E7B5C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2019 19:08, Sowjanya Komatineni пишет:
> 
>>>>> It became apparent to me that there is a problem here. The size of dma_buf is 4096 bytes and maximum message length is 4096 too, we have pushed 12 bytes packet_header to the buffer >and now there are 4084 bytes left for the message in the buffer. Hence transfer of 4KB will cause buffer overflow and either crash kernel or corrupt memory. One solution is to just always >push packet_header using PIO, other to reduce max_write_len or increase dma_buf size.
>>>>
>>>> Yes, This is known to me and I will add separate patch for this to 
>>>> update quirks to take care for t186 and t194 to exclude packet hdr lengths There was separate patch when quirks were added and it got merged already from 5.0-rc1 but don’t want to sneak that here. Will send separate patch to take care of this.
>>>> Need to update quirk to exclude packet header
>>>>
>>>
>>> No. This is a bug of this patch, it must be fixed in this patch as well. 
>>>
>>
>>
>> I'm not sure we actually need this. My understanding is that it's really the payload size that's 4 KiB and 64 KiB, respectively. I don't think that includes the header.
>>
>> Thierry
> 
> As per the design, Yes that’s including the HEADER. Its total transfer per packet including header.
> 

My understanding that I2C's max read/write sizes quirks are the payload limits, and so excluding the header size. Hence I'm not sure what you are trying to say, Thierry.

Sowjanya, also.. it should be fine if you'll include the separate patch into this series, placing it before this DMA-patch. I just read your message as "patch separately from this series".
