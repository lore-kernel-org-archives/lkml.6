Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JI8uC5UFG1tyOAAAmS7hNA
	; Fri, 08 Jun 2018 23:08:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F29C9608B8; Fri,  8 Jun 2018 23:08:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YPz0babu"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0F1DD60275;
	Fri,  8 Jun 2018 23:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F1DD60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeFHXIS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 19:08:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbeFHXIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 19:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/UJaseccqieEWMxIv+lr9xNW2xHBkTfGLkkX4awtsQ0=; b=YPz0babuboy0HObJseR+9XKKQ
        xghmQbT2Eh9YtjRKj4SagnhH9Cb5KIKxfKPMWGAJ1/CCeXQojyl7usaM6Isg3IsQtKjh1nx4iPN3l
        pqvSPiq9h4Z8cGS/mevjxU/ZHxWh1+Iog/bIMllbSF392gQm+QRfMO7vc9g09dUhCRMsK3ywb5tLU
        UOU/T+I9H8QuviaHA8cIXlYzZP9gnKplFMxniZ1EAgTJnGdnuKCNkwh4w6Ac499Qds6n8GNrOZlgF
        9ifQGlSVlaiRnF/OUuTyq5z3ytHq5CCBkNwzdHlyLf1tHsczvZY4UKy+TTlXVUF95E0lWInQ97iBo
        N9oERB5vQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRQUR-0003s3-7T; Fri, 08 Jun 2018 23:08:15 +0000
Date: Fri, 8 Jun 2018 16:08:12 -0700
From: Darren Hart <dvhart@infradead.org>
To: Mario.Limonciello@dell.com
Cc: Douglas.Warzecha@dell.com, andy@infradead.org,
        Stuart.Hayes@dell.com, Jared.Dominguez@dell.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        stuart.w.hayes@gmail.com
