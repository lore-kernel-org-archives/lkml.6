Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E469EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE77020855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548158650;
	bh=064ppCc6jyYK7LoC148H5B1oJ4PUXOfuAuS7Oy1kB8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=THgfjHE702Lvmd8Fvuxzu9XctmrNH9J3tMxyZLK3Ei6uihrDxQVWuXkqPxMQimIdv
	 5zUnBK8QlCgy4Ukuui4c06tZ7Kj68li9HzJliV27VtFzjD+CzQKQa24Hgmuy/ZXNWg
	 uMcZy7V4UHIZmNWd7Q5mayfM8zcIPdtxfjln0iDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfAVMEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:04:08 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44750 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfAVMEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:04:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so17150139oig.11;
        Tue, 22 Jan 2019 04:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3RxyDj7X7D9bq3pbSI/QFL5CqFU2HQD3I4etwDkrlA=;
        b=MzeafQ9rB4kNj7b5OPM1hp10fJj40ZadKHoFz0lABCpk63cbkq8UMp9q9gepZSM9/E
         XSGpkRvdGWJlBerpAV2tr8UkrYiewJaHP8Y8iSZhn8Na5+0zFm49nJtse+0VGqCWrBSu
         wifLPR10V+ADfLqN2AuukWNRfhP1x2J+aa+iOy0mqlcK+oZKzGqp2v4QqgGk9778mT21
         fywYH0eqeXFnatR2DD65CiGXy3pbC/tdwCRWRucqlLgVK40dp0XR7NY3eCqgMXURxqLk
         IcadjfTIQFVtA/9Oew5Qzpi7Uo//AfpHJfPgpBgfP6JA1vWqQ1xbQskCtuUX2z0Vdluy
         fYlQ==
X-Gm-Message-State: AJcUukdYt7rxdwt6GhXesiXGrubRtk2Ff3vu2DvMZNF/+i+rXuhqnY4p
        zm7a+Qicr495t2eEvdSGYlHV3gU6SNcTw32y3O12Mg==
X-Google-Smtp-Source: ALg8bN5zX0JbtFiboavrLFCwUs8GZqI4zXuVl9iMugpgsSk6dpboDBTReLUV8SO7P6/UhaArBp2RMqL1Tt98wdNVSpU=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr8391117oia.95.1548158646916;
 Tue, 22 Jan 2019 04:04:06 -0800 (PST)
MIME-Version: 1.0
References: <2897234.rJkq6cDEjt@aspire.rjw.lan> <6098592.dL5p0bd45o@aspire.rjw.lan>
In-Reply-To: <6098592.dL5p0bd45o@aspire.rjw.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jan 2019 13:03:55 +0100
Message-ID: <CAJZ5v0hpR2rVnzKUqzEB=vTWsZ6uGDrKrwsc=w_uPRF65TRQ_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: EC: Simplify boot EC checks in acpi_ec_add()
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 1:01 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Consolidate boot EC checks in acpi_ec_add(), put the acpi_is_boot_ec()
> checks directly into it and drop the latter.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This is the second patch in the series, the numbering in the subject
is incorrect.  Sorry about that.

> ---
>  drivers/acpi/ec.c |   20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1558,16 +1558,6 @@ static bool acpi_ec_ecdt_get_handle(acpi
>         return true;
>  }
>
> -static bool acpi_is_boot_ec(struct acpi_ec *ec)
> -{
> -       if (!boot_ec)
> -               return false;
> -       if (ec->command_addr == boot_ec->command_addr &&
> -           ec->data_addr == boot_ec->data_addr)
> -               return true;
> -       return false;
> -}
> -
>  static int acpi_ec_add(struct acpi_device *device)
>  {
>         struct acpi_ec *ec = NULL;
> @@ -1579,22 +1569,22 @@ static int acpi_ec_add(struct acpi_devic
>         strcpy(acpi_device_class(device), ACPI_EC_CLASS);
>
>         if (!strcmp(acpi_device_hid(device), ACPI_ECDT_HID)) {
> -               is_ecdt = true;
>                 ec = boot_ec;
> +               boot_ec_is_ecdt = true;
> +               is_ecdt = true;
>         } else {
>                 ec = acpi_ec_alloc();
>                 if (!ec)
>                         return -ENOMEM;
> +
>                 status = ec_parse_device(device->handle, 0, ec, NULL);
>                 if (status != AE_CTRL_TERMINATE) {
>                         ret = -EINVAL;
>                         goto err_alloc;
>                 }
> -       }
>
> -       if (acpi_is_boot_ec(ec)) {
> -               boot_ec_is_ecdt = is_ecdt;
> -               if (!is_ecdt) {
> +               if (boot_ec && ec->command_addr == boot_ec->command_addr &&
> +                   ec->data_addr == boot_ec->data_addr) {
>                         /*
>                          * Trust PNP0C09 namespace location rather than
>                          * ECDT ID. But trust ECDT GPE rather than _GPE
>
