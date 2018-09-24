Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B64C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402A32145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQnNKnS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402A32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIYCvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:51:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45637 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeIYCvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:51:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id l2-v6so11042397qtr.12;
        Mon, 24 Sep 2018 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQkZ6TA/jGxe/7Pkpq27cMlTj3NzQNhPRKX6zIWlttw=;
        b=FQnNKnS5l461zQuywDKMFyGUwsFt7FmwjucljCdFJVnJ0rIoUy1cRnjb/Dxk/Q2OUH
         IrvAGHsSbu8tHu6auiwHuUR0FO6glcyy0nx0fbJ3bMSTLTOLcLFMcHXQe0it1lIdmxcU
         OIjaFyhdZ+OdPvclsTbRYltCbYm2StUdga6afInyMWBR5ZIjtbak83Ird4YZkTCej+/f
         dq5oDHhtbRzLUSvmTuhP5nflwvG16iloUR9m3FZ2DOIZcN68tG5CjNd8An3jwxfNEYvN
         gxwwSnnLcvcvq3dut3ujgjn2u+SDX/UzdS1aHF5jPNunL0MF6nb5bhH53ry9dHU/f5bi
         YmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQkZ6TA/jGxe/7Pkpq27cMlTj3NzQNhPRKX6zIWlttw=;
        b=gFDlpGD6iWft0ETtAx73IWO/PyhbYElD1mUf26nebGjLo3ggt5JR3O4tnvZXz7YkVq
         FVieQZxv8BRNI1mBGg+lcZTIXRmXGWI+LDBA7i8SjKQ65JYaAx7FnZUPHGo2wpqKzpAe
         AEV98/j5mSh1hOwpCUbBGl0uMO0yRYoW3IcGsqQIQXw75CPhBT7JAJSVZY/Eh/RWV0mo
         WuC9NZRhh/0Z+SgMC15VxTf3u9dMEuj06FLEuWjzXIQkcqoZhXwr4/lGvlleS8IfadTV
         RhBtZeZ6rK5C9JPWyVApEXqI63SQUSXPyYjtAq77DTdda0wGev7u1w3qGEGhCmcAnigc
         LzWg==
X-Gm-Message-State: ABuFfojnMfg/HSCNKCqPtP8Ae1OOEE4QJAF+47c1P7B+2vtoGvx6sbjE
        IftvStzpSYhY21TjY1zppGqYfSU1NSbk8gYiNhE=
X-Google-Smtp-Source: ACcGV60vvQkh1W3sQHpdRop1d6WwnyuuXSOxk4hSVQxzscFOfc5JhkPC5NKKyHIvAFDA0O1CsrmSWIDhMv5+hcwdZes=
X-Received: by 2002:ac8:29ef:: with SMTP id 44-v6mr490348qtt.174.1537822053686;
 Mon, 24 Sep 2018 13:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180924193352.96335-1-mka@chromium.org> <20180924193352.96335-3-mka@chromium.org>
In-Reply-To: <20180924193352.96335-3-mka@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 Sep 2018 23:47:22 +0300
Message-ID: <CAHp75Vet111D7SYZ4+NqcR-dr1En6R=0N7xDKM58Sms1Xh=Anw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, bgodavar@codeaurora.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:37 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Use the new API to get the BD address instead of reading it directly
> from the device tree.
>
> Also remove an unncessary pair of braces in the same area of code.
>

This looks nice!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - pass bdaddr_t instead of byte pointer + len
> ---
>  drivers/bluetooth/btqcomsmd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index 7df3eed1ef5e..ff74d2c46991 100644
> --- a/drivers/bluetooth/btqcomsmd.c
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -172,11 +172,9 @@ static int btqcomsmd_probe(struct platform_device *pdev)
>         /* The local-bd-address property is usually injected by the
>          * bootloader which has access to the allocated BD address.
>          */
> -       if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
> -                                      (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
> +       if (!device_get_bd_address(&pdev->dev, &btq->bdaddr))
>                 dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
>                          &btq->bdaddr);
> -       }
>
>         hdev = hci_alloc_dev();
>         if (!hdev)
> --
> 2.19.0.444.g18242da7ef-goog
>


-- 
With Best Regards,
Andy Shevchenko
