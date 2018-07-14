Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0164BECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B42220854
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrpUYVvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B42220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbeGNWXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 18:23:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40087 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeGNWXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 18:23:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id t6-v6so28281017wrn.7;
        Sat, 14 Jul 2018 15:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K7ig861cIsEqOm33FlzLYu3y3dREU2igERhoL9/mHZY=;
        b=QrpUYVvyRkFBtFhaYAJw9v2HqGNSv8zh2IKp5gH0B74JdAKmsZiAAZ9WU6jT1z4Vlo
         cZeCFSSbe3u1qXvfuRXyJlWVWwc/3b/DdNxILdGFE3/Cpgdkoc2xFYnR5aXo9EfWHB/M
         T9EJj4mOtwrBdbsh0mGdquACQJz4vzz4GO7rTofyKHFom1WrZwWur++pclZE3HYAXJaJ
         7RKgqYIOhFlLw1LQek8ktFUWjd2qV6Qb7idMyG2UFiHj602B2KGet/7qqg+arzDYVRVI
         kzv0p5LJol8SvaQnXnWveU16QFSQAbw/+uSE9scy9OrwtTbn2ZAWYRNdWIZeLGB1s/0d
         g5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7ig861cIsEqOm33FlzLYu3y3dREU2igERhoL9/mHZY=;
        b=p2CQwDgm+7+450Tg5uPeTi5G/1GfKUyTIJGFNtOhFhWddZu4H2/FOmVuHDLZu8OT0f
         7hqIvnJCP4g5v+XGRrNzZsINMwvKWDqZZZ+iGxTGrrYg1kY97Dqj83VNxs5vPpAMAshy
         /zBrrFVFZvWpC6PcE4c0UQ9wOWE2XC321yyqzikjlvT8nALG4rvO6gqXfs71Oz6Zw9gl
         daTfVbJ9yFXg1W/BqZopw/komVMo5AcOT1+kKSyNrT5b3u4fGYG7+ktq7tV3VkApWpTp
         kniPbid1SkdPjlFuTOil53atafiFxFfj6YTQ/+mPIHJ12e1T2D9gNf+g3OG1NLhoS/r7
         j7iA==
X-Gm-Message-State: AOUpUlF0Jpradg1jz1m3MpCa9Cbe3qKGwVMnTET4zPK0eaHTl28ZCVLL
        z9jIWN/xI2ddnuc0wzXK2H/XqgTD
X-Google-Smtp-Source: AAOMgpcTZ63MosfJAUkp/uAfHwqaFxUI3Vx7K/X8EvovL/v5qKcrN4wGBUxXL4SAMgwmI+q8SLh0HA==
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr8864537wrr.227.1531605780334;
        Sat, 14 Jul 2018 15:03:00 -0700 (PDT)
Received: from [192.168.1.18] (cji197.neoplus.adsl.tpnet.pl. [83.31.58.197])
        by smtp.gmail.com with ESMTPSA id f190-v6sm23065767wmd.0.2018.07.14.15.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 15:02:59 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Pavel Machek <pavel@ucw.cz>, Baolin Wang <baolin.wang@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
 <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
 <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
Date:   Sun, 15 Jul 2018 00:02:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180714212033.GA31950@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 07/14/2018 11:20 PM, Pavel Machek wrote:
> Hi!
> 
>>> It also drew my attention to the issue of desired pattern sysfs
>>> interface semantics on uninitialized pattern. In your implementation
>>> user seems to be unable to determine if the pattern is activated
>>> or not. We should define the semantics for this use case and
>>> describe it in the documentation. Possibly pattern could
>>> return alone new line character then.
> 
> Let me take a step back: we have triggers.. like LED blinking.
> 
> How is that going to interact with patterns? We probably want the
> patterns to be ignored in that case...?
> 
> Which suggest to me that we should treat patterns as a trigger. I
> believe we do something similar with blinking already.
> 
> Then it is easy to determine if pattern is active, and pattern
> vs. trigger issue is solved automatically.

I'm all for it. I proposed this approach during the previous
discussions related to possible pattern interface implementations,
but you seemed not to be so enthusiastic in [0].

[0] https://lkml.org/lkml/2017/4/7/350

-- 
Best regards,
Jacek Anaszewski
