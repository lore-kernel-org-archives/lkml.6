Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58818C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 00:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB5C20870
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 00:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jck2l/Up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfBCAg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 19:36:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40834 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfBCAg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 19:36:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so7749202lfe.7;
        Sat, 02 Feb 2019 16:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0u0X+GYIZOXZ1SluuXNLGs3oL3brnqBksi+JHca++8g=;
        b=Jck2l/UpZhr2EQEYsK7kuf3qWE9Wln0a/UNHXEdt0gJMTEe6AYm/1a7yzAYAwfiXht
         4wV7YpMpCFYeW+eSLrweFzNjdmdZc2UXeS9HvhfhsAxX9tXkipP3i0cwgyRGh0VyfTbV
         +XIjzx+BPgvTF40ZP7isnn6Fz+Oj+rWSCEGtXJ8XoPbDXtGpxabx/Z4UfKBfwWNm3ONL
         OkhYSHAFIxHhj3YRxDf3dO/lYCyW7oYW+5jLKYrejakDsnjiTS31L5AnyFMh9KE4OCbR
         15HvkqydMxAaepQxgXzTvF7JH/NtFGqsGKLn/mqgAmyj3HXhXpoSVhNhCqcP1s5pkEAM
         j+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0u0X+GYIZOXZ1SluuXNLGs3oL3brnqBksi+JHca++8g=;
        b=A5j17dgXqjGaxvzTWUC0MMAhfDsd9bFzKd2OCvUjXWVoyccdW7sxLcTmMU6Ht4AhVj
         Iqe5DMqWEsFMM+bTi974Kl1V+unY2nvYuDrpjhI5P24xAY/DqCYf4Ex70v8zMKpz/5SH
         tYNe+nm3nuKt7zIR9rWfUPjeEEsDGv/SfMQI7AkLIrLWD6E+f/UMIp6Y3OeT6yaqfIUE
         2ieQMzE4X82351xfEQOYKDCCLcvKWZI4BFrUdMFm23KeIE4S5ZqmIon2VXPU9e2OKdQE
         To6W4VHqy35uasWr2ZHWgJv7nssymg901eWqw7TPzCKMUKlBRS/XZKFC7zIliWCXkhsK
         7JiQ==
X-Gm-Message-State: AJcUukckIA87a+toCfcchSvEvkL4mcCc6zjCaNJJNwCrD3S17KWGojFE
        ZHDuPsuBNrouw+JrrRdGTOLuecjzseyMaiM5
X-Google-Smtp-Source: ALg8bN4RPpfY4xXSpGZhUFz8aiFinKkE9zf9m2WxOSTTSAffh0zXZxEB1TJLGu1pykVXToEQnVUfPw==
X-Received: by 2002:a19:200b:: with SMTP id g11mr34252025lfg.58.1549154215778;
        Sat, 02 Feb 2019 16:36:55 -0800 (PST)
Received: from [192.168.1.36] ([31.134.130.226])
        by smtp.gmail.com with ESMTPSA id y131sm2159145lfc.43.2019.02.02.16.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 16:36:55 -0800 (PST)
Subject: Re: [PATCH v2 1/2] rtc: add AB-RTCMC-32.768kHz-EOZ9 RTC support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20190117184608.20987-1-panfilov.artyom@gmail.com>
 <20190130214828.GK19959@piout.net>
From:   Artem Panfilov <panfilov.artyom@gmail.com>
Message-ID: <58b5d6e0-a1a5-59c5-3994-87852d62891e@gmail.com>
Date:   Sun, 3 Feb 2019 03:36:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130214828.GK19959@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 31.01.2019 0:48, Alexandre Belloni wrote:

>> +#endif /* CONFIG_RTC_DRV_ABEOZ9_HWMON */
> This comment is not correct

Thank you for your remarks. Can I add HMON support as Kconfig build option?

Regards,
Artem
