Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD73DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ED620866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7AJ/Fm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74ED620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeKKXPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:15:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40521 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeKKXPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:15:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id w14-v6so1031021wrt.7;
        Sun, 11 Nov 2018 05:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EhCsaP7JHJY3ixUioPIMz9+bzITJ384+ymznfxWL05U=;
        b=C7AJ/Fm3mFtQBgTlmdpPxaHIWtV9M9+tkRzDwsli9IewVlyMWNMZqrGeu7XTmJ7JT4
         WiNIUQVEP6my+q3FJLvhjfSQ/rsNHMOmaaihOCE+VLo464W21l/euD4ZaPYiF4Dv5F4Z
         LObDj0JGZXOavMIYeTi5prbYEa8qfG8EHMEThn6vy44xrj9Wnqr+oFV5GX5Yl4gg9g6o
         +lcP8m/MmvjcAHaH55TVzi6gxlLn35yLp5JJ/YP5IOz13D5BaQrYPqyKJDclbUWKRB1s
         bg9s34Uyy08OvLcGoGNCAvWmYRT9REAr3IHAgS/dIQ2VJz7zzbQulZSwG+jnhPMX2lkV
         m1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EhCsaP7JHJY3ixUioPIMz9+bzITJ384+ymznfxWL05U=;
        b=X2xOPyGIj9ryq8EygkEX8L0EKI5VdsJdzu9UJdFltNZCG6nP+E/gP1Qxa4hcC8QvBI
         ee1R2gzv/u5hFSdvR9ciYWBixuQzujzvfi/kUZXhlbWJFRAouXpcAk9JPpHo3imkhoJh
         3qmWJmZgVmu+7CaWAUQlpclezLxoUP0Xtq9VRegQGVb1mt5XTidz6okQJdkF1TUeRbhD
         vPDSGmgq06iBLzfcqymWbvSDMhW3mpQGA66aZmCDB5qEkMzwtGjGAewwBdZ0/0+X4rjl
         VXncj96WJOAEJ+foqX2F41M8UAfiv2tKT/pZTo+/1PmH4OOud3Ojh/i4mKHFLQL4papi
         QZyw==
X-Gm-Message-State: AGRZ1gKj+ZVhKoaqWXw7aVsN6OQlEMpwoanCsnNXzF32jxNGym4g2uX0
        6iX8tFEtRqXAYuNSud9gC7r7/a4i
X-Google-Smtp-Source: AJdET5eGtfX0n3J65LEe8M7zH0twWgpU+fsZLK1L26CBHpKak8Ftuf/u6FL1/AjmM/gKVJDkN4AnNQ==
X-Received: by 2002:adf:bbc5:: with SMTP id z5-v6mr13884604wrg.183.1541942818564;
        Sun, 11 Nov 2018 05:26:58 -0800 (PST)
Received: from [192.168.42.150] (cst-prg-2-96.cust.vodafone.cz. [46.135.2.96])
        by smtp.gmail.com with ESMTPSA id p16-v6sm23838032wro.29.2018.11.11.05.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 05:26:57 -0800 (PST)
Subject: Re: [PATCH] mfd: bd9571mwv: add volatile register to make DVFS work
To:     Wolfram Sang <wsa@the-dreams.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Dien Pham <dien.pham.ry@renesas.com>
References: <20181003135841.4984-1-wsa+renesas@sang-engineering.com>
 <20181109110413.GC1031@kunai>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <0250a104-dab0-b8cb-11e3-e061be103018@gmail.com>
Date:   Sun, 11 Nov 2018 14:26:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181109110413.GC1031@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2018 12:04 PM, Wolfram Sang wrote:
> On Wed, Oct 03, 2018 at 03:58:41PM +0200, Wolfram Sang wrote:
>> From: Dien Pham <dien.pham.ry@renesas.com>
>>
>> Because BD9571MWV_DVFS_MONIVDAC is not defined in the volatile table,
>> the physical register value is not updated by regmap and DVFS doesn't
>> work as expected. Fix it!
>>
>> Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
>> [wsa: rebase, add 'Fixes', reword commit message]
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Fixes: d3ea21272094 ("mfd: Add ROHM BD9571MWV-M MFD PMIC driver")
>> ---
> 
> Any blockers for this one?
> 
>>
>> Grabbed from the BSP and confirmed by the datasheet. The register is RO
>> and reflecting states depending on other registers.
>>
>>  drivers/mfd/bd9571mwv.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mfd/bd9571mwv.c b/drivers/mfd/bd9571mwv.c
>> index 503979c81dae..fab3cdc27ed6 100644
>> --- a/drivers/mfd/bd9571mwv.c
>> +++ b/drivers/mfd/bd9571mwv.c
>> @@ -59,6 +59,7 @@ static const struct regmap_access_table bd9571mwv_writable_table = {
>>  };
>>  
>>  static const struct regmap_range bd9571mwv_volatile_yes_ranges[] = {
>> +	regmap_reg_range(BD9571MWV_DVFS_MONIVDAC, BD9571MWV_DVFS_MONIVDAC),
>>  	regmap_reg_range(BD9571MWV_GPIO_IN, BD9571MWV_GPIO_IN),
>>  	regmap_reg_range(BD9571MWV_GPIO_INT, BD9571MWV_GPIO_INT),
>>  	regmap_reg_range(BD9571MWV_INT_INTREQ, BD9571MWV_INT_INTREQ),
>> -- 

Makes sense,

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

-- 
Best regards,
Marek Vasut
