Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0F1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0034121855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="UZpU06VI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbfBKPsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:48:38 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45724 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731392AbfBKOkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:37 -0500
Received: by mail-yb1-f194.google.com with SMTP id e131so4218853ybh.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tstql8YTOu4MoEgSzgXoCCPJCMqyNx9aLo/AydYYf7A=;
        b=UZpU06VI5nyGPUji3iN6mgbZFYoiHE0jSh8jNTVpReUQH8ij4FLz/7rANY//d7VJYt
         Cw5NUL9rveNsjVoqjRhv9vJDWQp2ML0XHgmyqIB/4V+YuOz9n+iRhWFX5SuDoqED/FXK
         yKkLVwXhSwLUMn5jCn7+YAqgQLBCHK3CIfqnlPCSWb53VudDqqdLzB3nGCg5cfkEd0PI
         lfo3M3nQRd/pLLJFiwbPfEobzPjeN0kJLnvaOHyAOjmXGImLS56hi7sn+iUN7DTEUyau
         56+Tf/fxiiOH4METmU/GMlg3XbymmUWIGh5EQeefwiXMj34OUKS69jZp5s0ou8AjH0zQ
         iQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tstql8YTOu4MoEgSzgXoCCPJCMqyNx9aLo/AydYYf7A=;
        b=HmJ+KIOcjNn6wo8ceHRkWBhuv0dSORZgUXer8NpJxxy2azGgmnocvKrm9WOmFRFR8k
         YNV/widdXGh/6sHRRcpSx5g0aOFv3/30teWf3M9x7P+OahnCZYTleDVw3qJf6djsnJet
         jqODeh/tR+8SLQtWiQJ00qODItMDkczrhAlutGA/KM72oKVgEeN49OUt6IrP0r2BQ5KV
         EQ9gFMugqiaxHimZeZyCG1tXoDQHdVWvwvxXAJVQNvBwrWBTv4das7WeMLHCCX7uemDI
         ICO8+8CTO+7HRXFwzmCLWheNQLAadtgvtT2wE2b3pkrxFWyEVIqhY9tuN1xsTTJdJjTc
         56LA==
X-Gm-Message-State: AHQUAuZu39Eid3iOqVmMYOUaPThkerz2TinEOmM6d7M0zrkU2G+KbnRy
        6G2JZpjlEQiXXDDcQMKj1YKgoA==
X-Google-Smtp-Source: AHgI3Iazcb8GH3xhoApIW5S40qL+0JSCgyUpi1LK+2HKqshwQZEQWPMGJwuz0ujGwohUG0ihDLuLNQ==
X-Received: by 2002:a25:2fd4:: with SMTP id v203mr24348553ybv.184.1549896036623;
        Mon, 11 Feb 2019 06:40:36 -0800 (PST)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id 139sm4195958ywt.78.2019.02.11.06.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 06:40:36 -0800 (PST)
Date:   Mon, 11 Feb 2019 09:40:34 -0500
From:   Jon Mason <jdmason@kudzu.us>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v3 0/8]  Fix breakage caused by the NTB multi-port
 patchset
Message-ID: <20190211144034.GC13951@kudzu.us>
References: <20190109192233.5752-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109192233.5752-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:22:25PM -0700, Logan Gunthorpe wrote:
> Hey,
> 
> I'm resending this because I've recently found out that the change we
> made to use the NTB struct device in DMA allocations is wrong and
> needs to be reverted. Turns out that, when running with an IOMMU,
> dma_alloc_coherent() will always fail if you pass it the NTB struct
> device. This is because the device has not been assigned an IOMMU
> group and the Intel IOMMU at least expect the devices to be on the PCI
> bus and be able to find a proper bus-dev-fn number through a struct
> pci device. Therefore, we must revert the change and I've changed
> patch 2 to do this and remove the no longer necessary DMA mask
> adjustments.
> 
> I'm not sure if we can get past the impass in getting this series merged:
> I still maintain every patch in this series is necessary to fix a
> regression and there's no way to add port numbers to switchtec in the
> crosslink configuration so it can't be fixed in the other way that was
> suggested.

Given the need for this to get in (as it does fix actual problems) and
the absence of comments on v3, I'm adding this to the ntb-next branch.
If there is anyone that has anything more to say on this, please do so
immediately.  Otherwise, I think this probably needs to be moved to the
ntb branch and go into 5.1-rc1.

Thoughts?

Thanks,
Jon

> 
> Logan
> 
> --
> 
> Changes since v2:
> - Rebased on v5.0-rc1
> - Modify Patch 2 to revert back to using the PCI struct device
>   instead of the NTB struct device in DMA calls
> - Collected Allen's Acks
> - Collected Alexander's Tested-By
> 
> Changes since v1:
> - Rebased onto ntb-next (there was a minor conflict in a recent change
>   to the intel driver)
> - Collected Dave's Ack
> 
> --
> 
> Logan Gunthorpe (8):
>   NTB: ntb_tool: reading the link file should not end in a NULL byte
>   NTB: Revert the change to use the NTB device dev for DMA allocations
>   NTB: Fix the default port and peer numbers for legacy drivers
>   NTB: ntb_pingpong: Choose doorbells based on port number
>   NTB: perf: Don't require one more memory window than number of peers
>   NTB: perf: Fix support for hardware that doesn't have port numbers
>   NTB: perf: Fix race condition when run with ntb_test
>   NTB: ntb_test: Fix bug when counting remote files
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c         |  4 ----
>  drivers/ntb/hw/idt/ntb_hw_idt.c         |  6 -----
>  drivers/ntb/hw/intel/ntb_hw_gen1.c      |  4 ----
>  drivers/ntb/ntb.c                       |  9 ++------
>  drivers/ntb/test/ntb_perf.c             | 29 +++++++++++++++++++------
>  drivers/ntb/test/ntb_pingpong.c         | 14 +++++-------
>  drivers/ntb/test/ntb_tool.c             |  9 ++++----
>  tools/testing/selftests/ntb/ntb_test.sh |  2 +-
>  8 files changed, 35 insertions(+), 42 deletions(-)
> 
> --
> 2.19.0
