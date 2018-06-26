Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41468C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CE52660C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SD9h/KCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CE52660C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932235AbeFZHbv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:31:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34180 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbeFZHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so14440029wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b4fF2oO0bkEEogS6xZ3JsLqMwxHX67ERrCJz453a/1M=;
        b=SD9h/KCaYPHpVvMV5I/Gi15u09shf+2VUo/fzBC9VOeC6NZaSh2d9FaId9c1xbkzzL
         3gZmSlNS2+SgLEUNGTKIKb/fSjB6GeiHi+5tCHhP2Fg9EEf12gDBLHAHstnO9HVdd59h
         QawQizvpj1bkfSZhAMie4PBj4SP3H0vbIzqPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b4fF2oO0bkEEogS6xZ3JsLqMwxHX67ERrCJz453a/1M=;
        b=iH3wUg6wgJbm034AXXLbjN2kTvMsdHuJ7y1ajzg9wCQCZaXkO7SOWZ7IkEIG9qd7d3
         gOeZ6F/CARNIa7/3prtd1jAR/H6p0ryKes4VKXkqjIlCMJpb7A2+e/YfrqqItQw/fuEP
         AoPKH3IrMSjACPl5IfmbumFt+JrTldqmb5L/K89PZTqq6azZLN0rGYd7MDMEnKq0V1UX
         ZyEF24QRwL6DeNZQWOMnAVuzolHPQxd5neDzGWgwzFxNeL15B2S7gkzrMtVcc/KLno4y
         9qJ/vZIyEgW9lcRWtsi+GcSWVl1Y/ptnJ1E3iixxW0QmVJac+RBU7FZotMTmAaVxwSDY
         3Bfg==
X-Gm-Message-State: APt69E3L4F44Cu/ERJnvcS+HZg32ZDe/PFce/IUVrEaeZSGa2RcqNPn5
        T7y8+qCWzWgcFOXXD+WSOjmiTQ==
X-Google-Smtp-Source: AAOMgpeLy+N73jQnoX2B9OVk/5m/BlSuk0DD8UZW2GqrO+VES5TCiGXD2reuKtiv5tiPYm543HoSmg==
X-Received: by 2002:a1c:46c2:: with SMTP id t185-v6mr608145wma.56.1529998304846;
        Tue, 26 Jun 2018 00:31:44 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:7ce3:d1ec:2b62:6452? ([2001:41d0:fe90:b800:7ce3:d1ec:2b62:6452])
        by smtp.googlemail.com with ESMTPSA id c129-v6sm1198421wma.37.2018.06.26.00.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 00:31:44 -0700 (PDT)
Subject: Re: Add system timer driver for Mediatek SoCs
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com
References: <1529910601-15005-1-git-send-email-stanley.chu@mediatek.com>
 <dd36b094-b11c-e6ef-a0fc-b039785e74f2@linaro.org>
 <1529917631.17448.22.camel@mtkswgap22>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <561c2c41-ea92-3ad8-a1d7-aeef46cdc601@linaro.org>
Date:   Tue, 26 Jun 2018 09:31:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529917631.17448.22.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2018 11:07, Stanley Chu wrote:
> On Mon, 2018-06-25 at 09:34 +0200, Daniel Lezcano wrote:
>> On 25/06/2018 09:09, Stanley Chu wrote:
>>> This patch adds a new driver for system timer on the Mediatek SoCs.
>>
>> Please elaborate why we need yet another timer.
>>
>> Is this timer present on all Mediatek platform ? Does it always co-exist
>> with the existing one ?
>>
>>
>>
>>
> Hi Daniel,
> 
> This new "system timer" only exists on recent Mediatek platforms,
> for example, MT6765. We will upstream driver first, and then update
> device tree on MT6765 later.
> 
> System timer is designed and optimized as a SoC timer for
> tick-broadcasting. Besides timer IP has simpler register manipulation
> and friendly low-power design.
> 
> There is no plan to remove existed "General Purpose Timer" now.

It is unclear what "General Purpose Timer" and "System Timer" differ
except they are different timers running on different platforms.

Merge them into a single timer-mediatek.c file.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

