Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B7AC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6066321473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2eaEtGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfA3PtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:49:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35618 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfA3PtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:49:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so2250pfi.2;
        Wed, 30 Jan 2019 07:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/4Sbwm7veNDhyxOou4S/cQWZOP7XMI7wr7gNCAjko8=;
        b=I2eaEtGdlxi2bX8QiXpMmWr4ww0356wAZPcUNkiDDRX/ynDsNBZWGHdMQBy88eOJSv
         xEUZdMht53lWnqXkya5CnG9u5XNvaGYyZxBuIM3//+sK4WlJFz80/hdqaM9DZdkGuiG4
         vrTl4AvZr/lugCOFRM3SuAdmwsWfTcmDN1I+53c30JW2XMuVyX2D93pn8tyZ/q/wEjjV
         ogQHdSXHjp3hDTDDQSuLo8niiGKe85PUZ2JTvuZXO+J7/NiWyRYV4I9/Q3yj14rrR2oa
         k2d+IG676pm4o9hYDTPrlIjz4tKU8NjBAKoIqB/z3SF/ueYrhTuB9IsE5lUIOghLUhv7
         28jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/4Sbwm7veNDhyxOou4S/cQWZOP7XMI7wr7gNCAjko8=;
        b=rlBb30/N0aIpow8S4pud0vActLg0Ardm8vB9vyJo/qZZjZdZskp0blMegn0qona5zH
         L+ijpiWM9VDP7405RwwzoFGmy/1dvUf25d759ufEwDHC0ODL6KyLefrrYfl6EQH36qi0
         xyja8vdDr6uTVjQIp0NgKhSZJdJCCDC3smftQ2lT37yawZ6bikncg9Ni8nVPDqnacTnK
         rAU0IdDUz/OZ8+X2WAPrU6fjsVLG4tZar9u9nJIRUI2VUERHbjzZLTjGlXVkX/R9mBuC
         lgLhbvnwoRHi7jh6JEjXRbw4HQOs2bSJa9THVPUHFyNbAYE8FVBAsDy1rMZ5r7qVxnYB
         GB7A==
X-Gm-Message-State: AJcUukcGlwd25bO7HmCD9XrJaRmNRIyS3q8M48SSL32TsAacH7Cy16DE
        wzC2j9kekROoTI2Q0tE8cAOg9JtFEXVmIX1Was4=
X-Google-Smtp-Source: ALg8bN5uvZa4stdSVuq2cvWZ3yGJq4UiZLXCY7DzXJWjKXfJs/kREwdBkp7ZW3YtiKiZsSY7w+TV9L7sBtkHhQBhqUI=
X-Received: by 2002:a63:3287:: with SMTP id y129mr28107066pgy.337.1548863343017;
 Wed, 30 Jan 2019 07:49:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548860212.git.2pi@mok.nu> <830f6043839606c6ed04dfeaceeb0ce4d9cd1b54.1548860212.git.2pi@mok.nu>
In-Reply-To: <830f6043839606c6ed04dfeaceeb0ce4d9cd1b54.1548860212.git.2pi@mok.nu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Jan 2019 17:48:52 +0200
Message-ID: <CAHp75VeRVThOnL8Lo2TENB0zdcW1Sd00CL88ha6h+QGceBr7sg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] platform/x86: wmi: use MODULE_DEVICE_TABLE()
 instead of MODULE_ALIAS()
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 5:15 PM Mattias Jacobsson <2pi@mok.nu> wrote:
>
> WMI drivers can if they have specified an array of struct wmi_device_id
> use the MODULE_DEVICE_TABLE() macro to automatically generate the
> appropriate MODULE_ALIAS() output. Thus avoiding to keep both the array
> of struct wmi_device_id and the MODULE_ALIAS() declaration(s) in sync.
>
> Change all drivers that have specified an array of struct wmi_device_id
> to use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS().

Please, split this per driver basis. It would help in maintenance phase...

> Signed-off-by: Mattias Jacobsson <2pi@mok.nu>

> Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>

...and AFAIU Mario gave his tag only for Dell related stuff.