Subject: Re: [PATCH resend v2] dcdbas: Add support for WSMT ACPI table
Message-ID: <20180608230812.GA111314@localhost.localdomain>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <2f071e184b0040198954421d92dcca45@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f071e184b0040198954421d92dcca45@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 04:07:50PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Stuart Hayes [mailto:stuart.w.hayes@gmail.com]
> > Sent: Thursday, June 7, 2018 11:00 AM
> > To: Warzecha, Douglas
> > Cc: Limonciello, Mario; Dominguez, Jared; linux-kernel@vger.kernel.org; platform-
> > driver-x86@vger.kernel.org
> > Subject: [PATCH resend v2] dcdbas: Add support for WSMT ACPI table
> > 
> > If the WSMT ACPI table is present and indicates that a fixed communication
> > buffer should be used, use the firmware-specified buffer instead of
> > allocating a buffer in memory for communications between the dcdbas driver
> > and firmare.
> > 
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > Tested-by: Mario Limonciello <mario.limonciello@dell.com>
> > Acked-by: Doug Warzecha <douglas_warzecha@dell.com>
> > ---
> > v2 Bumped driver version to 5.6.0-3.3
> > 
> > 
> >  drivers/firmware/Kconfig  |   2 +-
> >  drivers/firmware/dcdbas.c | 102
> > +++++++++++++++++++++++++++++++++++++++++++---
> >  drivers/firmware/dcdbas.h |  11 +++++
> >  3 files changed, 109 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > index b7c748248e53..a2bd6092bfa1 100644
> > --- a/drivers/firmware/Kconfig
> > +++ b/drivers/firmware/Kconfig
> > @@ -125,7 +125,7 @@ config DELL_RBU
> > 
> >  config DCDBAS
> >  	tristate "Dell Systems Management Base Driver"
> > -	depends on X86
> > +	depends on X86 && ACPI
> >  	help
> >  	  The Dell Systems Management Base Driver provides a sysfs interface
> >  	  for systems management software to perform System Management
> > diff --git a/drivers/firmware/dcdbas.c b/drivers/firmware/dcdbas.c
> > index 0bdea60c65dd..1699cfdcefe4 100644
> > --- a/drivers/firmware/dcdbas.c
> > +++ b/drivers/firmware/dcdbas.c
> > @@ -36,12 +36,13 @@
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> >  #include <linux/mutex.h>
> > +#include <linux/acpi.h>
> >  #include <asm/io.h>
> > 
> >  #include "dcdbas.h"
> > 
> >  #define DRIVER_NAME		"dcdbas"
> > -#define DRIVER_VERSION		"5.6.0-3.2"
> > +#define DRIVER_VERSION		"5.6.0-3.3"
> >  #define DRIVER_DESCRIPTION	"Dell Systems Management Base Driver"
> > 
> >  static struct platform_device *dcdbas_pdev;
> > @@ -49,19 +50,23 @@ static struct platform_device *dcdbas_pdev;
> >  static u8 *smi_data_buf;
> >  static dma_addr_t smi_data_buf_handle;
> >  static unsigned long smi_data_buf_size;
> > +static unsigned long max_smi_data_buf_size = MAX_SMI_DATA_BUF_SIZE;
> >  static u32 smi_data_buf_phys_addr;
> >  static DEFINE_MUTEX(smi_data_lock);
> > +static u8 *eps_buffer;
> > 
> >  static unsigned int host_control_action;
> >  static unsigned int host_control_smi_type;
> >  static unsigned int host_control_on_shutdown;
> > 
> > +static bool wsmt_enabled;
> > +
> >  /**
> >   * smi_data_buf_free: free SMI data buffer
> >   */
> >  static void smi_data_buf_free(void)
> >  {
> > -	if (!smi_data_buf)
> > +	if (!smi_data_buf || wsmt_enabled)
> >  		return;
> > 
> >  	dev_dbg(&dcdbas_pdev->dev, "%s: phys: %x size: %lu\n",
> > @@ -86,7 +91,7 @@ static int smi_data_buf_realloc(unsigned long size)
> >  	if (smi_data_buf_size >= size)
> >  		return 0;
> > 
> > -	if (size > MAX_SMI_DATA_BUF_SIZE)
> > +	if (size > max_smi_data_buf_size)
> >  		return -EINVAL;
> > 
> >  	/* new buffer is needed */
> > @@ -169,7 +174,7 @@ static ssize_t smi_data_write(struct file *filp, struct kobject
> > *kobj,
> >  {
> >  	ssize_t ret;
> > 
> > -	if ((pos + count) > MAX_SMI_DATA_BUF_SIZE)
> > +	if ((pos + count) > max_smi_data_buf_size)
> >  		return -EINVAL;
> > 
> >  	mutex_lock(&smi_data_lock);
> > @@ -323,7 +328,8 @@ static ssize_t smi_request_store(struct device *dev,
> >  		break;
> >  	case 1:
> >  		/* Calling Interface SMI */
> > -		smi_cmd->ebx = (u32) virt_to_phys(smi_cmd->command_buffer);
> > +		smi_cmd->ebx = smi_data_buf_phys_addr
> > +				+ offsetof(struct smi_cmd, command_buffer);
> >  		ret = dcdbas_smi_request(smi_cmd);
> >  		if (!ret)
> >  			ret = count;
> > @@ -482,6 +488,85 @@ static void dcdbas_host_control(void)
> >  	}
> >  }
> > 
> > +/* WSMT */
> > +
> > +static u8 checksum(u8 *buffer, u8 length)
> > +{
> > +	u8 sum = 0;
> > +	u8 *end = buffer + length;
> > +
> > +	while (buffer < end)
> > +		sum = (u8)(sum + *(buffer++));
> > +	return sum;
> > +}
> > +
> > +static inline struct smm_eps_table *check_eps_table(u8 *addr)
> > +{
> > +	struct smm_eps_table *eps = (struct smm_eps_table *)addr;
> > +
> > +	if (strncmp(SMM_EPS_SIG, eps->smm_comm_buff_anchor, 4) != 0)
> > +		return NULL;
> > +
> > +	if (checksum(addr, eps->length) != 0)
> > +		return NULL;
> > +
> > +	return eps;
> > +}
> > +
> > +static int dcdbas_check_wsmt(void)
> > +{
> > +	struct acpi_table_wsmt *wsmt = NULL;
> > +	struct smm_eps_table *eps = NULL;
> > +	u8 *addr;
> > +
> > +	acpi_get_table(ACPI_SIG_WSMT, 0, (struct acpi_table_header **)&wsmt);
> > +	if (!wsmt)
> > +		return 0;
> > +
> > +	/* Check if WSMT ACPI table shows that protection is enabled */
> > +	if (!(wsmt->protection_flags & ACPI_WSMT_FIXED_COMM_BUFFERS)
> > +	    || !(wsmt->protection_flags
> > +		 & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))
> > +		return 0;
> > +
> > +	/* Scan for EPS (entry point structure) */
> > +	for (addr = (u8 *)__va(0xf0000);
> > +	     addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table)) && !eps;
> > +	     addr += 1)
> > +		eps = check_eps_table(addr);
> > +
> > +	if (!eps) {
> > +		dev_dbg(&dcdbas_pdev->dev, "found WSMT, but no EPS
> > found\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	/*
> > +	 * Get physical address of buffer and map to virtual address.
> > +	 * Table gives size in 4K pages, regardless of actual system page size.
> > +	 */
> > +	if (eps->smm_comm_buff_addr + 8 > U32_MAX) {
> > +		dev_warn(&dcdbas_pdev->dev, "found WSMT, but EPS buffer
> > address is above 4GB\n");
> > +		return -EINVAL;
> > +	}
> > +	eps_buffer = (u8 *)memremap(eps->smm_comm_buff_addr,
> > +				     eps->num_of_4k_pages * 4096,
> > MEMREMAP_WB);
> > +	if (!eps_buffer) {
> > +		dev_warn(&dcdbas_pdev->dev, "found WSMT, but failed to map
> > EPS buffer\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* First 8 bytes of buffer is for semaphore */
> > +	smi_data_buf_phys_addr = (u32) eps->smm_comm_buff_addr + 8;
> > +	smi_data_buf = eps_buffer + 8;
> > +	smi_data_buf_size = (unsigned long) min(eps->num_of_4k_pages * 4096 -
> > 8,
> > +			    (u64) ULONG_MAX);
> > +	max_smi_data_buf_size = smi_data_buf_size;
> > +	wsmt_enabled = true;
> > +	dev_info(&dcdbas_pdev->dev,
> > +		 "WSMT found, using firmware-provided SMI buffer.\n");
> > +	return 1;
> > +}
> > +
> >  /**
> >   * dcdbas_reboot_notify: handle reboot notification for host control
> >   */
> > @@ -548,6 +633,11 @@ static int dcdbas_probe(struct platform_device *dev)
> > 
> >  	dcdbas_pdev = dev;
> > 
> > +	/* Check if ACPI WSMT table specifies protected SMI buffer address */
> > +	error = dcdbas_check_wsmt();
> > +	if (error < 0)
> > +		return error;
> > +
> >  	/*
> >  	 * BIOS SMI calls require buffer addresses be in 32-bit address space.
> >  	 * This is done by setting the DMA mask below.
> > @@ -635,6 +725,8 @@ static void __exit dcdbas_exit(void)
> >  	 */
> >  	if (dcdbas_pdev)
> >  		smi_data_buf_free();
> > +	if (eps_buffer)
> > +		memunmap(eps_buffer);
> >  	platform_device_unregister(dcdbas_pdev_reg);
> >  	platform_driver_unregister(&dcdbas_driver);
> >  }
> > diff --git a/drivers/firmware/dcdbas.h b/drivers/firmware/dcdbas.h
> > index ca3cb0a54ab6..7ea5b3e070b9 100644
> > --- a/drivers/firmware/dcdbas.h
> > +++ b/drivers/firmware/dcdbas.h
> > @@ -54,6 +54,8 @@
> > 
> >  #define SMI_CMD_MAGIC				(0x534D4931)
> > 
> > +#define SMM_EPS_SIG				"$SCB"
> > +
> >  #define DCDBAS_DEV_ATTR_RW(_name) \
> >  	DEVICE_ATTR(_name,0600,_name##_show,_name##_store);
> > 
> > @@ -103,5 +105,14 @@ struct apm_cmd {
> > 
> >  int dcdbas_smi_request(struct smi_cmd *smi_cmd);
> > 
> > +struct smm_eps_table {
> > +	char smm_comm_buff_anchor[4];
> > +	u8 length;
> > +	u8 checksum;
> > +	u8 version;
> > +	u64 smm_comm_buff_addr;
> > +	u64 num_of_4k_pages;
> > +} __packed;
> > +
> >  #endif /* _DCDBAS_H_ */
> > 
> > --
> > 2.14.2
> 
> Darren, Andy,
> 
> Stuart and I were hoping you guys could bring this through the platform-driver-x86 tree.
> The logic behind this is that the only consumer for dcdbas in kernel is dell-smbios.
> 
> There isn't a subsystem maintainer for someone to pull in dcdbas even though the
> current maintainer (Doug W) has acked it.

Apologies for the delay. I'm OK bringing it in in general. I'm reviewing patches
today and tomorrow to try and close out the backlog. Should have a review by EOD
tomorrow.

I've been wondering about drivers/firmware anyway - that is almost by definition
platform specific and might make more sense as part of the platform drivers,
especially if it is currently without a maintainer (although akpm will often
take such things).

-- 
Darren Hart
VMware Open Source Technology Center
