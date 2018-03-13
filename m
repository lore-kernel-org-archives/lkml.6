Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeCMRUp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:20:45 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:37314 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeCMRUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:20:44 -0400
X-Google-Smtp-Source: AG47ELvq+GdyHV01XHqGPyMgRLd8eW4y2o4vNWPJKw9uh95A+gLt9poEWVU26E5KDHl67NsF7iidwU2P2ApSMHw1B1U=
MIME-Version: 1.0
In-Reply-To: <152055669123.63229.1692099069085978884.stgit@sosxen2.amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com> <152055669123.63229.1692099069085978884.stgit@sosxen2.amd.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 19:20:42 +0200
Message-ID: <CAHp75Vfc+JTjU2P0GCedVFcHYniXoVcmRC3n4cFsLMr9sx6eyA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iommu/amd - Add a debugfs entry to specify a IOMMU
 device table entry
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 2:51 AM, Gary R Hook <gary.hook@amd.com> wrote:
> Initially (at boot) the device table values dumped are all of the
> active devices.  Add a devid debugfs file to allow the user to select a
> single device table entry to dump (active or not). Let any devid value
> greater than the maximum allowable PCI ID (0xFFFF) restore the
> behavior to that effective at boot.

> +               oboff += OSCNPRINTF("%02x:%02x:%x (%u / %04x)\n",
> +                                   PCI_BUS_NUM(amd_iommu_devid),
> +                                   PCI_SLOT(amd_iommu_devid),
> +                                   PCI_FUNC(amd_iommu_devid),

Perhaps at some point we will have an extension to %p to print PCI BDFs.

> +       if (strnchr(obuf, OBUFLEN, ':'))
> +       {

Style

> +       } else if (obuf[0] == '0' && obuf[1] == 'x') {
> +               n = sscanf(obuf, "%x", &amd_iommu_devid);
> +       } else {
> +               n = sscanf(obuf, "%d", &amd_iommu_devid);
> +       }

kstrtoint() ?

-- 
With Best Regards,
Andy Shevchenko
