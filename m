Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3D5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEAA205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hN8zXXB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfBVSLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:11:11 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45069 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVSLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:11:11 -0500
Received: by mail-vk1-f194.google.com with SMTP id v187so689392vkf.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yT/oQfAp9+9b+mmKXUh+R+sclkwTdl+Hjri8aBZHc20=;
        b=hN8zXXB1FwdO4laQ6ncHvapI+ETfI8qP/oEuASL9VhTQ4HZjp3bcmKPGtCvrDhbpVC
         UODeZaqN1vFQzpGr1uJ0g5SzjwwJRUQa/1VZd+wHVgOtLx6FBolKbLchpMJ8xxqt76kn
         9JelpDgqXEaKp/hwRQb9CRvuJd4kPnaQbDtodmCTa9izMCz4kOgxbD2NuW+9AOGMlMgJ
         pzNMWOFMhiR7/ibVv/R3GevflnisAxFUy1hETREaeWkA0axje9TJlyh/xQND0x3VYorl
         vL1F3tzzOJ5HkHSdGZ2XrLAjJ/QS3lL8r8MSJKiDMe1MS+b4hxH/trpmKLV4t+ZgrxQb
         2uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yT/oQfAp9+9b+mmKXUh+R+sclkwTdl+Hjri8aBZHc20=;
        b=XIk3T5OFmTVBM8D9JX7XMSRxKrSkucB6gl0roFgAj4m2PDhLvR3SYF08y61lSPpaDO
         sShZ0LliQMlVJ5oyyPSvktuFZ+4tir3lDEhjxM/0ZWhjc/nt7uWxjGK4gENqIEz0/E4w
         YIS0bSzqH7zLOkUSWbg+8VQhNCjfzOcxbMT5LlqdfnTm6HkkeMKQaP1P11KMTYlnnz8x
         k114xxrzBcE9Hp7qMUubvNLize47R/eS0/al+PSQi1jMZ7lSutKxq7mK5kGuhh5P1xqR
         EZV5YgK/kDnhVyNrFBNq5RaWH4qBaKH8hDgkqyvFsX7Qe+V0sjarAFMbesl83HQy0Jhn
         DaBg==
X-Gm-Message-State: AHQUAubTcFu7uYwcgG+/UMw+Tcy9H5yENh9cbdbFTB+cxiBWwZ/X6Qpq
        855IA+HkwB6f2kUZ+cCn1diY75JxTEwv1MFtWCQxmQ==
X-Google-Smtp-Source: AHgI3IasjouTzqvQPhLd82rqPY1isLQKXkGRT6ykJaQKsmqL0Wc9qRNmUqD3eGOUBqVTp7yd919NM/Z/nG+4YCYvMSs=
X-Received: by 2002:a1f:8191:: with SMTP id c139mr3023777vkd.24.1550859069498;
 Fri, 22 Feb 2019 10:11:09 -0800 (PST)
MIME-Version: 1.0
References: <21c17b44-af9b-2f18-f109-ba4bb0635e61@linux.intel.com> <20190222082829.75567-1-xmdong@google.com>
In-Reply-To: <20190222082829.75567-1-xmdong@google.com>
From:   Jis Ben <jisben@google.com>
Date:   Fri, 22 Feb 2019 10:10:58 -0800
Message-ID: <CADChb=mw2YUTJXZnFbeXhVThuuQgFofQybzmh=foC71UT=b1Qw@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
To:     James Dong <xmdong@google.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An NVMe device configured in static identity mapping should also cause
this error when removed and rescanned. Essentially, a device that does
a DMA when its driver inits, or one that you can force a DMA from.

-Jis


On Fri, Feb 22, 2019 at 12:28 AM James Dong <xmdong@google.com> wrote:
>
> Baolu:
>
> The reproduction depends on devices. HW passthrough PCIe devices with default
> identity map could have the issue. Make sure that messages like following came
> out in dmesg and their mapping does not change after booting:
>   [   10.167809] DMAR: Hardware identity mapping for device 0000:30:00.0
>   [   10.167823] DMAR: Hardware identity mapping for device 0000:30:00.1
>
> Devices which make following true could also be used for the experiment:
>   > static int iommu_should_identity_map(struct device *dev, int startup)
>   > {
>   >             if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
>   >                     return 1;
>   >             if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
>   >                     return 1;
>
> Once they are up, remove them first by following command:
>   echo 1 > /sys/bus/pci/devices/0000\:03\:00.1/remove
>
> Then trigger the hotplug device rescanning:
>   echo 1 > /sys/bus/pci/rescan
>
> To provide an example of specific devices on the market, I need to try out.
> Or, if it is fine with you, forcing a PCIe NIC card to be default hardware
> passthrough by changing the intel-iommu.c is another easy way to reproduce
> this issue.
>
> Best Regards,
> James
