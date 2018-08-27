Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F3EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A51208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/nZpka7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A51208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeH0OZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:25:37 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33921 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeH0OZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:25:37 -0400
Received: by mail-qk0-f194.google.com with SMTP id d15-v6so10103597qkc.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZufcLoUvC4E+2WQMHSQ1SqB067pP5or1Y2CBI1fJiQ=;
        b=Q/nZpka7bcWBiPCTekCW60RXPKeNmg37HToATqs7FmvAKI+oT9u+DnGiV8UBvMg1fb
         MvOEuic9Z0KnEaY9ieJqZJugo+hwOqqNKWEuSsnSIfxhSVuwelh7FDwdxiWkYcL9Czda
         W46Oc81ayAYpUzxwuh/UURp/zZkOeuwG7geM9VJHft/rBkT5JJl59m090FgGFgwOpbrJ
         XJUui8F8tsk78vQQJvzkt/slVVOqpaKIljxXNTzfJqyjgrr8OujsmmChG+HvZldm6Pjr
         9es0KMEff6hiOTFlvcqcT0Kw78RhqhYaWYrBM4xqUxyOivVWUWTpX+IyJm0ThgvMXuRJ
         GHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZufcLoUvC4E+2WQMHSQ1SqB067pP5or1Y2CBI1fJiQ=;
        b=eHVf9ObT4nxAF+QULoJrc1TyUovUAHNi6UsUBgH7LPXOA66j+fQ5HbxRlsVdt/Akh4
         McwsbGc9J9m+Q1tEtOV1+3ephHc7Djm0/KghQ8l1RR6Ie2CWzW8GF6bDY7gwFk3KE3xI
         4NXTiFsqE9i9ba17kxirDmJpBvL+7rnUxhaX3Gw1MTUOENLqkZ8lG85Agc87eV3ly5fX
         DkxPnkhZPRKNrjzosf47ACSLy00ImcF9vrluH66fWBxji5JOgGasuEefDSBLtUQ/e7kW
         bI8+TtFWg6wld5jLIuWNfPjTEcOS0Sp70gpY3IlenHTgvwG5i9wQHaLjHu2AGg13boay
         6fNg==
X-Gm-Message-State: APzg51AHovRz4QIXGI7yP3J8Tel91pNYUBF25nYvTCCksc4wC/0Cy4y0
        Qpdbojw2pGuz9y4/59tQrVji54UEY7nUpN6g/0ei3cfk
X-Google-Smtp-Source: ANB0VdYsHy45PWRqBnPBgs+15/W0iK9ZfIzKnExxcGXcnw3bxFV+f81Ft7DfxOjiXw3kKXVZdUgTUlt9AKQ3270ga4c=
X-Received: by 2002:a37:58c3:: with SMTP id m186-v6mr12754932qkb.119.1535366369860;
 Mon, 27 Aug 2018 03:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180718160956.19864-1-enric.balletbo@collabora.com>
In-Reply-To: <20180718160956.19864-1-enric.balletbo@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 27 Aug 2018 12:39:18 +0200
Message-ID: <CAFqH_50x-HONi0k1sbztPVQQGtCfuP17W-9+zTr3B=JC_CEBrw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mfd: platform/chrome: some more cleanups between
 these subsystems.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>, kernel@collabora.com,
        Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee, Benson,


Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
dia dc., 18 de jul. 2018 a les 18:11:
>
> Dear Lee, Benson,
>
> This is another patchset to try to cleanup a bit more the interaction
> between the mfd subsystem and platform/chrome.
>
> The first patch moves some cros-ec include files from include/linux/mfd to
> platform/chrome. They are specific to the lpc transport driver and are not
> related to the mfd subsystem, so, there is no reason to have them living
> in include/linux/mfd.
>
> The second patch tries to cleanup and fix some kerneldoc commments in
> the remaining mfd/cros-ec include files. For now I only improved a bit
> the documentation and fixed the warnings reported by kerneldoc. I think
> that there is still a lot of improvement pending, specially in the
> cros_ec_commands.h file, but this is something I'd like to have the
> agreement of the chromeos folks as I know this file is used as interface
> for the EC firmware. As far as I know the kernel doesn't cares about this,
> but I know this is source of conflicts for the chromeos folks.
> Usually, in the chromeos kernel, the cros_ec_commands file is synced
> with the version available from the EC firmware but maybe we should
> reconsider this and have a well documented file in the kernel and sync
> in the other way. I am just thinking out loud.
>
> Best regards,
>  Enric
>
>
> Enric Balletbo i Serra (2):
>   platform/chrome: Move mfd/cros_ec_lpc* includes to drivers/platform.
>   mfd: cros_ec: Fix and improve kerneldoc comments.
>
>  drivers/mfd/cros_ec_dev.h                     |  13 +-
>  drivers/platform/chrome/cros_ec_lpc.c         |   3 +-
>  drivers/platform/chrome/cros_ec_lpc_mec.c     |   3 +-
>  .../platform/chrome}/cros_ec_lpc_mec.h        |   6 +-
>  drivers/platform/chrome/cros_ec_lpc_reg.c     |   3 +-
>  .../platform/chrome}/cros_ec_lpc_reg.h        |   6 +-
>  include/linux/mfd/cros_ec.h                   | 214 +++++++------
>  include/linux/mfd/cros_ec_commands.h          | 295 +++++++++++-------
>  8 files changed, 322 insertions(+), 221 deletions(-)
>  rename {include/linux/mfd => drivers/platform/chrome}/cros_ec_lpc_mec.h (96%)
>  rename {include/linux/mfd => drivers/platform/chrome}/cros_ec_lpc_reg.h (94%)
>

Now that rc1 was released, a gentle ping for if you can take in
consideration these patches for 4.20.

Thanks,
 Enric

> --
> 2.18.0
>
