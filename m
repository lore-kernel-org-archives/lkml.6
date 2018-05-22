Return-Path: <rajatja@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527031696; cv=none;
        d=google.com; s=arc-20160816;
        b=Bf6+e3KZlj024oaEGNQaYS7zX5IT6tSs9Q9osE778bHRxidbqOqHgjuTA3mQUhV3Jz
         wkJ6NYfIqcx93QKVFupkS5VYDxSSXbUlcCt829iX4bOvoZTqKBsdyYoL9fbtIY3ixLHa
         YR47tv9oKxmBVnrNlct1GDXabA7DiH2Ql75llqWy+gB05h9+nZmD0VuRGazvih7H+8mA
         zhud/mxy6yGKo3ozt5hyLcqUHzPpuWSssZNPTJ6hd0XcXSbpaAaF0zIhYtA93+veLZCf
         mS9uckJV8PKFznInShCZ6Aj+GGXNsCwn63OTHHzOYk7sf3M/hxDnDPm8/qzLnLXIQEof
         zEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=i58Ppfqdh+5bHRvHkrmBOHDeMbXtCVBJU1fm7/fb24M=;
        b=LgJj7w/AoU3qFiJ/sa8mRRpcwveCOBrha1gzzrPTiGZm7DSILpxg6A6r3s3CvOtLyf
         oBqBX53OV6EOZvSxSXN2zXv2AZQjf8H/XEaOKyZnY15avp6wsz47AipHNw7YmLWG/43w
         nOPAxEkC2+u/KVGKfMz42YTNmUU13cXjXVUYEminoFopwEltSLfhrvGRu4d2zqVRbwJX
         XE3pEPn3FY6TqIAJAjc9HyVXlsFdicWy/+4S3dN0gPy6ioZNVoAqjLB0bDuMpBmliSiT
         xFhQnA9R6gtU1cw0B6rguaNMzIVy/cj8CPcjj7GOYWogFVdU6OqQucDH3+xogNGFiMOk
         cPwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=D7GBWTIK;
       spf=pass (google.com: domain of rajatja@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rajatja@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=D7GBWTIK;
       spf=pass (google.com: domain of rajatja@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rajatja@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZrBb6btPhYTCnpeNfi6Vwi+xPrahXPfoffzXOWB8mqnSccO6mvaXMouZ5kLf97c1aN9iyBUQK5TMLyrt8MUKEw=
MIME-Version: 1.0
In-Reply-To: <dcbb2e92-722f-c178-efb7-8d99d4a9d99f@gmail.com>
References: <20180522222805.80314-1-rajatja@google.com> <20180522222805.80314-3-rajatja@google.com>
 <dcbb2e92-722f-c178-efb7-8d99d4a9d99f@gmail.com>
From: Rajat Jain <rajatja@google.com>
Date: Tue, 22 May 2018 16:27:33 -0700
Message-ID: <CACK8Z6GNPa+15WLxJBUAZ2=+jfhtdz+85=41B56KWSWCHSnyGw@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI/AER: Add sysfs stats for AER capable devices
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Thomas Tai <thomas.tai@oracle.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	linux-pci <linux-pci@vger.kernel.org>, linux-doc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jes Sorensen <jsorensen@fb.com>,
	Kyle McMartin <jkkm@fb.com>, Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205018627101133?=
X-GMAIL-MSGID: =?utf-8?q?1601208787543859608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 3:50 PM, Alex G. <mr.nuke.me@gmail.com> wrote:
>
>
> On 05/22/2018 05:28 PM, Rajat Jain wrote:
>> Add the following AER sysfs stats to represent the counters for each
>> kind of error as seen by the device:
>>
>> dev_total_cor_errs
>> dev_total_fatal_errs
>> dev_total_nonfatal_errs
>>
>> Signed-off-by: Rajat Jain <rajatja@google.com>
>> ---
>>  drivers/pci/pci-sysfs.c                |  3 ++
>>  drivers/pci/pci.h                      |  4 +-
>>  drivers/pci/pcie/aer/aerdrv.h          |  1 +
>>  drivers/pci/pcie/aer/aerdrv_errprint.c |  1 +
>>  drivers/pci/pcie/aer/aerdrv_stats.c    | 72 ++++++++++++++++++++++++++
>>  5 files changed, 80 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 366d93af051d..730f985a3dc9 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -1743,6 +1743,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
>>  #endif
>>       &pci_bridge_attr_group,
>>       &pcie_dev_attr_group,
>> +#ifdef CONFIG_PCIEAER
>> +     &aer_stats_attr_group,
>> +#endif
>>       NULL,
>>  };
>
> So if the device is removed as part of recovery, then these get reset,
> right? So if the device fails intermittently, these counters would keep
> getting reset. Is this the intent?

Umm, kind of.
* One argument is that if a PCI device is removed and then
re-enumerated, how do we know it is the same device and has not been
replaced by another device for e.g.?  Note that the root port counters
that have the cumulative counters for all the errors seen will still
have them logged in the situation you describe.

>
> (snip)
>
>>  /**
>>   * pci_match_one_device - Tell if a PCI device structure has a matching
>> diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
>> index d8b9fba536ed..b5d5ad6f2c03 100644
>> --- a/drivers/pci/pcie/aer/aerdrv.h
>> +++ b/drivers/pci/pcie/aer/aerdrv.h
>> @@ -87,6 +87,7 @@ void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info);
>>  irqreturn_t aer_irq(int irq, void *context);
>>  int pci_aer_stats_init(struct pci_dev *pdev);
>>  void pci_aer_stats_exit(struct pci_dev *pdev);
>> +void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
>>
>>  #ifdef CONFIG_ACPI_APEI
>>  int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
>> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> index 21ca5e1b0ded..5e8b98deda08 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> @@ -155,6 +155,7 @@ static void __aer_print_error(struct pci_dev *dev,
>>                       pci_err(dev, "   [%2d] Unknown Error Bit%s\n",
>>                               i, info->first_error == i ? " (First)" : "");
>>       }
>> +     pci_dev_aer_stats_incr(dev, info);
>
> What about AER errors that are contained by DPC?

Thanks, You are right, this patch does not take care of the DPC. I'll
try to read up on DPC and can integrate it if it turns out to be easy
enough.

Thanks,

Rajat

>
> Alex
