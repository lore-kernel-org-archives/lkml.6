Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 81/3ArGGGlv/fwAAmS7hNA
	; Fri, 08 Jun 2018 13:39:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E1543608B8; Fri,  8 Jun 2018 13:39:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PngCa/4G"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4B6DE607DC;
	Fri,  8 Jun 2018 13:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B6DE607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeFHNjI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:39:08 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53133 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeFHNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:39:07 -0400
Received: by mail-it0-f68.google.com with SMTP id m194-v6so2374691itg.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZqVZCdIzSxvJDMcLf9yRwXmG7LoFmAHjcU1sqYdfGco=;
        b=PngCa/4G9TQ29TNi4eIoMBlv8l4EJB7QDQ3ZPU6dYgViaxhb5P5Xsx969bZCsdzW8J
         TirSX4FqcA31YAl3wzmmPjM9Tumm6Ckiw84bzQhnq4XD5Ep0ZM5Sx+xNvbHnMiW0F9ve
         ndAPUBfunX0f5yPpQRPv3uSlM+wJZYGp2mLWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZqVZCdIzSxvJDMcLf9yRwXmG7LoFmAHjcU1sqYdfGco=;
        b=XEXhNTDJl0mmS+20TiPfL8g5IALA2Y13SmvgbQTeOvRAoOTo0uknl7ADf9vT/sVWwh
         FHThWuAdwEoBtPMfrgzANDO3ZZOQFzZlqp1Am4nGLtDXKvT9jWFoAGxEkFnTPfqyl+3p
         4AFseyeO2owINy7b40wzg2gBOe6KrfPBN4saH9Tuyw33vvpUeUleqIVLBvlstC4DmFQp
         WMnQdBRd/2ALcK5JngcasvqEeAu+Pc0qJoaJp8heellKoX0mPrySQAMrW1ykQhIXgNt9
         3Zz9hq/o5ybm1VoI3tnx+u15thdFk/0t37BjzG0wEC17QKntBeX3QMBpgT6HX2MR5G/e
         KIeQ==
X-Gm-Message-State: APt69E1KLGzGGXVq4rdqIcaCkhQKt6Pbs3F46cdOAgdZE4rtSCinZRA/
        bod3DSXnkmikXguqCIcl/ybw107aCfAQVxMVSIkCtA==
X-Google-Smtp-Source: ADUXVKLvXB+aLdmfaFTVj2Wrur/p9F9jOO0pk44TwvngcrUHqxLtcMdF1vMKkzHTWj+I8BsU1zfAtfqD+tXWFBGT6Ls=
X-Received: by 2002:a24:4001:: with SMTP id n1-v6mr1654823ita.8.1528465146722;
 Fri, 08 Jun 2018 06:39:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:304a:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 06:38:46 -0700 (PDT)
In-Reply-To: <20180608133630.GS16089@localhost.localdomain>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-7-git-send-email-vincent.guittot@linaro.org>
 <20180608123959.GE16089@localhost.localdomain> <CAKfTPtCTMFN2Hed9Ku=VLH2Uwm4sC1kBBa5yRbb20r0o=-R7jw@mail.gmail.com>
 <20180608125448.GR16089@localhost.localdomain> <20180608133630.GS16089@localhost.localdomain>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 8 Jun 2018 15:38:46 +0200
Message-ID: <CAKfTPtDi9JN2gJAZ2BPqVbKwzHxop+4yev++LZsXq-igMT0Djg@mail.gmail.com>
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
        Ingo Molnar <mingo@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 June 2018 at 15:36, Juri Lelli <juri.lelli@redhat.com> wrote:
> On 08/06/18 14:54, Juri Lelli wrote:
>> On 08/06/18 14:48, Vincent Guittot wrote:
>> > On 8 June 2018 at 14:39, Juri Lelli <juri.lelli@redhat.com> wrote:
>> > > Hi Vincent,
>> > >
>> > > On 08/06/18 14:09, Vincent Guittot wrote:
>> > >> Now that we have both the dl class bandwidth requirement and the dl class
>> > >> utilization, we can detect when CPU is fully used so we should run at max.
>> > >> Otherwise, we keep using the dl bandwidth requirement to define the
>> > >> utilization of the CPU
>> > >>
>> > >> Cc: Ingo Molnar <mingo@redhat.com>
>> > >> Cc: Peter Zijlstra <peterz@infradead.org>
>> > >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> > >> ---
>> > >
>> > > [...]
>> > >
>> > >> @@ -190,20 +192,24 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>> > >>       if (rq->rt.rt_nr_running)
>> > >>               return sg_cpu->max;
>> > >>
>> > >> -     util = sg_cpu->util_dl;
>> > >> -     util += sg_cpu->util_cfs;
>> > >> +     util = sg_cpu->util_cfs;
>> > >>       util += sg_cpu->util_rt;
>> > >>
>> > >> +     if ((util + sg_cpu->util_dl) >= sg_cpu->max)
>> > >> +             return sg_cpu->max;
>> > >> +
>> > >
>> > > Mmm, won't we run at max (or reach max) with a, say, 100ms/500ms DL task
>> > > running alone?
>> >
>> > not for a 100ms running task. You have to run more than 320ms to reach max value
>> >
>> > 100ms/500ms will vary between 0 and 907
>>
>> OK, right, my point I guess is still that such a task will run fine at
>> ~250 and it might be save more energy by doing so?
>
> As discussed on IRC, we still endup selecting 1/5 of max freq because
> util_dl is below max.
>
> So, turning point is at ~320ms/[something_bigger], which looks a pretty
> big runtime, but I'm not sure if having that is OK. Also, it becomes
> smaller with CFS/RT background "perturbations". Mmm.
>
> BTW, adding Luca and Claudio. :)

Argh... I have added few more but forgot Luca and Claudio. I'm very sorry
