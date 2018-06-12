Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6B5D2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F135208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4x0kwUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F135208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeFLPzn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933403AbeFLPzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:55:42 -0400
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com [209.85.161.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA0D6208B1;
        Tue, 12 Jun 2018 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528818941;
        bh=G0NHQ4UTEdjAy1NgSgoHYiKiV3FeG9MHhKJtGh2YRP8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=e4x0kwUfc8FcKetdadb/LkDoCaVT9CyhgIfPHtbb0lNeeiMdZfTcqmzOwuGI30zWV
         wA1tGSH/GwI4Pf7R6OK9nVxhFcoi8qmgQyPc6Qgv1zE/fO/uTMOi38rViZtseM6+01
         rFOussdGIO7cB1cVoz0yb+eP/O/Cv2HUH5AAVfjY=
Received: by mail-yw0-f176.google.com with SMTP id p129-v6so7672845ywg.7;
        Tue, 12 Jun 2018 08:55:41 -0700 (PDT)
X-Gm-Message-State: APt69E2WV8cG2/LkO/XHlWbQ3qyCvrH+g5OtMkiZnY5UEy4iH7vll0A5
        t6F0UlDmGjGQZWQiItNC5VHPqPOpqpRUdJgGf/E=
X-Google-Smtp-Source: ADUXVKJxWzncrBW5tv8kRmJjvCB74e2X2RmBIabQ6TDgHiS7OP20/vjiz58ZZ6uSVaBtJL/gMaCdpHHwYuyeVtuN4nI=
X-Received: by 2002:a81:a316:: with SMTP id a22-v6mr450246ywh.142.1528818940966;
 Tue, 12 Jun 2018 08:55:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 08:55:00 -0700 (PDT)
In-Reply-To: <1528798243-2029-8-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com> <1528798243-2029-8-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 12 Jun 2018 10:55:00 -0500
X-Gmail-Original-Message-ID: <CANk1AXQVFD-CATaGtjPAPf9tA86rRh1DtHx6_U7W1Wk-CRBA2A@mail.gmail.com>
Message-ID: <CANk1AXQVFD-CATaGtjPAPf9tA86rRh1DtHx6_U7W1Wk-CRBA2A@mail.gmail.com>
Subject: Re: [PATCH v6 07/29] fpga: dfl: add chardev support for feature devices
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
> For feature devices drivers, both the FPGA Management Engine (FME) and
> Accelerated Function Unit (AFU) driver need to expose user interfaces via
> the device file, for example, mmap and ioctls.
>
> This patch adds chardev support in the dfl driver for feature devices,
> FME and AFU. It reserves the chardev regions for FME and AFU, and provide
> interfaces for FME and AFU driver to register their device file operations.
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
> v2: rebased
> v3: move chardev support to fpga-dfl framework
> v4: rebase, and add more comments in code.
> v5: rebase, and add dfl_ prefix to APIs and data structures.
> v6: add index in dfl_devs to link to dfl_chrdevs.
>     improve naming on APIs.
