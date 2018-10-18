Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B78C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8E62152C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNt56oXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8E62152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeJRRya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:54:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40717 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJRRya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:54:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so32943939wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BZqEtCLOZ0aj9jANWBSWAYu1maNiiLKV6hSXgez5Myg=;
        b=cNt56oXfEulBAopNWklqBrGhqyCZPg0ji3gCZXAIFMWJGe5EeZQUQbUiQHZWRzC/am
         FpOnp6uIgueXVx3url01fK7Zecynv2K1dgmGTTxgCSIzmFteyAys+meCrLL6K+7zHpBN
         k37cFB08JBLUXglzoLqitbIb7WclveC02DN90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BZqEtCLOZ0aj9jANWBSWAYu1maNiiLKV6hSXgez5Myg=;
        b=Onfo7XozREg1O3TN60YZdXZ2NFNm2aB1b/SmYVGC5eGrUzGlvXVWHWuy0C8jOkS94o
         qLXp+K3Lv2bkbXGnhs7vZKhYEazKnJgb71v6YZwCK0XRY62N+bFh/U8xoUI1ZJwV32wn
         e5HNpp32J+FOCNgc9KryJnQ/VORAPZPCZAR2j/FXtUqBb81kEHvTR5FzEC49KxSHXKns
         el5rj+xuoEbPEKXKdCDcCldXBmB8MOmYpKjHNk3eRTtOo7gG2hw3ANkk5O0r/Z8N1RIx
         pUGFv13UE+zQ59aKC6JRQkH0ya7qkeau58Bh0ufmZAfmAZwglYjuKNA7NmO7mKEq2QOY
         cRjw==
X-Gm-Message-State: ABuFfojhJGcCF+iexYR4b91CgUrKHUHWl/XIU/VxAPhpruzF2+DBaopR
        +cP37oLCBxMNenH1QtpjZ2efKQ==
X-Google-Smtp-Source: ACcGV61E+WUOFsksWeQ7uRIVKwiRCBcF6fzx6Gei8VoZWB6e1jN0yu6qSejEax4eKkmkJcrpysuRgg==
X-Received: by 2002:adf:cc8a:: with SMTP id p10-v6mr6712253wrj.208.1539856454927;
        Thu, 18 Oct 2018 02:54:14 -0700 (PDT)
Received: from [192.168.0.40] (77.65.136.77.rev.sfr.net. [77.136.65.77])
        by smtp.googlemail.com with ESMTPSA id 18-v6sm4993292wmw.26.2018.10.18.02.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 02:54:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/cpufreq: Reorganize the cpufreq files
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
 <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0ikpPk12PshjB7EwtGSz6kF5WJyKgDHB8cnXaEusy38UQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8585bac0-c72c-edf4-2e93-c8740a3b1b6c@linaro.org>
Date:   Thu, 18 Oct 2018 11:54:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ikpPk12PshjB7EwtGSz6kF5WJyKgDHB8cnXaEusy38UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2018 11:42, Rafael J. Wysocki wrote:
> On Thu, Oct 18, 2018 at 11:36 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> It was suggested to set the scene for the PM components in the
>> scheduler code organization in the recent discussion about making the
>> scheduler aware of the capacity capping from the thermal framework.
>>
>> Move the cpufreq files into its own directory as suggested at:
>>
>> https://lkml.org/lkml/2018/10/18/353
>> https://lkml.org/lkml/2018/10/18/408
> 
> Fair enough, but do we need to do that right now?

I'm not planning to do more code reorg than this patch right now. Up to
you to decide if you are willing to take them.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

