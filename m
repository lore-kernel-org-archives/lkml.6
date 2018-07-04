Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7632C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734502064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YXGeFFGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734502064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeGDOuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:50:22 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40290 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeGDOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:50:18 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so11198696oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TxiDW3OOxpjzvu5gm+21bKfuKd6kH7Jf3np7KF/t+Fs=;
        b=YXGeFFGtQEmti30N9vZ8yTjdQKpUXBzbMIDk34OuQX1mdgKGQrzT7R08zOGJrfzStQ
         teEGeDza1o9TeorBHCHzVbddHTM29Dcq7Jny9vIx+PWhIL+2EgN67M+BSceZ90jz+xE3
         6BQZ8Fl57XcuoLeFr8HrSklHVA1+2shVCYJHUMC+gUITBh5EYy4wHh2g5TJlSUz0sP0J
         PAgAG+kWFBJ0CLA/F9kEiliHQ10Yj6qyrI5UrKA6yvROeFvZrJ723Xjt49tAX9ABuNuj
         YWNjeXBNnpTs441f0kpD8IVXgjzLQxKSMOXiaYMH0FtYfei1Bo61+3j+X6t9OfhXJpxd
         e6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TxiDW3OOxpjzvu5gm+21bKfuKd6kH7Jf3np7KF/t+Fs=;
        b=JLpY1tx1NCUtvkvwKxgdWw8mamH+/M8lCkGceRMnaYEwG3y+D/XbX3JZzmAk83i2A2
         k6V1+z2W3wCsXmF0VCXjUulNqwfxtJFyhwRFd/pLNhdXJfYIj/UNPiL/+8fZIawJXl0f
         xv3NN3pSQuV2tMp4bODCQjuIS5yC3MRXNGGdNw2pB6WfGefoOYQ0dGk7QerzT/k5561l
         oNucPZC2qUYf6kTuXQt3zDtLBAgNPl/GH2sg1HRTwcZZL/p37fyNzORvzLX9ZI86gEUQ
         IdzxUIRDpbVFlLFrGxxK+UjmF4V7vIs0/iNyv9V0G1MVEXo/JSyBlryWd5UQ7sm1b1I5
         +8Yg==
X-Gm-Message-State: APt69E2drLaxTVMba6H8ZtFcd+ueLSzOjFV+hoI+0AdUmSA/tchtyRR2
        fFurQwq/aJwHwrPeRmK0cXU30yTu0Ui8cBaCv6gGng==
X-Google-Smtp-Source: AAOMgpcnGNY1FNetH6Xd031ROLUP3LDKx096KxyaPxTBw2M/lrJKuud23/OKS58OzjaPuLlf/QN+Npp+4MXO3hJB+ns=
X-Received: by 2002:aca:100f:: with SMTP id 15-v6mr2777889oiq.110.1530715818404;
 Wed, 04 Jul 2018 07:50:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 07:50:18 -0700 (PDT)
In-Reply-To: <5c7996b8e6d31541f3185f8e4064ff97582c86f8.1530716899.git.yi.z.zhang@linux.intel.com>
References: <cover.1530716899.git.yi.z.zhang@linux.intel.com> <5c7996b8e6d31541f3185f8e4064ff97582c86f8.1530716899.git.yi.z.zhang@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Jul 2018 07:50:18 -0700
Message-ID: <CAPcyv4gjFVG7tHv65Z=FsZ9=5wXDxNWawFJqO8MkyMudch4zDw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: introduce memory type MEMORY_DEVICE_DEV_DAX
To:     Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Linux MM <linux-mm@kvack.org>, rkrcmar@redhat.com,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 8:30 AM, Zhang Yi <yi.z.zhang@linux.intel.com> wrote:
> Currently, NVDIMM pages will be marked 'PageReserved'. However, unlike
> other reserved PFNs, pages on NVDIMM shall still behave like normal ones
> in many cases, i.e. when used as backend memory of KVM guest. This patch
> introduces a new memory type, MEMORY_DEVICE_DEV_DAX. Together with the
> existing type MEMORY_DEVICE_FS_DAX, we can differentiate the pages on
> NVDIMM with the normal reserved pages.
>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
> ---
>  drivers/dax/pmem.c       | 1 +
>  include/linux/memremap.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
> index fd49b24..fb3f363 100644
> --- a/drivers/dax/pmem.c
> +++ b/drivers/dax/pmem.c
> @@ -111,6 +111,7 @@ static int dax_pmem_probe(struct device *dev)
>                 return rc;
>
>         dax_pmem->pgmap.ref = &dax_pmem->ref;
> +       dax_pmem->pgmap.type = MEMORY_DEVICE_DEV_DAX;
>         addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
>         if (IS_ERR(addr))
>                 return PTR_ERR(addr);
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 5ebfff6..4127bf7 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -58,6 +58,7 @@ enum memory_type {
>         MEMORY_DEVICE_PRIVATE = 1,
>         MEMORY_DEVICE_PUBLIC,
>         MEMORY_DEVICE_FS_DAX,
> +       MEMORY_DEVICE_DEV_DAX,

Please add documentation for this new type to the comment block about
this definition.
