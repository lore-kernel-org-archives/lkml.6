Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E20C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3172921920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U7PyiA9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390848AbeLUOLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:11:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39304 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388961AbeLUOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:11:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so2572551pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=78wocBL/vbQ0HY8CjHhLdO17OC8EYSaLbuOHWJ06LQc=;
        b=U7PyiA9GkHVY7izshsVE2jJer1Y2DUOFr/bvh+2pm9d4t2lckwiRmbD0vLvWKxY1NR
         DSqfsjXpYivMLU89D2YVbSmYRZO1+B4fCFxLq/JWSY6nIDQA/z0wcrg2DzISCk9Ailni
         sI1pLxOZvQaZZ80aeGTDM4SOMJ1w/1MUT9A5rtGWplSh2Avf8OUdsJsMNC1m8abFZtD6
         xByJDtrh44NW2h6p0GqAHRDdh91QjIsy/dDlEksc1bI8/W+ephJ/YHhHePS+IhFuWRJs
         wsT7ogjD/1/aYgAG+pYSTwTZDYhLKNZUsvytq4DX/nxFO4NuOqAQ+IlOjOiy8PHEsmqX
         shGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=78wocBL/vbQ0HY8CjHhLdO17OC8EYSaLbuOHWJ06LQc=;
        b=LxlQ8tWuBaeGhOuUaI3P1D0rx53vn9PTYfyyTGudo08pt+DkDNdzn3GaogE8y0ZNq5
         PTOoAyaYOPfYDu58nNqQHxav40Te4u9QhsZ9hPEP5Nxv+CIxCR5enWthuXzO9Fq7CxlF
         5UOapA+GNtnytSjAL2+R/ymL+E+AC13IsUv5EuJtPgseHeJUBJxsyciWudH5IFD5BK0v
         dQJ+dnrLZ+20S175LRv7fz6t1aWTuMvMweOjQTn0xjwTHlX8RXl0MAQVTAOk8fneSs4K
         8KPPCwXV9s3Glb/MGYyUjgN0pgjDLXJA/047xyTEw3uikjDuzJAFedEXHeGd0fYkQMXd
         dtGg==
X-Gm-Message-State: AJcUukcV1IX3EOX+rnkF0BWs/QvoQZZPQeRlCbx4IyzeS1Kg1a9vi1F2
        WcE7IGzYxRZmiyBLtYUYJV5UHm18tYbmxQ==
X-Google-Smtp-Source: ALg8bN6iUV8fMI0AJSU1RgcaJQCg8teNpBVN+xxpXqyIbUQ4bQiL+HfybFfW7eA4ZwMA8muoc52wpg==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6mr2690423plb.217.1545401505885;
        Fri, 21 Dec 2018 06:11:45 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id h185sm13359624pfg.143.2018.12.21.06.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 06:11:44 -0800 (PST)
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CGME20181121130510epcas3p4498edc67a02f61a6aa8e55efa9349681@epcas3p4.samsung.com>
 <20181121130439.22255-1-tiny.windzz@gmail.com>
 <b3331d3f-3bfd-f3ce-cea1-30c4b13e6374@samsung.com>
 <a925d66a-09ea-b6db-8043-df58548da192@kernel.dk>
 <CAEExFWuNc+3RyEHvpfAxtFFeFKk9nyVE_ZKHcpy2T6VWOEY1QA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1dcd36fa-6183-a477-0bb0-9543d3287e90@kernel.dk>
Date:   Fri, 21 Dec 2018 07:11:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWuNc+3RyEHvpfAxtFFeFKk9nyVE_ZKHcpy2T6VWOEY1QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 6:09 PM, Frank Lee wrote:
> On Fri, Dec 21, 2018 at 2:01 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/20/18 10:03 AM, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> On 11/21/2018 02:04 PM, Yangtao Li wrote:
>>>> of_find_node_by_path() acquires a reference to the node
>>>> returned by it and that reference needs to be dropped by its caller.
>>>> bl_idle_init() doesn't do that, so fix it.
>>>>
>>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>>>
>>> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>
>> Yangtao, were you going to resend this one?
> Actually,I've rensent the v2 at  Nov 22.And  I just changed the changelog.
> Can you pick it up?

I missed that, sorry. I'll pick it up.

-- 
Jens Axboe

