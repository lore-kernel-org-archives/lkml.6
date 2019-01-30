Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5FEC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8D82184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UphX7E/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbfA3KE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:04:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34997 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfA3KE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:04:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so21070965wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 02:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oo1kQyMUGCUjislYa6LlOze0vrMNQ5FaLTM41ZieqG8=;
        b=UphX7E/quzi2ltMApn41JSicUG4t2G10B5oXDGv4/PHrDm+nYV12oO/oa6khUAqite
         YpGzHx2Ddj+hSrUuhGj4aUwnqwXHUUZnAGHP0ESuZt6W8AMo5FRxejjMTq2Q+I/yFbA/
         RAQqYclkyy+3PyjN7lBbU4UoWD8p6Sg2NguHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oo1kQyMUGCUjislYa6LlOze0vrMNQ5FaLTM41ZieqG8=;
        b=aHDp7vW9IbiduLX31+5OAdSF87DNeGHBzbAjQTvVf1y+d6x4DmEcUlvhe6u2vlhL1Q
         tun63a+JjaJ6gdkqciQlDih1Wai3lvORbJWyobsF/I60en3hDT2e2RiTDUv5rOy2anUJ
         /RFv2VE0nvPDYigVNK64eMZDKeIAtC1mOc+59YT7GY700lkfzyL1sjdfEik7AEgiScJO
         1tmvzbw8e429ILkWtuJALCbX/RVXbVJIyONE/6nd+cyhWpss/+fDL8xPR8CwC2hUYeea
         lg+C2JMTz3oqIlvWK7IDtR2ODuRWlcavQdtvLKNji6DQexVTm9uXX0LV3HNoD7UAbMDl
         4FOw==
X-Gm-Message-State: AJcUukdBCTHsKkfGFuihG8rwnglWgo5NjFdYfMW4E+pvCglJfdvJ6H87
        KbrjxHQcfA0ocPOP0SKSK5WQnw==
X-Google-Smtp-Source: ALg8bN5VdDVfSK3jkpzTR7ScNQNvZQWNx+b8Vq5n67G0YQrVb9MhxKbQlqlECx9+AZSGNsAQ5TGH3g==
X-Received: by 2002:a1c:968a:: with SMTP id y132mr24391391wmd.107.1548842695839;
        Wed, 30 Jan 2019 02:04:55 -0800 (PST)
Received: from [192.168.0.41] (164.30.95.92.rev.sfr.net. [92.95.30.164])
        by smtp.googlemail.com with ESMTPSA id a1sm978712wrw.76.2019.01.30.02.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 02:04:55 -0800 (PST)
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michael.Kao@mediatek.com
References: <20190109055724.184692-1-pihsun@chromium.org>
 <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
 <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
 <CANdKZ0eDwTgKoFsAOboCz=q+nsUWepecXA7wmR=jGhkWEzLvnA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <49dbd0af-975e-cafb-d1b9-4e491a6c9383@linaro.org>
Date:   Wed, 30 Jan 2019 11:04:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANdKZ0eDwTgKoFsAOboCz=q+nsUWepecXA7wmR=jGhkWEzLvnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2019 10:25, Pi-Hsun Shih wrote:
> On Wed, Jan 30, 2019 at 3:44 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 30/01/2019 07:04, Peter Shih wrote:
>>> Adding Michael Kao to cc list.
>>>
>>> On Wed, Jan 9, 2019 at 1:57 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>>>>
>>>> The mtk_thermal struct contains a 'struct mtk_thermal_bank banks[];',
>>>> but the allocation only allocates sizeof(struct mtk_thermal) bytes,
>>>> which cause out of bound access with the ->banks[] member. Change it to
>>>> a fixed size array instead.
>>
>> Even if the fix is correct, it pushes back the bug later in time if a
>> new board containing more than MAX_NUM_ZONES is introduced. I suggest to
>> dynamically allocate the array with the 'num_banks' value.
>>
> 
> For the current code structure, those mtk_thermal_data are statically declared,
> so if there's new board containing more than MAX_NUM_ZONES of bank_data, it
> would actually be a compile error.
> 
> I'm fine with either way, but feel like that this is simpler than manually
> calculating the size needed for allocation.

Right, I missed it can be caught at compile time.

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

