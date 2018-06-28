Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF1C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D753A27865
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QzW+lhBA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QzW+lhBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D753A27865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754919AbeF1TRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:17:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753436AbeF1TRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:17:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D14E560B25; Thu, 28 Jun 2018 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530213468;
        bh=T3uAqQOmRTnDkuhFsr3Fk9+zMyDvUX9NsMSq8AbCeTU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QzW+lhBAbh14/uDZ68vb9cuq+91h45ThNCIFvuS7HyECjh76lsRI3VJsSWpmjaH9c
         aLC4C8PK79K6fSVPNx684VJ2/gn1sQbg0RE+gaOrJt8WIjmw2RUQaIvuHf+9P0XjxB
         dNny2HAyTf5YYaFenzqTcRAjdnnvGfW0mFAuBzhs=
Received: from [10.235.228.150] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD19860B16;
        Thu, 28 Jun 2018 19:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530213468;
        bh=T3uAqQOmRTnDkuhFsr3Fk9+zMyDvUX9NsMSq8AbCeTU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QzW+lhBAbh14/uDZ68vb9cuq+91h45ThNCIFvuS7HyECjh76lsRI3VJsSWpmjaH9c
         aLC4C8PK79K6fSVPNx684VJ2/gn1sQbg0RE+gaOrJt8WIjmw2RUQaIvuHf+9P0XjxB
         dNny2HAyTf5YYaFenzqTcRAjdnnvGfW0mFAuBzhs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD19860B16
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V3 5/6] PCI: Rename pci_try_reset_bus() to pci_reset_bus()
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VFIO DRIVER" <kvm@vger.kernel.org>
References: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
 <1530210507-9287-5-git-send-email-okaya@codeaurora.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <006d7041-6d5c-af10-6252-005978bdc203@codeaurora.org>
Date:   Thu, 28 Jun 2018 15:17:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530210507-9287-5-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/2018 2:28 PM, Sinan Kaya wrote:
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -905,7 +905,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
>  	 * delay after a reset is required.  Per spec requirements,
>  	 * the link is either working or not after that point.
>  	 */
> -	return pci_try_reset_bus(dev->bus);
> +	return pci_reset_bus(dev->bus);
>  }
>  

This should have been 

return pci_reset_bus(dev);

I'll wait until I hear more feedback.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
