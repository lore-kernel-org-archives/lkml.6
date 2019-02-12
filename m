Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC707C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983DF20821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549964609;
	bh=ba7wTDNhZuYSLdg9vq1CV3V4C+h9uM0vcZuPpf4gF1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0WxInQac2kQPbtoQ+J69ekgcNQZdwOx+pKrLd8TaostWzyxI97JWNzxUqlKvhEj3B
	 p8kECKiEndqP1U7Wwq8kbt+AOsOCphYp7JKnL1u4tuYqTLFoJbAvc2yA7oB6diEW4H
	 000tW10gnZYXxkxtn9/3eGzx/PGOF7ITQ0Wv6qHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfBLJn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:43:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45354 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfBLJn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:43:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so3227261ota.12;
        Tue, 12 Feb 2019 01:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwxW487nPN2myU8ArfIoC4z57AXvnJ8vUQii01xHTks=;
        b=qqCdKlS31kNuOk96zslMb4wdu3GhqPetuzB9zFoGj3tZCPvWZMfV77joNxozEqio7v
         TerEl3YG7iYbYByqqprODD6nWWQzfhVApdli8AIG79uClI3zFdFEQvOIZlE8CQ/aINqk
         3gwf6Ls/DhdkCf2vcuQnQswE1pljvCPS6aE6qvMLkzoioHqFCmQ/RTVvhB69lOgX1KJ6
         ck9kb0aB7zyR8uhIwa29MaBjz1voxuLI9nJ0bCM5HH+AQ3peWPKjfFdOXyWyO74CxUpc
         d+mxKNz6huPmvZzP0EyN6bOX+r8dvmYjL94xV/8G3mKpqw4UcErv9UdmS+DrYmGZvWmR
         U/9A==
X-Gm-Message-State: AHQUAuZpB3++73QD/tpqc3Idy/BXZQNuM2pPZTP1QS3Yf0bVngD86Ght
        TSUQpLG7mA4YjRSJceelBGOGM20H4JecqtGbXUM=
X-Google-Smtp-Source: AHgI3IY5OwzVNPqjV8BhiG8gFLyW7sBqyxk4b1uMtdd8mFwE6fP4OSKneFmiSMLzGfwDAgA3B3O9Om7CxgVM09voQtE=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr2924634otl.343.1549964606562;
 Tue, 12 Feb 2019 01:43:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549955027.git.viresh.kumar@linaro.org> <8030961ef762018fc286e4d3d3a010638e900e53.1549955027.git.viresh.kumar@linaro.org>
In-Reply-To: <8030961ef762018fc286e4d3d3a010638e900e53.1549955027.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Feb 2019 10:43:13 +0100
Message-ID: <CAJZ5v0hLOD-5XDp7jAwt4EqWYGAU9VZzumNchW9_+bt7F1MdQw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] cpufreq: dt: Implement online/offline() callbacks
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 8:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Implement the light-weight tear down and bring up helpers to reduce the
> amount of work to do on CPU offline/online operation.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 7ba392911cd0..1aefaa1b0ca2 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -295,6 +295,21 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>         return ret;
>  }
>
> +static int cpufreq_online(struct cpufreq_policy *policy)
> +{
> +       /* We did light-weight tear down earlier, nothing to do here */
> +       return 0;
> +}

I think you could avoid having to add this empty stub if the core
checked for both online and offline, that is

if (driver->offline || driver->online) {
    ret = driver->online ? driver->online(policy) : 0;
} else {
    ret = driver->init(policy);
}

or similar.

> +
> +static int cpufreq_offline(struct cpufreq_policy *policy)
> +{
> +       /*
> +        * Preserve policy->driver_data and don't free resources on light-weight
> +        * tear down.
> +        */
> +       return 0;
> +}
> +
>  static int cpufreq_exit(struct cpufreq_policy *policy)
>  {
>         struct private_data *priv = policy->driver_data;
> @@ -319,6 +334,8 @@ static struct cpufreq_driver dt_cpufreq_driver = {
>         .get = cpufreq_generic_get,
>         .init = cpufreq_init,
>         .exit = cpufreq_exit,
> +       .online = cpufreq_online,
> +       .offline = cpufreq_offline,
>         .name = "cpufreq-dt",
>         .attr = cpufreq_dt_attr,
>         .suspend = cpufreq_generic_suspend,
> --
> 2.20.1.321.g9e740568ce00
>
