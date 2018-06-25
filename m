Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B7AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DB9260EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6PFP+JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DB9260EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbeFYVzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:55:19 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35277 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeFYVzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:55:17 -0400
Received: by mail-oi0-f65.google.com with SMTP id e8-v6so14022511oii.2;
        Mon, 25 Jun 2018 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C1RT886UZYvBXOZnv8nIeXmnyqSk8mvKRXPNZS+7goE=;
        b=h6PFP+JPiq/TQdA+Ke45vHObtEAvMgf55T8DAj9CdUyWi0H0Ri+S95Qjw2XzEK5v4l
         N2wI9jxvZgGpgSquciDjjlHrMrzHfYL/1OutYocbAHMDBXbw5oXol/Mk5x0HfyO3cgbZ
         tC2XfCGmURVFWz0WXVdp7BvwQ/OhmxaxYVaHlYFWx2f9DAWWfr1OhQCwiLqIpL04ONN7
         sNB1SuMajAB05r7/3eBNEspdde45aXG+8/sjojnChXhcfAs63rY35oxNWzm+9pvtn2hO
         j49SHr8KChdwk4XIjdXpq8DtxpciGGCY6ET96XmsNjJqUaEbEM4ssUZ5Ve8oDqhUhhcN
         6JeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=C1RT886UZYvBXOZnv8nIeXmnyqSk8mvKRXPNZS+7goE=;
        b=USDceg+7EcyET4HgJmAjIGjnAWQ9prubdykvbjDsAqwLAp6j1Nmq42E51iDoTi8Ura
         kIJ+JGwR0DWNnVZeXw09dgM1xvxV41gTKMuxOlsK7wFJ3bo50aWvGP82TA0ZsywzRxqf
         3J/6E/lp/EkzQ2Ko7EsT0O3HFrpUHl+qiRPQV+WkWe3nuzpCo/lWRhNYEuB6egs5btMm
         IFlGOpLyF9YdTkjfME9vjxGnafFXYh8b0NCMWclQQ0dx9PAmnslfi5xG0zMD84VPI6kG
         qHCIdgbQ/7GM62POSUweplh4pxymw/vZ73khjWdEy0iLQO93X2NL/abKDF3zmnA47j/G
         BHNg==
X-Gm-Message-State: APt69E3iwNZwX2ypP9RekeSpWMh+L19uVn3NXF+4f8DqH3RDBt3fhL4B
        9SVE17fkc2D3vDkC8enF3AjqGdKIcRta/D27FCo=
X-Google-Smtp-Source: ADUXVKKs0+r+MAlguwiFYuII4PSoAfU6rLU16MtRBtMo/57cw+Qz6DR0z4wQCB4muA3S111oiIKx8ZXJ9AmLrV95WSc=
X-Received: by 2002:aca:e6c2:: with SMTP id d185-v6mr7383400oih.154.1529963716833;
 Mon, 25 Jun 2018 14:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 14:55:16
 -0700 (PDT)
In-Reply-To: <98f43bb6-9ab5-2f79-05f2-be68a0f7f88e@linaro.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com> <98f43bb6-9ab5-2f79-05f2-be68a0f7f88e@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jun 2018 23:55:16 +0200
X-Google-Sender-Auth: lT5liSfkiP96I0F2hPE26VERTd4
Message-ID: <CAJZ5v0gv_y9DfEsqq_46D5hi3SA+UYy7cUoaCwb3_+HtRadDOg@mail.gmail.com>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 1:52 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 25/06/2018 10:23, Rafael J. Wysocki wrote:
>
> [ ... ]
>
>>> + * It is up to the user of this framework to provide a lock at an
>>> + * upper level to prevent stupid things to happen, like starting while
>>> + * we are unregistering.
>>> + */
>>
>> The English above and elsewhere needs some polishing IMO, but I can
>> take care of that. :-)
>
> I can give a try and if you are still unhappy, you change them in a
> better way.

Well, I could tell you what I would write, but then it'll take less
time and effort if I just write it myself. :-)

> [ ... ]
>
>>> +static void idle_injection_setup(unsigned int cpu)
>>> +{
>>> +       struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
>>> +
>>> +       set_freezable();
>>
>> Why do you need set_freezable() here?
>
> We don't want to continue injecting idle cycles when the system is
> suspended.

And where's the corresponding try_to_freeze() called?
