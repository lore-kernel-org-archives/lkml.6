Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D526FC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808B82148D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIWfQghM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808B82148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeHJJo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:44:29 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41987 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeHJJo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:44:29 -0400
Received: by mail-oi0-f68.google.com with SMTP id b16-v6so14172829oic.9;
        Fri, 10 Aug 2018 00:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4S+B4dxAM01fMIMHLp1Y537TpunJAydeh/rHO1fTGa4=;
        b=tIWfQghMFsfD1iiPlP0fIkVhtRwfxzFYcs9iNnIReLxsYOqLsfSbCc816EuW/0dtPY
         YSfC/vYIOLAaMWWt3PaN4t29tFPjvLgNVGMbb5AFd7AFf93bV3AhmIMscO5N0cy595cQ
         CItsbCk8d29ZLTgFScYi4/kVDS83Hik8o9yxV+Dvav192KlnswyEVMZaUw3uX7MHtd6o
         eGsl3ay5k04V1FIclgd1XuS1cAExCVDTvDXUKqSBnAEmCzkXbdeMb+VdX0SsZAHsQJCj
         33WMNMII/tjxSzwu1Cub60R8qzhqUrLzzcK3DVI4AY45jYzxpJOFHW8oSJIMn4d/LXRp
         dA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4S+B4dxAM01fMIMHLp1Y537TpunJAydeh/rHO1fTGa4=;
        b=oWIEuqcc7zdHFiJJVMFJ48ix/ureiuVXJMhAprHLxYWRK97HyK4hrUvb3G4szh9Loy
         V51qbEcnVfGfzpMhGWNOHAxtYWJsczVvcpbVf82Qj1rU7tWIqJbnmwZ6u7YuPO0V31Wu
         HMAKi+2FuNJPWPtLErFC/oXbSO0GuNPIeAPYIycQQTgHaSzLH/OXxexHlRjcxCVMprSc
         87JTpT7skynCcbYAfpgNWDtaEPY9f1P2E8jav0vohz4eLeMfubXrQPaLJR1xgcjDHVg+
         rPx8WLQkk6UiHoFLXPHJneiIdNSV2/HvHW+nJwGs6icpniX4Cw4nuyj6mok7nz3N6V8f
         5LIQ==
X-Gm-Message-State: AOUpUlEH6s4B18PEs6pvGoFUY+qiJPkavr9xUb6BrSSvEDt68am9NWTt
        Xqkrqg8yXwDELaLDdL0jVq/JpD5dVpCjVc43pIzSWA==
X-Google-Smtp-Source: AA+uWPw0zoZcCAwL5t1J7wcFaHPnHg/YHjkE+PtAAr+Ze20LQckyjXQ7msJDPbpr54tMc61uofdOLIg72ys1amszSW4=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr5951370oih.227.1533885354704;
 Fri, 10 Aug 2018 00:15:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 00:15:54
 -0700 (PDT)
In-Reply-To: <20180810061917.GB11817@leoy-ThinkPad-X240s>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan> <20180810061917.GB11817@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Aug 2018 09:15:54 +0200
X-Google-Sender-Auth: Ok_W3qpNVoEwF-Mt8fVepuhFcnQ
Message-ID: <CAJZ5v0h6WRPe46RU+sx-xDDbSWMOdcV+n6J-_5e_wqp9zsyB=Q@mail.gmail.com>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been stopped
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 8:19 AM,  <leo.yan@linaro.org> wrote:
> On Thu, Aug 09, 2018 at 07:08:34PM +0200, Rafael J . Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> If the tick has been stopped already, but the governor has not asked to
>> stop it (which it can do sometimes), the idle loop should invoke
>> tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
>> of this case properly.
>
> IMHO, I don't think this patch is on the right way;

So we disagree here, quite obviously.

> from the idle loop side, it needs to provide sane fundamental supports,
> for example, it can stop or restart the tick per idle governor's request.

No, if the tick is stopped, restarting it is pointless until we exit
the loop in do_idle().

> On the other hand, the idle governors can decide their own policy for how to
> use the tick in idle loop.  This patch seems mixes two things and
> finally it's possible to couple the implementation between idle loop
> and 'menu' governor for sched tick usage.

I'm not following this, sorry.

> I still think my patch to restart the tick is valid :)

It changes the behavior significantly, though, and it is not clear if
the new behavior is desirable.

The patch here simply fixes a problem while leaving the overall behavior as is.

>> Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  kernel/sched/idle.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: linux-pm/kernel/sched/idle.c
>> ===================================================================
>> --- linux-pm.orig/kernel/sched/idle.c
>> +++ linux-pm/kernel/sched/idle.c
>> @@ -190,7 +190,7 @@ static void cpuidle_idle_call(void)
>>                */
>>               next_state = cpuidle_select(drv, dev, &stop_tick);
>>
>> -             if (stop_tick)
>> +             if (stop_tick || tick_nohz_tick_stopped())
>>                       tick_nohz_idle_stop_tick();
>>               else
>>                       tick_nohz_idle_retain_tick();
>>
