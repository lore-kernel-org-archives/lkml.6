Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD00ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1C6208C1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oz1t4YMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1C6208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeGOMoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 08:44:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34876 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeGOMoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 08:44:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so19978364wrt.2;
        Sun, 15 Jul 2018 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wSYIjkD6rouIpuYPNOoNEn9tdul70uccjrT5vxEiJRc=;
        b=oz1t4YMad8bjXZmV1mFh8sW7ub1hSlQPf6i28jt9qiLeFI/NWNgj0CedwG0kuqWBEN
         fFtzDGLx2Es/TTrzBHv3En5FwtgmLAi3PeBlu/M7SQieF5CDHrVcF3rrxvcBqMEjo2pu
         9H1ZwkZh8QXxIfP+dDizH8MQeRHm2gHMax/D0WKq2T3x9D8f68HAm1+riXtNdLJ9Rz1g
         qW1C8uOe25uVVL2Prw6UQLTOuHvx/hPI1jsjhJoqfKmECRQPGlojhIHM+wl+Eh06GY2n
         ztTdaG+JA+UCERU0hTSrU/iObltEiM1SoWUpnvGH5Zjq+UsurUMmUNR03RxhXeJtWi1i
         QpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wSYIjkD6rouIpuYPNOoNEn9tdul70uccjrT5vxEiJRc=;
        b=I0J/pSBeSRNHj+b74VJufoAa1eGxpPe2oIIRqucxmvvBGvdhs3kqhDsFL9n6tvi3nj
         Rq6ukzCXYCfK1llDbBeGt/y7Oyw4P83n1x+p4NeLbdN4Fd9/lH613C/bsNDvPJ9Ngy6c
         tlfAPx+ZbInnR+ZYVcvDu85KvR0Bh6GkBQbNUpkiwBOczGKVPY9H3SXUchd9+ioP7Rmz
         iXyXyQrf35YahamAza1nudY+V8XO+T4HmF9RqG9zdw4YVF/E/fRr0GIJ3cMuiPPIeADl
         v7q0H0c6KDIJRtrt8GufwSQ6piptq4u3GLT24ZcTM5mJt+lxImlRVun9MDiYIniC9CMj
         PddQ==
X-Gm-Message-State: AOUpUlEYdDazfCWkjAfwzXx8G2jwZNA3bsRLv3lrTQhMioGG00I4UvK0
        6eN9sOep0D02F/uGajogxUPSbHPM
X-Google-Smtp-Source: AAOMgpfy7+a9jNilTc8goosPtAgEq62wJp4otGxUIfgXqJ6OLelpH0+2jo4DMNkdB2o91UNv5az6JQ==
X-Received: by 2002:a5d:41c1:: with SMTP id e1-v6mr9558701wrq.25.1531657327115;
        Sun, 15 Jul 2018 05:22:07 -0700 (PDT)
Received: from [192.168.1.18] (cke246.neoplus.adsl.tpnet.pl. [83.31.80.246])
        by smtp.gmail.com with ESMTPSA id t6-v6sm11355386wrn.97.2018.07.15.05.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 05:22:06 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
 <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
 <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd> <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd> <20180714223907.GB2776@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
Date:   Sun, 15 Jul 2018 14:22:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180714223907.GB2776@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/15/2018 12:39 AM, Pavel Machek wrote:
> On Sun 2018-07-15 00:29:25, Pavel Machek wrote:
>> On Sun 2018-07-15 00:02:57, Jacek Anaszewski wrote:
>>> Hi Pavel,
>>>
>>> On 07/14/2018 11:20 PM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>> It also drew my attention to the issue of desired pattern sysfs
>>>>>> interface semantics on uninitialized pattern. In your implementation
>>>>>> user seems to be unable to determine if the pattern is activated
>>>>>> or not. We should define the semantics for this use case and
>>>>>> describe it in the documentation. Possibly pattern could
>>>>>> return alone new line character then.
>>>>
>>>> Let me take a step back: we have triggers.. like LED blinking.
>>>>
>>>> How is that going to interact with patterns? We probably want the
>>>> patterns to be ignored in that case...?
>>>>
>>>> Which suggest to me that we should treat patterns as a trigger. I
>>>> believe we do something similar with blinking already.
>>>>
>>>> Then it is easy to determine if pattern is active, and pattern
>>>> vs. trigger issue is solved automatically.
>>>
>>> I'm all for it. I proposed this approach during the previous
>>> discussions related to possible pattern interface implementations,
>>> but you seemed not to be so enthusiastic in [0].
>>>
>>> [0] https://lkml.org/lkml/2017/4/7/350
>>
>> Hmm. Reading my own email now, I can't decipher it.
>>
>> I believe I meant "changing patterns from kernel in response to events
>> is probably overkill"... or something like that.
> 
> Anyway -- to clean up the confusion -- I'd like to see
> 
> echo pattern > trigger
> echo "1 2 3 4 5 6 7 8" > somewhere

s/somewhere/pattern/

pattern trigger should create "pattern" file similarly how ledtrig-timer
creates delay_{on|off} files.

-- 
Best regards,
Jacek Anaszewski
