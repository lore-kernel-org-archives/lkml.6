Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1164CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE172145D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opCWN5xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE172145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbeHQOMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:12:50 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39732 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeHQOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:12:50 -0400
Received: by mail-qt0-f195.google.com with SMTP id o15-v6so2250122qtk.6;
        Fri, 17 Aug 2018 04:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c+tZzTRIqbAWxmUIx3dkilItV7tCjFdZWx667HsbkYs=;
        b=opCWN5xG/sEayGddsZ7iamSWaf5l0HeyUkkx4lkH6OmlkUb8KLC5J8v52kapNdguEL
         GexbCnrkxBM84B1JXEMvVHofgJpC3zErRAe8pcIWvuCmhVyhJ7me9mI7IbTUSCn6OOkX
         KbDVqut9dzowYv3ClN0aT4uaoA/pc+l5N/4N6EauWHpR3NR1EsqMmwflR05hjVfDUsoK
         vLlzbrxpQqq6JLSvwfwAE37u/ajGobdZIcrZBfRNZ1gcGehWfximvLebEmcIQkGIf/TF
         wuquKWjhpgZutvuICnUkrfvhNHU7B5nNc5veBvi2o8C0dnBdAnz/goSF1LyglMnUZ8m9
         t7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c+tZzTRIqbAWxmUIx3dkilItV7tCjFdZWx667HsbkYs=;
        b=EBY5qkvzQldTgFKUosqIAPM02Y2TDHEPWppzT+tuZCF1gc/0rcpCrmSYxnYeFYFgH/
         NI9lkr5vyDDvtQJrKRUW8WXqlPPtWIKBcc7jNg65+ecUywMJkzjcmiSez/6zeR0FUZZJ
         tlFTCA6AA4IP0wXawm4NMhuCW9NYFdlyC/SBR8+heVbUuh9g9g13iSlx/tA+sAWaoqAn
         r2Uolz92dRZnCT6DMLoc+iTpAAmeDlQi85Y26Jjes+J4UwnXIl8EySiSJVyQ64POTMnX
         y/DzwKla309e6zw17TWumPykEfattOYDMZhCsy8Y389RQiB8PUQmDro2/gfwBynRiNAz
         Wtcg==
X-Gm-Message-State: AOUpUlE+K8v4sNoZzQyp+Pi7hSPCy6mO1yt9IRT3GlXAU8QPVwYPx9uF
        2K622rvLvUpLTPS9M/e/OKqL/m105YT39MsScE0itcKY
X-Google-Smtp-Source: AA+uWPwbnSSkFiJeJb9D5h6sU/FYtLYuAhevYWDAG45u7f3lsrktKqvBJLJdL3CY5TbxUScyEBEhW2/QughHJLtm5Gw=
X-Received: by 2002:a0c:9088:: with SMTP id p8-v6mr30446036qvp.136.1534504186891;
 Fri, 17 Aug 2018 04:09:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 04:09:46
 -0700 (PDT)
In-Reply-To: <CAHp75Vd1ZZDJtASfFpr=eE+zaEiOxH3ohdSOe1aTcE3qEMd_QA@mail.gmail.com>
References: <7ccdc39d7e255547e851497ef9f449715b45f8bd.camel@kernel.crashing.org>
 <CAHp75Vd1ZZDJtASfFpr=eE+zaEiOxH3ohdSOe1aTcE3qEMd_QA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Aug 2018 14:09:46 +0300
Message-ID: <CAHp75VfjZe7XqJjv0CYFHXi95_v7R9B9E9eix+0xRwqn2tq6nQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: Silence "unsupported" message a bit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 2:07 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Aug 16, 2018 at 2:27 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> This driver prints that "Unsupported machine..." message on every boot on
>> ThinkPad X1 Carbon laptops (and I assume a number of other systems), which
>> causes graphical boots to "glitch" a bit and is rather annoying ...
>>
>> Make it a pr_debug instead.
>
> Thanks for the patch. Unfortunately it doesn't apply.
> Please, check your mail clients and tools for formatting patch (it
> produced at the end spaces instead of tabs)

No need to resend _this_ time. I have pushed to my review and testing queue.

>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
>> index 8952173dd380..7f7192e8fdab 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -2216,7 +2216,7 @@ static int __init acer_wmi_init(void)
>>         if (wmi_has_guid(AMW0_GUID1) &&
>>             !dmi_check_system(amw0_whitelist) &&
>>             quirks == &quirk_unknown) {
>> -               pr_err("Unsupported machine has AMW0_GUID1, unable to load\n");
>> +               pr_debug("Unsupported machine has AMW0_GUID1, unable to load\n");
>>                 return -ENODEV;
>>         }
>>
>>
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
