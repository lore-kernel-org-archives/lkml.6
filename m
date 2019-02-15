Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58295C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAB621B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDJX3v8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfBOK23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:28:29 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39225 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfBOK22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:28:28 -0500
Received: by mail-vk1-f194.google.com with SMTP id f206so2118600vke.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PINAiX8dc70wZC+Nch/uydyj/BSPov6DEeJ3MPB8ves=;
        b=WDJX3v8WBUumz0bXoytEnZEopdDo9uP4mTCKwHpJgm8sofqcYilluzsW0Eu96U9zng
         LfA97r8vJpy9pmRM6RQt6XdsQ6D5honYS8vUmx8jF9m6Qt/+AZpNqgPWvFpaHNWUlIES
         mlPueLi+6VVUJEVbYOjDJ85ttkJytXDDNvDhDWHwrnmyBW1skSCnioxQcgy8fdCVPc4k
         Ld2GVZ7qV71Os1mDZq8lPAEAVeAqjKCYaoSgptUPY2oYQ6pjGf8hbC6ZhPlVncJNTgw6
         rfTyHiZJ+utXmX3zb4/xnQJFBLemMoc8iiPPNDowPQCkiHdNWxe+7cNYF8iJlyamcXI6
         Bxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PINAiX8dc70wZC+Nch/uydyj/BSPov6DEeJ3MPB8ves=;
        b=MQsroFVfuVMxu23PaVoFUhEHNBBJxbnRKhw2/W/AYYV2uyvLfS2ebJ4k0HCQeK+KJ5
         lMVIq/wxrF0KbI9Mqb7Ti0QS7Ma/7d05PE16dodEdGw+dTZ9tTULJyTRs4dRsS7gF46r
         0BKE0WliD7V39A0r5q60201aCtV3gvEhX+mNcUVYP5pQj1jYz09RCObXUFbLGnyCKohh
         Xz7L7f7xER7RmsKTGCKJsdHIPhiA28TSIgOb+TLKTip9DKtuoZu6YCDrhHgOjp+EfQQy
         4HmA75hK5NjMFKPechSmPqrvsq8Wt5vlfDru/j5ohoCw0I4KgpL1yurS9UzuTcXkCnQn
         F98Q==
X-Gm-Message-State: AHQUAuZ1oojvCIB4e6ReAtE+BAfxUODnAXwC6hJ2cDihVFFILmlQN1pH
        AO1jjlRFsU6J35lKWq3vJoIphsY+mxB9Mzw7exiEyQ==
X-Google-Smtp-Source: AHgI3Ia+cjWXCuC/mW7RsW5u4jk5EOyOZSbqSju3x3nRvTQZYyUxB+xV0MtPrLkwxL2Cfo/xzmKUWey3cWaNB9VUY7E=
X-Received: by 2002:a1f:d005:: with SMTP id h5mr4517280vkg.4.1550226506020;
 Fri, 15 Feb 2019 02:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20190214181249.2749-1-dianders@chromium.org> <20190214181249.2749-2-dianders@chromium.org>
In-Reply-To: <20190214181249.2749-2-dianders@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Feb 2019 11:27:50 +0100
Message-ID: <CAPDyKFpXc+0rAHOgKN+QDK0MH-4efUZJ8asuBkAwg+w73huzOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / Domains: Mark "name" const in dev_pm_domain_attach_by_name()
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
> As of the patch ("PM / Domains: Mark "name" const in
> genpd_dev_pm_attach_by_name()") it's clear that the name in
> dev_pm_domain_attach_by_name() can be const.  Mark it as so.  This
> allows drivers to pass in a name that was declared "const" in a
> driver.
>
> Fixes: 27dceb81f445 ("PM / Domains: Introduce dev_pm_domain_attach_by_name()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Perhaps fold $subject patch into patch1, they seems highly related.
Anyway, no strong opinion here.

Kind regards
Uffe

> ---
>
>  drivers/base/power/common.c | 2 +-
>  include/linux/pm_domain.h   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index b413951c6abc..22aedb28aad7 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -160,7 +160,7 @@ EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_id);
>   * For a detailed function description, see dev_pm_domain_attach_by_id().
>   */
>  struct device *dev_pm_domain_attach_by_name(struct device *dev,
> -                                           char *name)
> +                                           const char *name)
>  {
>         if (dev->pm_domain)
>                 return ERR_PTR(-EEXIST);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 203be5082f33..1ed5874bcee0 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -341,7 +341,7 @@ int dev_pm_domain_attach(struct device *dev, bool power_on);
>  struct device *dev_pm_domain_attach_by_id(struct device *dev,
>                                           unsigned int index);
>  struct device *dev_pm_domain_attach_by_name(struct device *dev,
> -                                           char *name);
> +                                           const char *name);
>  void dev_pm_domain_detach(struct device *dev, bool power_off);
>  void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
>  #else
> @@ -355,7 +355,7 @@ static inline struct device *dev_pm_domain_attach_by_id(struct device *dev,
>         return NULL;
>  }
>  static inline struct device *dev_pm_domain_attach_by_name(struct device *dev,
> -                                                         char *name)
> +                                                         const char *name)
>  {
>         return NULL;
>  }
> --
> 2.21.0.rc0.258.g878e2cd30e-goog
>
