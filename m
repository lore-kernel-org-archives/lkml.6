Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D979DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B53F20645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsKZ+kRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B53F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeK1LZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:25:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33187 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1LZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:25:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so8539939pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kl3TmSXp/KuFcmJhWc8G6eYDYnxTJFr7ZMpPc2/cJDM=;
        b=PsKZ+kRXTRGmkaUz1UrBFw8+8g2D3btm3JyFY4LBo7hNHYEJepU2zyddSMiGALrXa2
         kgixHTR3Q23CYBTVaf5L3ao3AzPVAi2PTQc1lk8xq6C/KSunwmr7FK4XMg4u3kBWCyn/
         qfguv1/QInayN4y9m8ZF20Ojpe8J9ZjnBSP08bnPs1Axpm0HhdSL6g9ZY8XWWzuQa8Vv
         Gv2ygaPgojqCw0diBXd1NeMjoYmJ4RMFaSHhTZdopxAw9M/WOMf5hx71uxa4Ri1zg7Z2
         k2wAQu/S0pEThuQ2EmzL+m+YGt9xa//DWoUkzdP7e+E+4+zDerpqnWzSKZzpNw8G00P0
         /RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kl3TmSXp/KuFcmJhWc8G6eYDYnxTJFr7ZMpPc2/cJDM=;
        b=NMrGCMMQviy1rOYxWpp/ufs9UzRWh+lz5S9nVrD5+MabWFFlDdr125KNJvdPXt9+o4
         FgH4ZwMPFPr5pCcc35rkmT99xq+xqu6n1MzGCT3M8Bnsw2ixYhPk5FkzZcHWwXdTe7qE
         ljdUK/zDK8q6GrRZgRjtZw3jHQJhr7ue3e5Okebn0vbvgzQdBzenyHGwFXsmQy7nkATH
         LGbdnnp4HakZo/WjW6xavaLRRszdtQCQXrvmn5QutE4e75J3rvL8PPGTftudi3H5OWEw
         YP7vZF1FJDQG9fo0kizNc2RaUMvSSikwY48gC6qtTtdNFfbZ6CI7zmv4N0MDovgQTPC9
         zaBw==
X-Gm-Message-State: AGRZ1gLasJ2ELev1jnDtoep+m9/WHwtStDk/m0PLsPNjCHMoDREREwiS
        U6tmGenYuiY1ag1GNtSYRejveOTu
X-Google-Smtp-Source: AFSGD/WmygnXhfwMwTVAwr+NwyQm3fJXRA6kz+khGxZpbCccAGEaPOxTDX0MyRsVHZyOW2Bna+lldQ==
X-Received: by 2002:a63:42c1:: with SMTP id p184mr30913919pga.202.1543364736682;
        Tue, 27 Nov 2018 16:25:36 -0800 (PST)
Received: from [10.0.2.15] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 139sm6598471pfb.127.2018.11.27.16.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 16:25:35 -0800 (PST)
Subject: Re: [PATCH v2] soc: bcm: brcmstb: Don't leak device tree node
 reference
To:     Frank Lee <tiny.windzz@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, treding@nvidia.com,
        olof@lixom.net, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181124145223.29208-1-tiny.windzz@gmail.com>
 <CAEExFWut2Vu0e+j1U8_1PS683DtMMi7FVD6X=LfwwE63DT7Syg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <78dec05e-c936-4dbc-de8f-969c20ff6587@gmail.com>
Date:   Tue, 27 Nov 2018 16:25:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWut2Vu0e+j1U8_1PS683DtMMi7FVD6X=LfwwE63DT7Syg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/18 6:42 AM, Frank Lee wrote:
> On Sat, Nov 24, 2018 at 10:52 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>>
>> of_find_node_by_path() acquires a reference to the node returned by it
>> and that reference needs to be dropped by its caller. soc_is_brcmstb()
>> doesn't do that, so fix it.
>>
>> [treding: slightly rewrite to avoid inline comparison]
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>> ---
>> Changes in v2:
>> -update changelog
>> -slightly rewrite to avoid inline comparison
>> ---
>>  drivers/soc/bcm/brcmstb/common.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
>> index 14185451901d..bf9123f727e8 100644
>> --- a/drivers/soc/bcm/brcmstb/common.c
>> +++ b/drivers/soc/bcm/brcmstb/common.c
>> @@ -31,13 +31,17 @@ static const struct of_device_id brcmstb_machine_match[] = {
>>
>>  bool soc_is_brcmstb(void)
>>  {
>> +       const struct of_device_id *match;
>>         struct device_node *root;
>>
>>         root = of_find_node_by_path("/");
>>         if (!root)
>>                 return false;
>>
>> -       return of_match_node(brcmstb_machine_match, root) != NULL;
>> +       match = of_match_node(brcmstb_machine_match, root);
>> +       of_node_put(root);
>> +
>> +       return match != NULL;
>>  }
>>
>>  u32 brcmstb_get_family_id(void)
>> --
>> 2.17.0
>>
> Hi Florian:
> 
> How about this ?

This looks better, I will add:

Fixes: d52fad262041 ("soc: add stubs for brcmstb SoC's")

while applying the patch.
-- 
Florian
