Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id h9p1M8Y2GVtrYQAAmS7hNA
	; Thu, 07 Jun 2018 13:44:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6720C608BA; Thu,  7 Jun 2018 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528379083;
	bh=Pn+f4SrGbImOUNFcbc4MNV3slx53YnttR93PmGNqDrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=L5IqPpiUx+4pORuNm525URy/8cSfosl1Q/gxnM0kyHmOfRZMHd/Rl8gmscQg60EmU
	 iSPxRgYRkqbXrnjdwFnxAwvB05S9adsrDRPRZnRlNbtPBs31CoO+1lUHNxrxCskro2
	 TtRYmQ6Sg+H+dE7/+bzRWkh+Si/1K4L37GkeLcMg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BFEC7602FC;
	Thu,  7 Jun 2018 13:44:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hKNMH0aa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hp1z+T+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFEC7602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932662AbeFGNok (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:44:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53778 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932295AbeFGNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:44:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF7F7608CA; Thu,  7 Jun 2018 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528379077;
        bh=Pn+f4SrGbImOUNFcbc4MNV3slx53YnttR93PmGNqDrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hKNMH0aatcb3OKZxf3rUntHqduNaf1OczYOug4bNsFIa5WN3gRP2yZ/ST/aZ3R4QM
         foZCZH4C/ATQ41vAR3Ub+uJn3XYUF/aUOreGGIVuHrhpu/0F4fVK1my9BNzYdDJWdj
         NUfLNmkbSS1grZ3/Ygb/6Q9rXETC3UGoWLYseOW8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D0AC4602FC;
        Thu,  7 Jun 2018 13:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528379076;
        bh=Pn+f4SrGbImOUNFcbc4MNV3slx53YnttR93PmGNqDrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hp1z+T+Zux6hKAik+SF8VWjKPCR/pXwegFJKD4lK9dSRbx52rLCQzKWuvwe8O1lsV
         JyojrEXsul/FeD98DZTc8630JGdfyq0bHr7zyJhcbqJcqFUrbGxLjPmPmRbKQ2Rnl5
         ey857VCMQRMhgDGAKHnPuDghcJIW9xiGNYzbzi9o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Jun 2018 19:14:36 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH NEXT 1/6] PCI/AER: Take mask into account while clearing
 error bits
In-Reply-To: <20180607132140.GA15137@bhelgaas-glaptop.roam.corp.google.com>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
 <20180607132140.GA15137@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <08f79e22cde746f08942fc1de268a0e9@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-07 18:51, Bjorn Helgaas wrote:
> On Thu, Jun 07, 2018 at 02:00:29AM -0400, Oza Pawandeep wrote:
>> PCIe ERR_NONFATAL and ERR_FATAL are uncorrectable errors, and clearing
>> uncorrectable error bits should take error mask into account.
>> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> If/when you repost these, please include a [0/6] cover letter with an
> overview of the purpose of the series.
> 
> I assume these are for v4.19, so I'll look at them after the merge
> window.
> 
> If they fix issues introduced during the v4.18 merge window, we may be
> able to merge them during the v4.18 -rc cycle.  In this case, I would
> need specifics about what exactly the problems are.

sure Bjorn, will include cover letter.
Mostly these fixes the things which existed before 4.18 as well.
I have a question, please clarify when you get a chance.

I am posting the question on tops of PATCH-6.

Regards,
Oza.

> 
>> diff --git a/drivers/pci/pcie/aer/aerdrv.c 
>> b/drivers/pci/pcie/aer/aerdrv.c
>> index 377e576..8cbc62b 100644
>> --- a/drivers/pci/pcie/aer/aerdrv.c
>> +++ b/drivers/pci/pcie/aer/aerdrv.c
>> @@ -341,8 +341,6 @@ static pci_ers_result_t aer_root_reset(struct 
>> pci_dev *dev)
>>   */
>>  static void aer_error_resume(struct pci_dev *dev)
>>  {
>> -	int pos;
>> -	u32 status, mask;
>>  	u16 reg16;
>> 
>>  	/* Clean up Root device status */
>> @@ -350,11 +348,7 @@ static void aer_error_resume(struct pci_dev *dev)
>>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
>> 
>>  	/* Clean AER Root Error Status */
>> -	pos = dev->aer_cap;
>> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
>> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
>> -	status &= ~mask; /* Clear corresponding nonfatal bits */
>> -	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
>> +	pci_cleanup_aer_uncorrect_error_status(dev);
>>  }
>> 
>>  /**
>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c 
>> b/drivers/pci/pcie/aer/aerdrv_core.c
>> index 946f3f6..309f3f5 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>> @@ -50,13 +50,17 @@ 
>> EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
>>  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
>>  {
>>  	int pos;
>> -	u32 status;
>> +	u32 status, mask;
>> 
>>  	pos = dev->aer_cap;
>>  	if (!pos)
>>  		return -EIO;
>> 
>> +	/* Clean AER Root Error Status */
>> +	pos = dev->aer_cap;
>>  	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
>> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
>> +	status &= ~mask; /* Clear corresponding nonfatal bits */
>>  	if (status)
>>  		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
>> 
>> --
>> 2.7.4
>> 
