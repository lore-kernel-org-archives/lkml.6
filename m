Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA46AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8671C20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU66lAem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8671C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJPO2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:28:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35524 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeJPO2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:28:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id o14-v6so19789313ljj.2;
        Mon, 15 Oct 2018 23:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jL5P6guJvFKgwyFoHXbej2jNX+mJ2O2UGscPCmJHkEE=;
        b=jU66lAemMRr0HsDcumG6nNVDZ7GJzgWBsR1A6MIGm+1rZsHlcwzCr1j6k6EkqPv4QR
         T00z7R2apws674qmyPJR9JAkAriOCraX74TDPmxD0jdUv/zEZmzfZDQiXUet4kOCYjpQ
         q1DT74G1Dxlbajq7wBftY6SG7uVjh1h6rT7jfMD6TOqeNlgK5vG6u3GE15FM1dB/SlcP
         V7ftuxVrloHK9Vy/J5mYUpXRa01fL1yqQ+C2qWKKx+sgDsN+Xog+SUD7TVcJUdNrWvOu
         YC5MScM1+QNiBnG9ChWfeYO5cTE6zEM0WrQUitbBHh2/0/9mduqhx5mc1ii5TFEFQRoQ
         u7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jL5P6guJvFKgwyFoHXbej2jNX+mJ2O2UGscPCmJHkEE=;
        b=H3stfUm83twHWTmYVGvTW2s7sQuyUm7gMlLJTlk2rjDYJdkQAux6SuktP6oTYdj/iE
         z02pL6zD5dPAjmTis5ptJCvRUaXLCArjjRssDkXi47lPOD2czXP1iQlB0+YIX3pyf/Fs
         gyyr/haMU6hC2QJiQj/gOZIGAYh85ApMp2jAcgnlKSas1MvBD+nwW5T59I/cCMGMK+is
         cc4e66pi1q/UGyALLXBrRrayDlqm7oooldq1CWnVTjGf1byuLC+myOJSu8yEFPC7ZprB
         TwSKyIG8I1RFQSm+jSyZlrcdh0POe0LzSrw8Wq+9GSbACHgwh9uAuK7ibd5V+lSBAkmC
         fVtA==
X-Gm-Message-State: ABuFfogMnth48IcMuso8n890R3k7e2iyceQQAfAZiHF4sq9IRpFawB2M
        J4DxRR59EyZP5hqY5Ygv5JJ0yzyKhRaCtPytTChEK79ETms=
X-Google-Smtp-Source: ACcGV621MFgPZJt2DtLZtzjDuEQdmF4kT4ynYAiPeC6KfbiePi1mc4+RRuHVAunI/BHu0aIFZ+AYCOPO3YgWLImEKqk=
X-Received: by 2002:a2e:52ca:: with SMTP id n71-v6mr12395178lje.54.1539671966155;
 Mon, 15 Oct 2018 23:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
 <CAHKzcEOECQP8j6q=NKzuEjF+mc0s80fr6xWw-=NXsTtzCGGg_w@mail.gmail.com>
 <CAJZ5v0gFjBoFi=cpC2gPkZTDZof8dxdCCVx0XoAv2XuPmTfWPA@mail.gmail.com> <5406371.vuaACy5i7F@aspire.rjw.lan>
In-Reply-To: <5406371.vuaACy5i7F@aspire.rjw.lan>
From:   Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Date:   Tue, 16 Oct 2018 08:38:49 +0200
Message-ID: <CAHKzcEPsiR1zDQgw_N5Fu7tX+fP+brOs0okvK3yBr=16Y9S28w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Take limits changes into account properly
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>,
        linux-kernel@vger.kernel.org,
        "Bartholomae, Thomas" <t.bartholomae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 at 23:24, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the policy limits change between invocations of cs_dbs_update(),
> the requested frequency value stored in dbs_info may not be updated
> and the function may use a stale value of it next time.  Moreover, if
> idle periods are takem into account by cs_dbs_update(), the requested
> frequency value stored in dbs_info may be below the min policy limit,
> which is incorrect.
>
> To fix these problems, always update the requested frequency value
> in dbs_info along with the local copy of it when the previous
> requested frequency is beyond the policy limits and avoid decreasing
> the requested frequency below the min policy limit when taking
> idle periods into account.
>
> Reported-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
> +++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
> @@ -80,8 +80,10 @@ static unsigned int cs_dbs_update(struct
>          * changed in the meantime, so fall back to current frequency in that
>          * case.
>          */
> -       if (requested_freq > policy->max || requested_freq < policy->min)
> +       if (requested_freq > policy->max || requested_freq < policy->min) {
>                 requested_freq = policy->cur;
> +               dbs_info->requested_freq = requested_freq;
> +       }
>
>         freq_step = get_freq_step(cs_tuners, policy);
>
> @@ -92,7 +94,7 @@ static unsigned int cs_dbs_update(struct
>         if (policy_dbs->idle_periods < UINT_MAX) {
>                 unsigned int freq_steps = policy_dbs->idle_periods * freq_step;
>
> -               if (requested_freq > freq_steps)
> +               if (requested_freq > policy->min + freq_steps)
>                         requested_freq -= freq_steps;
>                 else
>                         requested_freq = policy->min;

Looks good.

Acked-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
