Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018D5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C489721B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Ji+mUi6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfBOQoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:44:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38221 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfBOQoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:44:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id m1so17555261otf.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNENtSq4gtxSa3KhUxwbO4/tTxp+QyVteb5iFUg4fdQ=;
        b=Ji+mUi6sP/fpcE4FWTKDKj5H+WF5Sqtemi0Y6sfsH0jOkRheQfDZAhe53ZlP2km2W6
         JhlWY1GsdrHr9Sj1LxAY2D5FXqT3I6i9Iw4qoWS2s7EfaeUEH1q4nqrOs2vemWsNgMEX
         hIPBNH3uqgDsIkYzJGjpTc3A2f9gIbR5HGrouHrYYQ2E9/FAhXeStT0OOubH7j5ElNVz
         L3FiRkzWaBN8fxBQVN+1LRBrJTNIdD7E0ekfXx2BnzxjAatiPLlsIlcigPzXP8P6MtKL
         wW13NibjcmlV8A6KCrtvKq3azra2fgslt3bFK9ixesl/i8Fgb7YCh58+7I2lKzG5rhXR
         JlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNENtSq4gtxSa3KhUxwbO4/tTxp+QyVteb5iFUg4fdQ=;
        b=h/tjBqoWWOFXTAq0M1YVH/FXmrDzVb6POU4LNrnQ4nh5hcDgFhEqJ0TTY2YF1lL88N
         3cgH77ZnOWbWNEWTDRz5l1TxEh0cFBMvRRVdpDsOTVSFmqM3VFhvjRbTYykUAniZr/AA
         UyqzlZvjnGpIzei5/A7pKfWoaBOwJkm+MYp82V1/f4/1DRoK7sMrCCoDQKUpAlxT1JDn
         UFTHLmuRSDIE1PB75nQfrS04T6R7+/Ytrrp7+WiAcLQNpiG8cbKSsPbDzFtii7Zwn4P+
         lPDF/FVsdqlxANbO2mym5OE2vPnXez14M4LgQCQh2CSPmBdtalCpHqFUO+Zw98HHl+V7
         yR7g==
X-Gm-Message-State: AHQUAubPE0s5Zz8jO43Ex5Dm7lK2raIN+jKrIykAWe0DlxupSDx76YNQ
        YyLo83N/EKaM0z+Ln/Y/7JzAZbXVd2MSGIk2xq/DQw==
X-Google-Smtp-Source: AHgI3IYxu3zjAaC3jdX2BoRSp0v3vL/4kxzlhNB6jGTSVK2f/1tFzfrQAIVOhdn3yHyOKH/qFbF8oRPwTnWhBoHmxPE=
X-Received: by 2002:a9d:37b7:: with SMTP id x52mr6663593otb.214.1550249043856;
 Fri, 15 Feb 2019 08:44:03 -0800 (PST)
MIME-Version: 1.0
References: <155017502147.944049.2893295352368862579.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155017550946.954637.8586902409974005660.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155017550946.954637.8586902409974005660.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Feb 2019 08:43:52 -0800
Message-ID: <CAPcyv4jVK-0F4BrSEb5VBn+Bq_qa4Ex5a=O=FGYdVYccf4hhzg@mail.gmail.com>
Subject: Re: [PATCH v2] nfit/ars: Allow root to busy-poll the ARS state machine
To:     linux-nvdimm <linux-nvdimm@lists.01.org>
Cc:     Erwin Tsaur <erwin.tsaur@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:32 PM Dan Williams <dan.j.williams@intel.com> wrote:
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
> Change since v1: Use mod_delayed_work() instead of queue_delayed_work()
> to modify the timeout for existing work.
>
>  drivers/acpi/nfit/core.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 934be96dc149..b1ab593a808a 100644
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
> +                       mod_delayed_work(nfit_wq, &acpi_desc->dwork, HZ);
> +               }

I added support to ndctl to specify a poll-interval to 'ndctl
wait-scrub'. The support highlighted an infinite loop problem as
mod_delayed_work() called in a loop prevented the workqueue from ever
running. A revised patch-set adds a new ARS_POLL flag to ensure that
the workqueue runs at least once after every mod_delayed_work().
