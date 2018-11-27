Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8518EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6CE208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YmnfKY3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6CE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeK0MGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:06:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46552 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeK0MGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:06:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so18560530otm.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 17:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkWcpopzHxXW/iV/00jVgivQKk+wbO0XDFbFuOkxAYY=;
        b=YmnfKY3lq0HfAxk/T7Kfc4wD0KWh/tZW/9LMDWeCVrxWoekk0CFBINcTUhZuBHXF+E
         0dBNHY/tj/0EZox13Jkq6fNyQyZ7AcdY5N1wU7NzrvllXhOVL24VTxwOdJX0Ve2OeZnj
         EV9dIYHhnOaW4EHtxePg/v7/Lk6wMmMHAq1nq1qiMd0lWKzcK/oR9D5wj5uzC/bVmo3/
         AfPvVtvAZ5j1eMquS594CuLMF+oP6aaUBPDRCKsL/PibTXkphR2UTmeXx7vH0504BoQQ
         DFzH4JVCsOTbA9lw73Q3hWgxuQ4HrnGvTN+4Ma4RCL9vUhBhPdVc7NPEGisBBs3vlBz+
         f13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkWcpopzHxXW/iV/00jVgivQKk+wbO0XDFbFuOkxAYY=;
        b=d6Cmz8ab0vGAN3f6sBaIe7W63ntO31Ib1ivew1xAfEMlHDVxYQ4RNhB/qA8a+wndL/
         4qWhsnd9lJOzrwT71sNYW+sW3WomeRKwaNnq+4dTEhjqwOR4P2kLEW5mVZUcl02KCo/D
         plIpmsWHDfca8hCpJjwFDSgJowefDk0ILi/XUHsfF1BLIY0Zyc7Yn3BRaJsi7d5FakvH
         //qLljcLF6GAY0eUPrlPVmkjzpQRZlSVhcyaLUz9ng0uVg1NflaXpDTCkMY5Fsx+mUeT
         BaiMnmcaahcxtctjML+9ZeZCIZT0tbrKZpcgggOOlSK8P7WNhSw0sc//dDiIfatbEcoL
         n7ew==
X-Gm-Message-State: AA+aEWaWXvW3ulOJ1giiguE8gwQuGWnmvNIKc5XrLFZAfcGOY74OCSkS
        BvGj75I33Q5nD3Hr8hOqtay1RmJ14AuvVZZn0X2i6w==
X-Google-Smtp-Source: AFSGD/W0i8HJRl0iLpfGbyBDy92+rEjBJnCJUlO0wPQnMCNSbG2xPUlsYMekDwWzWTt5nXH28ccXO8SAH6iY6R+e5rg=
X-Received: by 2002:a9d:a78:: with SMTP id 111mr12378507otg.229.1543281029326;
 Mon, 26 Nov 2018 17:10:29 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 17:10:18 -0800
Message-ID: <CAPcyv4jZdgkJ=12GJ_CoN5Van5=Ag+mGTjJjCWtj7oGD5dBG2w@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 2/9] async: Add support for queueing on
 specific NUMA node
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
> Introduce four new variants of the async_schedule_ functions that allow
> scheduling on a specific NUMA node.
>
> The first two functions are async_schedule_near and
> async_schedule_near_domain end up mapping to async_schedule and
> async_schedule_domain, but provide NUMA node specific functionality. They
> replace the original functions which were moved to inline function
> definitions that call the new functions while passing NUMA_NO_NODE.
>
> The second two functions are async_schedule_dev and
> async_schedule_dev_domain which provide NUMA specific functionality when
> passing a device as the data member and that device has a NUMA node other
> than NUMA_NO_NODE.
>
> The main motivation behind this is to address the need to be able to
> schedule device specific init work on specific NUMA nodes in order to
> improve performance of memory initialization.

What Andrew tends to due when an enhancement is spread over multiple
patches is to duplicate the motivation in each patch. So here you
could include the few sentences you wrote about the performance
benefits of this work:

"What I have seen on several systems is a pretty significant improvement
in initialization time for persistent memory. In the case of 3TB of
memory being initialized on a single node the improvement in the worst
case was from about 36s down to 26s for total initialization time."

...and conclude that the data shows a general benefit for affinitizing
async work to a specific numa node.

With that changelog clarification:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
