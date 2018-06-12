Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BDA10C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69470208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1KiL7eTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69470208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933909AbeFLPnF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932839AbeFLPnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:43:03 -0400
Received: from mail-yb0-f173.google.com (mail-yb0-f173.google.com [209.85.213.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4994B208B0;
        Tue, 12 Jun 2018 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528818182;
        bh=1MqBCEFiG2RqzC/vfHGDRh6kgxruLt2X5U+EVIRXAO8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1KiL7eTXmrXXWPhLnq/6l+qhlD8699BACo3kgcNmjo+IP2Dcl2jFl5Cdz4B1rrz6b
         av7yNrTwXM4b0UzuKEjMMcyEXNCK9KGYjKLoLHrpzSq7kuZINg9gIcNz3JlRNAPaIs
         mGarTUnaL46583xnf5Ae/KDIKXkKNzrOHNadTfPw=
Received: by mail-yb0-f173.google.com with SMTP id w3-v6so8082834ybq.10;
        Tue, 12 Jun 2018 08:43:02 -0700 (PDT)
X-Gm-Message-State: APt69E3UZig8eosgFGqWZRcbehkZd2YsHOvOX96bUZ4cNHxuhvtlt0WU
        mK2wUmHm8MXxkHMjCLeBO2oZqrPoMJqVY1W4qec=
X-Google-Smtp-Source: ADUXVKLfcAVBT2Ye1uIQdW/QKNw3dlfOmyxzX2wT+b/3F8DU4lIfyFmTwQBOU1TD3j39mPsLIxCp9Yvfs3Opahu+M/M=
X-Received: by 2002:a25:a3a1:: with SMTP id e30-v6mr449499ybi.166.1528818181493;
 Tue, 12 Jun 2018 08:43:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 08:42:21 -0700 (PDT)
In-Reply-To: <1528798243-2029-7-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com> <1528798243-2029-7-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 12 Jun 2018 10:42:21 -0500
X-Gmail-Original-Message-ID: <CANk1AXTnmMvLar5m7189JBsCO1qyVY71H7x5dgP0MtfDtrRr6Q@mail.gmail.com>
Message-ID: <CANk1AXTnmMvLar5m7189JBsCO1qyVY71H7x5dgP0MtfDtrRr6Q@mail.gmail.com>
Subject: Re: [PATCH v6 06/29] fpga: add device feature list support
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 5:10 AM, Wu Hao <hao.wu@intel.com> wrote:
> Device Feature List (DFL) defines a feature list structure that creates
> a link list of feature headers within the MMIO space to provide an
> extensible way of adding features. This patch introduces a kernel module
> to provide basic infrastructure to support FPGA devices which implement
> the Device Feature List.
>
> Usually there will be different features and their sub features linked into
> the DFL. This code provides common APIs for feature enumeration, it creates
> a container device (FPGA base region), walks through the DFLs and creates
> platform devices for feature devices (Currently it only supports two
> different feature devices, FPGA Management Engine (FME) and Port which
> the Accelerator Function Unit (AFU) connected to). In order to enumerate
> the DFLs, the common APIs required low level driver to provide necessary
> enumeration information (e.g address for each device feature list for
> given device) and fill it to the dfl_fpga_enum_info data structure. Please
> refer to below description for APIs added for enumeration.
>
> Functions for enumeration information preparation:
>  *dfl_fpga_enum_info_alloc
>    allocate enumeration information data structure.
>
>  *dfl_fpga_enum_info_add_dfl
>    add a device feature list to dfl_fpga_enum_info data structure.
>
>  *dfl_fpga_enum_info_free
>    free dfl_fpga_enum_info data structure and related resources.
>
> Functions for feature device enumeration:
>  *dfl_fpga_feature_devs_enumerate
>    enumerate feature devices and return container device.
>
>  *dfl_fpga_feature_devs_remove
>    remove feature devices under given container device.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

> ---
> v3: split from another patch.
>     separate dfl enumeration code from original pcie driver.
>     provide common data structures and APIs for enumeration.
>     update device feature list parsing process according to latest hw.
>     add dperf/iperf/hssi sub feature placeholder according to latest hw.
>     remove build_info_add_sub_feature and other small functions.
>     replace *_feature_num function with macro.
>     remove writeq/readq.
> v4: fix SPDX license issue
>     rename files to dfl.[ch], fix typo and add more comments.
>     remove static feature_info tables for FME and Port.
>     remove check on next_afu link list as only FIU has next_afu ptr.
>     remove unused macro in header file.
>     add more comments for functions.
> v5: add "dfl_" prefix to functions and data structures.
>     remove port related functions from DFL framework.
>     use BIT_ULL for 64bit register definition.
>     save dfl_fpga_cdev in pdata for feature platform devices.
>     rebase due to fpga region api changes.
> v6: update time in copyright and improve function name.
>     introduce dfl_devs table to save feature device info.
