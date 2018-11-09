Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B383C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9DF20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GDukpfyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9DF20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeKIU27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:28:59 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4538 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKIU26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:28:58 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5be5661e0000>; Fri, 09 Nov 2018 02:49:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 09 Nov 2018 02:48:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 09 Nov 2018 02:48:55 -0800
Received: from [10.19.64.176] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Nov
 2018 10:48:51 +0000
Subject: Re: [PATCH] pinctrl: max77620: Use define directive for
 max77620_pinconf_param values
To:     Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>
References: <20181101005021.8393-1-natechancellor@gmail.com>
 <CACRpkdY0YnUCFYahabGr7GBetBHs++QygDs3KVB=hMRBv0fGZg@mail.gmail.com>
CC:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
From:   Laxman Dewangan <ldewangan@nvidia.com>
Message-ID: <442c61c6-4a23-ae98-b017-cb129ba3af54@nvidia.com>
Date:   Fri, 9 Nov 2018 16:18:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdY0YnUCFYahabGr7GBetBHs++QygDs3KVB=hMRBv0fGZg@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541760544; bh=21h3RynuHaDBuH41H6HLwiejDOXNbDBXxcH0eE4BWvQ=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=GDukpfyFAhNlVL1Zf5r3t0j3FAGDSu0CMWIDvi1BkvHA0VL6VbcYDba+iN34ydbT9
         fZxjyDbgaG5wiNGQusccB/MHdGkaW2+I7zhcNSBPxdWQVQZ/tmZiTtUeW7Pwl3LHRZ
         OkCWtSCXQplILS4kaYGoW1tc/T8iyunuQxrXoOMPl51zPQQG1m43TtlrKCQmMEPvFl
         iDKHDT734s04fc7JN1EHCuVreXJUHvnM6K6Fzmk0HVLHAov7Q3aeo/Obos8h6KwwIp
         Bz854EcP/Md3Ob9ALQ5GiuoLqYgPJNYwH2H10nWzXJxfQuCuK7aM1PoKbs162YRgqo
         VfVEO/KSCMHCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 09 November 2018 02:31 PM, Linus Walleij wrote:
> On Thu, Nov 1, 2018 at 1:51 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
>
>> Clang warns when one enumerated type is implicitly converted to another:
>>
>> drivers/pinctrl/pinctrl-max77620.c:56:12: warning: implicit conversion
>> from enumeration type 'enum max77620_pinconf_param' to different
>> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>>                  .param = MAX77620_ACTIVE_FPS_SOURCE,
>>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> It is expected that pinctrl drivers can extend pin_config_param because
>> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
>> isn't an issue. Most drivers that take advantage of this define the
>> PIN_CONFIG variables as constants, rather than enumerated values. Do the
>> same thing here so that Clang no longer warns.
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/139
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Patch tentatively applied.
>
> This seems to be the direction we need to be going with a lot
> of CLANG business.
>
> Laxman: you weren't CCed, so tell us if you dislike it for some
> reason.
>
Looked changes and it is great. MISRA-C also happy with macros instead 
of enum.

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>


