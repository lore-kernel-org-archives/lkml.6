Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeEQPsX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:48:23 -0400
Received: from ale.deltatee.com ([207.54.116.67]:49998 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeEQPsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:48:19 -0400
To: dmeyer@gigaio.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a0997fec-ba06-0d1d-a43d-fcc1600484f5@deltatee.com>
Date: Thu, 17 May 2018 09:48:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, bhelgaas@google.com, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, dmeyer@gigaio.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your hard work on this Doug!

On 17/05/18 06:00 AM, dmeyer@gigaio.com wrote:

> +	if (pci_enable_device(pdev)) {
> +		dev_err(&pdev->dev, "Cannot enable Switchtec device\n");
> +		return;
> +	}

I suspect we should probably cass pci_disable_device() before leaving
this function so it's in the same state we started. Just like we unmap
the mmio.

Logan
