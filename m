Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E6DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F6120844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRmUWsX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F6120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeGYFA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:00:27 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34647 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeGYFA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:00:27 -0400
Received: by mail-it0-f65.google.com with SMTP id d70-v6so16572978ith.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 20:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rr3MHkYSW9aiKM7ASTwIA8/2DdgLrYSk+6ohTH7Vjjs=;
        b=QRmUWsX8d/WBHFEZF+CZoB2OXAV1NCDQbcQ5RFe3WiPw/N9UqyoHzoaWCKgegs6oAD
         IzUk1EX5WEJ84e5B144Ra2zg9NZp/K8NGx3tGcp8hBucqWdv/d/FXe/3vFVHIGuSucmI
         QPL01A94/Hzu0A8v10Y2KEaYfPwAwfENnuRZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rr3MHkYSW9aiKM7ASTwIA8/2DdgLrYSk+6ohTH7Vjjs=;
        b=mEgLt+mMqfm/ObQTs11xCFhcIMzeLuZIFzQPqLhPfnMmWZvDi8LqCUQTVaneUlit2e
         GGl86Loqe+4OeKSIf5CiGINnrAJ4LrTp/P5zn13v4cWbL1lsaAqSkzsvPu+rdjjhV4ce
         4L7JSkt9AOxKFJ4ppfnblBEzTprwoHhM/GMSJ4IaUc/gs2nHKewBCGdUycNyVhUMidvI
         pPxY3XavnXcPA72aEFa+JfdmFVvKo06nPnhH6tLHvgDz0JOj0gd6P7r9B6fjnm6JLHK0
         +BANBt2rz/6TOloD4XS9aFsP1QlDsJibhBE0dqN9YONEGuMXVnr+pEJJbmZnuayW7eCj
         XRGw==
X-Gm-Message-State: AOUpUlHF5XvbxH8EVSXRjmoUvclfhSePahG+zHkM7yJCtOm+jq9Mpk8m
        dXHs0FWzeluJGiOnTlz4QAF2gc5JjMKhXp6de+SYyQ==
X-Google-Smtp-Source: AAOMgpchu2zeA03XUyMwuNMi326GxcjALejxPYxON/d/ZF63bwuzUFPvEsxsacLxxcKn7lo3c6Ku7GpO60zT2H3JVfQ=
X-Received: by 2002:a24:62d0:: with SMTP id d199-v6mr4612162itc.91.1532490645589;
 Tue, 24 Jul 2018 20:50:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:4441:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 20:50:45
 -0700 (PDT)
In-Reply-To: <20180724173544.18876-1-joel@joelfernandes.org>
References: <20180724173544.18876-1-joel@joelfernandes.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 25 Jul 2018 09:20:45 +0530
Message-ID: <CAKohponm0CbBNLY19B-9ccfe3d3jreSJLDePEROR+w1=1JZEWw@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: trace frequency limits change
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Ruchi Kandoi <kandoiruchi@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 July 2018 at 23:05, Joel Fernandes <joel@joelfernandes.org> wrote:
> From: Ruchi Kandoi <kandoiruchi@google.com>
>
> systrace used for tracing for Android systems has carried a patch for
> many years in the Android tree that traces when the cpufreq limits
> change.  With the help of this information, systrace can know when the
> policy limits change and can visually display the data. Lets add
> upstream support for the same.
>
> Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> Viresh since I changed the patch, could you Ack it again?
>
> v2->v3: reduce parameters to tracepoint call (Steve)
> v1->v2: correct ordering of min/max (Viresh)
>
>  Documentation/trace/events-power.rst |  1 +
>  drivers/cpufreq/cpufreq.c            |  1 +
>  include/trace/events/power.h         | 25 +++++++++++++++++++++++++
>  3 files changed, 27 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
