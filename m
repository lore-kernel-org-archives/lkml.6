Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeBHUVk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:21:40 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35800 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbeBHUVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:21:38 -0500
X-Google-Smtp-Source: AH8x225KsHzlbduXS1WaEmrs7LQ0gURhwfWq0pYVVu+JAiulKWm+ZKsHZ63ezVSfbQnQDJBO9dlmXA==
Date: Thu, 8 Feb 2018 14:21:36 -0600
From: Rob Herring <robh@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, mark.rutland@arm.com,
        shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 2/2] thermal: imx: add i.MX7 thermal sensor support
Message-ID: <20180208202136.rpghc2dpcd42zqvn@rob-hp-laptop>
References: <1517818347-7436-1-git-send-email-Anson.Huang@nxp.com>
 <1517818347-7436-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517818347-7436-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 04:12:27PM +0800, Anson Huang wrote:
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
> ---
> changes since V2:
> 	Add bindind doc changes in this patch according to review comments.
>  .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/thermal/imx_thermal.c                      | 314 ++++++++++++++++-----
>  2 files changed, 254 insertions(+), 69 deletions(-)
