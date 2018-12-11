Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2224C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09C32084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09C32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeLKPSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:18:12 -0500
Received: from 8bytes.org ([81.169.241.247]:53552 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbeLKPSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:18:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BBC51322; Tue, 11 Dec 2018 16:18:06 +0100 (CET)
Date:   Tue, 11 Dec 2018 16:18:06 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     iommu@lists.linux-foundation.org,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>, oohall@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, jroedel@suse.de,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/6] driver core: Introduce device_iommu_mapped() function
Message-ID: <20181211151806.GQ16835@8bytes.org>
References: <20181211134343.10664-1-joro@8bytes.org>
 <20181211134343.10664-2-joro@8bytes.org>
 <b1344a34-cd5f-f080-fddf-c1548f85af6a@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1344a34-cd5f-f080-fddf-c1548f85af6a@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:59:33PM +0300, Sergei Shtylyov wrote:
> > +static inline bool device_iommu_mapped(struct device *dev)
> > +{
> > +	return (dev->iommu_group != NULL);
> 
>    You know that parens are unnecessary here, right? :-)

Yes, I know, but it feels incomplete to me without them :-)

	Joerg
