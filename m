Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F57ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0376720877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIOkXqtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0376720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbeITDZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:25:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43028 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732479AbeITDZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:25:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id 38-v6so3267566plc.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEPpB/hRevxsYBY+Ta3YcPygMLBZIYL7oVjMrCS5xEE=;
        b=cIOkXqttVWnY6/25RKRgZUuNDIWH7VnMkpIDZM+XGl2H4TcOp5TLS1NGJJ13F/kvms
         +gAcjC1rXBkfuINynob2LX3/ngQF16IfSzyMjj1QNmQqQbSbdjc3HaqE/XNFn6NMtKKJ
         JeHufg5WC/rwbQ1m8fTr353bb0yNrYS/PSGB+hB5SBjKb5nOh7f+zZO45tBBppzI6xzA
         YkHMFOBZknw5rn9PDcOF/qrLeqCTqR/2cuN1UycQb9EvaUOLSzswqMtuAPa6ir5VLcSM
         Gkje3YzsFNXWiR3D3PBBbZHdHUdk4lX2NidHaMgqXwcwZRhtl+pQQcPR/WN5XypZgm+A
         XR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEPpB/hRevxsYBY+Ta3YcPygMLBZIYL7oVjMrCS5xEE=;
        b=XSpOxtqBGBId27u7SgotO0+M7gPaxu3vFcqIBCA5mrc3NM/mQFxg7d5dnQetRgQ24v
         USS1wG3O2yNs0Hz/y9m22zWQnq3786FnvNeVrUC4DJeLVXmLCkwFBGsvUeo4rp7H8PJ+
         Da4aj4to16s2yCMeVWWGhG9oMa3erXrlJFIePMjU7PZm90FrvE8iLQ6NFwMgJc8nrDDt
         qzaZDyHO70yBMDNX2kbsO2eDG5I5MyOi4BQTVXOrPqi9dRqbfsleReAv/jB0En4J2Uwg
         fkxb+RHUBMSS+t/41jL4YrfVjFDZrxbSGJsXbRiR95D0V7bgUBAjLGw8dtg/2VSLTwyM
         laqQ==
X-Gm-Message-State: APzg51DvaQR+4GpzSb3vE5/zWiUQ9wMxryyntbNe036FsOvnrY7/Z8C8
        XwAJqC3rF2kmuY7NtdrrxOTtuz5j02wVmYVowQneMQ==
X-Google-Smtp-Source: ANB0VdZgIaIX/uwA+rjFhBvwPr9+zreplrgL8yvLoIgyzmlFXEV+KGO3rmzFSojJc5K7jzRPvf+pMhdKP4H7T+6L56g=
X-Received: by 2002:a17:902:708a:: with SMTP id z10-v6mr36624142plk.229.1537393527232;
 Wed, 19 Sep 2018 14:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180919182247.1101-1-natechancellor@gmail.com>
In-Reply-To: <20180919182247.1101-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Sep 2018 14:45:15 -0700
Message-ID: <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     ilia.lin@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:22 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> the function qcom_cpufreq_kryo_probe() to the function
> .init.text:qcom_cpufreq_kryo_get_msm_id()
> The function qcom_cpufreq_kryo_probe() references
> the function __init qcom_cpufreq_kryo_get_msm_id().
> This is often because qcom_cpufreq_kryo_probe lacks a __init
> annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
>
> Add the '__init' annotation to qcom_cpufreq_kryo_probe so that there is
> no more mismatch warning.

I wonder why this driver has an exit function marked __init rather
than __exit? Does that mean it gets cleaned up after kernel init, and
so on unloading of the driver, the kernel jumps to unmapped memory?

Does this patch now produce a warning for `qcom_cpufreq_kryo_driver`
referencing `qcom_cpufreq_kryo_probe`?

>
> Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> Add '__init' to qcom_cpufreq_kryo_probe instead of removing it from
> qcom_cpufreq_kryo_get_msm_id.
>
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index a1830fa25fc5..e001ef8ea7de 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -73,7 +73,7 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
>         return version;
>  }
>
> -static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> +static int __init qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  {
>         struct opp_table *opp_tables[NR_CPUS] = {0};
>         enum _msm8996_version msm8996_version;
> --
> 2.19.0
>


--
Thanks,
~Nick Desaulniers
