Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C1ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4371E2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m12ZUazy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4371E2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeJSUpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:45:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33571 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeJSUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:45:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id 84-v6so20870031qkf.0;
        Fri, 19 Oct 2018 05:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpIHd6By5nuAJPsoG56U/syqFR6s+RFeCrjWGSEZvMc=;
        b=m12ZUazyaMBuK2fQtv041WpzQfisEh+ObllKfI5xhzSRLyKOuPpJaB+8/b9MiQ630m
         d5KL1PiDX62IPmB9WkA3FVnSpEemhdlgDDRUV5oSExvPqEuabHyqduRo19gi1ru/GoRv
         KoAgyQnQrw2NudizYMOHI7vv9nZb1fNX3+1cMG9pfYs4sC/7x/f/YMrHZHHsULk7Bn2g
         cTcVy4LQh3TopOpYtQ2M8GLlJL5ffhcJFEQGDOvmfueMYS+ZfVBe2WmtnnFgpP6ku8qr
         gc194YqkcCRu0iwV3WBjp091+0ik8dlJieBqYHvmogOZoEq1hPNAFjxVwWGXxRVF69kh
         RJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpIHd6By5nuAJPsoG56U/syqFR6s+RFeCrjWGSEZvMc=;
        b=NuC98oDd4hqCUDtk7jeNGZjsKem8s8j5bJ/wKecehMYJNQfkmz/eBk6byOGj8MsMK0
         dX0CX0WoLG/duwmCMF9wxCQxC11fSBgopAGHPqCt1m3EX32JnOa4qfe6UM4IF9tKkeO5
         YiZirNHlhrVcxczMC3Ki8L4Lr1a45L1VGZt548ypKQsIDFtXm/KeITwEOUfnwGUWZufN
         AdN82x8k77z5o93weEi0ZzRQyOsw7CkltmCjxvDFRfknVocaPSZFjVcrplh1bGo7c7qI
         +c14p0t15l4PPkUUHG4fnoc38Z0J89dhOTqDLDBq6LsjWoaZnYCWuvPwlPX4+Q7H8lt9
         7wnQ==
X-Gm-Message-State: ABuFfoiTuRROsBXfNuFoko68QRlFlAW2APvn8DnGLkwLcecJqZguEH/V
        pyum30SCye5tc70uC08a34ISfXfsy/5/5rJDCzaUGsrx
X-Google-Smtp-Source: ACcGV609tLL53HOnztfTqDNjZCnhHpt4nHjpX8U5SMiop64UIVCqk6tO/CA2+AnmP5GPbSYKmlFzmJJWdFbSA8x/zwQ=
X-Received: by 2002:ae9:f40b:: with SMTP id y11-v6mr33525409qkl.137.1539952773168;
 Fri, 19 Oct 2018 05:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com> <20181006065113.669-4-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20181006065113.669-4-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 15:39:22 +0300
Message-ID: <CAHp75VfS2cB3fh1R_iQk91skU-p+yZ_X1Jx2sBaiwHmtAZ0dpw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] platform/x86: intel_telemetry: report debugfs failure
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        matt.turner@intel.com, "Brown, Len" <len.brown@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 9:54 AM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> On some Goldmont based systems such as ASRock J3455M the BIOS may not
> enable the IPC1 device that provides access to the PMC and PUNIT. In
> such scenarios, the IOSS and PSS resources from the platform device can
> not be obtained and result in a invalid telemetry_plt_config which is an
> internal data structure that holds platform config and is maintained by
> the telemetry platform driver.
>
> This is also applicable to the platforms where the BIOS supports IPC1
> device under debug configurations but IPC1 is disabled by user or the
> policy.
>
> This change allows user to know the reason for not seeing entries under
> /sys/kernel/debug/telemetry/* when there is no apparent failure at boot.
>

Pushed to my review and testing queue, thanks!

P.S. I appended one more patch against this file, please check if it's okay.

> Cc: Matt Turner <matt.turner@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198779
> Acked-by: Matt Turner <matt.turner@intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
> Changes in v2:
>  * Removed print and out label both as suggested by Andy.
>  * changed to pr_info.
>  * Other minor style fixes.
>
>
>  drivers/platform/x86/intel_telemetry_debugfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
> index ffd0474b0531..1423fa8710fd 100644
> --- a/drivers/platform/x86/intel_telemetry_debugfs.c
> +++ b/drivers/platform/x86/intel_telemetry_debugfs.c
> @@ -951,12 +951,16 @@ static int __init telemetry_debugfs_init(void)
>         debugfs_conf = (struct telemetry_debugfs_conf *)id->driver_data;
>
>         err = telemetry_pltconfig_valid();
> -       if (err < 0)
> +       if (err < 0) {
> +               pr_info("Invalid pltconfig, ensure IPC1 device is enabled in BIOS\n");
>                 return -ENODEV;
> +       }
>
>         err = telemetry_debugfs_check_evts();
> -       if (err < 0)
> +       if (err < 0) {
> +               pr_info("telemetry_debugfs_check_evts failed\n");
>                 return -EINVAL;
> +       }
>
>         register_pm_notifier(&pm_notifier);
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
