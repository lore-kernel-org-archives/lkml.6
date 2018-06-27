Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3FDC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBF225C59
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNguUrc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBF225C59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966351AbeF0WPz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:15:55 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43629 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeF0WPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:15:53 -0400
Received: by mail-vk0-f65.google.com with SMTP id d74-v6so2119147vke.10;
        Wed, 27 Jun 2018 15:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QR1HIs+noV83nTmLxbWob8K0X6QQc6Ic9OkwJowIKWI=;
        b=JNguUrc4K/rAbZGfglSKJgNfPuVPfW9E/p+3M/TiQRwwDTIOtMJL4sxMryTEBw0Tk3
         coqT8veOEAsrmXZLNg9fym+7d7hnWDi4rZAx3LWv5qd0dGZYJ+r3tHMf+ODVXsPmA+l+
         0Wm5wcYeM1nZP1jMSE8qXGGRdz4Dd+MnHkyHLZjNoEMNwmONNQRYZRrfezAqkLRS4uVL
         yQROazinmbOYCg+D0XrJJrvx9y81bLdXFVD611/n/pYfv8IR0NTgvDm0cbWLITU5eTvK
         nhgdpP6ZgMo+ETK6bSd72R18rGR/A75QJUJU6IE9xueJ8FZ4hhcyLz8/UdN0vfuwWFmg
         RVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QR1HIs+noV83nTmLxbWob8K0X6QQc6Ic9OkwJowIKWI=;
        b=dMVopZJ/ziDslIcij61D+d3qtvfGZUbGcieHksFLRUw40MDkGLJW24vWDZjh0jegUW
         zWm6CRYYrlVgh959se3CkB6DdLHVi1KiLO4IRFHrMoXzZM4GVHj6HmlTYTnEFy/MMuBo
         xiSuXmnVdppPc9mdISo9GxY7TZpPyUNuMcRp1gui70Vbmv0lgvHBnf1kboYOe3F6v/3P
         kBQpgZQpg7jVgv1ma6FtHGfMI/ugRIUH+eoNyB0BIBsr5Tj/MJKlULN+rljuE2IO0yzC
         xokU7wC9WzdlAn3bLyyaSY2JWVjsrg8EcSJBX0d/9lpPWC08wt8FTHJCHfsJgwxBEcWb
         AdWQ==
X-Gm-Message-State: APt69E2pbpdjUyh/8trhuEt4M8zZax+zZ/riqqDmjuczUiZw+CgFsoxE
        3yNoausNgHq0MGq/MjRzJSCSDZaKsq7yXxD/cPg=
X-Google-Smtp-Source: AAOMgper6eB5UJ2ycxGnwtoSsdwfBmrRd6Iy65U9wqMYFOU4uYZiCDNkBUyKdCyC7jiYKnXI19RGzSAiUTUi79wMNO8=
X-Received: by 2002:a1f:a8d6:: with SMTP id r205-v6mr4753831vke.129.1530137752376;
 Wed, 27 Jun 2018 15:15:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 15:15:51
 -0700 (PDT)
In-Reply-To: <20180626233454.47340-1-srinivas.pandruvada@linux.intel.com>
References: <20180626233454.47340-1-srinivas.pandruvada@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jun 2018 01:15:51 +0300
Message-ID: <CAHp75Vcn22DG0=TPdq+RYTErtaGFMf4POpuZyP9X78+9FrhLyA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel-hid: Add support for Device Specific Methods
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 2:34 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> In some of the recent platforms, it is possible that stand alone methods
> for HEBC() or other methods used in this driver may not exist. In this
> case intel-hid driver will fail to load and power button will not be
> functional.
>
> It is also possible that some quirks in this driver added for some platfo=
rms
> may have same issue in loading intel-hid driver.
>
> There is an update to the ACPI details for the HID event filter driver.
> In the updated specification a _DSM is added, which has separate function
> indexes for each of the previous stand alone methods.
>
> This change brings in support for the _DSM and allows usage of function
> index for corresponding stand alone methods.
>
> Details of Device Specific Method:
>
> Intel HID Event Filter Driver _DSM UUID:
> eeec56b3-4442-408f-a792-4edd4d758054
>
> =E2=80=A2 Function index 0: Returns a buffer with a bit-field representin=
g the
> supported function IDs.
>
> Function Index  ASL Object
> --------------------------------
> 1               BTNL
> 2               HDMM
> 3               HDSM
> 4               HDEM
> 5               BTNS
> 6               BTNE
> 7               HEBC
> 8               VGBS
> 9               HEBC
>
> One significant change is to query the supported methods implemented on
> the platform. So the previous HEBC() has two variants. HEBC v1 and
> HEBC v2. The v2 version allowed further define which of the 5-button
> are actually defined by the platform. HEBC v2 support is only available
> via new DSM.
>
> v1 Button details:
> Bits [0] - Rotation Lock, Num Lock, Home, End, Page Up,
> Page Down
> Bits [1] - Wireless Radio Control
> Bits [2] - System Power Down
> Bits [3] - System Hibernate
> Bits [4] - System Sleep/ System Wake
> Bits [5] - Scan Next Track
> Bits [6] - Scan Previous Track
> Bits [7] - Stop
> Bits [8] - Play/Pause
> Bits [9] - Mute
> Bits [10] - Volume Increment
> Bits [11] - Volume Decrement
> Bits [12] - Display Brightness Increment
> Bits [13] - Display Brightness Decrement
> Bits [14] - Lock Tablet
> Bits [15] - Release Tablet
> Bits [16] - Toggle Bezel
> Bits [17] - 5 button array
> Bits [18-31] - reserved
>
> v2 Buttom details:
> Bits [0] - Rotation Lock, Num Lock, Home, End, Page Up, Page Down
> Bits [1] - Wireless Radio Control
> Bits [2] - System Power Down
> Bits [3] - System Hibernate
> Bits [4] - System Sleep/ System Wake
> Bits [5] - Scan Next Track
> Bits [6] - Scan Previous Track
> Bits [7] - Stop
> Bits [8] - Play/Pause
> Bits [9] - Mute
> Bits [10] - Volume Increment
> Bits [11] - Volume Decrement
> Bits [12] - Display Brightness Increment
> Bits [13] - Display Brightness Decrement
> Bits [14] - Lock Tablet
> Bits [15] - Release Tablet
> Bits [16] - Toggle Bezel
> Bits [17] - 5 button array
> Bits [18] =E2=80=93 Power Button
> Bits [19] - W Home Button
> Bits [20] - Volume Up Button
> Bits [21] - Volume Down Button
> Bits [22] =E2=80=93 Rotation Lock Button
> Bits [23-31] =E2=80=93 reserved

