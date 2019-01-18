Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44861C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198D32086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfARLVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:21:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727001AbfARLVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:21:47 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E0E2764CB6599412032A;
        Fri, 18 Jan 2019 19:21:45 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Fri, 18 Jan 2019
 19:21:44 +0800
Date:   Fri, 18 Jan 2019 11:21:34 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs
 attributes
Message-ID: <20190118112134.00003b65@huawei.com>
In-Reply-To: <20190116175804.30196-6-keith.busch@intel.com>
References: <20190116175804.30196-1-keith.busch@intel.com>
        <20190116175804.30196-6-keith.busch@intel.com>
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

On Wed, 16 Jan 2019 10:57:56 -0700
Keith Busch <keith.busch@intel.com> wrote:

> Add entries for memory initiator and target node class attributes.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-devices-node | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 3e90e1f3bf0a..a9c47b4b0eee 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -90,4 +90,27 @@ Date:		December 2009
>  Contact:	Lee Schermerhorn <lee.schermerhorn@hp.com>
>  Description:
>  		The node's huge page size control/query attributes.
> -		See Documentation/admin-guide/mm/hugetlbpage.rst
> \ No newline at end of file
> +		See Documentation/admin-guide/mm/hugetlbpage.rst
> +
> +What:		/sys/devices/system/node/nodeX/classY/
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		The node's relationship to other nodes for access class "Y".
> +
> +What:		/sys/devices/system/node/nodeX/classY/initiator_nodelist
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		The node list of memory initiators that have class "Y" access
> +		to this node's memory. CPUs and other memory initiators in
> +		nodes not in the list accessing this node's memory may have
> +		different performance.
> +
> +What:		/sys/devices/system/node/nodeX/classY/target_nodelist
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		The node list of memory targets that this initiator node has
> +		class "Y" access. Memory accesses from this node to nodes not
> +		in this list may have differet performance.

Different performance from what?  In the other thread we established that
these target_nodelists are kind of a backwards reference, they all have
their characteristics anyway.  Perhaps this just needs to say:
"Memory access from this node to these targets may have different performance"?

i.e. Don't make the assumption I did that they should all be the same!



