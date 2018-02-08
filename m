Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518099641; cv=none;
        d=google.com; s=arc-20160816;
        b=r80T6r2JLcdl/OFluNOLJRhKdi2guo4aEzFvZu+39dgNQ1nzlvsxdydnsynf7TJnd8
         KUqQdTG0rCl7ZJ6ULCj/yiO+xR0q3sNao8RULT1zboi7e6qVfN+qQSZ/x1WU4PmuVHH9
         yllfjfh710MEJUdcSpZ2H8z2CRzOZ4Onv2FvFNSYd40NgBq2OlqOcMHZh1ZWE1lwYGbR
         hXijFggLHbUxxq7c57qkF8FNFNlPpBsoMqhEMJhy+sjXMjkIZ19JpQENM18SvMtJanJ8
         mmfJmBkH0FTUblWnWmmCMB1H4DwBn7RGMqPlcBtcCF3jKEFiAmgGJUoIMCTK9rdJqmGx
         csxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AmHmfhbeBfL2i2CGnbm/wUEHZNlxHShc+MBqzTsotJs=;
        b=IkKXilV++Cq0T/hRNuqGfpDzL4U6P8RM/NSuHQXyIjoQdo7mZC8NYjbya/2CoiXgHe
         qEfsVySfzLVl1TlCuahaMlc3gQEqpXkmwvbMp/Pt8x5SyBT4KKMLoIab1DZYiDb0Gqeh
         N5y9S+yHAiK0YgJW/9VUc27fPpDfRxCnMK24llDcQIyvRlPDMgEqhDeay9dL6Sq/vCdu
         K0oTmER7G+/PyEHMoITwViV5DHoor2tEO2pDrX/cG2WDFj6CvLejt7HKLMXeHJNoz6ee
         liytakSKvc+CRYkVryHBv7vT+3JLcsWd8ccVw0rQDyHHofpEHPQ3ti60wbOR0U5tc2B5
         4UZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=bvHe5mRA;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=bvHe5mRA;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x2279nvdHVhHSesRoDXB/eayrHXChud3lXXoaSCZAvbd4rBvBIrtxn63e21d4k4SJy1oS0QFzGCsftDw2hjdKjQ4=
MIME-Version: 1.0
In-Reply-To: <20180130004051.15416.78620.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130003559.15416.18047.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180130004051.15416.78620.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 15:20:00 +0100
Message-ID: <CAOFm3uHN6bfhQgFSjOUPYMG6U5Z+E_4hmOtocvE7rchf+eCPew@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add SPDX GPL-2.0+ to replace implicit GPL v2 or
 later statement
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
	Sebastian Ott <sebott@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Jan Glauber <jang@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590975901365034097?=
X-GMAIL-MSGID: =?utf-8?q?1591842849741348578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jan 30, 2018 at 1:40 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> 7441b0627e22 ("s390/pci: PCI hotplug support via SCLP") added
> s390_pci_hpc.c, which included this license information:
>
>   +MODULE_LICENSE("GPL");
>
> Based on "git show 7441b0627e22:include/linux/module.h", that "GPL" string
> means "GPL v2 or later":
>
>    *      "GPL"                           [GNU Public License v2 or later]
>
> 0729dcf24832 ("s390: hotplug: make pci_hpc explicitly non-modular")
> subsequently replaced the MODULE_LICENSE() with a "License: GPL" comment.
>
> Add SPDX GPL-2.0+ and remove the "License: GPL" comment, relying on the
> assertion in b24413180f56 ("License cleanup: add SPDX GPL-2.0 license
> identifier to files with no license") that the SPDX identifier may be used
> instead of the full boilerplate text.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/hotplug/s390_pci_hpc.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
> index 530d0e49f2ed..ffdc2977395d 100644
> --- a/drivers/pci/hotplug/s390_pci_hpc.c
> +++ b/drivers/pci/hotplug/s390_pci_hpc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * PCI Hot Plug Controller Driver for System z
>   *
> @@ -5,8 +6,6 @@
>   *
>   * Author(s):
>   *   Jan Glauber <jang@linux.vnet.ibm.com>
> - *
> - * License: GPL
>   */
>
>  #define KMSG_COMPONENT "zpci"

Thanks!
I have CCed too: Jan Glauber <jang@linux.vnet.ibm.com> too just in case!


Reviewed-by: Philippe Ombredanne <pombredanne@nexB.com>
