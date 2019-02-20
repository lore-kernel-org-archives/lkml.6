Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04660C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9B72086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfBTMa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:30:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46361 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfBTMa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:30:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id z25so5148331qti.13;
        Wed, 20 Feb 2019 04:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yoWMNmw6z+cpbLzoGJad+5c02l6ZFuam/3NvFBUuMQ=;
        b=Cwian7Mwzfyx9YZxdvC5c+rx53uwbIndTynKqrg74Rv+A2I5SnpGfhjkTIzgbXMzOB
         fyTCTDrjQ/fN9PpYKkGK/nWBAP3n5KlszC+L2MxldlB8A38pKNZgdMja3eABUagSCC7T
         ZduwZR4NAMUfUOjzLxckRTKg/Rc9VUNFHWOWG/O55P5ZMk8rTPlc8Ju8CiqawdVXw5b8
         bVXbx4KzSVObm5Aj0pXDTSbA02vMZ8oAKuuzfmtz7fbK6E0UbwL3ld/uIDUDuQk0D4Rm
         rcgw2wC3DI5/OvDLikJks62FIquRXHeB7wcPUeWqgf8QHZgMIFkUVbn4+Pz/cGUjN+Mb
         fLgA==
X-Gm-Message-State: AHQUAuZ9dwqRUCmljVRSI+1HSA2pxjq1gXqBY02tlMedSPlU+h/ZE6VM
        d48fl0ysDqb54SaliCIymbUZcT6XlQDQFWSQuWYYuw==
X-Google-Smtp-Source: AHgI3IbMJxG9R4EGTw54AuzJRKB6dP/CBcWXly2F9POoetMaWgZqtU4a0ibAXcoQC2eqSxJjjtfrwfALm4zUpzYvu/M=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr27103194qta.152.1550665855029;
 Wed, 20 Feb 2019 04:30:55 -0800 (PST)
MIME-Version: 1.0
References: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
In-Reply-To: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 13:30:38 +0100
Message-ID: <CAK8P3a3Qkrx75K6sTQqhn0MZmOQ5O6x-FRH_2MkCkZf2OehZfQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: kyro: Reduce frame-size of qcom_cpufreq_kryo_probe()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:14 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> With the introduction of commit 846a415bf440 ("arm64: default NR_CPUS to
> 256"), we have started getting following compilation warning:
>
> qcom-cpufreq-kryo.c:168:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>
> Fix that by dynamically allocating opp_tables and freeing it later.
>
> Compile tested only.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Looks good to me, thanks for the fix!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
