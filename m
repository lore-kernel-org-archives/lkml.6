Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05507ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5147214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2LsjepN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5147214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbeISXUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:20:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33309 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeISXUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:20:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id b97-v6so3022441plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vhyycqy1KmGUwFK9SNpx0vNthfefJkGNvICOiYVwFGQ=;
        b=Z2LsjepNTPjqqH63/XJ/aPE3az0iTbGJ9wBBR6423AsqE2+nK5vQ02HGShnWSJ16XG
         H6WAhawZGGHEbrJ8uvztQHDgHmXKEE/mS8pd1Xdj3AmC1d1GUqbUaXK61Vi2HIRqzT2s
         wcCkYUgXkp40wBMqjS/J5aheXC+15w7hmGtMsVP8UeHRZVsMCj0jrKLdkUL62Av7Msao
         +3CXaKY8/Qy7JZIyGQsFlsEmdkYQ7C5CZYXWG39fIzhSNC9cui4P22qAHyPspDz6IbnP
         nkrBQNTqDbmNi1DpABmh6eTQ9rHgBujEDkBKJTUdSm4sMjUQoYWDr+oxSL38AoAgPZEs
         8+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vhyycqy1KmGUwFK9SNpx0vNthfefJkGNvICOiYVwFGQ=;
        b=DYkhcLa9fbDZcj/aspAJpwcAnEtXF4UMYpqk4LXzTe5n5lgapE7Ej4cQYHwVLl0OlF
         xlNPzTQpDSADUo2+sTMJ/8fyMDG5VUdCys9WT3Lguav+GYDCdd7bwcXd41v8bPJbq/j9
         uhpr6ehgI5UZEbKolT5qwmZhLdNAO+cG9eTjlQl1JsR97L2UraKNFB2gF2ngBrUJtYoc
         C5K+kQvSswAIOWyljVH/Oyw6CbEn9pQUUfU7VNgQHk6aX5Mv6pwl9e3TW84icd1x00Ya
         SmPyHEVZH+PRBkn7KNPqrdXvLFwTOxtM2PxZIM4JJUvp7cXluCr9tTFYGzMqi61eF4F/
         c+4g==
X-Gm-Message-State: APzg51Bv72N77AEmxBUFxbG30nPySjGrQ4esuiz20JVRl2nbfIciThGk
        Qld37VQMfMTeRRpkb4B5s8rLA9yLEKX8wNN1usLXcg==
X-Google-Smtp-Source: ANB0VdYvR9laNddNOMQUosi3IytuTJbWo4BvB9uzOBHJwwFcj6v8o7Nd/un+Dar7O1gUeCYz371awPjRqOPAWVJOUis=
X-Received: by 2002:a17:902:7102:: with SMTP id a2-v6mr35464551pll.217.1537378878188;
 Wed, 19 Sep 2018 10:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180919060504.29281-1-natechancellor@gmail.com>
In-Reply-To: <20180919060504.29281-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Sep 2018 10:41:06 -0700
Message-ID: <CAKwvOdnrQYJQnOuh3jDGjw9gKJn64TUMeOXoet2G7v+CyRY-ZA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: qcom-kryo: Fix section mismatch warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     ilia.lin@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 11:05 PM Nathan Chancellor
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
> Remove the '__init' from qcom_cpufreq_kryo_get_msm_id so that there is
> no more mismatch warning.
>
> Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index a1830fa25fc5..4ea0afc8964c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -44,7 +44,7 @@ enum _msm8996_version {
>
>  struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
>
> -static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
> +static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)

Similar to https://lkml.org/lkml/2018/9/19/816, I think the probe
function should be marked __init instead.

>  {
>         size_t len;
>         u32 *msm_id;
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
