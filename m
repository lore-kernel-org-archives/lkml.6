Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D2C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309C320870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfBAJqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:46:55 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46206 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfBAJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:46:55 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so3585728qkf.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHvmNmdOtSPO35Cqpx7seqeQauLcX+o8JF3FZbwsoGg=;
        b=d+taBaiPRGLA8LjLmLix+stvUB9xiEvFDcxaWHQFZ8GyoTlzbzpgHWYRHSObSLLxfo
         CPipqUWxSKPLbKZbG+sIcf5wrhDa2OJyFCnReR/xWrwzK6NW4WBVaamTWW/pKlu0ln+K
         upN26rywdxsEUWSInOity72niA58bXQ6HvFJvl8boh0l1/BFbIzNl73wBHe0KFhg5jyV
         UgzhDTlgskpuLCFWaVAivVuK03olYD6VbEvD/Xv9dhCjX/8Nnsv+HHaLGt1oaULQoa9s
         Eee0MGfAphkcLxrU+RAxKdkOqbs9NrjdDWaZQpH2STl4QrM6YVx1wxX9GFSp7HqUj68u
         7GZw==
X-Gm-Message-State: AHQUAuYBVihxorjA65j0aB5QDW3K68SkMugnHm54r8NZdwKOxfzki+bj
        d7ziT5B1CYDmcZftejH/dbx2SKFHcoWydVtE1KFlLLl2
X-Google-Smtp-Source: AHgI3IZ/EnDu0uYY0AThztSpd8rxW/J3PLTAmX4DUvD+OCuhjWC1HpPw9+OMTV6jX1xBuonAujtjSfKQ4McVyRCBM0o=
X-Received: by 2002:a37:5ac4:: with SMTP id o187mr7899693qkb.282.1549014414168;
 Fri, 01 Feb 2019 01:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20190130213217.8060-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20190130213217.8060-1-srinivas.pandruvada@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 1 Feb 2019 10:46:43 +0100
Message-ID: <CAO-hwJJBrA8i=p-LbHJJbyngoht=bBqfzBt3jzQKYjOfsCADUA@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: Use VID/PID from ISH
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:32 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The Intel ISH HID can now have other devices attached to it, not just
> sensors. Hence ISH HID transport is no longer just used for sensors.
> Currently the vendor and product id is hardcoded for sensors, but they
> can be obtained from ISH firmware for the real device. The driver already
> extract them and store as part of device_info structure in client_data.
> So use vendor id/product id obtained from the ISH firmware.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---

Applied to for-5.1/ish

Cheers,
Benjamin

>  drivers/hid/intel-ish-hid/ishtp-hid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
> index e918d78e541c..bc4c536f3c0d 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
> @@ -206,8 +206,8 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
>         hid->bus = BUS_INTEL_ISHTP;
>         hid->dev.parent = &client_data->cl_device->dev;
>         hid->version = le16_to_cpu(ISH_HID_VERSION);
> -       hid->vendor = le16_to_cpu(ISH_HID_VENDOR);
> -       hid->product = le16_to_cpu(ISH_HID_PRODUCT);
> +       hid->vendor = le16_to_cpu(client_data->hid_devices[cur_hid_dev].vid);
> +       hid->product = le16_to_cpu(client_data->hid_devices[cur_hid_dev].pid);
>         snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-ishtp",
>                 hid->vendor, hid->product);
>
> --
> 2.17.2
>
