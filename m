Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x224IOX9NkIAeuVoYJyHaKxU0noGLJ4oHWgUttcT/8nc3WGz/gne1+c5c2OW2lI9wSUDBqHFq
ARC-Seal: i=1; a=rsa-sha256; t=1519711929; cv=none;
        d=google.com; s=arc-20160816;
        b=twr4jKrXy4dxr4LRDczz9lEwoMzsxv56Fx65fr6vofy60vPzrvIfDzNFgToHNshfHF
         sIS8OjSQxAu1z3ce+XicBcG1v/AwuXuMs1EZ2L3NbXqQXuyFtmRVKlf074HZ1Ht61Okf
         3kAY53qVMONnDXnzlFEfbkU59OciuxjdHfAJAMX8dvCp7fzwv0y1iBrnEYiOb4eNAFVl
         A10zsED+5mD7Z4TWdt29HtJLpBi7FP/dz3zx67aCg0xIAoNgnfzfNhAaswau09FkrHGy
         DbH2BlpGeSXajvPfsFDnv5OiRsJJNP7xO5lZYSohnm2IJ1DDykbSmFOudhwVNw4kuU/2
         n0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=Al6iaoBpwKRxDZXL/VEao1feiFgVFFOfngPwWUOa2V8=;
        b=snnxK1O85MfbUpKqZStS862jtHYnZQ+RspE/4X5gMzCWGFGw9M0Uc0dqEFqUl4w899
         ns1ZB5F1/Z7smFmx09WGIuK1LIS7VVFjT8fl3pgjAwlfC+OH6n6u1rVi7G85rcNkTbvP
         YrUs6meXWqTCEa1W26pyy2KK+wJhuwpJaJpm1WyNNqznnjX89e29NVeM+iaXYBrtBc56
         O2S3qR3mCX6tKV1FEeAQUq6b+uK5xizbY6dF70m3dxGpNNMTZk9eBOu9W4g/IaNuijKA
         2ttIEEFAKl8d7kQWTtRY6B0bo40z6iwbRzRHQlkj+ZRul3KK98fVyVhyPEeIMg8+2eg3
         7glg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NMt4d1aF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eld/jDOV;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NMt4d1aF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eld/jDOV;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Feb 2018 11:42:08 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v11 5/7] PCI/AER: Unify aer error defines at single space
In-Reply-To: <20180224153621.GS14632@bhelgaas-glaptop.roam.corp.google.com>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
 <1519374244-20539-6-git-send-email-poza@codeaurora.org>
 <20180224153621.GS14632@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <72ebd20432dacac5d494eae3006bc575@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593179400685279370?=
X-GMAIL-MSGID: =?utf-8?q?1593533456727597359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-24 21:06, Bjorn Helgaas wrote:
> On Fri, Feb 23, 2018 at 01:54:02PM +0530, Oza Pawandeep wrote:
>> This patch moves AER error defines to drivers/pci/pci.h.
>> So that it unifies the error repoting codes at single place along with 
>> dpc
> 
> s/repoting/reporting/
> s/dpc/DPC/ (in English text)
> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 1efefe9..7ae9bb3 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -56,6 +56,7 @@
>>  #include <ras/ras_event.h>
>> 
>>  #include "apei-internal.h"
>> +#include "../../pci/pci.h"
> 
> You're right, it's ugly to use this sort of path to a private PCI
> header file from outside drivers/pci.
> 
> Could you just add DPC_FATAL to include/linux/aer.h?  Maybe we
> discarded that for some reason?  Having pcie-dpc.c include linux/aer.h
> seems like it would be better than having this ACPI code include
> "../../pci/pci.h"

pcie-dpc already includes #include "aer/aerdrv.h", which in turn 
includes aer.h
so aer.h is the place where DPC_FATAL should go.

> 
>>  #define GHES_PFX	"GHES: "
>> 
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index f8575da..c8394ec 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -343,7 +343,11 @@ static inline resource_size_t 
>> pci_resource_alignment(struct pci_dev *dev,
>>  void pci_enable_acs(struct pci_dev *dev);
>> 
>>  /* PCI error reporting and recovery */
>> -#define DPC_FATAL	4
>> +#define AER_NONFATAL		0
>> +#define AER_FATAL		1
>> +#define AER_CORRECTABLE		2
>> +
>> +#define DPC_FATAL		4
>> 
>>  void pcie_do_recovery(struct pci_dev *dev, int severity);
>> 
>> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c 
>> b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> index 6a352e6..4c59f37 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/cper.h>
>> 
>>  #include "aerdrv.h"
>> +#include "../../pci.h"
>>  #include <ras/ras_event.h>
>> 
>>  #define AER_AGENT_RECEIVER		0
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 8f87bbe..3eac8ed 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -11,10 +11,6 @@
>>  #include <linux/errno.h>
>>  #include <linux/types.h>
>> 
>> -#define AER_NONFATAL			0
>> -#define AER_FATAL			1
>> -#define AER_CORRECTABLE			2
>> -
>>  struct pci_dev;
>> 
>>  struct aer_header_log_regs {
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>> index 9c68986..d75c75b 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -13,6 +13,7 @@
>>  #include <linux/aer.h>
>>  #include <linux/cper.h>
>>  #include <linux/mm.h>
>> +#include "../../../drivers/pci/pci.h"
>> 
>>  /*
>>   * MCE Extended Error Log trace event
>> --
>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
>> Technologies, Inc.,
>> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
>> Linux Foundation Collaborative Project.
>> 
