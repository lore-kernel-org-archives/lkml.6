Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C06AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F2321927
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUjdRgAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439286AbfBNOoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:44:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55405 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733163AbfBNOoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:44:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id r17so6508089wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OElgaH9/rySIbebd8tZ+DsfKLXEMJFPUAht1tqtT8kc=;
        b=YUjdRgADxK0ZPbTAvp/LTfJPXhOz+Jk+KHaRlC64g+nV1uwnoMFmqiDuFB4sis17zb
         UfuOsuvLdlVMG1HpLucv906FNBl5p7mevu6kksDwOyPNq4tZOq9Xumrt5ewfgRy0FRgK
         FeuCG2YlyR+93O7h6lb2231kdpK0zFCN/PN0PvGsTqNLKwWwL0D7lSFr2pCkXPYpU0By
         /TFTcnWSHC0lseH1hs9C5f6PFJ3Cr3NqPpmK006x3QOfOlIy+f34RgoWQAf44OUn0T/W
         +B3Ra4t+hFV+x0Vc31L1gGdG9i18H9lyoQFu9l+LM0q+Lh4biTAn1KqLGf+9RN9o9ZWW
         GaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OElgaH9/rySIbebd8tZ+DsfKLXEMJFPUAht1tqtT8kc=;
        b=BLq0/hRBEfa7fWXVk7ezKckB3fu4TnAPtcZfeZC3Wb1g8/GsPejdiaWnDqunGWpNnG
         WfqWcFruE/s2FSwwAGDyf2NU4SouC72EgPIMvcbhUfkDiN6ZHyFQlYStGhlNxtedUyk8
         F2Rsq14UAGGuovOQUr7pGvTU74WKv+w0vhLcrXNjdOdBdq0ZDFGHJM5QCIcOyx1gtXFW
         O6AzahsJO0hV//t7uZy3iGwk+OAjNOlh0hnugMC+YMRVwkpxlb6ltlXi9pNBVMyz0LRX
         Bc9LrbTQ+PDpgtKw9G+VClr46jBzhgz04qCnXZPY9FFLDvFjpYjj1FaAFD1tYvwKmBGK
         GgmQ==
X-Gm-Message-State: AHQUAuZOVTsGxJl1E8tSI+9OWqaJWRo8B2jvB6GL5jFb1uL8igt5kBT+
        wjduBe8NDEmSK8AuCME3Uq1fzw==
X-Google-Smtp-Source: AHgI3Ialsr+3wy2S2VJYKZwI6YIPfJNVQpNR5htc5iXDao/0SZKdxuce12XstXxKpSaNYhUEOmv6SA==
X-Received: by 2002:a1c:47:: with SMTP id 68mr2858553wma.89.1550155456046;
        Thu, 14 Feb 2019 06:44:16 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id e7sm3913430wrw.35.2019.02.14.06.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:44:15 -0800 (PST)
Subject: Re: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
To:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd.bergmann@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-soc@vger.kernel.org
References: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
 <80f521e5-6207-a32f-2f79-c2cb81dd1908@linaro.org>
 <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org>
Date:   Thu, 14 Feb 2019 15:44:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2019 11:34, Sugaya, Taichi wrote:
> Hi,
> 
> On 2019/02/12 18:06, Daniel Lezcano wrote:
>> On 08/02/2019 13:26, Sugaya Taichi wrote:
>>> Add timer driver for Milbeaut SoCs series.
>>>
>>> The timer has two 32-bit width down counters, one of which is configured
>>> as a clockevent device and the other is configured as a clock source.
>>>
>>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>>
>> Do want me to take it through my tree?
>>
> 
> Yes, please.
> 
> By the way, the patch series includes other sub-system drivers, so
> should it be splitted into each driver patch ?

Well usually changes are per sub-systems but in case of first submission
you may ask linux-soc@ team to take all the patches together with the
acked-by tags from those subsystems maintainer.

Added in Cc: Arnd@ and linux-soc@

I'll wait a bit before applying the patch you clarify this.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

