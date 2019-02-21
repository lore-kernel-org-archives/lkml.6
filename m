Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E45C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FC3214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOc0Pspe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfBUAww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:52:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37617 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfBUAww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:52:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so12831345pgq.4;
        Wed, 20 Feb 2019 16:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kh1svTHewnOx5U6FCaK99LqgmDpHgPmNQxoXvIesZCQ=;
        b=eOc0Pspetul8vaXx2WJnOOFkvVcGVQrBru5Dji/Kh+vHMmMDFX3WvMk26Ile1H0FUg
         Oq3OYmaecih9NzP1LGVN/CWRxLazuvRBz+7YvemJL9HZVwaRzvqVc+8G2WUhjAOhIAec
         Id37FYWdarMR3QyZiI9rDd+YDI5t2P+LJfAnPYbbu2FvGYXIu98pyN4UKntg4EsgMR+6
         beG37xZTOLO41ivUECsK2TURINKXEYA0IEOKH3kGMjBg21SuDjAQu/NAoHwEA/k+pMGF
         7JUbrBzEfR1TCfwZ5orX6QUIqFobANgX6UoyjgE6WqJVYTcUru7OHbNmTHuVDuCuQlnv
         T+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kh1svTHewnOx5U6FCaK99LqgmDpHgPmNQxoXvIesZCQ=;
        b=rAjLG/AzvTeqyr+94LMKqTLI3HmR6WW8OgX5ol9eT6Sd84NRqFS/jWab+mlIhw3k1K
         LoG/IhHYOMInb/5Obbm2F24LsFqQ4uZiJid63E+M6wd71F+R/KAwSUYia38iIJIHSPAu
         h2+FX6OYyvPOoMvWNUCFRZm5h+IclK36UCqvSzkK0YqjbtY4KDXQ7ShMSvyiX5M1wFdm
         PhyYblT28dVg23n6DkoIylpgkC6ECOJQjb2JmzmvpdgT0v3SetgoGqYXClkFfYyQM1xB
         uX1h9Om+VKRABNbqeHxHMnu3wfcpz1SLkOt7Qwi/QXxUBk+E061MU6mIoyA4vTeG0eWc
         H9YA==
X-Gm-Message-State: AHQUAuYRIUbIpTU7xIHz4utXt3Y61QD9IOyiDiQtmrZgkj7bPYZtf+ev
        XxvSWxbUzR2/U8BcpNqgiEY=
X-Google-Smtp-Source: AHgI3IahVw+xnfCol7D2myY4hm6xc8h9riMWaRkJY4vUfOFUlm95nDPKvVk9G87SQZd0/2+A69zkkg==
X-Received: by 2002:a62:36c7:: with SMTP id d190mr26306335pfa.178.1550710370883;
        Wed, 20 Feb 2019 16:52:50 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id u8sm243427pfi.22.2019.02.20.16.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:52:50 -0800 (PST)
Date:   Wed, 20 Feb 2019 16:52:48 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] QorIQ TMU multi-sensor and HWMON support
Message-ID: <20190221005246.GB31479@localhost.localdomain>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrey

On Mon, Feb 18, 2019 at 11:11:29AM -0800, Andrey Smirnov wrote:
> Everyone:
> 
> This series contains patches adding support for HWMON integration,
> multi-sensor support as well as a small fix and general improvements
> (hopefully) for TMU driver I made while working on it on i.MX8MQ.
> 
> Feedback is welcome!

What branch is this patch series based off?

Would you mind re-sending the series based off my -linus branch?
There has been an addition on qoriq driver to support multiple sensors
and the code has shifted and your series does not apply over there.

> 
> Thanks,
> Andrey Smirnov
> 
> Andrey Smirnov (12):
>   thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
>   thermal: qoriq: Remove unnecessary DT node is NULL check
>   thermal: qoriq: Add local struct device pointer in qoriq_tmu_probe()
>   thermal: qoriq: Don't pass platform_device to qoriq_tmu_calibration()
>   thermal: qoriq: Convert driver to use devm_ioremap()
>   thermal: qoriq: Add hwmon support
>   thermal: qoriq: Convert driver to use regmap API
>   thermal: qoriq: Enable monitoring before querying temperature
>   thermal: qoriq: Do not report invalid temperature reading
>   thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()
>   thermal: qoriq: Be more strict when parsing "thermal-sensors"
>   thermal: qoriq: Add support for multiple thremal sites
> 
>  drivers/thermal/qoriq_thermal.c | 326 ++++++++++++++++++--------------
>  drivers/thermal/thermal_hwmon.c |  28 +++
>  drivers/thermal/thermal_hwmon.h |   7 +
>  3 files changed, 214 insertions(+), 147 deletions(-)
> 
> -- 
> 2.20.1
> 
