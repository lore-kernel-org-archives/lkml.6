Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5250C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2172145D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pJOCvp76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2172145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeHQUnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:43:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38405 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbeHQUnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:43:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so3798284pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/LlIEftYtD7GxPnLyw24zjttcZQ0OW8ZCqBx9AhaZ6A=;
        b=pJOCvp76qebF1rM/LHB8LfrjrXvgFx+iGw2gQU26qNW1Vw4Yo0tvJQDvI9Syj7M5TG
         7pK7iXDOFBFNJn0v2vb+ALegIRgcgOlsoaA9scKcBAYP1cfLszVg7USruuow5Oq79olh
         pyduT482RgkC9t+kXJi/f8+U1qRwlroOJhYSgR/KmYXWVBMXCmh6eo1MghHpagRuGem1
         axq60APnJsnjecVqrrCJcobhe2UGVvD2PReCUM1g9Gz61jH79YiHKu8yZAmmu07VNKQ6
         ajwS7j/UKfUcCuv2Ml9MuOi0h9a0g2yxfVDbjxtjFU124+wqDy1PZ8SKD5vhH93z89QF
         Ft2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/LlIEftYtD7GxPnLyw24zjttcZQ0OW8ZCqBx9AhaZ6A=;
        b=CDOp2VvzglGIgBAklx8ZQSbquR91xmRUxZp/EsTsRj63KscfvBo6ndjNhmTs9sBn7q
         NQ2ndyn1ClOnbrLh+rUBU38z9pBiqrvTFK/eGd6i+NTbFEvNVqIQL5iQFmEk1AiuN6Jp
         JuugFyaY/BDV1ntvWQHE0v87v92jgaBOD4qiNQVY1zDULEpIUtobjALDbgU+kiWs4hXf
         ORAHk9QaCdHkBndWkdZ4Un+uoC9ZHqwCRvWmn13KPI1O3bjevRadzR5qCl/U/AIqvSCo
         Ol5BTctCd+kZlx+cE8seFOvZgzOR17hK5xAkR2lBF+MzQn2HgPeCazwKvGy0Kp2z2Orm
         tywQ==
X-Gm-Message-State: AOUpUlFROn0HGRXUq+kAm6Oy7/LV4A/bD/ozcV/t/4uYCdlybVInob9i
        cIXvX5g6aTZ5BK/BktacrSfrww==
X-Google-Smtp-Source: AA+uWPwqmNpfb4BNZIwwDA/GhMGgZ7WWnsjo9ZRvBUgvzsq1avO2g1yScQWq/swnGOB7EOW9wqFpWg==
X-Received: by 2002:a62:3952:: with SMTP id g79-v6mr37536337pfa.133.1534527541935;
        Fri, 17 Aug 2018 10:39:01 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1133::1308? ([2620:10d:c090:180::1:7c2f])
        by smtp.gmail.com with ESMTPSA id n24-v6sm4319169pfi.161.2018.08.17.10.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 10:39:00 -0700 (PDT)
Subject: Re: [PATCH] block, bfq: return nbytes and not zero from struct cftype
 .write() method
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arianna Avanzini <avanzini.arianna@gmail.com>
References: <f574e019-00f2-96c3-fc32-541c6584ca96@maciej.szmigiero.name>
 <19c68f93-017d-cda1-632f-039ca3ca0158@kernel.dk>
 <1f2ca124-bb7c-d02c-07cd-4afe6a634ee6@maciej.szmigiero.name>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb3a6209-9474-2b4d-1ff8-2e2f7c3367fb@kernel.dk>
Date:   Fri, 17 Aug 2018 11:38:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1f2ca124-bb7c-d02c-07cd-4afe6a634ee6@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/18 11:27 AM, Maciej S. Szmigiero wrote:
> On 16.08.2018 21:11, Jens Axboe wrote:
>> On 8/15/18 3:56 PM, Maciej S. Szmigiero wrote:
>>> The value that struct cftype .write() method returns is then directly
>>> returned to userspace as the value returned by write() syscall, so it
>>> should be the number of bytes actually written (or consumed) and not zero.
>>>
>>> Returning zero from write() syscall makes programs like /bin/echo or bash
>>> spin.
>>
>> Applied, thanks.
> 
> Thanks.
> 
>> Just a heads-up that gmail thinks your email is spam.
> 
> Thanks for the information - it looks like gmail just doesn't like my
> email server for some reason.

This one came through fine, jfyi.

-- 
Jens Axboe

