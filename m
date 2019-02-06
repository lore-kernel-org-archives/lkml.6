Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF80C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7874F2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfBFQjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:39:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730520AbfBFQjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:39:52 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4130AF3CCF7C76F780C3;
        Thu,  7 Feb 2019 00:39:49 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Feb 2019
 00:39:43 +0800
Date:   Wed, 6 Feb 2019 16:39:29 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCHv5 03/10] acpi/hmat: Parse and report heterogeneous
 memory
Message-ID: <20190206163929.0000394a@huawei.com>
In-Reply-To: <20190206160613.GG28064@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
        <20190124230724.10022-4-keith.busch@intel.com>
        <20190206122814.00000127@huawei.com>
        <20190206160613.GG28064@localhost.localdomain>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


...

> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __init hmat_parse_address_range(union acpi_subtable_headers *header,
> > > +					   const unsigned long end)
> > > +{
> > > +	struct acpi_hmat_address_range *spa = (void *)header;
> > > +
> > > +	if (spa->header.length != sizeof(*spa)) {
> > > +		pr_debug("HMAT: Unexpected address range header length: %d\n",
> > > +			 spa->header.length);  
> > 
> > My gut feeling is that it's much more useful to make this always print rather
> > than debug.  Same with other error paths above.  Given the number of times
> > broken ACPI tables show up, it's nice to complain really loudly!
> > 
> > Perhaps others prefer to not do so though so I'll defer to subsystem norms.  
> 
> Yeah, I demoted these to debug based on earlier feedback. We should
> still be operational even with broken HMAT, so I don't want to create
> unnecessary panic if its broken, but I agree something should be
> immediately noticable if the firmware tables are incorrect. Maybe like
> what bad_srat() provides.

Agreed. Something general like that would be great. Let's people know they
should turn debug on.

Thanks,

Jonathan



