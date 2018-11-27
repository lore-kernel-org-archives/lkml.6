Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B9EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3336208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="abHet6se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3336208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeK0PtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 10:49:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43082 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeK0PtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 10:49:25 -0500
Received: by mail-oi1-f193.google.com with SMTP id u18so18156937oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 20:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3x30mb5WkXesOZicx6Q/Pe9DoFfuRZyew13vCeC75A=;
        b=abHet6seFflaIq1JpgxgIKcUOmNxQ54GOScxmHIyjyzdkF/c05zl/eiuRhC5GP6vAV
         mvQquc7glWua2I4R08GTEQcBV+Gbu+9su3JFfjCVKIEfv0AiBRt2u4cBI4v8HYvKyJT1
         buAetZsZhP3+RcphlN/ftxUaBZd4jud0h41BjIhKZjJukZX7z3YSsuUCvjj1N7V5wgnU
         z3ShILEPb/9Uiw2jUL7trAiwKiDl36V5ER2dDw0vB7gWYfXOrLQnsaGz+wo8TZsuHVye
         RHN5bX7uk8FrjDCcRUzuPArNHeBuoqfFkaSQWjY0cMErrYZgulTVfjwV29/hm3rVcJoe
         xXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3x30mb5WkXesOZicx6Q/Pe9DoFfuRZyew13vCeC75A=;
        b=YB5g0Q4lKbkdQRzQAmWj35kDkd1M5j82KFnwkZzu4zHiEqX8Y12N710RIlAWmfZASa
         6mqvc/0FZm4/igqtn/bi5xfGIDkafWeOV13h7wdykTI/Oi8QkwczhdYkW3X6yaGr4TeI
         p8rEIf+y5y36qofvHAfOWIyBXZ+yP091EyNjkrCcZ/3dfV/jPFkcgZ/ZdQn7WUl3U4GA
         yt/aXGRWGR6mckSNS5EGpvrw7SQJ0xsLoowVGFI0EQ97rzlD5YrvHCicHKCNEvYWAE8o
         2Ki4pbr7gkvSl6fLqnOzmBpSVvJyYBQTayB9V3FJtLeOgBhZMMblHh0+BeCdQTCdfh/w
         0jyA==
X-Gm-Message-State: AGRZ1gKKxh45P8MFvGX/oGS2FYgB+3mw4xf4wL2u+euxBUq6ZfzRQ7ZZ
        B/QZ8ExcVr2grWEwNOxnjNyDg0W727GGX28+0zRC5Q==
X-Google-Smtp-Source: AJdET5cCKw+bLg0NXn84QL7gNxO+X39gnI4vjlBgSK4BUmtWYCGRADfuHspouURKmocbTladEbcJs7ATwbeq0Mg0V/k=
X-Received: by 2002:aca:d944:: with SMTP id q65-v6mr17873643oig.0.1543294368253;
 Mon, 26 Nov 2018 20:52:48 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170044143.12967.7385910787360171117.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154170044143.12967.7385910787360171117.stgit@ahduyck-desk1.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 20:52:37 -0800
Message-ID: <CAPcyv4jWAp8UHY3Q3LaJtZ1Kw=XKK_oC9sBAwUWDrTGxyrx1Lw@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 8/9] PM core: Use new async_schedule_dev command
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Use the device specific version of the async_schedule commands to defer
> various tasks related to power management. By doing this we should see a
> slight improvement in performance as any device that is sensitive to
> latency/locality in the setup will now be initializing on the node closest
> to the device.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
