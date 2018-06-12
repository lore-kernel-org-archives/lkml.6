Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 36203C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6B5208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1AUs9zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6B5208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933039AbeFLJKm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:10:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43853 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932497AbeFLJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:10:39 -0400
Received: by mail-io0-f194.google.com with SMTP id t6-v6so27167934iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 02:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8JO5NmeeG8gYKNC3jBCfh/uJphCDaKh6Wq+neCS8bkM=;
        b=E1AUs9zp4mO9s57WAqZsQtHjTsBKKlX/+mlPaYLkP++3NSZYIQoC7KZpJLGsBW8c5w
         7lMXsam5DKfGwYgKz+fqsrVX9ETX6g3fY2LdC4CPfMRxprhcOTMIQllxhd3wsOhIPSBV
         lvuwsepHErTJjJ2mxpyr8a4w+gTXhpH9bz6Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8JO5NmeeG8gYKNC3jBCfh/uJphCDaKh6Wq+neCS8bkM=;
        b=TQVaj7xoEe9UGHdWsoVLXD8i5leGF6RthyC0I0w1ZNdPxw7T64qLdSbsWbonQ4qk6J
         DmetIkHswarakuZeKo8a86omNcjaYuVECGgK1K/hIMQOD0dyZsSyiIVNp7DXNdZxl/io
         Qtn0qPg6Fk6js8oxxZYE1QCHGYBpoajaLqj+9NggZoQJnE0gK6r/A0zrUP73cZPFWnVj
         AqndcEe40lEcGxjTaTBnJK3MoyhcIvdR6Rl+JaLYk0OJRNgoKo4hPgTe1sDWSRD3K2Ef
         jq40dByqBIjIHIv+gIG37qXGbZUl0CihWge19peeV0skvsR/WMCdRNzcGdvEMVO3lb4n
         lfwg==
X-Gm-Message-State: APt69E3ZwWJhFJP07GNM4tqONQSFJ3fonh19v/i/rPgJec6/MB8uvIPj
        AY7c9eeqRiKNhC+0ijOd5Q3l5NI9PmKPVBY/a9+XSQ==
X-Google-Smtp-Source: ADUXVKKPQ+ph6zwXUqh/wxb5zyj1EvLejDfwlKhzSfC58gbltrNQwm0zpL8xpoAU1VhrKBosQEMGmNtDCxVjQoMox2E=
X-Received: by 2002:a6b:1884:: with SMTP id 126-v6mr2387459ioy.183.1528794638882;
 Tue, 12 Jun 2018 02:10:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:304a:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 02:10:18
 -0700 (PDT)
In-Reply-To: <cf1f65b9-26cf-24ab-e7b1-0503f2b5e65c@arm.com>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-9-git-send-email-vincent.guittot@linaro.org> <cf1f65b9-26cf-24ab-e7b1-0503f2b5e65c@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Jun 2018 11:10:18 +0200
Message-ID: <CAKfTPtCCi665e45Ar52VLvaeem4Acin0jgo_563nAhYEkhHacw@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] cpufreq/schedutil: take into account interrupt
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 at 10:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 06/08/2018 02:09 PM, Vincent Guittot wrote:
>
> [...]
>
>> @@ -182,21 +183,30 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>>         sg_cpu->util_dl  = cpu_util_dl(rq);
>>         sg_cpu->bw_dl    = cpu_bw_dl(rq);
>>         sg_cpu->util_rt  = cpu_util_rt(rq);
>> +       sg_cpu->util_irq = cpu_util_irq(rq);
>>   }
>>     static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>>   {
>>         struct rq *rq = cpu_rq(sg_cpu->cpu);
>> -       unsigned long util;
>> +       unsigned long util, max = sg_cpu->max;
>>         if (rq->rt.rt_nr_running)
>>                 return sg_cpu->max;
>>   +     if (unlikely(sg_cpu->util_irq >= max))
>> +               return max;
>> +
>> +       /* Sum rq utilization */
>>         util = sg_cpu->util_cfs;
>>         util += sg_cpu->util_rt;
>>   -     if ((util + sg_cpu->util_dl) >= sg_cpu->max)
>> -               return sg_cpu->max;
>> :confirm b9
>
>
> This didn't let me apply the patch ;-) After removing this line it worked.

Argh ... i have done something wrong
I'm going to resend it
>
> [...]