It's hard to get if they have a common part.
If so, perhaps in the latter drop the common part and replace it with

... same as v1 ...

or alike.


> +enum intel_hid_dsm_fn_codes {
> +       INTEL_HID_DSM_FN_INVALID,
> +       BTNL_FN_CODE,
> +       HDMM_FN_CODE,
> +       HDSM_FN_CODE,
> +       HDEM_FN_CODE,
> +       BTNS_FN_CODE,
> +       BTNE_FN_CODE,
> +       HEBC_V1_FN_CODE,
> +       VGBS_FN_CODE,
> +       HEBC_V2_FN_CODE,

> +       HEBC_MAX_FN_CODES

For sake of consistency I would rather name it
INTEL_HID_DSM_FN_MAX

> +};

> +static bool intel_hid_execute_method(acpi_handle handle,
> +                                    enum intel_hid_dsm_fn_codes fn_index=
,
> +                                    unsigned long long arg)
>  {
> +       union acpi_object *obj, argv4, req;
>         acpi_status status;
> +       guid_t dsm_guid;
> +       char *method_name;
>

> +       if (fn_index <=3D INTEL_HID_DSM_FN_INVALID ||
> +           fn_index >=3D HEBC_MAX_FN_CODES)
> +               return false;
> +

> +       method_name =3D (char *)intel_hid_dsm_fn_to_method[fn_index];

Can it be const char * in the first place?

> +
> +       if (!(intel_hid_dsm_fn_mask & fn_index))
> +               goto skip_dsm_exec;
> +

> +       guid_parse(HID_EVENT_FILTER_UUID, &dsm_guid);

Perhaps we can cache this in global variable and parse only once at
init / probe time?

> +
> +       /* All methods expects a package with one integer element */
> +       req.type =3D ACPI_TYPE_INTEGER;
> +       req.integer.value =3D arg;
> +
> +       argv4.type =3D ACPI_TYPE_PACKAGE;
> +       argv4.package.count =3D 1;
> +       argv4.package.elements =3D &req;
> +
> +       obj =3D acpi_evaluate_dsm(handle, &dsm_guid, 1, fn_index, &argv4)=
;
> +       if (obj) {

> +               pr_debug("Exec DSM Fn code: %d[%s] success\n", fn_index,
> +                        method_name);

acpi_handle_debug() ?

> +               ACPI_FREE(obj);
> +               return true;
> +       }
> +
> +skip_dsm_exec:
> +       status =3D acpi_execute_simple_method(handle, method_name, arg);
> +       if (ACPI_SUCCESS(status))
> +               return true;
> +
> +       return false;
> +}
> +
> +static bool intel_hid_evaluate_method(acpi_handle handle,
> +                                     enum intel_hid_dsm_fn_codes fn_inde=
x,
> +                                     unsigned long long *result)
> +{

Same comments as per previous function.

> +}

> +static void intel_hid_init_dsm(acpi_handle handle)
> +{

Ditto.

> +}

> +
> +static int intel_hid_set_enable(struct device *device, bool enable)
> +{
> +
> +       /* Enable|disable features - power button is always enabled */

> +       if (!intel_hid_execute_method(ACPI_HANDLE(device), HDSM_FN_CODE,
> +                                     enable)) {

For me the temporary variable looks slightly better.

acpi_handle handle =3D ACPI_HANDLE(device);
...


>                 dev_warn(device, "failed to %sable hotkeys\n",
>                          enable ? "en" : "dis");
>                 return -EIO;
> @@ -129,9 +259,8 @@ static void intel_button_array_enable(struct device *=
device, bool enable)
>         }
>
>         /* Enable|disable features - power button is always enabled */
> -       status =3D acpi_execute_simple_method(handle, "BTNE",
> -                                           enable ? button_cap : 1);
> -       if (ACPI_FAILURE(status))
> +       if (!intel_hid_execute_method(handle, BTNE_FN_CODE,
> +                                     enable ? button_cap : 1))
>                 dev_warn(device, "failed to set button capability\n");
>  }


>         if (priv->array) {
> +               unsigned long long results;
> +

Seems it's not used, perhaps call it dummy instead?

>                 intel_button_array_enable(&device->dev, true);
>
>                 /* Call button load method to enable HID power button */
> -               status =3D acpi_evaluate_object(handle, "BTNL", NULL, NUL=
L);
> -               if (ACPI_FAILURE(status))
> +               if (!intel_hid_evaluate_method(handle, BTNL_FN_CODE,
> +                                              &results)) {
>                         dev_warn(&device->dev,
>                                  "failed to enable HID power button\n");
> +               }
>         }

--=20
With Best Regards,
Andy Shevchenko
