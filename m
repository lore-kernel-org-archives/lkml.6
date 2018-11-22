Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA20C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CBA20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuwNuP7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CBA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404393AbeKWBVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:21:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45706 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeKWBVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:21:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so9490937wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cbvK4hi3MkPgvaVx/5DjqWtEHGitaiK0Xj4jdkMYHWs=;
        b=LuwNuP7+x7U723kYtkJo9Pe2Zhak9p3Vj//nQDjtrWXzoRlEOW1sisDuZsBWC0VZCG
         fJzULcl/GO0/ajI+bjNbShhmaqXR0T19cz518B8orakzabucAEStKLRJNX8JrfiKw0y9
         rq1tPkT9L6+yYh/Gtai/3MAP+JgD0qWzkFre4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cbvK4hi3MkPgvaVx/5DjqWtEHGitaiK0Xj4jdkMYHWs=;
        b=LURja+ISNAFNX4w+QsHOf2GDLZXEKholYIl1HHC5mySCmbVr5qE3yTULDZ/53kwpxa
         /YfiojRu0dBJovnGhZ59xeAbIYcNs5Xte209qxLO31NJXhmYLFcFz8FzaFhvUH2/ZaIy
         sH+6/3gFG1tVK0mBpGtBqE7CJUxmrS1gCkD9+WYTtDhECzebUb6K9uuT4o2aAjHh5zOQ
         qvg+vmHnrcXEv6Somj6qA7z24EOVgpywbmgSAAE+li7QsQ6VcCmTK3syDK0oyjBvkf6E
         xFDba/za3mjeV3pwU4XQFH/mMsTCBnKrMtiT0tPbdO3j2II4EiihqyO/NaeiOr2RAQwV
         bguQ==
X-Gm-Message-State: AA+aEWbwMR5XKMr0YWemrxyTjZydZzFw3Qpj/PdVQDU4t9L588/PFjn+
        u3/t/ArkoVsEHGMOZMSr4Hu2QM03Lfs=
X-Google-Smtp-Source: AFSGD/UBPhsv1YEtcg/afecEf/WsmbLwLxxJWnRH8ysd+kXiY/+NgF01R1+8ZRw6I1V9qHCStCOwew==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr10618432wrp.92.1542897712006;
        Thu, 22 Nov 2018 06:41:52 -0800 (PST)
Received: from [192.168.0.40] (44.65.136.77.rev.sfr.net. [77.136.65.44])
        by smtp.googlemail.com with ESMTPSA id x136sm6294847wme.0.2018.11.22.06.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 06:41:51 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20181120131853.19710-1-tiny.windzz@gmail.com>
 <5ea4da1e-65de-ddc3-5ca6-eb83c2347930@linaro.org>
 <CAEExFWsOh1gixoC4bbSkbawC-ybz1YUA-tmw5FW5W-GFyFGs7Q@mail.gmail.com>
 <54a66dbf-df0a-8cec-cb60-0603a52dad99@linaro.org>
 <CAEExFWvTCJ-k+54PGv7Ov5FRMpD1C2ZzzUxi4=Kbn_hrkmBmqw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a645f0bd-bed4-d472-f3db-30fc1f952797@linaro.org>
Date:   Thu, 22 Nov 2018 15:41:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWvTCJ-k+54PGv7Ov5FRMpD1C2ZzzUxi4=Kbn_hrkmBmqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 15:39, Frank Lee wrote:
> On Thu, Nov 22, 2018 at 10:37 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 22/11/2018 15:33, Frank Lee wrote:
>>> On Thu, Nov 22, 2018 at 10:26 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 20/11/2018 14:18, Yangtao Li wrote:
>>>>> use of_node_put() to release the refcount.
>>>>>
>>>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>>>>
>>>> Applied, thanks!
>>> Hi Daniel：
>>>
>>> This patch is a bit small, I will resend。
>>
>> What do you mean by 'small' ?
>         pri_node = of_find_node_by_path(path);
>         if (node == pri_node){
>                 of_node_put(pri_node);
> 
>                 /* The primary timer lacks IRQ, use as clocksource */
>                 return integrator_clocksource_init(rate, base);
>         }
> 
>         sec_node = of_find_node_by_path(path);
> 
> Under my revision, pri_node and sec_nodeare the same thing.
> 
> Yours,
> Yangtao
>>
>>>> --
>>>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>>>
>>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>>> <http://twitter.com/#!/linaroorg> Twitter |
>>>> <http://www.linaro.org/linaro-blog/> Blog
>>>>
>>
>>
>> --
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

