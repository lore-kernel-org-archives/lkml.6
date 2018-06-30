Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04E7C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 23:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7D4253A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 23:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="D6LaK+SE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7D4253A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeF3XPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 19:15:22 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40488 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeF3XPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 19:15:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so4336190oie.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 16:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uL9nJEMrWu+8M7enOLRXjK65arit6uaB8Qxg+x9YmY8=;
        b=D6LaK+SEjHOFxEEWRaD9aDCiAPNQiSCI4iZgFTt3MFWzvkHbB7fiMp7Qs+yolocDEH
         z8CZdm5ymNhhTxLGecaOTfUV5Cz0fHAjMQIgLYvbllHgxpMICMnijXbF8bRzkTPl52RW
         xJaWhdENOdOp6VfOoD5ViKG2IOqVBLF5xAB40lPxZ1jbvuqZeN5nwclrZdVP3yDdOqg3
         0rFZgCBNNUuc4S17/MmdvuAkzf2y/Vo3Mx6FsFCrgHKhyM+CHpMdx+PB4jD6QarziTZi
         nM6Gf1PuRquyWCrMg3KJNVMi49SHST+FvBkE4ZMm9ZJBwbACnigwvns+MkagFkxheY1o
         iLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uL9nJEMrWu+8M7enOLRXjK65arit6uaB8Qxg+x9YmY8=;
        b=f2Ojo9toStEYR8ybRrdBx4Lr0xjQbK612jLkKNJ3l1BOzKfn6RKinMInDOgrpUF52w
         /ZTtHhLFyzjYZuJsPNk9Ltyi8tO9lIlufKAFudt6CnHLnI5QtFAA1nacsSXRo7hbtAa9
         HZYlV4USmHRgNjEc7q0NeaRwySi39B44wcL1r5n7pAVWnN8W+7OdVHw6mWejzEzucxCj
         sKyZdYFJGESEQkofhYgtVOVkFylklV24lghxZ3FSgPk1ge6I0YWQHo8SocBNSMacjpq1
         NeVmZc4eovfIqRhocmgs/gLjajg39PY/8+h4vj/sLDsBHwDh7mV0t7LPD+m/1WBH5fOT
         OnYQ==
X-Gm-Message-State: APt69E0b8X/ePxYU8DlOYXuDScxZOqIoIZRt1/BD+yGerRci2bT6GtxQ
        9ZB3X6uDqFowi/EPLyL/rkO1bK1PFx3X0AEes7oj4Q==
X-Google-Smtp-Source: AAOMgpd5g71j0k3Ei6KPBly9aF2EN5DI+yfD/qwp/LGLjFoRIMabO7+flbDTOfEkpNrN7ezNprE+fKfU7AvD+r+pvlU=
X-Received: by 2002:aca:a993:: with SMTP id s141-v6mr7475242oie.72.1530400519071;
 Sat, 30 Jun 2018 16:15:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 16:15:17
 -0700 (PDT)
In-Reply-To: <5f52b3d3-6720-426d-6f8c-dfed997e4705@canonical.com>
References: <5f52b3d3-6720-426d-6f8c-dfed997e4705@canonical.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 30 Jun 2018 16:15:17 -0700
Message-ID: <CAPcyv4iWOo2fqd3Z73Ge55nF719j2Dtt=hW7O-kxL75jTkxQoA@mail.gmail.com>
Subject: Re: memremap: change devm_memremap_pages interface to use struct dev_pagemap
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 2:11 PM, Colin Ian King
<colin.king@canonical.com> wrote:
> Hi,
>
> static analysis with CoverityScan detected an issue with the following
> commit:
>
> commit e8d5134833006a46fcbefc5f4a84d0b62bd520e7
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri Dec 29 08:54:05 2017 +0100
>
>     memremap: change devm_memremap_pages interface to use struct dev_pagemap
>
>
> 247        }
> 248
>    CID 1464431 (#1 of 1): Unchecked return value (CHECKED_RETURN)
> check_return: Calling devm_add_action without checking return value (as
> is done elsewhere 33 out of 35 times).
>
> 249        devm_add_action(dev, devm_memremap_pages_release, pgmap);
> 250
> 251        return __va(res->start);
>
> devm_add_action can fail and return -ENOMEM because it calls
> devres_alloc which can fail in an out of memory situation. So I believe
> it may be pertinent to add a -ENOMEM check and clean up appropriately.
> I'm not sure of the correct way to perform the error clean up, so I'm
> sending this report instead of a fix.

Thanks for this. We have a fix pending here looking to go through Andrew's tree.

    https://patchwork.kernel.org/patch/10473317/
