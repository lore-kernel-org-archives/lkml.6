Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34388C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D4721916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="W5e493JJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439949AbfBNU1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:27:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46138 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbfBNU1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:27:14 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so12718042otm.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/JRwKrg8/8VAJgIzEUmtU1uEot958tbEqNIlIy4wyI=;
        b=W5e493JJl2wUI1oORnwCgfhtYqH01QelSVUr+eKHBB55XsDY/PUMLQogJ5QBw8o44d
         m46B1eOq7zYXv2pGpGcq3XY8h4L576Nm1YG9NWmCLB0oMyibgQuoKmOoBZm5pWZj7dTo
         40wY2hzgrX2RhOJIeOC/9Vu0/AlzgvycQFES0G9dXLBRM96JHfNnWTHE6XTwLscCgcaR
         J/GAjTqmvucpIvutD5Vbk7ZpRqurRegsj0kuedkPUHu8eLbDr1y5hNoT4RsGTXa4Tp4d
         6LWgq8TpldmZDsDeIAWStmNISMIDhSO2S7WL3w5mQbgIO6fPbgZFZEeWsGN7Ir3ZX9w4
         Q7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/JRwKrg8/8VAJgIzEUmtU1uEot958tbEqNIlIy4wyI=;
        b=CP6WAQBdiQpZlRVj4vjYJK/bPAun/DuKNSE32CP+Pae+7d4gIwgIaip+F7XDioE8ax
         l2IRKAIQUV9KockbXYb0Sxd6YFGbkzATFlr/WHNyeJW02nsr3oMNLhL+XC/6t/Ip0Pm7
         vZYTJHc/7oDB34VCl6gorDVKNAnXsH5X9HSRXp8Ju25Ixm4FtLY0AzOI9UFln1EqhNJ6
         h1Eh+nmrh82l+NjTEB8G5DytTww2Q8SbyeHKC8EcA2bBC5gmIvV1HrnDpiOkLdijfgVN
         kSPtIv1/FeSSMwSNSQkyKKCEkoT1sU47l6E1qE23sONvA+IGY5oKvokHW3yQnVTGelMR
         zw7A==
X-Gm-Message-State: AHQUAuYS+fT15kn2b1do2P55lk4CEIKV3C+2xF8HbrJ9u8e+k4I4iLBP
        UlEm45KSxattpysARy77PMsOfOjw+4aycRsh/J8YIw==
X-Google-Smtp-Source: AHgI3IaLe5WpFZIpm3Fj7x9RyAn/ABNHVViHdagsklSm/o7ppQ1P1RouPknN+Mehp2zoJSgkprLALEOgNGPvNTS9lys=
X-Received: by 2002:a9d:7493:: with SMTP id t19mr3463144otk.98.1550176033658;
 Thu, 14 Feb 2019 12:27:13 -0800 (PST)
MIME-Version: 1.0
References: <155017500427.944049.2254497897075714747.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155017502147.944049.2893295352368862579.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155017502147.944049.2893295352368862579.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Feb 2019 12:27:02 -0800
Message-ID: <CAPcyv4g83aNP_CF+hygCEQ=9dRL9beC7vGGLQDg9=rMy2+nPfQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] nfit/ars: Allow root to busy-poll the ARS state machine
To:     linux-nvdimm <linux-nvdimm@lists.01.org>
Cc:     Erwin Tsaur <erwin.tsaur@oracle.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:23 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The ARS implementation implements exponential back-off on the poll
> interval to prevent high-frequency access to the DIMM / platform
> interface. Depending on when the ARS completes the poll interval may
> exceed the completion event by minutes. Allow root to reset the timeout
> each time it probes the status. A one-second timeout is still enforced,
> but root can otherwise can control the poll interval.
>
> Reported-by: Erwin Tsaur <erwin.tsaur@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/nfit/core.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 934be96dc149..5ec0e19760ea 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1328,6 +1328,12 @@ static ssize_t scrub_show(struct device *dev,
>                 rc = sprintf(buf, "%d%s", acpi_desc->scrub_count,
>                                 acpi_desc->scrub_busy
>                                 && !acpi_desc->cancel ? "+\n" : "\n");
> +               /* Allow an admin to poll the busy state at a higher rate */
> +               if (acpi_desc->scrub_busy && !acpi_desc->cancel
> +                               && capable(CAP_SYS_RAWIO)) {
> +                       acpi_desc->scrub_tmo = 1;
> +                       queue_delayed_work(nfit_wq, &acpi_desc->dwork, HZ);

Whoops, just realized this should be mod_delayed_work().
queue_delayed_work() is a nop if the work is already scheduled. v2
inbound.
