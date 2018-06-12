Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5DFD5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EA7208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQaxxOFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EA7208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934414AbeFLP6G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933439AbeFLP6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:58:03 -0400
Received: from mail-yb0-f174.google.com (mail-yb0-f174.google.com [209.85.213.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159CC208B0;
        Tue, 12 Jun 2018 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528819083;
        bh=ErrLgF4gA2nNgefx+o3EkbSdr5u8OLytmu5nf0pSFWg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=FQaxxOFQStkQlDULVdW4FSyVgJ1TR5hNQ9JWVJFzmoFOEkKvdJ8A0NAa1rIbWviHn
         uWKarcIjj59hWJFAx2sEIHCmbsKaffrtHiCgNrEhFk0tZGGo3FciwS3Eiyq7BzK7LX
         tKMMFukhtjnVmdpPONDDtgZn09JqQ7UAgesoupPE=
Received: by mail-yb0-f174.google.com with SMTP id f79-v6so8112932ybg.2;
        Tue, 12 Jun 2018 08:58:03 -0700 (PDT)
X-Gm-Message-State: APt69E3krbMh6BeqSBQFijkgYaFqL6woF5vrsVUsc7xG6SAcDuQzOn0n
        O4SpxYASCPjGfMOW4nGzRPOW1FCGv0g200Cphx8=
X-Google-Smtp-Source: ADUXVKLYAmBIx5lZWucEtwTepeuY20tE0y62INZrSa2fO7ox0GiFwu+QNwbRVhV2gCNzwMZrCeS9kHyJIRiW4LbYC/I=
X-Received: by 2002:a25:d647:: with SMTP id n68-v6mr444079ybg.113.1528819077370;
 Tue, 12 Jun 2018 08:57:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 08:57:16 -0700 (PDT)
In-Reply-To: <1528798243-2029-4-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com> <1528798243-2029-4-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 12 Jun 2018 10:57:16 -0500
X-Gmail-Original-Message-ID: <CANk1AXQqix_eK1XRtSVGWNe-9wQm+OGOFr61MhqOY1_fzKNXRA@mail.gmail.com>
Message-ID: <CANk1AXQqix_eK1XRtSVGWNe-9wQm+OGOFr61MhqOY1_fzKNXRA@mail.gmail.com>
Subject: Re: [PATCH v6 03/29] fpga: mgr: add status for fpga-manager
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 5:10 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

>  Documentation/ABI/testing/sysfs-class-fpga-manager | 24 +++++++++++++++++++
>  drivers/fpga/fpga-mgr.c                            | 28 ++++++++++++++++++++++
>  include/linux/fpga/fpga-mgr.h                      |  9 +++++++
>  3 files changed, 61 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-manager b/Documentation/ABI/testing/sysfs-class-fpga-manager
> index 23056c5..2aadf59 100644
> --- a/Documentation/ABI/testing/sysfs-class-fpga-manager
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-manager
> @@ -35,3 +35,27 @@ Description: Read fpga manager state as a string.
>                 * write complete        = Doing post programming steps
>                 * write complete error  = Error while doing post programming
>                 * operating             = FPGA is programmed and operating
> +
> +What:          /sys/class/fpga_manager/<fpga>/status
> +Date:          June 2018
> +KernelVersion: 4.18

4.19

Greg is queuing new functionality for 4.19 after 4.18-rc1 is done.

> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read fpga manager status as a string.
