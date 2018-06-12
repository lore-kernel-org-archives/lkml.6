Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 21997C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3F120660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U/kBjMCx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aVmcRWGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3F120660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934054AbeFLRpC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:45:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933574AbeFLRpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:45:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4286D6022C; Tue, 12 Jun 2018 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528825500;
        bh=2n8llUgkliDR69FuEA/1Z2l8XYNofv0QHii/5UR9Dcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U/kBjMCxZ0KckTB9RQkaZwAFJMms04KpPJ8FFfYCXbz38EBjiJQh5JIrJ5W+yc9lk
         nGPigkyz8NV5vyGcnf/u4TrVzq91iU2bPc44zqZxGeB0b0/WV+9bf+4f6Xbpz2RhWD
         dDfIbPjM+KrXpApYRunmg6osJftzilXDxJwjP83w=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7EB2B602B8;
        Tue, 12 Jun 2018 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528825499;
        bh=2n8llUgkliDR69FuEA/1Z2l8XYNofv0QHii/5UR9Dcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aVmcRWGD04KgTRbEFHpkuiPh0ajZ31Wo7NmRvI2/1sS8hKdG5tq17YJaK/ied6cUv
         96svA4wMtcSya9UKgtIN9bai4d+WPOIOo806Mc6Sw8Jc9AnJ0k5usfJoqg8ukVSsfk
         NiitZ29d7eGjwqvG4QRxBrBKDMXw7h7MWyO6ss7c=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 12 Jun 2018 23:14:59 +0530
From:   poza@codeaurora.org
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v2 3/5] PCI: iproc: Disable MSI parsing in certain PAXC
 blocks
In-Reply-To: <c44bf00c-b412-2cd1-75ee-7541bc775173@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-4-git-send-email-ray.jui@broadcom.com>
 <8f6d7771baec3f56e0ccf5efd0efe2a2@codeaurora.org>
 <c44bf00c-b412-2cd1-75ee-7541bc775173@broadcom.com>
Message-ID: <5dab98f1205c33320422ea1732bc6fba@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-12 22:28, Ray Jui wrote:
> On 6/12/2018 1:29 AM, poza@codeaurora.org wrote:
>> On 2018-06-12 05:51, Ray Jui wrote:
>>> The internal MSI parsing logic in certain revisions of PAXC root
>>> complexes does not work properly and can casue corruptions on the
>>> writes. They need to be disabled
>>> 
>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>  drivers/pci/host/pcie-iproc.c | 34 
>>> ++++++++++++++++++++++++++++++++--
>>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/pci/host/pcie-iproc.c 
>>> b/drivers/pci/host/pcie-iproc.c
>>> index 680f6b1..0804aa2 100644
>>> --- a/drivers/pci/host/pcie-iproc.c
>>> +++ b/drivers/pci/host/pcie-iproc.c
>>> @@ -1197,10 +1197,22 @@ static int 
>>> iproc_pcie_paxb_v2_msi_steer(struct
>>> iproc_pcie *pcie, u64 msi_addr)
>>>      return ret;
>>>  }
>>> 
>>> -static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, 
>>> u64 msi_addr)
>>> +static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, 
>>> u64 msi_addr,
>>> +                     bool enable)
>>>  {
>>>      u32 val;
>>> 
>>> +    if (!enable) {
>>> +        /*
>>> +         * Disable PAXC MSI steering. All write transfers will be
>>> +         * treated as non-MSI transfers
>>> +         */
>>> +        val = iproc_pcie_read_reg(pcie, IPROC_PCIE_MSI_EN_CFG);
>>> +        val &= ~MSI_ENABLE_CFG;
>>> +        iproc_pcie_write_reg(pcie, IPROC_PCIE_MSI_EN_CFG, val);
>>> +        return;
>> can be dropped.
> 
> 
> No it cannot be dropped. Please review the code carefully.

Ahhh, my bad, it looked like a new function to me, may e I need sleep.
sorry about that.

Reviewed-by: Oza Pawandeep <poza@codeaurora.org>



