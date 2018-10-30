Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617FDC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5152075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQSrsFnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5152075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeJ3Omh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:42:37 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33144 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeJ3Omh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:42:37 -0400
Received: by mail-oi1-f195.google.com with SMTP id c25-v6so9374836oiy.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfJK4B2Y8mscisFcx5galCYlcb3eipHpS0nZJamTh+Q=;
        b=ZQSrsFnNiOCSn6txGqEvHMp7Bzw3Y54NkibPoFeGImOXblNz+Sl9NuXNncGFP0tyjx
         Loxf0vGvdJ5j7JUz2KwLcZFM4GyBX9bvbkDgvlRuAVujGaPUtFmU3W84iMlrrnUch12a
         L3KKdLBIsPKshaX9HAzWazkVqcBopJ+x1vu1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfJK4B2Y8mscisFcx5galCYlcb3eipHpS0nZJamTh+Q=;
        b=YGBlvJbqwWkUociiohQmX087RiZsLIO4x3z2a5JbUyox86wQe3ONXEUzeu6MB4ou2R
         HA1Hea9TXRwkp6Lb9mtvDUptq+ApZNzgezwKOY3LhO1tMWGKDAjZNhwbB3E+75iaRDI0
         +4kOvHqnjI34eME9HWLBWIDQJDKpQBooGXnBVDnnNcR9uyRGUkYIJp6pTvqhceBITHZi
         jFolmoBU0nZXdiaXs2A1DtS04nqN71lX/DPVxahVzWCxxiQOPiVYR7eJ9sbaompemz8v
         tPbAK4ycwOWaD3Ca9p6Adk59FsuXMkl7KSYJ4/5ZIIXL2HZRafmJktSByOVsJFIUzHlF
         yQ7A==
X-Gm-Message-State: AGRZ1gIuFrx6dxse8mxZzsM0y2vUs5yKLsGsZ8lJ3eb2z29ZlEnZplNW
        vvWyC8lpYTIfufi64iXVEL2FyTc4Pa0Owf073EY=
X-Google-Smtp-Source: AJdET5fU4oCuBsUJSBgc1FROM35mS7gCWFs1bFsbc/pP4vnuclnQJoMI4tDcKtEjfRQyQSMFWV5JJu+gAUGgLzwbKWw=
X-Received: by 2002:aca:5cc6:: with SMTP id q189-v6mr92791oib.121.1540878633671;
 Mon, 29 Oct 2018 22:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue, 30 Oct 2018 11:20:19 +0530
Message-ID: <CAOh2x==y+7jEdC-3xpvhr6j+RTtXRwTnBFC2uRVUmuktbCvsKw@mail.gmail.com>
Subject: Re: [PATCH 1/4] base/drivers/arch_topology: Remove useless check
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 9:56 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

Would have been better if I was cc'd on all the patches since I was
looking at this
stuff actively this week :)

> The function 'register_cpufreq_notifier' registers the
> init_cpu_capacity_notifier() only if raw_capacity is not NULL.
>
> Hence init_cpu_capacity_notifier() can not be called with raw_capacity
> set to NULL, it is pointless to check it.

It isn't entirely pointless though.

It is possible for init_cpu_capacity_notifier() to get called after
free_raw_capacity()
is called from it as the notifier unregistration happens from a workqueue.
