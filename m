Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B063C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D635120672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKeP5VW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D635120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeK0E7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:59:07 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39893 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeK0E7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:59:06 -0500
Received: by mail-yb1-f195.google.com with SMTP id w17-v6so7863485ybl.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+50rqAZQg4F9cniwrM8TnvkunPxG45aToI9OGlhzwM=;
        b=DKeP5VW55nSTDAUmmLDMsvPTmwBn2aH1fzyb2Nhcz7HFjrI9T2eBGeN/1aTj+HqNRV
         3FjEAvRe10PkEFILv0ZjKD++9EWNQozjfeETEdiqWouD1DwAB/fkWiRdFbW7YO+vLPrT
         Sa9SP4HSwGknA5PWOLnwW5gvxCfmeWcFEDBaT3/gbkTo5GimYjYEVXblSeiDdblG2GUX
         GNBG7D6H0dwrFKGJrFymMdYOq7OUufB4o7oERNr5yGrvtuXTVAt41Zxn8iCqHqwOdhxr
         3+lVpWk31PM/yc64p6oerMJyl47wgDOpV+UaC8QHkfbB9KHf6EO+2857nly4t6QYWE1b
         vD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+50rqAZQg4F9cniwrM8TnvkunPxG45aToI9OGlhzwM=;
        b=mejWTGbkMYxGBaoYK2dsKlXAghkPigVjzGZlk6YWU4SRhHUaTJhCF+BUcVP7lPKvsN
         F9Clk1foNMUY+1ap6TwDEk5yrYt9bnc+UdVsIzg1sTlQgbJ3HB9WemOn125+CWAH3dEh
         SJG8QuSpAyd9v61lwDPn4kB1zF4h4pFOOA3W6BxmbifblYvgiIzhy60kNcnh8p/fMVvA
         ld2tRaEQp1vriKqIBplfQg6FH4F3M5zX2unj9xnBR22/mU4Os+svJ2J5aFZB6Aelt1rV
         KmudIVBHxQf5LnQmz0Iv/vI5RRPlNOan5JMhHVTGOBxrvrYKxQ88G/6wPvcKC39+T/EL
         v3yg==
X-Gm-Message-State: AA+aEWY70bKBfKmIrrdsu8rCxJxhWujxtPErtRSb0jyvqZEPnyNesvxJ
        Qb6gWuo5jRFquVBQ7we3/qQOP3FJ7sp3UJ6Xk8DaVA==
X-Google-Smtp-Source: AFSGD/WB4QO02qSINqZBpe1wqGPDG/4oh1wRxG6dRLNEvce9UJY2Z1rrBoZteJnotLy1Ga9I+0J9hNJdiKv6Rxv0aTA=
X-Received: by 2002:a25:2206:: with SMTP id i6-v6mr28381411ybi.151.1543255124770;
 Mon, 26 Nov 2018 09:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20181126175158.5425-1-enric.balletbo@collabora.com> <20181126175158.5425-2-enric.balletbo@collabora.com>
In-Reply-To: <20181126175158.5425-2-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 26 Nov 2018 09:58:33 -0800
Message-ID: <CABXOdTdgKMGjx07+9QrmoyeRqHeYCW8xEks8Xf7C8QaGy171ig@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] mfd / platform: cros_ec: use devm_mfd_add_devices.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Mon, Nov 26, 2018 at 9:52 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Use devm_mfd_add_devices() for adding cros-ec core MFD child devices. This
> reduces the need of remove callback from platform/chrome for removing the
> MFD child devices.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v2:
> - Use devm only for the cros-ec core.
>
...

> -int cros_ec_remove(struct cros_ec_device *ec_dev)
> -{
> -       mfd_remove_devices(ec_dev->dev);
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL(cros_ec_remove);
> -

You should also remove the function declaration from
include/linux/mfd/cros_ec.h.

Guenter
