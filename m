Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D112C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D9620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547721087;
	bh=EVgsZUiIGwENE+9IIXMtkJRT9qz238EuJSpK+1s3mz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JE1UtKoethY1rME8Jbosi5+02VVBkoqYjSycoAMuPpsOlVL1sUHJC5aCFdVOV907i
	 aQkbH/FyiXDwqR242P+xgCr0iE8FEboIJvphGpr5A+Z5U1kCT3bh//D8sErhUTfVPS
	 BiVfB9VoAtDY8916DzEGV9skgBgX3kXMCdn9bnis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfAQKbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:31:25 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45240 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfAQKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:31:25 -0500
Received: by mail-oi1-f194.google.com with SMTP id y1so5722372oie.12;
        Thu, 17 Jan 2019 02:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGd1GzfRXCa7LnA5V4FSlo4bq5QGELGlvjfZTifFP3o=;
        b=WQb5SJw58tX2w/BZd7dbyyB/Qk6r1R1p+GHKAhEzSF2zj3puUxi8rdSm9ScUescrzk
         FPHjxuuGGnMJz/asupUgomTQvfO0ddJLOA9GHf10qPPUIC0eyhQE3mNq4HKeSPSmGGSG
         6CdxJfmro8PcehVfVennCzSz++mHvMPouBDREcqzqNzxrNQaVZWoHZOz0Mjoi64NYfop
         pyjxAoaDBxrzOgnyIXsPX+svX7ZNkwt5csY0CxZ3vSDPKVRYhpNQiGjsNoMPvMVBfjpy
         dlXUK4gmLMcML4EEs36IJytb2G+O4uE0bUpaIYbLqVFFTcrneYlYhpKaGx++ZZhDiwhl
         xL+g==
X-Gm-Message-State: AJcUukenA/FfV40mXhvdsku0K/GLM4dU+B3yHifFNUYrXfzza789O6kI
        I/nlK+FFO9Bm5VSud0b01OmmCuDFz05TajlyOa4=
X-Google-Smtp-Source: ALg8bN5c+rJ4uszRgZIkgs0ZQrcYAyuaAq4DqfJERAZoa1JIDIazitANO042tZMiEHKxbZPZLW3KRG6JMQ6hCLhxy00=
X-Received: by 2002:aca:e715:: with SMTP id e21mr7418405oih.76.1547721084580;
 Thu, 17 Jan 2019 02:31:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7> <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
 <CAJZ5v0jMOnV-maVfxbD-8HWOV30qzLfYUYN+xMNBhhgJWB2aFw@mail.gmail.com> <20190117102839.xrkhmghp44nzlytd@vireshk-i7>
In-Reply-To: <20190117102839.xrkhmghp44nzlytd@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 11:31:13 +0100
Message-ID: <CAJZ5v0idoGcc-j1kZVjsNE9Z76xzN1xe0bb=AW-JFcL0ZjfyMg@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling device
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-01-19, 11:14, Rafael J. Wysocki wrote:
> > Alternatively, "depends on THERMAL=y" under CPU_THERMAL should work
> > too, shouldn't it?  "!CPU_THERMAL || THERMAL" would be always true
> > then, AFAICS.
>
> That works and this is the easiest of the changes to make :)

Let's do that, then, I think.
