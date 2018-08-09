Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EB7C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A9D2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxXitGb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A9D2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeHIL7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:59:11 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45659 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbeHIL7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:59:10 -0400
Received: by mail-oi0-f66.google.com with SMTP id q11-v6so8676172oic.12;
        Thu, 09 Aug 2018 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=d1UjsPKRmbNUYYEn2Qc2cNsilpOUiAEPYM1HKZXi6EE=;
        b=OxXitGb/oby1f7BsWq7x0TusX561VsSMczUb1+aoQyBJTrGWTzZgHEEsL/zvw++t7f
         DG55ktE8hETF7w77lOv9T2lixq+xKCcJYsSnSI3GlrQW61nIOEc4DDO6DpqjjEulEk9v
         EZ/FKZ286TRDGAytkLVfa7URUQmwSmDt3algm0x1NszLWlW8t/NDJMd6MPuxK9O/eoEM
         NarzdfL7W71tATryDkSODf7M4HY8qzyrUw5+vlehfR4aEE2cJfuOuuNNNEePs2FnPnS3
         vrxA624rewLgqwUGVwf91W5BR0SKtiHdG5DXtMI5WklL4DoOcuqkdGhsbtk9f28ycC3l
         D7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=d1UjsPKRmbNUYYEn2Qc2cNsilpOUiAEPYM1HKZXi6EE=;
        b=frTIYKdSXRoc+Eje6cCG9ZQspTkVSzTZXJWVtvD+Mbkk0b76UlZZ4sMrPtAb1EOKZj
         8Fn2yVsJu5h//b4e0lusxph4q+WNWv5NRHDpr4ENwSSGGuponebE7PqIGRuwRxcTtK7z
         2MlAq+Zt9qVs2kkqFQHlGOkD1GY5A1zcO/5KTw2XLLx4Ufg/SRE+SC5W2zkhfZV1w07s
         78DXCtrMThAyiDq+hxk8BKg/Rsg/EpmlbMqM0MW3ZrJxE2A9ymjsfyewEWzv0U0d0211
         5d/eyUuDHNpgj9QemXZJZk8PxNkwWRRz+fKfce0pabd/pPHaSAPMuuMB1krSUUYsjnpo
         THAw==
X-Gm-Message-State: AOUpUlFczAF/wmLIbs+psTYkHFN+J6oOZW4oyJAOGT58/+g+/L+Bitax
        zyMOAgP9lVgnkHaI3r773nZNmNWAUNrem71KoCQ=
X-Google-Smtp-Source: AA+uWPxD6yA3Wo0dml+mF39o8HBUKtlpqbQMMXB4Rz1+YE3jEuhatehEiBRd0L/ojStxlTh5mSKxQWayhg8CML+NFlY=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr1394666oie.174.1533807309373;
 Thu, 09 Aug 2018 02:35:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 02:35:08 -0700 (PDT)
In-Reply-To: <20180809091558.4317-2-hdegoede@redhat.com>
References: <20180809091558.4317-1-hdegoede@redhat.com> <20180809091558.4317-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Aug 2018 11:35:08 +0200
X-Google-Sender-Auth: DhvKaKaLKA1qBRXYK2-lzqNGwdA
Message-ID: <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 11:15 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Since commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to
> initialize ACPI_TYPE_DEVICE devs") the status field of normal acpi_devices
> gets set to 0 by acpi_bus_type_and_status() and filled with its actual
> value later when acpi_add_single_object() calls acpi_bus_get_status().
>
> This means that any acpi_match_device_ids() calls in between will always
> fail with -ENOENT.
>
> We already have a workaround for this, which temporary forces status to
> ACPI_STA_DEFAULT in drivers/acpi/x86/utils.c: acpi_device_always_present()
> and the next commit in this series adds another acpi_match_device_ids()
> call between status being initialized as 0 and the acpi_bus_get_status()
> call.
>
> Rather then adding another workaround, this commit makes
> acpi_bus_type_and_status() initialize status to ACPI_STA_DEFAULT, this is
> safe to do as the only code looking at status between the initialization
> and the acpi_bus_get_status() call is those acpi_match_device_ids() calls.
>
> Note this does mean that we need to (re)set status to 0 in case the
> acpi_bus_get_status() call fails.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> -New patch in v3 of this patch-set
>
> Changes in v4:
> -This is not a fix for acpi_is_indirect_io_slave() as I thought at first,
>  acpi_is_indirect_io_slave() calls acpi_match_device_ids() on its parent
>  device, where status is already set properly. Rewrite the commit message
>  accordingly.

I've applied the v4 of this patch and I don't think there are any
changes from it here.

As for the rest of the series I'll wait from comments from Wolfram and
the other reviewers.

Thanks,
Rafael
