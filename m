Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A217C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3032087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZ92Ebj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3032087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeKTUTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:19:19 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52158 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeKTUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:19:18 -0500
Received: by mail-it1-f196.google.com with SMTP id x19so2457487itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 01:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L0vl6VVNZcgIX8bxm67EfYqsQ7odEvIlNTxRdcQCtK4=;
        b=YZ92Ebj26O87BdJ4vZCEvZxGtsDPPDD4d1eRZNarYHgFnJ+cTzijXPlVc890GMcmdR
         lv8qS2DIP3g/wjDegf6tyDD0ksglEjfI5SjUa/FUg0dk+huW8JKbXwK8lcvwQaywo681
         kpepAS610eZb+tiWrkA/MNffOK11xln7431P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L0vl6VVNZcgIX8bxm67EfYqsQ7odEvIlNTxRdcQCtK4=;
        b=e5laRCMofaC48CWBxYizFKuHvMQEgWwdVveiTwuCrKgOqYAOADRzYvmyP9ZpVWs8Jm
         CAUwNHeoBq1dhI9dqBqvGv49JoJys0Vz/Ynr9XGLbqakUMUBGwXi+F4MwlfPC+BaRrBn
         ODrHb16TfCJyfz0Ewz2hcelgEFR2CAuDnSDYGhgO8Xf7sM2TZ58h33LwpRZnWd1SVsfY
         u2V1sB7V46oU1gTHJVCz9v0VraM6vMvz3BUPCHNtURSG52EGjEhpUHsUB4mVhw6OtP0F
         5WFKUXG3+acvX1wTV54/ObgQlZECo5ldnn6DibHe9OmEAe+pD+V53gblHbNU2i7+sirq
         Jbew==
X-Gm-Message-State: AA+aEWYlR6q3Wyn7WEltFSZ8wsXJ7SD0CpBsQWWOQIhIJp7g2iDo9PNb
        3JosLvlH3kFj8ZXiUGuVWj/3LNom8ue68jDM9Xgo+Q==
X-Google-Smtp-Source: AJdET5c8apQ3n5/J0EqdMqE+hkejt65XOE02OTUH6Y11cbsCH+nsznyEVloV0gH3ZtXMRbUt4bjU7gJv9W/rMQX6eLU=
X-Received: by 2002:a02:c909:: with SMTP id t9-v6mr1144151jao.95.1542707462489;
 Tue, 20 Nov 2018 01:51:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 01:50:22
 -0800 (PST)
In-Reply-To: <9bf3713b-df00-03b3-d235-7549565382c7@codeaurora.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-25-ulf.hansson@linaro.org> <9bf3713b-df00-03b3-d235-7549565382c7@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Nov 2018 10:50:22 +0100
Message-ID: <CAPDyKFond=Q-cWsjKwGToprjPTFj=WA_-nsAoUFJdNCdkki8Rw@mail.gmail.com>
Subject: Re: [PATCH v8 24/26] drivers: firmware: psci: Deal with CPU hotplug
 when using OSI mode
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 November 2018 at 20:50, Raju P L S S S N <rplsssn@codeaurora.org> wro=
te:
> Hi Ulf,
>
> Got one issue in hotplug path where of_genpd_detach_cpu calls
> dev_pm_qos_remove_notifier which can be sleeping as per below call stack.=
 I
> think it should be applicable for current patch as well right? Please let=
 me
> know what am I missing? why didn't you see this issue with this patch?

Weird.

>
>
> [ 8103.221387] BUG: sleeping function called from invalid context at
> /mnt/host/source/src/third_party/kernel/v4.14/kernel/locking/mutex.c:238

Could it be due to some other patch in your v.4.14 kernel?

> [ 8103.221455] in_atomic(): 1, irqs_disabled(): 128, pid: 11, name:
> migration/0
> [ 8103.221487] Preemption disabled at:
> [ 8103.221529] [<ffffff800814dfb0>] cpu_stopper_thread+0x98/0x118
> [ 8103.221600] ------------[ cut here ]------------
> [ 8103.221636] kernel BUG at
> /mnt/host/source/src/third_party/kernel/v4.14/kernel/sched/core.c:6102!
> [ 8103.221678] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [ 8103.222396] CPU: 0 PID: 11 Comm: migration/0 Tainted: G        W  4.14=
.72
> #1
> [ 8103.222428] Hardware name: Google Cheza (rev1) (DT)
> [ 8103.222460] task: ffffffc0f842d580 task.stack: ffffff8009c18000
> [ 8103.222504] PC is at ___might_sleep+0x138/0x140
> [ 8103.222542] LR is at ___might_sleep+0x138/0x140
> [ 8103.222577] pc : [<ffffff80080d8f04>] lr : [<ffffff80080d8f04>] pstate=
:
> 60c001c9
> [ 8103.222605] sp : ffffff8009c1bb40
> =E2=80=A6.
> [ 8103.223924] [<ffffff80080d8f04>] ___might_sleep+0x138/0x140
> [ 8103.223965] [<ffffff80080d8d98>] __might_sleep+0x4c/0x80
> [ 8103.224009] [<ffffff80088e4258>] mutex_lock+0x28/0x60
> [ 8103.224054] [<ffffff800850fa2c>] dev_pm_qos_remove_notifier+0x1c/0x54
> [ 8103.224097] [<ffffff8008517814>] genpd_remove_device+0x3c/0x10c
> [ 8103.224140] [<ffffff800851949c>] genpd_dev_pm_detach+0x48/0x108
> [ 8103.224183] [<ffffff80085193e0>] of_genpd_detach_cpu+0x48/0xbc
> [ 8103.224227] [<ffffff80083edea4>] cpu_pd_dying+0x28/0x38
> [ 8103.224268] [<ffffff80080ab2c0>] cpuhp_invoke_callback+0x254/0x5f0
> [ 8103.224308] [<ffffff80080acdec>] take_cpu_down+0x60/0x9c
> [ 8103.224346] [<ffffff800814d898>] multi_cpu_stop+0xac/0x104
> [ 8103.224385] [<ffffff800814dfb8>] cpu_stopper_thread+0xa0/0x118
> [ 8103.224427] [<ffffff80080cff74>] smpboot_thread_fn+0x19c/0x278
> [ 8103.224472] [<ffffff80080cc0c4>] kthread+0x120/0x130
> [ 8103.224513] [<ffffff8008084608>] ret_from_fork+0x10/0x18

Thanks for the report, I will double check my series before I post the
new version of my series. If nothing unexpected shows up, that should
be in a couple of days from now.

I keep you cc.

[...]

Kind regards
Uffe
