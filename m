Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D6C42C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819F6208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FvvdK6R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819F6208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeFLJ1C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:27:02 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39177 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932639AbeFLJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:27:01 -0400
Received: by mail-it0-f68.google.com with SMTP id p185-v6so14529433itp.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i4WVvS08OVhEEozPP/YKKeBzmizyilnCZ11u7NUguwM=;
        b=FvvdK6R5e2QiislZzL4AYSLoaLDYttjAntnq9dj0fyD9o767/iPUfhMMqGcNiscFJt
         Rv4l9f3ms9V7TuY16X2TYuQ4QLKWqbrp5w40qS1+yndAclyaY96bpFc3wAtRAmGdOg2K
         FMHmmR5By9Lcp3T+DgxiRq78iqRDC1YATjD2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i4WVvS08OVhEEozPP/YKKeBzmizyilnCZ11u7NUguwM=;
        b=OCGuQj3BYwmv6T+7CPx10KCZnfEn2bbPq8oFPYFR/Ido1AOj/E+J2LYRL3fxrVJnIX
         zYvW2G9mmR8c4+MjlDsYevnBTVyHXiz/pIyZ41zW+PkmlEyGFAT5d21VdaIJNAJeVJsZ
         u6x6T26NA6Wc3sFf0zfpkp2B4eqeXIIvcHrtN6EE3FOcSQdwFbC7d/0mbzYkECs7eBt0
         78uWBX25+QtsY3+4uhBGwZcxg6BuGREEiwskrHiDHDRHuIljCSxVZmb2YS4XI296MHE2
         vgGCL7ai2xUQQ1JmmuxKuWTvl5n76lmjB0eD3vZllwENwICHw2+r+osW0ax8O/17B3Ns
         gIhA==
X-Gm-Message-State: APt69E3cCGT2is2t3tJ7FUuq9/MMhVaLk/zvAudHOyETQe0Oj7SkejkN
        V4NcInklndbmrDo3j9HUl+yYBJAYpv62JcfFliWAZYFZ
X-Google-Smtp-Source: ADUXVKJjE06RGjIXE5PQgj6zkD5+bCRBbbxWswi+EwiW9drq7CYOSyeIzGqtAc8cmuKtouodu8MPX6FmwMG8e0b8sB4=
X-Received: by 2002:a24:4001:: with SMTP id n1-v6mr2256412ita.8.1528795620551;
 Tue, 12 Jun 2018 02:27:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:304a:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 02:26:40
 -0700 (PDT)
In-Reply-To: <20180612092028.GG17720@e108498-lin.cambridge.arm.com>
References: <CAKfTPtCCi665e45Ar52VLvaeem4Acin0jgo_563nAhYEkhHacw@mail.gmail.com>
 <1528795016-18208-1-git-send-email-vincent.guittot@linaro.org> <20180612092028.GG17720@e108498-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Jun 2018 11:26:40 +0200
Message-ID: <CAKfTPtCOp1ucoVRCKSmbHts=wbZP8wQ08sa0_fkQHB-yMkK8JA@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] cpufreq/schedutil: take into account interrupt
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 at 11:20, Quentin Perret <quentin.perret@arm.com> wrote:
> On Tuesday 12 Jun 2018 at 11:16:56 (+0200), Vincent Guittot wrote:
>> The time spent under interrupt can be significant but it is not reflected
>> in the utilization of CPU when deciding to choose an OPP. Now that we have
>> access to this metric, schedutil can take it into account when selecting
>> the OPP for a CPU.
>> rqs utilization don't see the time spend under interrupt context and report
>> their value in the normal context time window. We need to compensate this when
>> adding interrupt utilization
>>
>> The CPU utilization is :
>>   irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg
>>
>> A test with iperf on hikey (octo arm64) gives:
>> iperf -c server_address -r -t 5
>>
>> w/o patch             w/ patch
>> Tx 276 Mbits/sec        304 Mbits/sec +10%
>> Rx 299 Mbits/sec        328 Mbits/sec +09%
>>
>> 8 iterations
>> stdev is lower than 1%
>> Only WFI idle state is enable (shallowest diel state)
>                                             ^^^^
> nit: s/diel/idle
>
> And, out of curiosity, what happens if you leave the idle states
> untouched ? Do you still see an improvement ? Or is it lost in the
> noise ?

the result are less stable because c-state wake up time impact
performance and cpuidle is not good to select the right idle state in
such case. Normally, an app should use qos dma latency or a driver per
device resume latency

>
> Thanks,
> Quentin
