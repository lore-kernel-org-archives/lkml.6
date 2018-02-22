Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x224v/cfNH70TT3qk02igARHYBL+m5oNeUECEVwCjY1D49uciSWRdEZ77Ypuv0ta3Nak2MhjZ
ARC-Seal: i=1; a=rsa-sha256; t=1519315585; cv=none;
        d=google.com; s=arc-20160816;
        b=WCKvnyiQ8JgQ9v5pM/U7Wvi+VgqJYSGBjPzQ6E+t3SJUZjSYfWCrpcrrHV/0x4qcU4
         zjDqqoWMGNTWXkoptWMkHcHa1Crhx5lN8zfgq5CcyRtho4UZqLQ+Q5bTrpO/tv+o98Pp
         2Wq9Zx84cK4U2M1F1AksCnzfyhrnaEs61ry/6y9SP9clhLvFOE73Vcp1l/YzNsqXEj47
         bjar+psNy10m7APCttHcM/2IYcTf7r/FcvFViWF0G5LQ1moui7lbTp/r7jbyMYFP1dIR
         UG6fXXs6ckmwptZStYH07vSXGw0LxAKGBFVW2987Sr5IqozXcFewXtY3oUTxjrTfcNbI
         SpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:to:from:date
         :content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=O1D7szXMGuzGmVIQ/dxzgnt8fphHposEQoEuLzCFJp4=;
        b=pwj0jV520uO3WFyZ7nNu/Uwa6UFQlwqKeJ/nKoS9eNFX2n4XMauwzXTyiGSfpLUy9V
         ahOlSV+cKmRh4cmwe5zBkvLGrltg36XMxFIgnsg49OnXFZkLH7rPfb6iF8OTGII9h7oR
         QN0yFwA8Smaxy7Sr6zZm9MyKnWGAfouEs72jJj8Vp3QQxLtw7LKKhgsqhBLWV9ecfJbk
         FYG3Yq3HYnwAEJqeIQcF+5YyySCRVSKzyl6nfuHW7KHb4dCLXh7WeKeLUrtGH/t4ruIW
         eOY6NsqvEnmvH+ScFHmLRARxK93daTP5ilHlIfrJdkAT28sRd+ofTU8vExDf/dMPIoB4
         Qt+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bbSxUnSZ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Zj7nmw88;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bbSxUnSZ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Zj7nmw88;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Feb 2018 21:36:23 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v10 5/7] PCI/AER: Unify aer error defines at single space
In-Reply-To: <1519315332-26852-6-git-send-email-poza@codeaurora.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-6-git-send-email-poza@codeaurora.org>
Message-ID: <823d8b71a56656f87b6f0868a813db8c@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593117637130164390?=
X-GMAIL-MSGID: =?utf-8?q?1593117858973173027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-22 21:32, Oza Pawandeep wrote:
> This patch moves AER error defines to drivers/pci/pci.h.
> So that it unifies the error repoting codes at single place along with 
> dpc
> 
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
> 
>  #define GHES_PFX	"GHES: "
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 124f42e..b0e63b5 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -343,7 +343,11 @@ static inline resource_size_t
> pci_resource_alignment(struct pci_dev *dev,
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
>  void pci_do_recovery(struct pci_dev *dev, int severity);
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c
> b/drivers/pci/pcie/aer/aerdrv_errprint.c
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


Hi Bjorn,

Based on your earlier comment I have moved AER and DPC error defined in 
driver/pci/pci.h
but I am not entirely comfortable with moving them there because

file such as
drivers/acpi/apei/ghes.c
include/ras/ras_event.h

they are outside of the scope of driver/pci/pci.h and they have to 
include the files
#include "../../pci/pci.h" and #include "../../../drivers/pci/pci.h" 
respectively.

hence my suggestion is to move error defines in include/linux/pci.h

let me know your view.

Regards,
Oza.
