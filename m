Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034932AbeE1PtC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:49:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49298 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034841AbeE1Ps6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:48:58 -0400
Subject: Re: [PATCH 3/5] scsi: ufs: Add Kconfig for UFS HC driver crypto
 support
To: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        Vinayak Holikatti "<vinholikatti@gmail.com>;" "\"James" "E.J."
         "Bottomley\"" "<jejb@linux.vnet.ibm.com>;" "\"Martin" "K."
         "Petersen\"" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org,
        "linux-scsi@vger.kernel.org;" Manjunath M Bettegowda
         "<manjumb@synopsys.com>;" Prabu Thangamuthu
         "<prabut@synopsys.com>;" Tejas Joglekar
         "<joglekar@synopsys.com>;" Joao Pinto <Joao.Pinto@synopsys.com>
References: <9baaf314-e9de-a078-1085-9c81b3421d42@synopsys.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <394042f2-2231-37c9-f875-979415dbdf58@infradead.org>
Date: Mon, 28 May 2018 08:48:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9baaf314-e9de-a078-1085-9c81b3421d42@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 06:29 AM, Ladvine D Almeida wrote:
> 
> This patch adds the Kconfig for enabling crypto support for
> UFS Host Controller driver. It also adds Makefile changes
> for building crypto support based on crypto Kconfig selection.
> 
> Signed-off-by: Ladvine D Almeida <ladvine@synopsys.com>
> ---
>  drivers/scsi/ufs/Kconfig  | 15 +++++++++++++++
>  drivers/scsi/ufs/Makefile |  6 +++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index e27b4d4..0134672 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -50,6 +50,21 @@ config SCSI_UFSHCD
>  	  However, do not compile this as a module if your root file system
>  	  (the one containing the directory /) is located on a UFS device.
>  
> +config SCSI_UFSHCD_INLINE_ENCRYPTION
> +	bool "Universal Flash Storage Controller Driver crypto support"
> +	depends on SCSI_UFSHCD
> +	default n
> +	select BLK_DEV_INLINE_ENCRYPTION if SCSI_UFSHCD_INLINE_ENCRYPTION
> +	help
> +	This enables the Inline Encryption feature of the UFS Host
> +	Controller driver. Once the capability is detected in hardware,
> +	it will be made available for the user through Linux Kernel
> +	Cryptography Framework(LKCF).

The help text above should be indented (as below), with one tab + 2 spaces.

> +
> +	  If you have a controller with this capability, say Y.
> +
> +	  If unsure, say N.
> +
>  config SCSI_UFSHCD_PCI
>  	tristate "PCI bus based UFS Controller support"
>  	depends on SCSI_UFSHCD && PCI


-- 
~Randy
