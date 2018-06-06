Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9cXuj1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C9B560555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeFFQE6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeFFQE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:04:56 -0400
X-Google-Smtp-Source: ADUXVKKvy1mm946lnWAo2W1SO5u+D3Qu1gtvxJCtSSc9OmwdOPHC78W7RsDj2TyCs6cc630AlxGuNmiQ69EzCdHyTmk=
MIME-Version: 1.0
In-Reply-To: <1525229431-3087-28-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com> <1525229431-3087-28-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 6 Jun 2018 11:04:15 -0500
X-Gmail-Original-Message-ID: <CANk1AXRVdZp7zCfY+YCBVubQa1iWYNq00xv=aQ=G3nwR-_vePg@mail.gmail.com>
Message-ID: <CANk1AXRVdZp7zCfY+YCBVubQa1iWYNq00xv=aQ=G3nwR-_vePg@mail.gmail.com>
Subject: Re: [PATCH v5 27/28] fpga: dfl: afu: add afu sub feature support
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

> From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>
> User Accelerated Function Unit sub feature exposes the MMIO region of
> the AFU. After valid PR bitstream is programmed and the port is enabled,
> then this MMIO region could be accessed.
>
> This patch adds support to enumerate the AFU MMIO region and expose it
> to userspace via mmap file operation. Below interfaces are exposed to user:
>
> Sysfs interface:
> * /sys/class/fpga_region/<regionX>/<dfl-port.x>/afu_id
>   Read-only. Indicate which PR bitstream is programmed to this AFU.
>
> Ioctl interfaces:
> * DFL_FPGA_PORT_GET_INFO
>   Provide info to userspace on the number of supported region.
>   Only UAFU region is supported now.
>
> * DFL_FPGA_PORT_GET_REGION_INFO
>   Provide region information, including access permission, region size,
>   offset from the start of device fd.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
