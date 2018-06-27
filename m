Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D5AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184DF2666C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gO2MK02E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184DF2666C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934254AbeF0J7z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:59:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44451 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934221AbeF0J7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:59:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id p12-v6so1379675wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=np70YmqXeAMOPa18W6j7V+hkMBK7+Qumnw7jCK9DUW8=;
        b=gO2MK02EgD4DDMRiNfELRiqvVkhX0Vvt6y7tWdpfmugKbCxuKP/5CXQDJgWbSyGhhG
         18UBQS31FzjDfDaDMkqiZJcroqRm0stECJvwWAx9n9COtVtSwN767FnSWCEGUZto3knK
         V3VQhTpzHCONQeusPGP324I9Yz3UcFlfIVSfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=np70YmqXeAMOPa18W6j7V+hkMBK7+Qumnw7jCK9DUW8=;
        b=ANeZWeicDZn8voQVUlbISnxARjMxL/tPAioBkIawV337Leisw/glPlvi29j7GmRdxN
         PABNgz2BNFm/p1z8Q1ec8u7oEftLuZ5Z2c64u81cnUrjxuR7NB8MPLUWHYUMK88LqV5L
         t1RIPvS7euLDOcttnNjTCTuravLXttteQvMEolHBLVUhNdM9MNJKUYsgQHZDWLa0vhFk
         P+q6kxqLTKYDk9FXrK4jjcS1w9ZtHNxaL/unZHIEK9WrTHPILOALMvD9O+mPJk1043hj
         /fwQh2pUP5iQBfgXkV6fTyyjVhed8GcZ1H22S59pFax9bdldvn5CAUz1NdL1lwVI1Qfb
         3+UQ==
X-Gm-Message-State: APt69E2iiuC2jGb2OxitwHLJd87ggY6GpV/q8hBlIRhgP/s4iuKH4B4t
        uLZfprPDl3Tkt9QRBRlgQWYfwsoKxDk=
X-Google-Smtp-Source: AAOMgpcuk9cxM1ZlSt/pJsdqnF7e4POzBBmIsFSKIZsJNx4tVJkfihLZNdh/L+gv/fwcmgKXEaV+dA==
X-Received: by 2002:adf:a54d:: with SMTP id j13-v6mr4805283wrb.155.1530093592469;
        Wed, 27 Jun 2018 02:59:52 -0700 (PDT)
Received: from [192.168.8.101] ([37.170.252.174])
        by smtp.googlemail.com with ESMTPSA id o203-v6sm1649138wmd.30.2018.06.27.02.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 02:59:51 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] clocksource/drivers/mtk_systimer: Add support for
 Mediatek SoCs
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com
References: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
 <1530086039-3763-3-git-send-email-stanley.chu@mediatek.com>
 <2a40ec95-7352-f0c4-b394-d7b689de98ec@linaro.org>
 <1530093016.17448.35.camel@mtkswgap22>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e8a7e390-789c-5c91-a9db-535adf0d7d4a@linaro.org>
Date:   Wed, 27 Jun 2018 11:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530093016.17448.35.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2018 11:50, Stanley Chu wrote:
> On Wed, 2018-06-27 at 11:39 +0200, Daniel Lezcano wrote:
>> On 27/06/2018 09:53, Stanley Chu wrote:
>>> This patch adds a new clock event for the timer
>>> found on the Mediatek SoCs.
>>>
>>> The Mediatek System Timer has several 32-bit timers.
>>> Only one timer is used by this driver as a clock event
>>> supporting oneshot events.
>>>
>>> The System Timer can be run with two clocks. A 13 MHz system
>>> clock and the RTC clock running at 32 KHz. This implementation
>>> uses the system clock with no clock source divider.
>>
>> Recent platforms have the arch_arm_timer and it will be always selected.
>>
>> What is the benefit of adding this timer ?
>>
>>
> Hi Daniel,
> 
> To save power as much as possible, our platform enables
> "arch_timer_c3stop" in arch_arm_timer, and thus another always-on timer
> is required for tick-broadcasting. System Timer is introduced for above
> purpose

Obviously :)



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

