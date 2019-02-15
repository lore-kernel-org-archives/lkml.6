Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB18EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D6921924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9Y9aZ4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfBOK2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:28:33 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:46197 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfBOK2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:28:31 -0500
Received: by mail-vk1-f195.google.com with SMTP id j68so2102666vke.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLBd3lhZPfXWMH7Ws28iyP7cbmLb4ZgLVBr3D/WvZKU=;
        b=g9Y9aZ4K7fz42Ls6vZS0HdjFuG+W5XAuB+UXyA8B+my0s4owUijZQ5q423wHpJvj+R
         DmgGUoqXEMaI8W/ztT9ReESSroTPNfOd38EOovBrGtXvbOnfDLo1rGXDbBnOVCPiv7Du
         S/fiNruzTWtxPiEyppBcy9L+Gr2mhjKdfD5m97y7Er527lpTPmbNu8kpW1ut+f6OyI5M
         csiSc0JGb93zfl4PFG27euQc559F0o6P113HXA5O1EbAQklEIwI/bV90FAJUfROCR8dP
         uGF5dPA9ixG6QFcqzC/12bXqwlutCvT1jU+T4rTCSzeqBpG3BcFtetdH30aMdxuXVwDl
         brJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLBd3lhZPfXWMH7Ws28iyP7cbmLb4ZgLVBr3D/WvZKU=;
        b=ibQ/loUO0vuMfTxFyTmuR2qYmPfMn7LP3mvfpnCuuGQBo1qnxuThivqm6aSC4GnzJI
         SFyIrHJwY/7YiiTgEmW8VF4a5BTax2lYg9wm1UQnaPWEFRNqfU24jXmx3LaOnWGJ/Wa5
         8h7QKbIBepyb9HfulHZEQOVeyd1qUHd9n4xInFkq5RAyngiT6xex9MnrcHm63eCBl8np
         ftvENyx3+nK4wU8pz90PVqmRzUfavL6U5QBOPwQeDiGwyww4jymqucJHyZLoEeqOrlDW
         N+W7YkJG5VPbVMTQEJq8lvQ7Vk9RpS4OLx9uV48dmfzbQoYiyZ9V+jsqg2LZT5wElIgG
         v8GQ==
X-Gm-Message-State: AHQUAub6910Vqb0hAT8gVVLBgL7jFd96098xmS5zw19U1VVyQ9nFu3Ms
        gOBv46VgpWeoONOUhGupKYzsBRyU6e37wYlZ2GGTJg==
X-Google-Smtp-Source: AHgI3IZ2QL1QAe9kob+NyrFfaj5kFTeFY8cZFOeoBoXqWycTnNnSRsVZkMVca99N/Vgs+k+QfgHE4bVF2LKz9T5+S1I=
X-Received: by 2002:a1f:9042:: with SMTP id s63mr4427887vkd.17.1550226510162;
 Fri, 15 Feb 2019 02:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20190214181249.2749-1-dianders@chromium.org>
In-Reply-To: <20190214181249.2749-1-dianders@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Feb 2019 11:27:54 +0100
Message-ID: <CAPDyKFpw8Fwgc8QjjhjuxcW7zJp1-kqcKC4RAs65S8Jr5H=uYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / Domains: Mark "name" const in genpd_dev_pm_attach_by_name()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 at 19:13, Douglas Anderson <dianders@chromium.org> wrote:
>
> The genpd_dev_pm_attach_by_name() simply takes the name and passes it
> to of_property_match_string() where the argument is "const char *".
> Adding a const here allows a later patch to add a const to
> dev_pm_domain_attach_by_name() which allows drivers to pass in a name
> that was declared "const" in a driver.
>
> Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device by name to genpd")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>
>  drivers/base/power/domain.c | 2 +-
>  include/linux/pm_domain.h   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 45eafe8cf7dd..2c334c01fc43 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2483,7 +2483,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
>   * power-domain-names DT property. For further description see
>   * genpd_dev_pm_attach_by_id().
>   */
> -struct device *genpd_dev_pm_attach_by_name(struct device *dev, char *name)
> +struct device *genpd_dev_pm_attach_by_name(struct device *dev, const char *name)
>  {
>         int index;
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index dd364abb649a..203be5082f33 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -271,7 +271,7 @@ int genpd_dev_pm_attach(struct device *dev);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>                                          unsigned int index);
>  struct device *genpd_dev_pm_attach_by_name(struct device *dev,
> -                                          char *name);
> +                                          const char *name);
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>  static inline int of_genpd_add_provider_simple(struct device_node *np,
>                                         struct generic_pm_domain *genpd)
> @@ -324,7 +324,7 @@ static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  }
>
>  static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
> -                                                        char *name)
> +                                                        const char *name)
>  {
>         return NULL;
>  }
> --
> 2.21.0.rc0.258.g878e2cd30e-goog
>
