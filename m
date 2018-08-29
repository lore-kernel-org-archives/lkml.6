Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63117C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDB520652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DD0+518q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDB520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeH2W6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:58:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43071 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeH2W6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:58:03 -0400
Received: by mail-qt0-f193.google.com with SMTP id g53-v6so6997132qtg.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aj7vKNoh1Ub9jx1gxpkiw3iLReAJmQvV6UDu1lFdRFo=;
        b=DD0+518qXZyd9QVodeotIAU7Fg7rkvWWhQfvU067kLIWGK+A3wHbhW5NAxBeRpiduG
         wDZ2grNUtOL69kNkRlf5Rout5P12+mUNi12o592wJc8IxgFKbWH6eYyCSqpcwkvdH7zc
         i35YdMv1ieTDZn87HPamK6D+QpePUWhI0EXek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aj7vKNoh1Ub9jx1gxpkiw3iLReAJmQvV6UDu1lFdRFo=;
        b=Sr/v6wL/v/pUUP1te4gWto8TiEzEJURuwVBHaOXLVho4KuBusejDoABtNWosS5CIuy
         kBflENxahPsc5k2EN+A4F6YChPLGVxeXCohuOKnEPgCWyxRn4trNJqWv9xQa6i1T+pj4
         zLMSGCDADuLvUHtCAMXl1cngUM9RiiqXA0yJq2ETEkRlRCg++git8q/MLBwPR6iULDFL
         lxbr02banFHIOoMTb56Nz6ekeb7w1L0tUhWXUi/R6OxvRWEK5wydq+yXTCEhcb82/ny2
         kPuwWcKSAskuDp5LiD65A8eQzIb8iKdJaaM686Mu/T81zZy8QXNvszLPEG6CIIvzLIIT
         bCUQ==
X-Gm-Message-State: APzg51AsNfSmSDR9pT44sAf/DRZS63tvV2s4JkPDnj9hMazWkU2RDrtS
        XbJZa2kvu03N6wZUiDhPGDjxV22k9VtkUA==
X-Google-Smtp-Source: ANB0Vda03ykvSH0Tj822rSSzaId2iV++iZsilsDM9orxyWU1ENlRno1rdV2OzsepAUKWzr7LhoOQfQ==
X-Received: by 2002:aed:2e22:: with SMTP id j31-v6mr3218654qtd.180.1535569188642;
        Wed, 29 Aug 2018 11:59:48 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d67-v6sm676223qkc.90.2018.08.29.11.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 11:59:48 -0700 (PDT)
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Olof Johansson <olof@lixom.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com>
Date:   Wed, 29 Aug 2018 11:59:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,


On 18-08-29 11:44 AM, Olof Johansson wrote:
> Hi,
>
> On Wed, Aug 29, 2018 at 10:21 AM, Scott Branden
> <scott.branden@broadcom.com> wrote:
>> Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
>> parameter to function with efi loader.
>>
>> Required to boot on existing bootloaders that do not support devicetree
>> provided by the platform or by the bootloader.
>>
>> Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the DTB loader")
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Why did Ard create an option for this if it's just going be turned on
> in default configs? Doesn't make sense to me.
>
> It would help to know what firmware still is crippled and how common
> it is, since it's been a few years that this has been a requirement by
> now.
Broadcom NS2 and Stingray in current development and production need 
this option in the kernel enabled in order to boot.
>
>
> -Olof

