Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C2ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48264208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48264208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeJRRnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:43:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45848 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJRRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:43:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so23464281oig.12;
        Thu, 18 Oct 2018 02:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqMq6ifJ0/tIUZEfpCxUnacrcaoNiU1/pH4bfcSxsyE=;
        b=fKMB5ECVVYXH4/IFVTk8+VDD7LLI40z6YOsSCsuIJSONIbIrQCnSn+jY5AenlPLbK/
         adLAjxhRXmo+uRkLBHCipmeYi94AFmkfNBINSYEbwd06Ks3H4FjD+/hm05icG7RG9fmf
         4wUGCnGOZ70SStrahpmQpop906OBttRXNXAyKjLFzce6ZdRzLw8JUiKWpjJMEGXhI+/N
         GTcuEY5pgveBfr5dBwMbA2b4uV1lN0difx7z5V4g0t80NeFcEkP/HtKx+wCp1C7DmNt3
         3sfjamo6ivMjgVpHQbViqXysbdA059leV4DO1eJF1ULju6e/DDJn3qHIrUesNdRsBtmO
         oZQQ==
X-Gm-Message-State: ABuFfohM/ovRys/5pefTKlPjV9GONe6O+Q7jC0OLWQOyLze5MG9Gu27N
        DxiJnxn5r9G6HcrmlIdVTvr15TOWtgCokNtNgug=
X-Google-Smtp-Source: ACcGV63g7z0cE3WJtnAMNUtrprNsYkvxd/7Ei2I/968s4QFIFxtZICMiC4h4yUmzovbB70oSSH2RuuTra7FndrU9SoI=
X-Received: by 2002:aca:b655:: with SMTP id g82-v6mr14917437oif.195.1539855785101;
 Thu, 18 Oct 2018 02:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
 <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Oct 2018 11:42:53 +0200
Message-ID: <CAJZ5v0ikpPk12PshjB7EwtGSz6kF5WJyKgDHB8cnXaEusy38UQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/cpufreq: Reorganize the cpufreq files
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:36 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> It was suggested to set the scene for the PM components in the
> scheduler code organization in the recent discussion about making the
> scheduler aware of the capacity capping from the thermal framework.
>
> Move the cpufreq files into its own directory as suggested at:
>
> https://lkml.org/lkml/2018/10/18/353
> https://lkml.org/lkml/2018/10/18/408

Fair enough, but do we need to do that right now?
