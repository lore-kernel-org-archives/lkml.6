Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3C9C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEE02184C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POgGCmzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfAYVTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:19:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51730 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYVTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:19:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so8111758wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQzzqQ3+UzMnix9yquvbg7D8EhyAlAxFx9vArkHnx4w=;
        b=POgGCmzE8XS4i5eE3CynQ43OOX3OZIiQQ0nJX6EPCn8yYU6aBbg1fvNAYgUlIkCJCU
         zko869Ky5+A13BTKZTH9WGyiB3S/iPol1z+b4ZkwwMcx5cW1pdNXrzN8n17Nkc0CnPP5
         uK4RNlx6fKMXdcJJGmiyWMFgrPZdcoqewEXtEZcWs2xhr9yyytpbZ6zD8R+FcSlGlsji
         86h3en5V8qXGKs9ams7SXRThulxZsrnRPXObK/gRetalRcKOtfn8YldiV00Th535qgAW
         0pCeZ8Jh4RQjv6JV96afmHOZv3DNQvz8bC/JuR56nnjwf9arT+h2F3NDBFqOrzSaw3WK
         zUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQzzqQ3+UzMnix9yquvbg7D8EhyAlAxFx9vArkHnx4w=;
        b=F5OeVoMWHCdkS52cHAatQ+DRYLKDpiCkfYWAhvqLRajDPuDiBTDjEHfrcC5DDpTCvy
         WYDVDFh96/8JU7U02CxYVeBp88TSNaiH+eJ48OV/xyN2ILM/L0hyjHZVHXuFWsPX1z2J
         yFgkdpwFAMCb6AqOdRZeD0k9REUZQvveIBO2uid9q9pXn6htYNPp1zLVBjXsfQ7MsyUF
         IkfHFi4LudIp9cnmQ7FLMoGpDd5I5SS4cyxi8UQoHSTaCsymltUubijygywrxQlfmmPi
         La3F5vkudHFZOtdJU5ycG1puYjON1Q9opAmsGtOYOLHprqGGqpkPj0uWCM5fgs5s/9cD
         98Rg==
X-Gm-Message-State: AJcUukeAV0zy7pg4783ShlFmGnzjq9V4a2Tk4Xfd9WKMJDtLLDY4sUGx
        Lo18uB5UL+zVlRZUMUOpCGLhu5IaDO4jSk9R1RAX
X-Google-Smtp-Source: ALg8bN7irm/L6gQp/8x2VZvHpdIzHgEuxgsBUwQrPhnrokaxn4XixZGoXgbUmXLRSAjP0ncqw25NVUTTJ0lEtI2k6KU=
X-Received: by 2002:a1c:4046:: with SMTP id n67mr7847962wma.123.1548451140658;
 Fri, 25 Jan 2019 13:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231444.38182DD8@viggo.jf.intel.com>
In-Reply-To: <20190124231444.38182DD8@viggo.jf.intel.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 25 Jan 2019 15:18:49 -0600
Message-ID: <CAErSpo4oSjQAxeRy8Tz_Jvo+cRovBvVx9WBeNb_P6PxT-A_XhA@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/resource: move HMM pr_debug() deeper into resource code
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Huang Ying <ying.huang@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Jerome Glisse <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 5:21 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> HMM consumes physical address space for its own use, even
> though nothing is mapped or accessible there.  It uses a
> special resource description (IORES_DESC_DEVICE_PRIVATE_MEMORY)
> to uniquely identify these areas.
>
> When HMM consumes address space, it makes a best guess about
> what to consume.  However, it is possible that a future memory
> or device hotplug can collide with the reserved area.  In the
> case of these conflicts, there is an error message in
> register_memory_resource().
>
> Later patches in this series move register_memory_resource()
> from using request_resource_conflict() to __request_region().
> Unfortunately, __request_region() does not return the conflict
> like the previous function did, which makes it impossible to
> check for IORES_DESC_DEVICE_PRIVATE_MEMORY in a conflicting
> resource.
>
> Instead of warning in register_memory_resource(), move the
> check into the core resource code itself (__request_region())
> where the conflicting resource _is_ available.  This has the
> added bonus of producing a warning in case of HMM conflicts
> with devices *or* RAM address space, as opposed to the RAM-
> only warnings that were there previously.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> Cc: Jerome Glisse <jglisse@redhat.com>
> ---
>
>  b/kernel/resource.c   |   10 ++++++++++
>  b/mm/memory_hotplug.c |    5 -----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff -puN kernel/resource.c~move-request_region-check kernel/resource.c
> --- a/kernel/resource.c~move-request_region-check       2019-01-24 15:13:14.453199539 -0800
> +++ b/kernel/resource.c 2019-01-24 15:13:14.458199539 -0800
> @@ -1123,6 +1123,16 @@ struct resource * __request_region(struc
>                 conflict = __request_resource(parent, res);
>                 if (!conflict)
>                         break;
> +               /*
> +                * mm/hmm.c reserves physical addresses which then
> +                * become unavailable to other users.  Conflicts are
> +                * not expected.  Be verbose if one is encountered.
> +                */
> +               if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
> +                       pr_debug("Resource conflict with unaddressable "
> +                                "device memory at %#010llx !\n",
> +                                (unsigned long long)start);

I don't object to the change, but are you really OK with this being a
pr_debug() message that is only emitted when enabled via either the
dynamic debug mechanism or DEBUG being defined?  From the comments, it
seems more like a KERN_INFO sort of message.

Also, maybe the message would be more useful if it included the
conflicting resource as well as the region you're requesting?  Many of
the other callers of request_resource_conflict() have something like
this:

  dev_err(dev, "resource collision: %pR conflicts with %s %pR\n",
        new, conflict->name, conflict);

> +               }
>                 if (conflict != parent) {
>                         if (!(conflict->flags & IORESOURCE_BUSY)) {
>                                 parent = conflict;
> diff -puN mm/memory_hotplug.c~move-request_region-check mm/memory_hotplug.c
> --- a/mm/memory_hotplug.c~move-request_region-check     2019-01-24 15:13:14.455199539 -0800
> +++ b/mm/memory_hotplug.c       2019-01-24 15:13:14.459199539 -0800
> @@ -109,11 +109,6 @@ static struct resource *register_memory_
>         res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>         conflict =  request_resource_conflict(&iomem_resource, res);
>         if (conflict) {
> -               if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
> -                       pr_debug("Device unaddressable memory block "
> -                                "memory hotplug at %#010llx !\n",
> -                                (unsigned long long)start);
> -               }
>                 pr_debug("System RAM resource %pR cannot be added\n", res);
>                 kfree(res);
>                 return ERR_PTR(-EEXIST);
> _
>
