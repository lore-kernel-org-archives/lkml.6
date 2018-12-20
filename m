Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D95C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFD3218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDH2s/TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbeLTSGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:06:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46446 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388560AbeLTSGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:06:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so2694601wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rOmuocn43JbtxF3XCjVijJD6+dvHI36G0VecIvd2WLo=;
        b=fDH2s/TQTgFcY+zbGO/WgAKUGEdGaRjNBwFwBanEa2SCgi6HUQacEgOv5RJkTAzx5F
         u93JziiqKbp50xl9bConDlBZCUglPr71IqlsKeV9prfMpTUG7g6/b9c/7nDwmHjLTTYM
         y/BqHu7Ox9HJoLaBNFR3nii23MmrsdokQSk7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rOmuocn43JbtxF3XCjVijJD6+dvHI36G0VecIvd2WLo=;
        b=j6TrPQsQ850TORzvsm/VhiJQm+/F/WKhuPBpX9sVKKbNbNuScJy7BkVLfFIai179gQ
         y+/79fi546TxPwChj/fArViMH2Cwo6Le2BSWzCojBNoZpKv4q9No5trmWSYmEXLnJoz1
         vuFwPBsalou+KEtR7zAbn+SkHTLw9Cm8pUIceEFxiyPthkquwZ1eNzcEWCnB8Qbajqfn
         /U7mhGU7gB9Y8fG97i8OfdRY/v+HYIQ4u8cCS+nmP4Y6KAYh65i0kj7RWSIWfZP2/fvB
         Qh6u4u11rbnb801xTXpSIec8OhPT0greYZYkbgVG1H/sqVtSAOFEJWsIWKIktflPBk/i
         vfBQ==
X-Gm-Message-State: AA+aEWbs3bflC0FCVuDZt5CAnfrpSYVSrRkH+Zc1fHrub2y7rnIBaj/1
        64GerZtxExxZ9frFjLY6v4YURatQC9s=
X-Google-Smtp-Source: AFSGD/WjmWkkjc+OFpkV+G4Oir6OxO8qV/smNJb3b76SKsfvNfkM8YKSQHdvnpYu7B5wNz+G4XZbxQ==
X-Received: by 2002:adf:f703:: with SMTP id r3mr23092752wrp.93.1545329198335;
        Thu, 20 Dec 2018 10:06:38 -0800 (PST)
Received: from [192.168.0.40] (55.183.88.92.rev.sfr.net. [92.88.183.55])
        by smtp.googlemail.com with ESMTPSA id h2sm15476841wrv.87.2018.12.20.10.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:06:37 -0800 (PST)
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM
 domains
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org>
 <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
 <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c5587b35-734c-5c1d-a433-ce78c8583ef1@linaro.org>
Date:   Thu, 20 Dec 2018 19:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 16:49, Ulf Hansson wrote:

[ ... ]

>>> +#ifdef CONFIG_CPU_IDLE
>>
>> It would be nicer if you can remove the CONFIG_CPU_IDLE by replacing it
>> with a specific one (eg. CONFIG_PSCI_IDLE) and make it depend on
>> CONFIG_CPU_IDLE, so the config options stay contained in their
>> respective subsystems directory.
> 
> I am all for simplifying the Kconfig options in here, as indeed it's
> rather messy. However, I would rather avoid folding in additional
> cleanup changes to this series, is already extensive enough.
> 
> Would you be okay if we deal with that on top?

IMO, there are patches in this series which can be grouped into a
cleanup + set the scene patchset and merged immediately. An option
similar to ARM_SCMI_POWER_DOMAIN can be part of it.

However, if you swear you will do the change after and sign with your
blood, I'm fine with that 0:)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