> ---
>  drivers/platform/x86/dell-smbios-wmi.c       | 2 +-
>  drivers/platform/x86/dell-wmi-descriptor.c   | 2 +-
>  drivers/platform/x86/dell-wmi.c              | 4 ++--
>  drivers/platform/x86/huawei-wmi.c            | 3 +--
>  drivers/platform/x86/intel-wmi-thunderbolt.c | 2 +-
>  drivers/platform/x86/wmi-bmof.c              | 2 +-
>  6 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/platform/x86/dell-smbios-wmi.c b/drivers/platform/x86/dell-smbios-wmi.c
> index cf2229ece9ff..c3ed3c8c17b9 100644
> --- a/drivers/platform/x86/dell-smbios-wmi.c
> +++ b/drivers/platform/x86/dell-smbios-wmi.c
> @@ -277,4 +277,4 @@ void exit_dell_smbios_wmi(void)
>         wmi_driver_unregister(&dell_smbios_wmi_driver);
>  }
>
> -MODULE_ALIAS("wmi:" DELL_WMI_SMBIOS_GUID);
> +MODULE_DEVICE_TABLE(wmi, dell_smbios_wmi_id_table);
> diff --git a/drivers/platform/x86/dell-wmi-descriptor.c b/drivers/platform/x86/dell-wmi-descriptor.c
> index 072821aa47fc..14ab250b7d5a 100644
> --- a/drivers/platform/x86/dell-wmi-descriptor.c
> +++ b/drivers/platform/x86/dell-wmi-descriptor.c
> @@ -207,7 +207,7 @@ static struct wmi_driver dell_wmi_descriptor_driver = {
>
>  module_wmi_driver(dell_wmi_descriptor_driver);
>
> -MODULE_ALIAS("wmi:" DELL_WMI_DESCRIPTOR_GUID);
> +MODULE_DEVICE_TABLE(wmi, dell_wmi_descriptor_id_table);
>  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
>  MODULE_DESCRIPTION("Dell WMI descriptor driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index 16c7f3d9a335..0602aba62b3f 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -50,8 +50,6 @@ MODULE_LICENSE("GPL");
>
>  static bool wmi_requires_smbios_request;
>
> -MODULE_ALIAS("wmi:"DELL_EVENT_GUID);
> -
>  struct dell_wmi_priv {
>         struct input_dev *input_dev;
>         u32 interface_version;
> @@ -738,3 +736,5 @@ static void __exit dell_wmi_exit(void)
>         wmi_driver_unregister(&dell_wmi_driver);
>  }
>  module_exit(dell_wmi_exit);
> +
> +MODULE_DEVICE_TABLE(wmi, dell_wmi_id_table);
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
> index 59872f87b741..52fcac5b393a 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -201,8 +201,7 @@ static struct wmi_driver huawei_wmi_driver = {
>
>  module_wmi_driver(huawei_wmi_driver);
>
> -MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
> -MODULE_ALIAS("wmi:"AMW0_EVENT_GUID);
> +MODULE_DEVICE_TABLE(wmi, huawei_wmi_id_table);
>  MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
>  MODULE_DESCRIPTION("Huawei WMI hotkeys");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c b/drivers/platform/x86/intel-wmi-thunderbolt.c
> index 9ded8e2af312..4dfa61434a76 100644
> --- a/drivers/platform/x86/intel-wmi-thunderbolt.c
> +++ b/drivers/platform/x86/intel-wmi-thunderbolt.c
> @@ -88,7 +88,7 @@ static struct wmi_driver intel_wmi_thunderbolt_driver = {
>
>  module_wmi_driver(intel_wmi_thunderbolt_driver);
>
> -MODULE_ALIAS("wmi:" INTEL_WMI_THUNDERBOLT_GUID);
> +MODULE_DEVICE_TABLE(wmi, intel_wmi_thunderbolt_id_table);
>  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
>  MODULE_DESCRIPTION("Intel WMI Thunderbolt force power driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
> index c4530ba715e8..8751a13134be 100644
> --- a/drivers/platform/x86/wmi-bmof.c
> +++ b/drivers/platform/x86/wmi-bmof.c
> @@ -119,7 +119,7 @@ static struct wmi_driver wmi_bmof_driver = {
>
>  module_wmi_driver(wmi_bmof_driver);
>
> -MODULE_ALIAS("wmi:" WMI_BMOF_GUID);
> +MODULE_DEVICE_TABLE(wmi, wmi_bmof_id_table);
>  MODULE_AUTHOR("Andrew Lutomirski <luto@kernel.org>");
>  MODULE_DESCRIPTION("WMI embedded Binary MOF driver");
>  MODULE_LICENSE("GPL");
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
