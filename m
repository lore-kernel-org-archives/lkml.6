Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE43ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C81208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liGrlXNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C81208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbeGPXcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 19:32:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45953 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbeGPXcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 19:32:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id q5-v6so31357191ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wOpV4fqMfulJL94yGwph5KH7V/fTx9ABJUvCl4zr4w=;
        b=liGrlXNOZhhF6RjFa0x5dMLyC7lDk8rJNzg2KWJaeh2nW0ots5gKg8I8D7aL3fkri/
         PujKBuZ3bml1wpT7o8sWbw+l6dhNL7R9VM/vBOW1QWbdX4cMjaQJWyOMMzDMRc3HV2ec
         HpL3pWULi90mMjWUJwP6/Gqk4dsLGhdJDzDovwOlkfKmKxOphxUnnrPmGhOY+pYbR9Sn
         TJLqNAno20OJEv46+DYu3+ZA2ogYeSyem7EcTPCsDVx6nEaEbEguYBrEg9iGJbMCmIHa
         pfLjPXwy/tAdjCNNDDtRxJ7UaLLO8ySlXukYI2hp2fnp/5gmDeXLe4bNmaiHlAux2apz
         p3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wOpV4fqMfulJL94yGwph5KH7V/fTx9ABJUvCl4zr4w=;
        b=XR9NskMIOgTT+GPVi/CjSUrvuFtwLt4IR26Ym1i1ExePCaAPxte1XP75FRLzP6WaA0
         1NCrMIKmEmDqsn6GDnSRwgXDn7kIDTpwKmelFuuPfcaSsioC2h9t5rdNyfAefPpdYnYW
         iDhFlELu7H8Cy1h/6znHtcFYEcdw/sP1EmwWnYquEE3a0bOtmlzefzvbNzzzijcGOB7N
         CUpbWm2RNMUq6xd9r/Q+QPtugZ2n4WuTpi+D5KB1SkBcbWwSaIuwfn3pCcZRZ5MLBs40
         5HYTemgI9njWmWLUY3sPs6DIpr1eVtqOKLGXZxIsICmQ6/nlqw1Yj8t4Mw0VgyjPedCu
         vfSw==
X-Gm-Message-State: AOUpUlEfTztYtAJHAHLCAJLMWdy2ovvtaHS+FrKeRjFgSXi7abUCKahJ
        1JcotrQ4QyOKDgI2LGJhUkdv2dsSpuqrbE+qnLGhDQ==
X-Google-Smtp-Source: AAOMgpeInIE46igp2jwTiSYZ4BQGpl5dV6Kh7Apyxbtusa9tby4vdgbws7u3zxpLFvRENEE2oaVYyJfq8rhh4mUXKJ0=
X-Received: by 2002:a2e:540d:: with SMTP id i13-v6mr10865685ljb.51.1531782190211;
 Mon, 16 Jul 2018 16:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org> <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
From:   Evan Green <evgreen@google.com>
Date:   Mon, 16 Jul 2018 16:02:33 -0700
Message-ID: <CAE=gft7pVnhbEtOyR7Q8n_WuL_RsttrxN+sp=_EPyR=D3NPv9g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
To:     tdas@codeaurora.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        anischal@codeaurora.org, devicetree@vger.kernel.org,
        robh@kernel.org, Saravana Kannan <skannan@codeaurora.org>,
        amit.kucheria@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,
On Thu, Jul 12, 2018 at 11:06 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  10 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 344 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
>
...
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> new file mode 100644
> index 0000000..fa25a95
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
...
> +static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +       struct cpufreq_qcom *c;
> +
> +       c = qcom_freq_domain_map[policy->cpu];
> +       if (!c) {
> +               pr_err("No scaling support for CPU%d\n", policy->cpu);
> +               return -ENODEV;
> +       }
> +
> +       cpumask_copy(policy->cpus, &c->related_cpus);
> +
> +       policy->fast_switch_possible = true;
> +       policy->freq_table = c->table;
> +       policy->driver_data = c;
> +
> +       return 0;
I haven't looked at this driver in detail, but I have tested it.
Instead of the line above, I needed:

return cpufreq_table_validate_and_show(policy, c->table);

Without this the framework thinks that the min and max frequencies are
zero, and then you get a warning about an invalid table. I also
removed "policy->freq_table = c->table", since validate_and_show does
this.
-Evan
