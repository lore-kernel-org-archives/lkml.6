Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCWOTg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:19:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37744 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeCWOTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:19:35 -0400
Date: Fri, 23 Mar 2018 15:19:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        stuyoder@gmail.com, ruxandra.radulescu@nxp.com,
        razvan.stefanescu@nxp.com, Roy.Pledge@nxp.com, arnd@arndb.de
Subject: Re: [PATCH v2 2/6] bus: fsl-mc: move fsl_mc_command struct in a uapi
 header
Message-ID: <20180323141932.GA28906@kroah.com>
References: <cover.1521132659.git.ioana.ciornei@nxp.com>
 <1b6473b17a61f2cea51258a7220c9a1b741c646b.1521132659.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b6473b17a61f2cea51258a7220c9a1b741c646b.1521132659.git.ioana.ciornei@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 12:05:32PM -0500, Ioana Ciornei wrote:
> Define "struct fsl_mc_command" as a structure that can cross the
> user/kernel boundary. Also change the variable types used with
> the proper ones.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
>   - added the patch itself
> 
>  MAINTAINERS                 |  1 +
>  include/linux/fsl/mc.h      |  8 +-------
>  include/uapi/linux/fsl_mc.h | 23 +++++++++++++++++++++++
>  3 files changed, 25 insertions(+), 7 deletions(-)
>  create mode 100644 include/uapi/linux/fsl_mc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 473ac00..4f54765 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11463,6 +11463,7 @@ S:	Maintained
>  F:	drivers/bus/fsl-mc/
>  F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>  F:	Documentation/networking/dpaa2/overview.rst
> +F:	include/uapi/linux/fsl_mc.h
>  
>  QT1010 MEDIA DRIVER
>  M:	Antti Palosaari <crope@iki.fi>
> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
> index f27cb14..19a352b 100644
> --- a/include/linux/fsl/mc.h
> +++ b/include/linux/fsl/mc.h
> @@ -12,6 +12,7 @@
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/interrupt.h>
> +#include <uapi/linux/fsl_mc.h>
>  
>  #define FSL_MC_VENDOR_FREESCALE	0x1957
>  
> @@ -198,8 +199,6 @@ struct fsl_mc_device {
>  #define to_fsl_mc_device(_dev) \
>  	container_of(_dev, struct fsl_mc_device, dev)
>  
> -#define MC_CMD_NUM_OF_PARAMS	7
> -
>  struct mc_cmd_header {
>  	u8 src_id;
>  	u8 flags_hw;
> @@ -209,11 +208,6 @@ struct mc_cmd_header {
>  	__le16 cmd_id;
>  };
>  
> -struct fsl_mc_command {
> -	u64 header;
> -	u64 params[MC_CMD_NUM_OF_PARAMS];
> -};
> -
>  enum mc_cmd_status {
>  	MC_CMD_STATUS_OK = 0x0, /* Completed successfully */
>  	MC_CMD_STATUS_READY = 0x1, /* Ready to be processed */
> diff --git a/include/uapi/linux/fsl_mc.h b/include/uapi/linux/fsl_mc.h
> new file mode 100644
> index 0000000..90892c4
> --- /dev/null
> +++ b/include/uapi/linux/fsl_mc.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

UAPI files should have the correct license on them:
	/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

thanks,

greg k-h
