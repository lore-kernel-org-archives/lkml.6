Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeCWPsP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:48:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeCWPsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:48:14 -0400
Date: Fri, 23 Mar 2018 16:48:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        stuyoder@gmail.com, ruxandra.radulescu@nxp.com, arnd@arndb.de,
        razvan.stefanescu@nxp.com, Roy.Pledge@nxp.com
Subject: Re: [PATCH v3 3/4] bus: fsl-mc: add root dprc rescan attribute
Message-ID: <20180323154812.GB382@kroah.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <7d4c4463871d4129c6c062265d83d886432af6aa.1521818403.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d4c4463871d4129c6c062265d83d886432af6aa.1521818403.git.ioana.ciornei@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:38:57AM -0500, Ioana Ciornei wrote:
> Introduce the rescan attribute as a device attribute to
> synchronize the fsl-mc bus objects and the MC firmware.
> 
> To rescan the root dprc only, e.g.
> echo 1 > /sys/bus/fsl-mc/devices/dprc.1/rescan
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
>   - added proper documentation in /Documentation/ABI/
>   - updated the MAINTAINERS file
> Changes in v3:
>   - no change
> 
>  Documentation/ABI/stable/sysfs-bus-fsl-mc |  6 ++++++
>  MAINTAINERS                               |  1 +
>  drivers/bus/fsl-mc/dprc-driver.c          |  4 ++--
>  drivers/bus/fsl-mc/fsl-mc-bus.c           | 28 ++++++++++++++++++++++++++++
>  drivers/bus/fsl-mc/fsl-mc-private.h       |  3 +++
>  5 files changed, 40 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc b/Documentation/ABI/stable/sysfs-bus-fsl-mc
> new file mode 100644
> index 0000000..e530e8c
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
> @@ -0,0 +1,6 @@
> +What:		/sys/bus/fsl-mc/devices/dprc.*/rescan
> +Date:		March. 2018

"."?

> +KernelVersion:	4.16

4.17 :)

> +Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
> +Description:	Root dprc rescan attribute

What does this do?  A bit more description please.

thanks,

greg k-h
