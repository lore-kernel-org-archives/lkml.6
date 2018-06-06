Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeFFBUn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 21:20:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43792 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeFFBUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 21:20:41 -0400
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, ryan@finnie.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com (open list:HEWLETT-PACKARD SMART ARRAY
        RAID DRIVER (hpsa)),
        linux-scsi@vger.kernel.org (open list:HEWLETT-PACKARD SMART ARRAY RAID
        DRIVER (hpsa)),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH V5] scsi: hpsa: disable device during shutdown
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1527913733-16492-1-git-send-email-okaya@codeaurora.org>
Date: Tue, 05 Jun 2018 21:19:57 -0400
In-Reply-To: <1527913733-16492-1-git-send-email-okaya@codeaurora.org> (Sinan
        Kaya's message of "Sat, 2 Jun 2018 00:28:53 -0400")
Message-ID: <yq1d0x4g18i.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8915 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=599
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806060011
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sinan,

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
> Disable device as part of the shutdown sequence.

Applied to 4.18/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
