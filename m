Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968611AbeE3BuP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:50:15 -0400
Received: from feh.colobox.com ([209.177.154.210]:59606 "EHLO feh.colobox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968432AbeE3BuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:50:12 -0400
Subject: Re: [PATCH V3 2/2] scsi: hpsa: drop shutdown callback
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:HEWLETT-PACKARD SMART ARRAY RAID DRIVER (hpsa)"
        <esc.storagedev@microsemi.com>,
        "open list:HEWLETT-PACKARD SMART ARRAY RAID DRIVER (hpsa)"
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
 <1527542471-10316-2-git-send-email-okaya@codeaurora.org>
From: Ryan Finnie <ryan@finnie.org>
Message-ID: <51bb7b82-c4a1-435c-7668-639db96d76e1@finnie.org>
Date: Tue, 29 May 2018 18:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527542471-10316-2-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 02:21 PM, Sinan Kaya wrote:
> 'Commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
> shutdown")' has been added to kernel to shutdown pending PCIe port
> service interrupts during reboot so that a newly started kexec kernel
> wouldn't observe pending interrupts.
> 
> pcie_port_device_remove() is disabling the root port and switches by
> calling pci_disable_device() after all PCIe service drivers are shutdown.
> 
> This has been found to cause crashes on HP DL360 Gen9 machines during
> reboot due to hpsa driver not clearing the bus master bit during the
> shutdown procedure by calling pci_disable_device().
> 
> Drop the shutdown API and do an orderly clean up by using the remove.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
> Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
> Cc: stable@vger.kernel.org
> Reported-by: Ryan Finnie <ryan@finnie.org>

Tested successfully on DL360 Gen9 and DL380 Gen9.

Tested-by: Ryan Finnie <ryan@finnie.org>
