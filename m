Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE1CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F66B21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F66B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeJRXkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:40:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727598AbeJRXkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:40:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B023A9363C232;
        Thu, 18 Oct 2018 23:38:56 +0800 (CST)
Received: from localhost (10.203.177.13) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Thu, 18 Oct 2018
 23:38:51 +0800
Date:   Thu, 18 Oct 2018 16:38:36 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Oscar Salvador <osalvador@techadventures.net>
CC:     <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <dan.j.williams@intel.com>, <yasu.isimatu@gmail.com>,
        <rppt@linux.vnet.ibm.com>, <malat@debian.org>,
        <linux-kernel@vger.kernel.org>, <pavel.tatashin@microsoft.com>,
        <jglisse@redhat.com>, <rafael@kernel.org>, <david@redhat.com>,
        <dave.jiang@intel.com>, <linux-mm@kvack.org>,
        <alexander.h.duyck@linux.intel.com>,
        Oscar Salvador <osalvador@suse.de>, <linuxarm@huawei.com>
Subject: Re: [PATCH 5/5] mm/memory-hotplug: Rework
 unregister_mem_sect_under_nodes
Message-ID: <20181018163836.00005a45@huawei.com>
In-Reply-To: <20181018150221.GA31605@techadventures.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
        <20181015153034.32203-6-osalvador@techadventures.net>
        <20181018152434.00001845@huawei.com>
        <20181018150221.GA31605@techadventures.net>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.13]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 17:02:21 +0200
Oscar Salvador <osalvador@techadventures.net> wrote:

> On Thu, Oct 18, 2018 at 03:24:34PM +0100, Jonathan Cameron wrote:
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Thanks a lot Jonathan for having tested it!
> 
> Did you test the whole serie or only this patch?
> Since you have caught some bugs testing the memory-hotplug code
> on ARM64, I wonder if you could test it with the whole serie
> applied (if you got some free time, of course).
> 
> 
> thanks again!

Sorry I should have said.  Whole series on latest mmotm as of yesterday.
Obviously that only tested some of the code paths as I didn't test
hmm at all.

There are a few more quirks to chase down on my list, but nothing
related to this series and all superficial stuff.

I'm away from my boards (or the remote connection to them anyway) until
the 29th so any other tests will probably have to wait until then.

It's not clear if we'll take the actual arm64 support forwards but
hopefully someone will pick it up in the near future if we don't.
The complexity around pfn_valid on arm64 may take some time to unwind.

Thanks,

Jonathan

