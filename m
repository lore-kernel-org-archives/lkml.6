Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFBDC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BB621773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6N7KPRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfAJM3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:29:00 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46751 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfAJM27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:28:59 -0500
Received: by mail-vs1-f65.google.com with SMTP id n10so6850149vso.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUdFYRONqOJTQk68et+xd2yVkYPxgXEdsw9txX4Tlpg=;
        b=L6N7KPRHjzzGnnWg5XB5HqDQKygHFTHAzWI/arESTfP4q5oi9l5EyJFCYYStiNk7MZ
         A9scVRN7hh8lOmgBpBw5ZolteyhtnU+4AMc0j9eUK9LVLDQQNjsVktas7NfCvc+gv22c
         JHwmzpHDF8sjl+U3xZhM5kk8sta92PDBKoyEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUdFYRONqOJTQk68et+xd2yVkYPxgXEdsw9txX4Tlpg=;
        b=fTUL4aU2sQpYeeYhZ4jL557XC+YlJ9UaGT19ATtJvCxFT14u7JP86sV7BY1Ph0TYe8
         NEbhEwMONxt7tOpwHN5j5MHdDPYUBKixc9MnXleOUovFmeNuAW7X3oFvPqm5LpNGQqaa
         6l58bdHlawUqUm8JMBjEmjuyfQkPkQlqf5J1WeTzBLtu+F2/4+BYIDgBjrXKb4dtlQY+
         t9XOZ1sADPSk8ExO27K57HJO5764hAb8cG9ACgcIsJEW8j48OysJ6Cz6g7tXsUh9xFRA
         +zqnXh4CFJ8IRSAwTCeq6LHjTy8xuDJroplBLItSJJm7Q0WahNSzFZ2gGo/a0bagXzMq
         Mdww==
X-Gm-Message-State: AJcUukfk0R0HKn9gFuqJ3LGofqHDFVQQvR5vm1RPLM8vlvI5cSXskJAx
        YpCbnjmjmYVzoOkClsi7MjMe8+zvVGIz/NTNb3E9Sw==
X-Google-Smtp-Source: ALg8bN5Y+rBxwYkeQulrt0q2NaGqrgs5fN8XEXlgHiXyuPaAF4M+mjpF1fl387uVwgOD2AkT5AVh/lED01LKGyKcv0g=
X-Received: by 2002:a67:7ed8:: with SMTP id z207mr3821938vsc.159.1547123338369;
 Thu, 10 Jan 2019 04:28:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
 <154708009884.15366.3039982038291126570@swboyd.mtv.corp.google.com>
In-Reply-To: <154708009884.15366.3039982038291126570@swboyd.mtv.corp.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 10 Jan 2019 17:58:47 +0530
Message-ID: <CAHLCerNQgOrud7OkhJ3Vy431B=kQuXZU5pSMXc24cU1ZUeR1Xw@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] arm64: dts: sdm845: wireup the thermal trip points
 to cpufreq
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 5:58 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-01-09 16:00:56)
> > Since the big and little cpus are in the same frequency domain, use all
>
> Oh? I thought the big and little cpus were in different frequency
> domains and voltage domains. Maybe that's what you're saying here but
> I'm misunderstanding. So change the wording a bit to be more clear?

Yeah, forgive my English - it is my second language. ;-)

That should've been "since all the cpus in the big and little clusters
are in the same frequency domain". Will fix.

> > of them for mitigation in the cooling-map. At the lower trip points we
> > restrict ourselves to throttling only a few OPPs. At higher trip
> > temperatures, allow ourselves to be throttled to any extent.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>
