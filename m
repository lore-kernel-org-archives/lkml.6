Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D179C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F95208B6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KYH0yFG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F95208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753522AbeGFH7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:59:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38111 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753362AbeGFH7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:59:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id j33-v6so3217428wrj.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 00:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OmRQ3B2Zy9YdyVSFRobJ0T+1HBzCHYt2NvIoaTPoI2I=;
        b=KYH0yFG8FFDChML1Rh9UkJUA5MAEdqc/pfn7Q3PRfJLrnh84J9/9oZ1VtU3yxNpGGc
         dE1fbPlV9ibRoekCK2GttBdQSonr1uEw2FIePsGOPm2/34h0qCxH1eWRk8xmeTSerf44
         8QzxTHM4pBkBmY4eQlnkqgjfzu/e9nyf30KgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OmRQ3B2Zy9YdyVSFRobJ0T+1HBzCHYt2NvIoaTPoI2I=;
        b=H7O4pEI2tU1zDGFOk3cCtJdZb/uqBL1Hj1fkjoeyRnwYafhHtTshK0oDFCrvauwShf
         IBSdJmybxQnVBTjNCuLhFkSC752iZy6PndTANP7weJXAsPO0b+npfHk5txkSYWRTDcPO
         hnRQa+EedsO85HNZAA3a/3FHJP+j71X9L8DwPnLMSN6Dr+73Dggg32zPZG5Ks+qlvex3
         oTmGXlHs22XrtM+Y0qPrF6qt1+pyVAtNr6jzyZds2f8KljKFOBUTgr8QaB8OI+w4Y3qJ
         epwCRa4RPJrv62sYt/vXIGq8TZ77ZuKZwScO213fPTzR5aap+I2a+UbZYiikmNpxsZUs
         pPzg==
X-Gm-Message-State: APt69E2eHsGxfr9rhKnB9JXviMNrIJy31McJYHrXQBOB/iM8qVCTdJR0
        f5lN4Ic2iWAhm95Lwj/kuK+ZVw==
X-Google-Smtp-Source: AAOMgpe2FhE+1e8H42q4DH2IIMntXG4y5iyMvMIHaWUpcylouVNpMkpldyEBBRt9bedbxkP4g7FbBg==
X-Received: by 2002:adf:a9f0:: with SMTP id b103-v6mr6489658wrd.271.1530863954002;
        Fri, 06 Jul 2018 00:59:14 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:b5fb:ea90:9c33:3629? ([2001:41d0:fe90:b800:b5fb:ea90:9c33:3629])
        by smtp.googlemail.com with ESMTPSA id l1-v6sm14587955wrf.19.2018.07.06.00.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 00:59:13 -0700 (PDT)
Subject: Re: [PATCH] arm64: hikey960: update idle-states
To:     Vincent Guittot <vincent.guittot@linaro.org>, xuwei5@hisilicon.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leo.yan@linaro.org
References: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <722aed2b-673b-7f17-2337-a7b3442dca56@linaro.org>
Date:   Fri, 6 Jul 2018 09:59:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 08:57, Vincent Guittot wrote:
> Update entry/exit latency and residency time of hikey960 to use more
> realistic figures based on unitary tests done on the platform.
> 
> The complete results (in us) :
>                   big cluster
>                   cluster  CPU
> max entry latency     800  400
> max exit latency     2900  550
> residency  903Mhz    5000 1500
> residency 2363Mhz       0 1500
> 
>                   little cluster
>                   cluster  CPU
> max entry latency     500  400
> max exit latency     1600  650
> residency  533Mhz    8000 4500
> residency 1844Mhz       0 1500
> 
> We can see that the residency time depends of the running OPP which is not
> handled for now. Then we also have to take into account the constraint of
> a residency time shorter than the tick to get full advantage of idle loop
> reordering(tick is stopped if idle duration is higher than tick period).
> Finally the selected residency value are :
>                  big cluster
>                   cluster  CPU
> residency            3700 1500
> 
>                   little cluster
>                   cluster  CPU
> residency            3500 1500
> 
> A simple test with a task waking up every 11,111ms shows improvement:
> - 5% a lowest OPP
> - 22% at highest OPP
> 
> The period has been chosen:
> - to be shorter than old cluster residency time and longer than new
> residency time od cluster off C-state
> - to prevent any sync with tick (4ms) when running tests that can add
> some variances between tests
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Great! Thanks for fixing the values.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

