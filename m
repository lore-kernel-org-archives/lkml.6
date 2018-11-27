Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26098C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23BB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="II9mE3+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23BB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeK0PrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 10:47:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36836 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeK0PrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 10:47:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so18967728otk.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 20:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptE7XFuc75iumdx3gAaHWldfDUA75r2DCd1nrYgaBVs=;
        b=II9mE3+AYwztPIR3T/CeMxXEnm/pdaZrpssUw0wEIN6tsZX2PK4OSngetQsYgwe6Os
         iwY94rMPo4PF7QclzwudlmoCr29MY/a6OFb3oCdTJH9tbsSUHmBusCwNo18NU4czVdWf
         4BNBnVjMrcITwoM6Hk3FCgS6WA7NGEjh6ib/nWKh7m0eh3RfzP3AHoSB2Wxk+tSEakCL
         OQRY91TLSG4yLnR016YcMd7Y/EpNIvmc9lXgsV0NAUc7PvCvUWXobCa3uFdi/gTXWynK
         Fp4Gu2lrksMX7shT4T7XkEVcejSmT0XZ2wxEruLj2MlW/HlBDDhceXhR7FUT7n0zbtdV
         F7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptE7XFuc75iumdx3gAaHWldfDUA75r2DCd1nrYgaBVs=;
        b=d9NFW6AByds3mcmasuKjVIk2EE0SGtJNJTBlrsLA9DFREDFFDAKA5fMrYiicOcnJ+X
         8XdVevXfqbw69B/d1jMR9TOiTbD6cy7MIlWSCDoXiLYEjzA28ZdFHqSYq8wz85hSLUPh
         589pSjAlKrIrxOaFJZSP2VIlX4qLuR7Oe7KyGdR1C+jiVC7b5sldzEcViDQ/VVdMvDBu
         04F4azU7AJqlXcYUrhmxcS//VcKwtq2ZPbtrCl5iCwEPEPuv8xEyC/KEwpd8Ndb/H3Xh
         q1pssS8MP72RDAur7AqL0omwdzby8feBwC4Jpwg9xDsiAjSLECO4m+uInMLLIyNbI+BL
         vSpQ==
X-Gm-Message-State: AA+aEWbVXF5wbE27fc5PBubB0lXJJDqKtsdIJJ18rMXPrECY21glWtlW
        pmUORRTqdphP5YnyNgFFYJYfhdYoZ9RsejZVqUOzfw==
X-Google-Smtp-Source: AFSGD/W8iy9LfpvccKDFgoh5CImNcDx9+7S2nY2dmVLqVVykJsdbezl/k90XUtiE/zGLy16E/qTfdsr3ZVNsCEXivO0=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr17446137oti.367.1543294232858;
 Mon, 26 Nov 2018 20:50:32 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170043632.12967.5339750954964165831.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154170043632.12967.5339750954964165831.stgit@ahduyck-desk1.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 20:50:22 -0800
Message-ID: <CAPcyv4jzLes=Xj-YKSaTtg-suc9T5V0BqQoDb4scpx5m9xG-BA@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 7/9] driver core: Attach devices on CPU
 local to device node
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
> Call the asynchronous probe routines on a CPU local to the device node. By
> doing this we should be able to improve our initialization time
> significantly as we can avoid having to access the device from a remote
> node which may introduce higher latency.
>
> For example, in the case of initializing memory for NVDIMM this can have a
> significant impact as initialing 3TB on remote node can take up to 39
> seconds while initialing it on a local node only takes 23 seconds. It is
> situations like this where we will see the biggest improvement.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
