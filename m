Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FA9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D092124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HLxm2sRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D092124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbeGLUAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:00:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37835 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732215AbeGLUAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:00:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so22856822wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 12:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4JdeX8j5cZm3m9tKASthZAM3yN1Cub13mYFE0Dth974=;
        b=HLxm2sRH8zEK8mX/Wny4b3RWWiOVxI6nV58LIjeH0sLkJhxZ+GN7xw8hSeRdc3wLlg
         ffSZ8kWQa2XHG8TF6mn1EVJfVSk+zEUSRdInoCusZr726Rbf6KCyJxjveOdHzhgg6cUa
         YiiSiMl9VrBCpGjtQ6ulOXSQVxZfYIvamoHO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4JdeX8j5cZm3m9tKASthZAM3yN1Cub13mYFE0Dth974=;
        b=UlAc/mJRLSrLZCNC10aETVFoQ5qRvF4CnCEUlCBc+kJre200G52CXrusVutXlipyhv
         RaEHSp7BfLbvZxAzxPQ2p8yuqdT3nhPsk43+ieDZ3Xu0GdjLx9pVl6i6l+sIAYs9BxRl
         3V9955Wd2kqvRlsIjrVyMI/ch9BQmR2TyM/wwlx7Wy/WdLvWxsf2Ca7U+8FrdtWtZYhC
         07GJ0fXJxizuQe+XdyRj7jzvw+lOLCrmGjQzDpowJpmLeVRydjZ5IV7WZVswLoQhq8j+
         /701MeSqJiqo07E6Iom+2bP2vHJDScpD9f5ui/Vy/EILVy1pIWUrgktcGOk6rDINX3NO
         Ji9g==
X-Gm-Message-State: AOUpUlHZm2ZafN4CZBtt3FFPIpYci66nnHZyzYciaj56epUaRq1vh64m
        k/1uf1J0P32hDgcXY3wXY/tswQ==
X-Google-Smtp-Source: AAOMgpd9w2DbvfPE6SVhxALUc+goU3PKTXTOypxbdWcxtZgK7Zy4aStSx0ogRf0erS3Uey6MkfNoCw==
X-Received: by 2002:a5d:60c5:: with SMTP id x5-v6mr2998178wrt.232.1531424952205;
        Thu, 12 Jul 2018 12:49:12 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.255.197])
        by smtp.googlemail.com with ESMTPSA id f190-v6sm10372292wmd.0.2018.07.12.12.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:49:11 -0700 (PDT)
Subject: Re: [PATCH v9 1/5] clocksource/drivers/timer-mediatek: Add system
 timer bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com
References: <1530832288-8156-1-git-send-email-stanley.chu@mediatek.com>
 <1530832288-8156-2-git-send-email-stanley.chu@mediatek.com>
 <a4c1a9cf-4d48-a9a7-e7ac-d94685c30619@linaro.org>
 <CAL_JsqLz0txawAP3BuQ2H4NyzFsKGkTVZ_kp8toDNRC0eJEC7g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1a4b9e36-61b7-0933-4cde-b80218199d14@linaro.org>
Date:   Thu, 12 Jul 2018 21:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLz0txawAP3BuQ2H4NyzFsKGkTVZ_kp8toDNRC0eJEC7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2018 21:16, Rob Herring wrote:
> On Tue, Jul 10, 2018 at 9:02 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Rob ? Are you fine with this change ?
> 
> Yes, I added my R-by on Fri.

Ah, ok. I missed it.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

