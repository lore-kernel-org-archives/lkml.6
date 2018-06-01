Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeFANeK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:34:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeFANeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:34:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9477B60224
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V3 2/2] scsi: hpsa: drop shutdown callback
To: Don Brace <don.brace@microsemi.com>
Cc: Ryan Finnie <ryan@finnie.org>, linux-pci@vger.kernel.org,
        timur@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "esc.storagedev" <esc.storagedev@microsemi.com>,
        "open list:HEWLETT-PACKARD SMART ARRAY RAID DRIVER (hpsa)"
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
 <1527542471-10316-2-git-send-email-okaya@codeaurora.org>
 <51bb7b82-c4a1-435c-7668-639db96d76e1@finnie.org>
 <af772e6434e645f4a42d22821442a3bd@microsemi.com>
 <3ebb873ea4658275e7fa89c01cd8bfe1@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <fe49b9b4-5e15-b0ae-59c3-33b5a31eeb9c@codeaurora.org>
Date: Fri, 1 Jun 2018 09:34:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3ebb873ea4658275e7fa89c01cd8bfe1@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2018 9:08 PM, okaya@codeaurora.org wrote:
> I have seen that shutdown() is also called from remove().
> 
> remove() is supposed to do a safe cleanup too. If it is leaving the hw in inconsistent state even though it is c lling shutdown , it is yet another bug.

Let's try to be constructive. I'll post a patch with the pci_disable added to shutdown
only as in my original proposal.

Somebody can deal with remove another day.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
