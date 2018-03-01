Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161988AbeCAVXM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:23:12 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35160 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161475AbeCAVXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:23:09 -0500
X-Google-Smtp-Source: AG47ELvJsyF1uPgQ3SYVD5xZSfar4DuQ1Z/Vmr1zq4qaEBjWLyVcbu1FAZqCFuIJQvRMMflu+Z52Pw==
Date: Thu, 1 Mar 2018 15:22:53 -0600
From: Rob Herring <robh@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: leonard.crestez@nxp.com, rui.zhang@intel.com, edubezval@gmail.com,
        mark.rutland@arm.com, shawnguo@kernel.org, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V5 2/2] thermal: imx: add i.MX7 thermal sensor support
Message-ID: <20180301212253.fp4gxes57t2m2tg2@rob-hp-laptop>
References: <1519859380-15878-1-git-send-email-Anson.Huang@nxp.com>
 <1519859380-15878-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519859380-15878-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 07:09:40AM +0800, Anson Huang wrote:
> This patch adds i.MX7 thermal sensor support, most
> of the i.MX7 thermal sensor functions are same with
> i.MX6 except the registers offset/layout, so we move
> those registers offset/layout definitions to soc data
> structure.
> 
> i.MX7 uses single calibration data @25C, the calibration
> data is located at OCOTP offset 0x4F0, bit[17:9], the
> formula is as below:
> 
> Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> ---
> changes since V4:
> 	drop direct OCOTP register access for i.mx7d since it is a new added platform,
> 	only support reading ocotp values through the ocotp nvmem driver which handles clock.
>  .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
>  drivers/thermal/imx_thermal.c                      | 295 ++++++++++++++++-----
>  2 files changed, 239 insertions(+), 65 deletions(-)

Please add ack/reviewed-by's when posting new versions.

Rob
