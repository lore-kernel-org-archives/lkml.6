Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8139C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A771120879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170046;
	bh=fyp2QqM0UxIhWKk0lJxAf1EXGxL6PVpmbDMRYdMkbXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gXhm0wlFG6obRSZOS2HYxt5J/WOe0XZP99+VTnNN8508tiFae//aHPpwz8obpjLfb
	 A8siT0H46/CKyNf9Aa3/SOj3rWBNO0vnReq7BUKYVDSZAPhb6Hi5eYHN0x17ji8i2J
	 jRyMFNHsoLlh6nDoMqzHxPFD1wasxEajIlV7ubf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfAVPOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:14:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35993 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfAVPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:14:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so23932164otk.3;
        Tue, 22 Jan 2019 07:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcehbzQCmPckqMk4yP9uWhQubWgqQUD4lkqqSeTlaLs=;
        b=etxyJ/P7A0EbQqxf1ICzLcnpKkJhndNlCK05etwbsOhYLOcm20VIqlEZ7spYu68zQr
         TpAsfUA5O4X+KXrfAo0IO6baqFf2ltB7BxbKRC2L7BOkYBXjvETvDAEqa44YGmKIBWAR
         rizvTBTt/8PnsJiNgU6zXyHrpPCs/b7CsiiYaKcc+YcA8gjjXuRZKlgrVqgNYMYlDCAe
         VAwQ40V8xyAItNAcfCRArdW+QvaHL2ATGRZCstEA+qVIt44kLKzlDRlrPVp8TQ1W7bBr
         b/whLTRDrpELxUCt/TRdwJ0Fn9eO20z/y7z9Mibzx/+S1wMFF8frFgKOJqjTCNgho5xp
         3rQA==
X-Gm-Message-State: AJcUukeozSJ254zI4f4UvhpkEZUdnJY25uo2FVERRlv3lDjDxVAXM3mw
        w0tQq54A7sB87PWZZJU7FRL4hxePLBitLDaNzx4wY50m
X-Google-Smtp-Source: ALg8bN7QZtFYWNNdnUHkIiAqR75gzrrxG7dO+Ulz/w3wytZUPuEvfpdZT9GkVE20xkUAwtmrdufl6v0FOdFRcq7vvj4=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr23267144oti.258.1548170043485;
 Tue, 22 Jan 2019 07:14:03 -0800 (PST)
MIME-Version: 1.0
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org> <1548167070-421-2-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1548167070-421-2-git-send-email-vincent.guittot@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jan 2019 16:13:51 +0100
Message-ID: <CAJZ5v0gxYvDQZVrkQZ-eQgoQDhwRYR1x+SC_q7uxxbko0R03=w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] PM-runtime: update accounting_timestamp only when enable
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 3:24 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Initializing accounting_timestamp to something different from 0 during
> pm_runtime_init() doesn't make sense and put useless ordering constraint between
> timekeeping_init() and pm_runtime_init().
> PM runtime should start accounting time only when it is enable and discard
> the period when disabled.
> Set accounting_timestamp to now when enabling PM runtime.
>
> Suggested-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/base/power/runtime.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index fb5e2b6..7df1d05 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1306,6 +1306,10 @@ void pm_runtime_enable(struct device *dev)
>
>         spin_lock_irqsave(&dev->power.lock, flags);
>
> +       /* About to enable runtime pm, set accounting_timestamp to now */
> +       if (dev->power.disable_depth == 1)
> +               dev->power.accounting_timestamp = jiffies;

I would do this in the dev->power.disable_depth > 0 branch below.
Just check if disable_depth is zero after decrementing it and update
accounting_timestamp if so.

> +
>         if (dev->power.disable_depth > 0)
>                 dev->power.disable_depth--;
>         else
> @@ -1506,7 +1510,7 @@ void pm_runtime_init(struct device *dev)
>         dev->power.request_pending = false;
>         dev->power.request = RPM_REQ_NONE;
>         dev->power.deferred_resume = false;
> -       dev->power.accounting_timestamp = jiffies;
> +       dev->power.accounting_timestamp = 0;
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires = 0;
> --
> 2.7.4
>
