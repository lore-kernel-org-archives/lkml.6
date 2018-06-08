Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tnDFGc16GluhfwAAmS7hNA
	; Fri, 08 Jun 2018 12:48:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BFA916089E; Fri,  8 Jun 2018 12:48:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6uiGEAD"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 22573606FA;
	Fri,  8 Jun 2018 12:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22573606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeFHMso (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:48:44 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33686 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeFHMsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:48:32 -0400
Received: by mail-it0-f65.google.com with SMTP id k17-v6so4976818ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rn8DQz9q5gegUFKFJy3Zu8eZg3OrGa+dccB1AJrUwnk=;
        b=A6uiGEADDwvWdLWqDKrLRP5ZA84v7GdCwaaAOBlzGGJ7eHzgcTlAKWL0LA7oIpP0Mw
         VUhqFVht1gTZ2XJ4NEYxNrUy7fADK+gvzOvj0WsVaAViS+PCdugnDiQ+mJJENfocg9dr
         K6cuAM8gM/rOqmfaeBuLyAC4Kmz5LanQBURq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rn8DQz9q5gegUFKFJy3Zu8eZg3OrGa+dccB1AJrUwnk=;
        b=s1zrBNYZuzIjW4hLB/9ueiut7Tyj/jmxBUG5ShnOnacR8mPUzcjdPsvmTACj0psV+y
         Ol2S5smcIgRgXPEYY9jU+OFYIq3lk7SgAIaOIMHakdZ+j8LLEYVtr4B7aRi/14x3tUql
         TY/QgXhJGpm/D93ri0RJkRWY7/UKqXyQbhXs2Z+YVDGR5Vaz/sbAUdz7VeYEhUF1/MIq
         n7dhrFF0J/vjJnAcUSy0Tert1uzzhGMvIdH5cz1E8SAjxjgT5isiCCt0WBdpqUhwhqY+
         MWFrLz17/h2P4b4r/0Y1xStqTydFi2Dx7fVJEtClAwuli7TaflAxNpuXdtvWyegRVx1e
         yiZw==
X-Gm-Message-State: APt69E3ptK53NvkUn2w5Efm9CJ7Dw1VdlETmSPP9sdS164Za5m0DH750
        FeNY9atOLkf7lay7Cn9bJYozoD4dDAawd1kzR6zVJQ==
X-Google-Smtp-Source: ADUXVKLd8CUWJwKjxvLz+cBGuOlGMm1+W85gSuemiJD89vKu9hrqjEoJVoJwGcK0I75ID6yC7sk6/Z+1ICVsFp4FMQY=
X-Received: by 2002:a24:4985:: with SMTP id e5-v6mr1467944itd.89.1528462111941;
 Fri, 08 Jun 2018 05:48:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:304a:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 05:48:11 -0700 (PDT)
In-Reply-To: <20180608123959.GE16089@localhost.localdomain>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-7-git-send-email-vincent.guittot@linaro.org> <20180608123959.GE16089@localhost.localdomain>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 8 Jun 2018 14:48:11 +0200
Message-ID: <CAKfTPtCTMFN2Hed9Ku=VLH2Uwm4sC1kBBa5yRbb20r0o=-R7jw@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] cpufreq/schedutil: use dl utilization tracking
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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

On 8 June 2018 at 14:39, Juri Lelli <juri.lelli@redhat.com> wrote:
> Hi Vincent,
>
> On 08/06/18 14:09, Vincent Guittot wrote:
>> Now that we have both the dl class bandwidth requirement and the dl class
>> utilization, we can detect when CPU is fully used so we should run at max.
>> Otherwise, we keep using the dl bandwidth requirement to define the
>> utilization of the CPU
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>
> [...]
>
>> @@ -190,20 +192,24 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>>       if (rq->rt.rt_nr_running)
>>               return sg_cpu->max;
>>
>> -     util = sg_cpu->util_dl;
>> -     util += sg_cpu->util_cfs;
>> +     util = sg_cpu->util_cfs;
>>       util += sg_cpu->util_rt;
>>
>> +     if ((util + sg_cpu->util_dl) >= sg_cpu->max)
>> +             return sg_cpu->max;
>> +
>
> Mmm, won't we run at max (or reach max) with a, say, 100ms/500ms DL task
> running alone?

not for a 100ms running task. You have to run more than 320ms to reach max value

100ms/500ms will vary between 0 and 907

Vincent

>
> Best,
>
> - Juri
