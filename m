Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04587C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90EE20831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjOhnG5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90EE20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJ3TXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:23:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43773 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeJ3TXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:23:04 -0400
Received: by mail-io1-f66.google.com with SMTP id y10-v6so6880011ioa.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6Nj+yWUe+wiS0rgS+is2Mtfyw+0vHdQsT72Jg+h9wCg=;
        b=YjOhnG5b9z0MMUmEzcNrcMVP7FqukyxMURT/br1pXLi280kwsa+a3wD9zg7g/0bI3u
         6t/RspR1ETzfoyevAFW9ErAGNOFVbdPig3eNWWwW5nuqrXOJ94Laq3+erepgULRSVdi4
         HnT2sZlv496v/PKY0HPQDP3tGR8iBqUmLPpk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6Nj+yWUe+wiS0rgS+is2Mtfyw+0vHdQsT72Jg+h9wCg=;
        b=KY7PNed8SjxCCK8Yk16mU8RLBumXzsxS802flvNPyWZdjTgodMdx2yx4HA6B2V6Qxi
         B98eIRrqekhnE26IlY1/5L4PYf1VzlcY86iQQWU5EnkSpKoGC6Y6i96jnl8dAW3upVyi
         dxWwHC5JlxgZfFKRfgF8yK1Jqhwn3Ic26OeQlVCYvhv4pJukbFvND2YWoB8VGkKz3Je+
         uQc0fz0nDaw8kmoKFZeoHlZ6KxmIHtOp9zMMgWVPAbostcYWolffHQQ2XMnYL+7URC9W
         gl8eEdjWG2SW5N5B46OBXdaphIkRGMpS0VOovvR3w5E/QJ4mjuo0Y7TW8rs/rnAxwdaE
         svKg==
X-Gm-Message-State: AGRZ1gK3PS5qSghitap325NeFG2UOZ+k+x3BJn8flxhwNHwkLUmPREZi
        EfNzeknqD70xpyBJUndB3JRJe7EvZw8VDOQ3/Xf2+g==
X-Google-Smtp-Source: AJdET5enf8kMFwlVQLkvEbc3jctf5TIPks0yT9TCfh0Ov55jCcswduTSjw7UkKzZ+eC1SHVac3kpZfhGrpfTWRa1NjQ=
X-Received: by 2002:a6b:8fca:: with SMTP id r193-v6mr11447222iod.266.1540895410140;
 Tue, 30 Oct 2018 03:30:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:38d:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 03:29:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1810292334160.5984@nanos.tec.linutronix.de>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-4-git-send-email-rplsssn@codeaurora.org> <alpine.DEB.2.21.1810292334160.5984@nanos.tec.linutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Oct 2018 11:29:29 +0100
Message-ID: <CAPDyKFrV-YJ4k_4Vnm-eFx8YAUF9b82U7PLPLFkz2fzcqYWybw@mail.gmail.com>
Subject: Re: [PATCH RFC v1 3/8] timer: Export next wakeup time of a CPU
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 October 2018 at 23:36, Thomas Gleixner <tglx@linutronix.de> wrote:
> Raju,
>
> On Thu, 11 Oct 2018, Raju P.L.S.S.S.N wrote:
>>
>> +/**
>> + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
>
> Lacks documentation of @cpu. Please include kernel docs into your test
> builds.

Good point!

>
>> + */
>> +ktime_t tick_nohz_get_next_wakeup(int cpu)
>> +{
>> +     struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
>> +
>> +     return dev->next_event;
>> +}

Thanks for your review!

Kind regards
Uffe
