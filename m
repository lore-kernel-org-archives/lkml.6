Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097D3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCE521533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyHzQn44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCE521533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeIZXQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:16:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42570 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeIZXQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:16:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id z8-v6so18018219qto.9;
        Wed, 26 Sep 2018 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vuAsAFoEkV1aJPn0jXhhkTq+Dvdgmczkft8PmSYqkdk=;
        b=jyHzQn44W5EjxZE85lLQjsKAr5IrD/ohkguYY4aRYMVhFBNhnkXwoDr5UdB5f0Am6K
         x3DFEv7aDwIB/aM08d3+jq+Oh3dwxa6VfjS+lRMS7Wk1TEDvt2E/OnwdDZQ82ZZfetFn
         CuhtyulWwZGn2S5MJJSdeVoVIcKh2PO29emRl9qnCcxgU8wa3gd8kLEBfD6L0k4oPegw
         GOv+FAafHloCyyRkuL8YHKPkisXBgrATd6vmUilEHk5JD3vi5zfSo6ib/Vtm0UMBFN9+
         oixk0fEtIEmnOZpNBaUIUZxU2VV3MFbE7b3+OeIFZpLiov2Ts7d2k8rcXJR4gmtqr1Ng
         zY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vuAsAFoEkV1aJPn0jXhhkTq+Dvdgmczkft8PmSYqkdk=;
        b=d9S8YM7SYjHMG2BUP5qh/hjGEQComCGJVajBJMGoYSiAsRbcnPIyWh9uBLdJ4O4LjT
         uVBVyZlGF5UJUQr37gfwvdLd2ow+E8b/epaHgl12i1F7zKEZvd75IGmqa/pT+GaHrih5
         VA/HZUcHRIcsfTi1sf/deoGLGBisHghnOqcBmqEcRuQk6TVqjxTEEbN/knqndldvu7m9
         E2TE1YkJ3GzduknyLncTpDfAWtPd9TN8bLM31BZXZWxwlD0jbq6MA/d707hR1oG2N14R
         uuBDZrOUJbyCDg0zrfaK5h749bcCe8eNf4ens4EYsNElIWbrQqfG9gjoqFFvaD7vt8Gi
         Qd4g==
X-Gm-Message-State: ABuFfojKL7e0MjBiHjFts/zd71nxqoO5p2AoiddXgM/8vo6Oo4YLzZ98
        TFUAyowXjFhXZ61rDHYIue8sA0PdGIQATEbx2AM=
X-Google-Smtp-Source: ACcGV62IWoE/HWCTBCHrZiS8SEhV/FbxkSVHUmLb6ggVsxWkIGRept8nj9EnhNk8auYnK2GjrdLLVr7eqmZodcDpN64=
X-Received: by 2002:ac8:3c3:: with SMTP id z3-v6mr5304085qtg.39.1537981362805;
 Wed, 26 Sep 2018 10:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <1537978258-2907-1-git-send-email-mario.limonciello@dell.com>
In-Reply-To: <1537978258-2907-1-git-send-email-mario.limonciello@dell.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 20:02:31 +0300
Message-ID: <CAHp75VeGQTEZOrMbNsbsxSb4RcN1y=gAZuZ5Z6FawuU-e0+qcg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel-wmi-thunderbolt: Add dynamic debugging
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 7:11 PM Mario Limonciello
<mario.limonciello@dell.com> wrote:
>
> Some users have been reporting issues with thunderbolt being turned off
> before fully initialized.  This is suspected to be caused by userspace
> turning off the Thunderbolt controller using intel-wmi-thunderbolt
> prematurely.
>

> Details are available here:
> https://bugzilla.kernel.org/show_bug.cgi?id=201227
> https://bugzilla.kernel.org/show_bug.cgi?id=199631

BugLink: ... ?
BugLink: ... ?

I can do it myself if you are okay with this format.

The patch itself LGTM.

>
> Userspace has already made some mitigiations for this situation:
> https://github.com/hughsie/fwupd/commit/ef6f1d76983c9b66
> https://github.com/hughsie/fwupd/commit/c07ce5b4889a5384
>
> To allow easier debugging of this situation add output that can be turned
> on with dynamic debugging to better root cause this problem.
>
> Suggested-by: Mika Westerberg <mika.westerberg@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/platform/x86/intel-wmi-thunderbolt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c b/drivers/platform/x86/intel-wmi-thunderbolt.c
> index c2257bd..ce5fbf0 100644
> --- a/drivers/platform/x86/intel-wmi-thunderbolt.c
> +++ b/drivers/platform/x86/intel-wmi-thunderbolt.c
> @@ -38,12 +38,16 @@ static ssize_t force_power_store(struct device *dev,
>         input.length = sizeof(u8);
>         input.pointer = &mode;
>         mode = hex_to_bin(buf[0]);
> +       dev_dbg(dev, "force_power: storing %#x\n", mode);
>         if (mode == 0 || mode == 1) {
>                 status = wmi_evaluate_method(INTEL_WMI_THUNDERBOLT_GUID, 0, 1,
>                                              &input, NULL);
> -               if (ACPI_FAILURE(status))
> +               if (ACPI_FAILURE(status)) {
> +                       dev_dbg(dev, "force_power: failed to evaluate ACPI method\n");
>                         return -ENODEV;
> +               }
>         } else {
> +               dev_dbg(dev, "force_power: unsupported mode\n");
>                 return -EINVAL;
>         }
>         return count;
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
