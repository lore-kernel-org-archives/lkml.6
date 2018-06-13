Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6F49DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2AC208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axEBplTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2AC208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936002AbeFMV1c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:27:32 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42203 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935775AbeFMV1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:27:30 -0400
Received: by mail-ot0-f195.google.com with SMTP id 92-v6so4664844otw.9;
        Wed, 13 Jun 2018 14:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YFsCbT4tHoYDAOZbR7u0N/nOiyimTeCv2KNmdeXdk5k=;
        b=axEBplTtPG366hzBbuEsQx2nfqf3fIMJcDm84KFMx0KGPJxaj4iwOhBbsT9zjXO8Rj
         ynkGAmH8+WPTyXhAGlElERf0g8usfuCL9zwUKhmTuZH80whB4iNO3rJ+wXSVLw0hEcZk
         zjrD55B1hCqbiq68jtMAWhSw9DmU/QyDEfDP2FmKZZQgdnYKooO5y+6A+HPVb2AK81vk
         yN7JpoQ09JmpbEKVNopz0NdCLxOA/2NbHA3fjTCeWLblP/Mz3VnNtnAWs4iXOqOkIafY
         1i7tWJT7w/rgd2sLauWel52NQu//jgYIhHeG3O7+TAKPQU7kmivTso7pDjSOEXmVwY4K
         AJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YFsCbT4tHoYDAOZbR7u0N/nOiyimTeCv2KNmdeXdk5k=;
        b=K+Ov35gvhl8hQPmekb/1fsTla9vhrcrTm9C6kkWWnIFNcrRJFxS7/ACAGjEyWv8ZNY
         js4iPTszOnwKfSIK4joiDHO0eX0AM1pk821c3+6+ze/qcFZDBaRTixHOCjYbA+xhpw02
         WCGXboAWmTraeQ2VBeFItCuHP25GBAgD8WNnGGuRVifsWh9u/jGTAiLYFkWONoKQOQGf
         kpMo3t1RCiNEn0FVjVz+VMqF2nRwX98kHSgOAZOkkE3GFWE2W3LaEPH+lxQ/wYwSYhTl
         qo9mJQMP6c6aLSkPl/1pkEZfAYYLLYBdUtryDO9mgYX1U13VWAFX/45z3oKuQeExvCjo
         g+Ag==
X-Gm-Message-State: APt69E2/yWy2vi7zreijElGFlngbv6jd1UM67qA/3G7YQV/0QA/H6sxx
        1AUmk6z9g2dYSN8pvOGaLwjWdjxDp1FeywCEfSU=
X-Google-Smtp-Source: ADUXVKLd9ePVRrj5bgP58YtKu6H+4kQdb735ow/3MnrvMwIF0dGAQ6G3bXJT4NiTRwWZmXLNri1Wz4U8MNQ9Tz30E44=
X-Received: by 2002:a9d:1012:: with SMTP id h18-v6mr3912901ote.364.1528925249616;
 Wed, 13 Jun 2018 14:27:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 14:27:28
 -0700 (PDT)
In-Reply-To: <55e8799f-9af2-f311-72fd-3f52439b5b97@linaro.org>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <1528905257.48473.4.camel@intel.com> <0b72e862-6bbe-e706-79f8-e1b690982920@linaro.org>
 <1528920447.48473.11.camel@intel.com> <ac38f5d9-80d1-09f2-6f8e-c58085f9a32a@linaro.org>
 <1528921968.48473.15.camel@intel.com> <55e8799f-9af2-f311-72fd-3f52439b5b97@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jun 2018 23:27:28 +0200
X-Google-Sender-Auth: oPWdiuOU-OdXGH4S_10Bok4-VP4
Message-ID: <CAJZ5v0jKsc6RjYWv9kYQmg3xEbXop0AH0J5Q=XmJG+K2rFJdcw@mail.gmail.com>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "kevin.wangtao@linaro.org" <kevin.wangtao@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "javi.merino@kernel.org" <javi.merino@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:35 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 13/06/2018 22:32, Pandruvada, Srinivas wrote:
>> On Wed, 2018-06-13 at 22:19 +0200, Daniel Lezcano wrote:
>>> On 13/06/2018 22:07, Pandruvada, Srinivas wrote:
>>>> On Wed, 2018-06-13 at 22:00 +0200, Daniel Lezcano wrote:
>>>>> On 13/06/2018 17:54, Pandruvada, Srinivas wrote:
>>>>>> On Tue, 2018-06-12 at 14:00 +0200, Daniel Lezcano wrote:
>>>>>>> Initially, the cpu_cooling device for ARM was changed by
>>>>>>> adding a
>>>>>>> new
>>>>>>> policy inserting idle cycles. The intel_powerclamp driver
>>>>>>> does a
>>>>>>> similar action.
>>>>>>>
>>>>>>> Instead of implementing idle injections privately in the
>>>>>>> cpu_cooling
>>>>>>> device, move the idle injection code in a dedicated framework
>>>>>>> and
>>>>>>> give
>>>>>>> the opportunity to other frameworks to make use of it.
>>>>>>>
>>>>>>> The framework relies on the smpboot kthreads which handles
>>>>>>> via
>>>>>>> its
>>>>>>> main loop the common code for hotplugging and [un]parking.
>>>>>>>
>>>>>>> This code was previously tested with the cpu cooling device
>>>>>>> and
>>>>>>> went
>>>>>>> through several iterations. It results now in split code and
>>>>>>> API
>>>>>>> exported in the header file. It was tested with the cpu
>>>>>>> cooling
>>>>>>> device
>>>>>>> with success.
>>>>>>>
>>>>>>
>>>>>> May be I have missed, but I don't see any use of powercap
>>>>>> sysfs.
>>>>>>
>>>>>> We created powercap sys that user space is presented a common
>>>>>> interface
>>>>>> for power capping. The RAPL driver was also submitted as
>>>>>> cooling
>>>>>> device
>>>>>> before, but suggestion was to create this powercap.
>>>>>>
>>>>>> So if powercap interface is not enough then may be we should
>>>>>> enhance
>>>>>> that.
>>>>>
>>>>> We are creating a framework for idle injection. This framework
>>>>> can
>>>>> then
>>>>> be used by the cpu_cooling device, the power_clamp and in
>>>>> addition a
>>>>> power capping for ARM (if it makes sense).
>>>>
>>>> But in this case, why in drivers/powercap folder as this is another
>>>> framework?
>>>
>>> I presented at OSPM 2nd the cpu idle cooling device. It is ARM
>>> specific
>>> but has some similarities with the power clamp driver.
>>>
>>> Some board come with power numbers defined in their DT and from there
>>> we
>>> are able to compute a targeted power by injecting idle cycles.
>>>
>>> As the idle injection allows to do also power capping, Rafael told me
>>> to
>>> move that to a framework (may be better say a component with exported
>>> services or library) and put it in drivers/powercap.
>> So Rafael wants it to be in powercap.
>
> That is what I understood.

While this is not exactly power capping, the purpose of this mechanism
is to prevent too much power from being drawn by the system, so IMO it
falls under the same broad category.
