Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AH8x224fPb3pQzbUgLToEoVlugoxw7JXZG1iWxTTGIgY2QSovuWbwi8Sn1BurX4ZxhrUOoPI8qWO
ARC-Seal: i=1; a=rsa-sha256; t=1519486585; cv=none;
        d=google.com; s=arc-20160816;
        b=uKUS2xJszQNMe+yEp6D5ZjQv7MLRgGb714/qrlJHtm5NG5artvH+LdRmrJKjgWUAar
         bIEJ1+LjZzHkTl9MCMx72Bq3bMp9InT11ETEQ+26OV4dC27zAIxutEjttXHsjnuLt5CY
         mSzymL/NPZqEOmsLynmuz1DncNI/CORC5bojSJWPSoxmiO4iDgKWnhlYLe0n4aF6n9mC
         yPBJAcXAVA1IyfcvPt+vDj/flWN1KvWb67BfJNY8lQUnvP493OU9iBhtpohI8bFJ+bRx
         5/s9888bIId/YfHnT8KwxixHzDaz9YHs8IgEuA5JvvfWfofaCHmJEF7Qr+40mAj4l14X
         aTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=A1cloFrQ9oMReIrOXDqOhL0SuBmy9QRKLqghQCZwPCM=;
        b=HvLpsFa0723h9TPXoLxmLvps49V9MsQoWRDH44iQ3uYt2CnNn7/7uxarTs9g2YnLmn
         rgQ4tOBseAjpVW6CCjNupOLEN8Xd5djgVKp8417xSCfR+zfLIb+kfvxnp4ZZ8HEjLtJh
         P3ksWkyDpTxTin1rSAuUsTaip004/aL5Yt6CImMfDvYdvKmqCe5kbX0Z13lGtuGQ87UK
         TMuldcC07S+/uNq11F8mRU8J5WxSyyi+3X3rvyVlHQG8Z+g2cdlSkSO4fxmR4+iH6mMC
         M8otKIFNNXUyPPzmL0PuSoOlAdsLa01xU4vOWpS7zVMvMnw/4tNX7Yq37PUR/3wN6NI5
         gQxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF6A21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Sat, 24 Feb 2018 09:36:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v11 5/7] PCI/AER: Unify aer error defines at single space
Message-ID: <20180224153621.GS14632@bhelgaas-glaptop.roam.corp.google.com>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
 <1519374244-20539-6-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519374244-20539-6-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593179400685279370?=
X-GMAIL-MSGID: =?utf-8?q?1593297165654490436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 01:54:02PM +0530, Oza Pawandeep wrote:
> This patch moves AER error defines to drivers/pci/pci.h.
> So that it unifies the error repoting codes at single place along with dpc

s/repoting/reporting/
s/dpc/DPC/ (in English text)

> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 1efefe9..7ae9bb3 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -56,6 +56,7 @@
>  #include <ras/ras_event.h>
>  
>  #include "apei-internal.h"
> +#include "../../pci/pci.h"

You're right, it's ugly to use this sort of path to a private PCI
header file from outside drivers/pci.

Could you just add DPC_FATAL to include/linux/aer.h?  Maybe we
discarded that for some reason?  Having pcie-dpc.c include linux/aer.h
seems like it would be better than having this ACPI code include
"../../pci/pci.h"

>  #define GHES_PFX	"GHES: "
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f8575da..c8394ec 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -343,7 +343,11 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
>  void pci_enable_acs(struct pci_dev *dev);
>  
>  /* PCI error reporting and recovery */
> -#define DPC_FATAL	4
> +#define AER_NONFATAL		0
> +#define AER_FATAL		1
> +#define AER_CORRECTABLE		2
> +
> +#define DPC_FATAL		4
>  
>  void pcie_do_recovery(struct pci_dev *dev, int severity);
>  
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index 6a352e6..4c59f37 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -19,6 +19,7 @@
>  #include <linux/cper.h>
>  
>  #include "aerdrv.h"
> +#include "../../pci.h"
>  #include <ras/ras_event.h>
>  
>  #define AER_AGENT_RECEIVER		0
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 8f87bbe..3eac8ed 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -11,10 +11,6 @@
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  
> -#define AER_NONFATAL			0
> -#define AER_FATAL			1
> -#define AER_CORRECTABLE			2
> -
>  struct pci_dev;
>  
>  struct aer_header_log_regs {
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 9c68986..d75c75b 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -13,6 +13,7 @@
>  #include <linux/aer.h>
>  #include <linux/cper.h>
>  #include <linux/mm.h>
> +#include "../../../drivers/pci/pci.h"
>  
>  /*
>   * MCE Extended Error Log trace event
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
