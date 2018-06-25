Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB1FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C0726129
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWdbohPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C0726129
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeFYWPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:15:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44787 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbeFYWPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:15:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id p12-v6so13540000wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UvrXs+qy2Fcrq2CTMnh6Wrp6q/WoLGsOa/5BXS7bfio=;
        b=IWdbohPyql8LRd+qLmyU30LbItFAN4DrSnpcHajZCFGN2sCr88lBn69Xw+NRzvZcfJ
         56hgks8z3EQyy9kiWbhVKpnOp4miph5BVNnldNksOMcXdtLdawqWtKW++jOk3lBLr/2m
         raQ7G4ZTsW6RrvIuvXeTWwfcDzW9rlRBc6N/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UvrXs+qy2Fcrq2CTMnh6Wrp6q/WoLGsOa/5BXS7bfio=;
        b=R6pC8cY/Y2HlWuL+SjlQFmKMoqzYgqYteThgf8mOprDT+kGR6OmDiUAdIOWjralFGW
         kP9417rL8+TWOWKPzVRrmEa6YtlrCaIQeN6XLepvhlQA0icbR+1y/FDvzyBUC5Zdgjfb
         WO58Xgvbt82H1eHrO/fmqkXD1jY/T/B2vuCfcxefVbu0UfYu9gqgsfhr2/ex7KXaOpbv
         CJnGf9zzILeYheWlM/UUs8YTpEkRBU3CxQmv/MLGf+1G+zuxoJpmBTOyM1BOi38X1oZx
         dRGYHy9/Ex8szzZ5eQ3qILLWvHQZz1cikE6zAvIG9T1QEUTGdye0L8DQcxFWDjN3MwL7
         Ueag==
X-Gm-Message-State: APt69E1sJrtc7czW7ZthZocacmBKXj+yNOdpvtIBOmFM0+31d2jUrQxd
        /apCtqZogzkog3sDMplYcNIByA==
X-Google-Smtp-Source: AAOMgpctfneSrUpnUUgmf1Ui98MhqmSK6ILUwKH/6zY6Qjx4zJEjd5WXX3jL6YwUx7uM3teNO2rURg==
X-Received: by 2002:adf:e987:: with SMTP id h7-v6mr11256393wrm.102.1529964899694;
        Mon, 25 Jun 2018 15:14:59 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:7ce3:d1ec:2b62:6452? ([2001:41d0:fe90:b800:7ce3:d1ec:2b62:6452])
        by smtp.googlemail.com with ESMTPSA id d14-v6sm50407wro.24.2018.06.25.15.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 15:14:58 -0700 (PDT)
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com>
 <98f43bb6-9ab5-2f79-05f2-be68a0f7f88e@linaro.org>
 <CAJZ5v0gv_y9DfEsqq_46D5hi3SA+UYy7cUoaCwb3_+HtRadDOg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dd30daab-caf6-91d6-2f72-998f640f85ae@linaro.org>
Date:   Tue, 26 Jun 2018 00:15:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gv_y9DfEsqq_46D5hi3SA+UYy7cUoaCwb3_+HtRadDOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2018 23:55, Rafael J. Wysocki wrote:
> On Mon, Jun 25, 2018 at 1:52 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 25/06/2018 10:23, Rafael J. Wysocki wrote:
>>
>> [ ... ]
>>
>>>> + * It is up to the user of this framework to provide a lock at an
>>>> + * upper level to prevent stupid things to happen, like starting while
>>>> + * we are unregistering.
>>>> + */
>>>
>>> The English above and elsewhere needs some polishing IMO, but I can
>>> take care of that. :-)
>>
>> I can give a try and if you are still unhappy, you change them in a
>> better way.
> 
> Well, I could tell you what I would write, but then it'll take less
> time and effort if I just write it myself. :-)

Ok.

>> [ ... ]
>>
>>>> +static void idle_injection_setup(unsigned int cpu)
>>>> +{
>>>> +       struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
>>>> +
>>>> +       set_freezable();
>>>
>>> Why do you need set_freezable() here?
>>
>> We don't want to continue injecting idle cycles when the system is
>> suspended.
> 
> And where's the corresponding try_to_freeze() called?

Yes, it is missing. I suppose try_to_freeze() should be put at the
beginning of the idle_inject_fn() function, right ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

