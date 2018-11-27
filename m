Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25774C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA35620659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBoQfA2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA35620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbeK1E21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:28:27 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33207 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731689AbeK1E21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:28:27 -0500
Received: by mail-yw1-f66.google.com with SMTP id q11so9491347ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bz7xMDhS+tfgS3VbdkfNRXb7f1L4LZSOAuI7RlEkDPI=;
        b=iBoQfA2IQDDmhxgU+UxVsRctRo0YXjU/yf+/ZU/4dJt8EEisNcxWStifjBmhJ3Prei
         93xDxvtOytr9J29xBvwLtjmpDH2hsFQaQV1KAn66aG+IZlUvxt29hRqQq3fHEq6Ho1eg
         JUljH/+y5nru/tjmzC5SZ8oc4BIP4fiZDN1ZT2cCJmYYJ2e3yvu4D71zvE82JYJOBbIN
         qrJczZP/amQ52dz97VVuPD9CEf9hogJXVoXMFXq+G8ENhnnm+qrCSbalUl9S7xAaBNdI
         8xC0pjRVjd+OEjtQGvqL7+LeHxAoNrasrJCagmOUjZU1oCcRQcq5i1BsbnkZjjlc9l/k
         jtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bz7xMDhS+tfgS3VbdkfNRXb7f1L4LZSOAuI7RlEkDPI=;
        b=PGHCqFAomfu70E0cbvMTFfdickpqC2BPtY5add8I6p/lEMMorfIC+rwhryoO3zTnVZ
         LcfWRziWiAEBAlDdW4E/rZY0Oo8Eai3HWg9FsmEyMg6w8gyKa+MU3LUH/dj5fSpV3Iu8
         3xch/M2hgUA7TwgolEzhcHz4PgwU+4XYu4OF1Fgiwb0ZLgL7h68V8gunJf2wLTxDne4M
         WMsXSBLGC0XTq7Rt7aROkZuXP/+hLeSt5kBGjSfEZvgX2fLubwTiALyZiPCFhslcxNrM
         mt5QIWbY4K37PAoL7w1IJ6sOeAk8Khb/ASdQuwxAbkXiq60cco+uddp+uYc5SukjfAYh
         huSw==
X-Gm-Message-State: AA+aEWZue5/juGlc5l5ORfVdQQ3T8KOQPsEH6T5S+Sv2JuS//WD+UMB8
        zgJxGOYiATR/9Gz8oVZyffxhcZiEGFbMTekINqjmyg==
X-Google-Smtp-Source: AFSGD/XNlDZZlke33y9S4l9muQ8SeO6xbo0VNsZ4CiFFgkfUjGTTCHY5oudeT2eZ1BH8S990G51DUNPIkOtyCUDO2AY=
X-Received: by 2002:a0d:eb06:: with SMTP id u6mr20498538ywe.443.1543339789967;
 Tue, 27 Nov 2018 09:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20181127121849.23975-1-enric.balletbo@collabora.com> <20181127121849.23975-9-enric.balletbo@collabora.com>
In-Reply-To: <20181127121849.23975-9-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 27 Nov 2018 09:29:38 -0800
Message-ID: <CABXOdTeL6ZC4mfGdU52bkz3-5g-EUL7wMvd-nDjmeBHWM2XSuA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mfd: cros_ec: add a dev_release empty method.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Tue, Nov 27, 2018 at 4:19 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Devices are required to provide a release method. This patch fixes the
> following WARN():
>
> [   47.218707] ------------[ cut here ]------------
> [   47.223901] Device 'cros_ec' does not have a release() function, it is broken and must be fixed.
> [   47.234430] WARNING: CPU: 0 PID: 3585 at drivers/base/core.c:895 device_release+0x80/0x90
> [   47.243560] Modules linked in: btusb btrtl btintel btbcm bluetooth ecdh_generic [...]
> [   47.323851] CPU: 0 PID: 3585 Comm: rmmod Not tainted 4.20.0-rc2+ #29
> [   47.330947] Hardware name: Google Kevin (DT)
> [   47.335714] pstate: 40000005 (nZcv daif -PAN -UAO)
> [   47.341063] pc : device_release+0x80/0x90
> [   47.345537] lr : device_release+0x80/0x90
> [   47.350001] sp : ffff00000b17bc70
> [   47.353698] x29: ffff00000b17bc70 x28: ffff8000e48e9a80
> [   47.359629] x27: 0000000000000000 x26: 0000000000000000
> [   47.365561] x25: 0000000056000000 x24: 0000000000000015
> [   47.371492] x23: ffff8000f0248060 x22: ffff000000b700a0
> [   47.377414] x21: ffff8000edf56100 x20: ffff8000edd13028
> [   47.383346] x19: ffff8000edd13018 x18: 0000000000000095
> [   47.389278] x17: 0000000000000000 x16: 0000000000000000
> [   47.395209] x15: 0000000000000400 x14: 0000000000000400
> [   47.401131] x13: 00000000000001a7 x12: 0000000000000000
> [   47.407053] x11: 0000000000000001 x10: 0000000000000960
> [   47.412976] x9 : ffff00000b17b9b0 x8 : ffff8000e48ea440
> [   47.418898] x7 : ffff8000ee9090c0 x6 : ffff8000f7d0b0b8
> [   47.424830] x5 : ffff8000f7d0b0b8 x4 : 0000000000000000
> [   47.430752] x3 : ffff8000f7d11e68 x2 : ffff8000e48e9a80
> [   47.436674] x1 : 37d859939c964800 x0 : 0000000000000000
> [   47.442597] Call trace:
> [   47.445324]  device_release+0x80/0x90
> [   47.449414]  kobject_put+0x74/0xe8
> [   47.453210]  device_unregister+0x20/0x30
> [   47.457592]  ec_device_remove+0x34/0x48 [cros_ec_dev]
> [   47.463233]  platform_drv_remove+0x28/0x48
> [   47.467805]  device_release_driver_internal+0x1a8/0x240
> [   47.473630]  driver_detach+0x40/0x80
> [   47.477609]  bus_remove_driver+0x54/0xa8
> [   47.481986]  driver_unregister+0x2c/0x58
> [   47.486355]  platform_driver_unregister+0x10/0x18
> [   47.491599]  cros_ec_dev_exit+0x1c/0x258 [cros_ec_dev]
> [   47.497338]  __arm64_sys_delete_module+0x16c/0x1f8
> [   47.502689]  el0_svc_common+0x84/0xd8
> [   47.506776]  el0_svc_handler+0x2c/0x80
> [   47.510960]  el0_svc+0x8/0xc
> [   47.514171] ---[ end trace 9087279fc8c03450 ]---
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v3: None
> Changes in v2:
> - Fix WARN when unloading. This is new in these series.
>
>  drivers/mfd/cros_ec_dev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 1ba98a32715e..cdb941c6db98 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -35,9 +35,14 @@
>  #define CROS_MAX_DEV 128
>  static int ec_major;
>
> +static void cros_ec_dev_release(struct device *dev)
> +{
> +}
> +

This tends to be a wrong solution. Problem is that object lifetime is
not necessarily tied to device lifetime. Greg KH (copied) has a much
better understanding of the problem than I do.

Guenter

>  static struct class cros_class = {
>         .owner          = THIS_MODULE,
>         .name           = "chromeos",
> +       .dev_release    = cros_ec_dev_release,
>  };
>
>  /* Basic communication */
> --
> 2.19.1
>
