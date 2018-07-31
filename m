Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE2FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440C12083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keh0dpNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440C12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbeGaOXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:23:14 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40216 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732084AbeGaOXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:23:14 -0400
Received: by mail-io0-f194.google.com with SMTP id l14-v6so12854560iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yfDT0sjOo/OCrTR4HuaFIvKNgLRSC0E4B8UOHDYeBw8=;
        b=keh0dpNdkGtVr+ZCIu/Y3NBwVRjzKOOIpr2Yi6fY9zBSmTLng76zLNyDYhlWYIj5k+
         /kLUWtsHQqZzYGbYtK5GaVxUJ9oHkBXOUa+LmMTiqhEUMX9b/gDYGtE2bcGO9RVOOYvC
         mBzHdLaA1y3u0bBzu1ABZNWOjNkC0j0WdUaLhLFlL22Hqb93rue4LxdRCs97AxFXqAUM
         nuTlO5NaoP0MTMdoTziduhq5im98BcuQDXCwAGJ2oR+bSbhzZhh9hrhJo864eErAVV2g
         Kxsa0ZFj4KWdu5UYhhFLR8fB8kKo765GRCuP1U+mt/m2epYxZx5/yY57pWpJ/1pAajCN
         EuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yfDT0sjOo/OCrTR4HuaFIvKNgLRSC0E4B8UOHDYeBw8=;
        b=bTfY37ThA/E1urtT2uv9doOoy9E3Cku081ChF1YlmkMjb1osXtFwS0n0XOWTRIo/KD
         tCKtRbL4YNSrAZ63Rlui9NjjJg7+1j8JiqW7Z9/hD1tokJS1MyhWB+zrb/Wxy8ST45y5
         np6amEUh3jMPRGAiateiDi9berNK7fL9pDibAT14IkdQeiOVAJSmrKR/yB2d+2TEEa61
         YC3WgGU48AKQDR5f54dWA+k7vDtvt66+3KzzDW0iO8YWhs3VEnd83x9I5G8qj1H2j4fP
         4v+qNeYaMdIu5ly1YVW12qfWQCE4cD6C6ErPKwRWrAzZnZz7qGy79ApUCHiM3q9Rn1BS
         Jj0w==
X-Gm-Message-State: AOUpUlEYtzP3sM+XwMOBNRlRsrDewyw69W+q9J0hzgg7ysVXkHH62RvH
        NDsJy00EfXrPWlA31vyMaiw2RU/wKNU=
X-Google-Smtp-Source: AAOMgpcA9OG+2TI5NHmPHalE5MkVt85+8ICkofl3OoEvEBjXN1IGsvCZB8hGRVjXLl+Mdi6WCHoKkQ==
X-Received: by 2002:a6b:9303:: with SMTP id v3-v6mr16377563iod.264.1533040984332;
        Tue, 31 Jul 2018 05:43:04 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id x14-v6sm2024063ita.18.2018.07.31.05.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 05:43:03 -0700 (PDT)
Subject: Re: [PATCH 5/6] arm: enable RapidIO menu in Kconfig
To:     Christoph Hellwig <hch@infradead.org>,
        Alexei Colin <acolin@isi.edu>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-6-acolin@isi.edu> <20180731120428.GA5696@infradead.org>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <3784698f-bd9d-6d02-6fa4-2f6057e4c93f@gmail.com>
Date:   Tue, 31 Jul 2018 08:43:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731120428.GA5696@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 08:04 AM, Christoph Hellwig wrote:
> On Mon, Jul 30, 2018 at 06:50:33PM -0400, Alexei Colin wrote:
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index afe350e5e3d9..602a61324890 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1278,6 +1278,8 @@ config PCI_HOST_ITE8152
>>   
>>   source "drivers/pci/Kconfig"
>>   
>> +source "drivers/rapidio/Kconfig"
> 
> Please include this from drivers/Kconfig instead of enabling it
> for a completely random set of architectures.
> 
This is not a random set of architectures but only ones that implement 
support for RapidIO as system bus.

On some platforms RapidIO can be the only system bus available replacing 
PCI/PCIe.

As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or 
"Bus Support" (ARMs) sub-menu and from system configuration option it 
should be kept this way.

Current location of RAPIDIO configuration option is familiar to users of 
PowerPC and x86 platforms, and is similarly available in some ARM 
manufacturers kernel code trees.

