Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E594BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EAD206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7GIlPkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EAD206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389816AbeKVH4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:56:42 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34136 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387437AbeKVH4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:56:42 -0500
Received: by mail-wr1-f46.google.com with SMTP id j2so7179135wrw.1;
        Wed, 21 Nov 2018 13:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A5uLxxpVh2NUb07B1fMFEjfoH6ycGdu8Yj4ZFa+lS00=;
        b=S7GIlPkDrPXPMl+DnvFmbYY/RK1UFrhAfYm3SVOnHaVaNqnzBZVI7k1ZErmQe7/Lh/
         G/Q86xWrfUhTJliE2kSu5fQrQW/hljcb0V1wk8efCnhrkqy9k4x/iX/6m4QUfbvMJpxp
         m9787f8qI9/wZq/7q3RD0QIgy18bcw3GA2KFiaODWlYriptfLUNcgwj5NpKR8JtxwF1M
         O82gMoj8XfyslgPDyTCYzeROO6ot8Dl8LxMi0KN6KeaMckcH26piPikWGfksmhku2ar8
         TtoqQX4QhJLw4KYfjXFSegttDJkcwoZfP7F+v1Z5hDAUpR/8XLuWQgJxrcjf43uSWNIq
         zX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A5uLxxpVh2NUb07B1fMFEjfoH6ycGdu8Yj4ZFa+lS00=;
        b=ZCLkrSTq58FgsT66SNDIE6Q/GB/sLClv6j5ysl+ovIbDhd4YD0l+okmcZmzKGYeXtO
         e2jmjohVRI9U6XFKMwxHjOQBjXGsyeEEyl6BGAwnLx2+2V/ijBshMXwfAt8vr9atuBtU
         r0SDsVURehsqqygAxoAIA7axScOJYzexRDE1nLOCd31+X4YU4Ktwvf//ZmdX7I/8tRa9
         qsUGzNv83BbCGASYxgNp47CDo9loQpUrRY2MOri2i1enXazyWwDHKZAh5uq4CmLb3L8n
         aQ+52+Wyrc0CAnNOJ4M+fagWvoCrI9wt5HpJlR7wNWy4DAtTVCmm89v734r3l6DPJUiC
         WKQw==
X-Gm-Message-State: AA+aEWZOlxptikMlLUK8QUS6a+E7awufYWrXMKQZ76Ei5uM5lTrpOrEi
        URyvXYfdt5aMFFUHB59V3WcEZf8B
X-Google-Smtp-Source: AFSGD/UkQlO3nw8WM1rYDMIjErWjVTBo9wqbWlTo6vIGT0LO2QlnxMPCywJSLoxRBnTE/LQFCG1dEA==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr7687424wrm.223.1542835237736;
        Wed, 21 Nov 2018 13:20:37 -0800 (PST)
Received: from [192.168.43.227] (94.197.121.1.threembb.co.uk. [94.197.121.1])
        by smtp.gmail.com with ESMTPSA id s81sm2683814wmf.14.2018.11.21.13.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 13:20:37 -0800 (PST)
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        stakanov <stakanov@eclipso.eu>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <4e0356d6303c128a3e6d0bcc453ba1be@mail.eclipso.de>
 <20181120104217.5b487bcd@coco.lan> <1593929.t9Y74Rdlh1@roadrunner.suse>
 <20181120140855.29f5dc3f@coco.lan>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <96849b97-3abb-b879-ed05-35bcd58b5e43@gmail.com>
Date:   Wed, 21 Nov 2018 21:20:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120140855.29f5dc3f@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 16:08, Mauro Carvalho Chehab wrote:
> Em Tue, 20 Nov 2018 14:20:01 +0100
<snip>

> Ok. Now, min/max frequencies are at the same scale. For DVB-S, 
> dvb_frontend_get_frequency_limits() returns both in kHz, so the frequency
> range is now OK.
> 
> The tuning frequency is wrong through. 10,719,000 kHz - e. g. 10,719 MHz
> seems to be the transponder frequency you're trying to tune, and not the
> intermediate frequency used at the DVB-S board.
> 
> That sounds to me either a wrong LNBf setting or a bug at libdvbv5 or
> at Kaffeine's side. What happens is that the typical European LNBFs are:
> 
> 1) the "old" universal one:
> 
> UNIVERSAL
> 	Universal, Europe
> 	Freqs     : 10800 to 11800 MHz, LO: 9750 MHz
> 	Freqs     : 11600 to 12700 MHz, LO: 10600 MHz
I am pretty certain this type is obsolete it doesn't look right for 9750Mhz oscillator.

I am sure it was 10000Mhz or 96?? or something like that for old analogue transmissions of 
20 years ago

> 
> 2) the "new" universal one, with seems to be used by most modern
> satellite dishes in Europe nowadays:
> 
> EXTENDED
> 	Astra 1E, European Universal Ku (extended)
This needs renaming as 1E has long gone.

Certainly this type is used for Astra 19.2 and 28.2.

Ideally we should use a default LNB type for each Satellite either in libdvbv5, Kaffeine or respective tables.

Regards


Malcolm

