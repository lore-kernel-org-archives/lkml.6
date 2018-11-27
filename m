Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20F52146F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UrSrkcc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20F52146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeK0L53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:57:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39189 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbeK0L53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:57:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so6163667oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 17:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQ7nONK8cOdTAxJGznQAP2rEX4jRNiKILVq1drt4mak=;
        b=UrSrkcc7z9Yd4NRYVZ/CM+Jiwvtuli/fxa4GCewTGQbKocpklTDekO8WUx2KSzVAWp
         y0NQHDq4yYC1b+A9B5/rXdb4vEbvxE15JimI/MnkNIiVJsqWWjI+xF4L4hknWUq0TtWo
         SXTq2O1iaEpu+XtJD4LkEDmn0w1PSG86q5WjuL849b5X/hproxa6sDelCrvSvjwhmKes
         HcusQ0ov6xSpZZkjYDptJLsD/5xeTtDygCqquXbKaY9tbirHy26GKF4/+JZwL+e0bPDZ
         C+NdMEQ1gte1dV3mYRtF4i7ghBOirFG9GCPLfttXKj+ERI9RyRgYHa4AMnuQ2/TG+Cmu
         0nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQ7nONK8cOdTAxJGznQAP2rEX4jRNiKILVq1drt4mak=;
        b=dQtiJGg/NifzWCf9HWK4r318Zu54BwCuDAtVC65aUttSYX7XNBB6o26fua1ob6PNdG
         JYaP6g/HZ93uphJmfb3J6OYnpbEd5ExnwjnFBf6hy96kkdHokiH5E9+fNryRLhZta39z
         T3lZc1l/FXDawvcw73/qcDg0ueTKaf/EjEHXPtovZw/JrL8XRoTOZW6PeJqIcaDVSlb6
         XlUfM3CRMYYdDxf8UTGvwllO/WdlTm1xSoUMAHxwZe5JdNUtQne63GXaDOJ/7gOJ8cb7
         KoW1HM4+7GLpxhQd20BLYwG8rZb4WRZk9bICGwF3bfhioBBhdJ/fOiovdCQi/tM2ygXz
         3U3Q==
X-Gm-Message-State: AA+aEWaDSBF0HH+i0P0dHRU+ji7SbnkyXxAGPDankcY2/T5LIhHnPN/w
        rH0KgvCOdOX3oPdU6Ji1nL4SpSuX2smw592CaIbjJA==
X-Google-Smtp-Source: AFSGD/W2WI+qAZ+fShsTrKX67Z+tjLxn5JLhIKR+EGgT/1w6WgD3hcP0DmSdkPLi/VOwgPgcjuc+h4OJ0LzZFhgkKQU=
X-Received: by 2002:aca:5205:: with SMTP id g5mr1034965oib.149.1543280485480;
 Mon, 26 Nov 2018 17:01:25 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170040562.12967.17831655390715808287.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154170040562.12967.17831655390715808287.stgit@ahduyck-desk1.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 17:01:14 -0800
Message-ID: <CAPcyv4j5P7OWbof8gMUmFRswR4YVQAJEZTAPNGhUup_y3XRYiw@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 1/9] workqueue: Provide queue_work_node to
 queue work near a given NUMA node
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

On Thu, Nov 8, 2018 at 10:06 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Provide a new function, queue_work_node, which is meant to schedule work on
> a "random" CPU of the requested NUMA node. The main motivation for this is
> to help assist asynchronous init to better improve boot times for devices
> that are local to a specific node.
>
> For now we just default to the first CPU that is in the intersection of the
> cpumask of the node and the online cpumask. The only exception is if the
> CPU is local to the node we will just use the current CPU. This should work
> for our purposes as we are currently only using this for unbound work so
> the CPU will be translated to a node anyway instead of being directly used.
>
> As we are only using the first CPU to represent the NUMA node for now I am
> limiting the scope of the function so that it can only be used with unbound
> workqueues.
>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>
