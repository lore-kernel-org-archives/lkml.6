Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeCMU4d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:56:33 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:46434 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeCMU4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:56:31 -0400
X-Google-Smtp-Source: AG47ELvHRR9Z22pxKL8iatyHz7oOXpI7diL1ngwf/cBBSXrtfOf/bGhzptiq4kCnLM0WPpHWhdL8UGl7oKOmWJlp3r0=
MIME-Version: 1.0
In-Reply-To: <3969f155-c3bf-44c5-d056-825e71d42152@amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
 <152055669123.63229.1692099069085978884.stgit@sosxen2.amd.com>
 <CAHp75Vfc+JTjU2P0GCedVFcHYniXoVcmRC3n4cFsLMr9sx6eyA@mail.gmail.com> <3969f155-c3bf-44c5-d056-825e71d42152@amd.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 22:56:30 +0200
Message-ID: <CAHp75VcuYamhrEu=B1zeFpz6s1vGfZaMyonYK6p_Y_EJF4=4Ng@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iommu/amd - Add a debugfs entry to specify a IOMMU
 device table entry
To: Gary R Hook <gary.hook@amd.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 8:54 PM, Gary R Hook <gary.hook@amd.com> wrote:
> On 03/13/2018 12:20 PM, Andy Shevchenko wrote:

>>> +       } else if (obuf[0] == '0' && obuf[1] == 'x') {
>>> +               n = sscanf(obuf, "%x", &amd_iommu_devid);
>>> +       } else {
>>> +               n = sscanf(obuf, "%d", &amd_iommu_devid);
>>> +       }

>> kstrtoint() ?

> I see various mechanisms for this sort of thing, and simply chose one.
> Am happy to use whatever is preferred.

sscanf() has an enormous overhead for cases like this.

simple

ret = kstrtoint();
if (ret)
 ... do error handling ...


-- 
With Best Regards,
Andy Shevchenko
