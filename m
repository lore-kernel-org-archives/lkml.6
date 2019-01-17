Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0C0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9A320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I5hxFv/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfAQShK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:37:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41678 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfAQShJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:37:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so4802021pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=Iwme1IJBrOll4LMdbMEnsclPpzmiRPiz5uaby3aLiM0=;
        b=I5hxFv/jkLE38D/g2QLZ2U+muN4vWmD65O93e7B78rbFQl9RZjo5zcVxyLkJ9aicqe
         IqZ1k58mIJoPc/vQxLdBkSWpp2DfX0BJ4APP109iP0s/uuVm+EE4kckJGeLAg70uJHE/
         I4UPlaWJgJKAakQpeb31R7DoiTa+NETXnsrf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=Iwme1IJBrOll4LMdbMEnsclPpzmiRPiz5uaby3aLiM0=;
        b=Tw3vARORx4Va7FNV3SOiP08AXHpJpbKRxtywwDYJ79H03QTUKek8JTH5W5HkrW51Ez
         5u+s9pqWlXiyApgXbhGjfmadae6OpwZkfRnHOG/IoUDfStXKWjPtTDNDykHGVcUxQkDV
         86UTzTmCgM3zGxVSW6gmTDx9Frs0G8yAF/pVNrC3WDV8vGUway7Xso2SKhkVBO86vSVC
         PF7C95iFt67FBbJP10/LIPMd5dPYgIzO0h01T0p0JpBCCMyTO+JAaApkH/A10xvKU8CE
         BYeVMKTEqJiu5ayjke1VUUu2IYNGLvA1jG4y/FiZJjVM+L6x3db/Zd5a7UWbPWOSBxVV
         1tgw==
X-Gm-Message-State: AJcUukehFUV5nTr/ShtP4OO9mLRui4tMFnZld+Bvzl+3zH48zcwIW+Hs
        WIhhFaH5Z7HuiMjMCQjt+vqnmQ==
X-Google-Smtp-Source: ALg8bN5c6ip8oeTRd7auagE/kbJfwwUkROGSHholusOTakST1qYPB5Y9k5w0+61mgYGzxW0TbVGwCQ==
X-Received: by 2002:a63:8742:: with SMTP id i63mr14326263pge.298.1547750229112;
        Thu, 17 Jan 2019 10:37:09 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b2sm3216692pgg.87.2019.01.17.10.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 10:37:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
User-Agent: alot/0.8
In-Reply-To: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Guenter Roeck <groeck@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Message-ID: <154775022743.169631.1716489383315213219@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Thu, 17 Jan 2019 10:37:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2019-01-17 07:19:42)
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 780971318810..5dfd604477a4 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -245,6 +245,28 @@ static int qcom_wdt_remove(struct platform_device *p=
dev)
>         return 0;
>  }
> =20
> +static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> +{
> +       struct qcom_wdt *wdt =3D dev_get_drvdata(dev);
> +
> +       if (watchdog_active(&wdt->wdd))
> +               qcom_wdt_stop(&wdt->wdd);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused qcom_wdt_resume(struct device *dev)
> +{
> +       struct qcom_wdt *wdt =3D dev_get_drvdata(dev);
> +
> +       if (watchdog_active(&wdt->wdd))
> +               qcom_wdt_start(&wdt->wdd);
> +
> +       return 0;
> +}

This looks fairly generic. For example, the Mediatek driver also stops
and starts (but also pings after starting). Grepping for 'active' in
drivers/watchdog/ finds more examples. Could there be some functions in
watchdog core that do the common things like watchdog_stop() and
watchdog_start() and watchdog_start_and_ping()? Or maybe a bit can be
set during registration so that the 'struct class watchdog_class' can
get PM ops to stop and start on suspend/resume of the watchdog character
device?

Nothing is wrong with the patch, I'm just bemoaning the amount of code
duplication here.

