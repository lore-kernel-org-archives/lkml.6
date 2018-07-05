Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B7FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E087C2406C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P8zmbDOU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P8zmbDOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E087C2406C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754121AbeGEPMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:12:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42356 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbeGEPMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:12:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C509D60B23; Thu,  5 Jul 2018 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530803562;
        bh=sNjvNGnfrrS3iR8ryd2BCf7/LwjjJbHiFSCjoxVckxs=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=P8zmbDOU6Wjd9KwwtbDDIOXDAsCngf5LtF9M+oSZp34I9oJ/TuN8O7GMiN+IMQWVX
         B9KYNNpuQdhlHMQap3XLqyjS/xK3NZpm10cuN6jAlaWwuhGi0Vv6ECd6QedboLXxcS
         5uBxH85whcnL0Zw15D4Y8/pJJhoeJwA6jqPGoVaY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E57C460B23;
        Thu,  5 Jul 2018 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530803562;
        bh=sNjvNGnfrrS3iR8ryd2BCf7/LwjjJbHiFSCjoxVckxs=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=P8zmbDOU6Wjd9KwwtbDDIOXDAsCngf5LtF9M+oSZp34I9oJ/TuN8O7GMiN+IMQWVX
         B9KYNNpuQdhlHMQap3XLqyjS/xK3NZpm10cuN6jAlaWwuhGi0Vv6ECd6QedboLXxcS
         5uBxH85whcnL0Zw15D4Y8/pJJhoeJwA6jqPGoVaY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Jul 2018 20:42:41 +0530
From:   poza@codeaurora.org
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 0/6] Fix issues and cleanup for ERR_FATAL and
 ERR_NONFATAL
In-Reply-To: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
Message-ID: <e2cdfff7ddffc3e10dc800c31bd27864@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Could you help to review this series ?

Regards,
Oza.

On 2018-06-22 15:28, Oza Pawandeep wrote:
> These are follow up patches for the series which modifies ERR_FATAL 
> handling.
> although there were couple of problems existed before which, itis also 
> fixing.
> 
> patch-1:
> Fixes the problem where ERR_FATAL and ERR_NONFATAL status should be 
> cleared
> taking severity mask into account.
> 
> patch-2:
> Takes care of clearing error fatal status
> 
> patch-3:
> Follow up patch where no more need of handling ERR_FATAL
> case.
> 
> patch-4:
> Fixes clearing device status in case of uncorrectable errors.
> (e.g. ERR_FATAL and ERR_NONFATAL)
> 
> patch-5:
> Fixes clearing device status in case of correctable errors.
> 
> patch-6:
> Follow up patch where no more need of handling pci_channel_io_frozen
> in pcie_portdrv_slot_reset()
> 
> Oza Pawandeep (6):
>   PCI/AER: Take severity mask into account while clearing error bits
>   PCI/AER: Clear uncorrectable fatal error status bits
>   PCI/ERR: Cleanup ERR_FATAL of error broadcast
>   PCI/AER: Clear device error status bits during ERR_FATAL and
>     ERR_NONFATAL
>   PCI/AER: Fix correctable status bits clearing in device register
>   PCI/PORTDRV: Remove ERR_FATAL handling from pcie_portdrv_slot_reset()
> 
>  drivers/pci/pcie/aer.c         | 35 
> +++++++++++++++++++++++------------
>  drivers/pci/pcie/err.c         | 15 +++++++--------
>  drivers/pci/pcie/portdrv_pci.c | 18 ------------------
>  include/linux/aer.h            |  5 +++++
>  4 files changed, 35 insertions(+), 38 deletions(-)
