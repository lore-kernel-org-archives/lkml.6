Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152A7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF732087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF732087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbeKPXTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:19:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:35848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbeKPXTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:19:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3BB9AAFCA;
        Fri, 16 Nov 2018 13:06:44 +0000 (UTC)
Message-ID: <1542373588.3020.22.camel@suse.de>
Subject: Re: [PATCH 2/5] mm/memory_hotplug: Create add/del_device_memory
 functions
From:   osalvador <osalvador@suse.de>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     osalvador@techadventures.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Yasuaki Ishimatsu <yasu.isimatu@gmail.com>,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Jonathan.Cameron@huawei.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        alexander.h.duyck@linux.intel.com
Date:   Fri, 16 Nov 2018 14:06:28 +0100
In-Reply-To: <20181112212839.ut4owdqfuibzuhvz@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
         <20181015153034.32203-3-osalvador@techadventures.net>
         <CAPcyv4jM-EJCmOwFkPqXhtgR54UueNtHjfCUbnnJqFLmgj7Jvw@mail.gmail.com>
         <20181112212839.ut4owdqfuibzuhvz@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-12 at 21:28 +0000, Pavel Tatashin wrote:
> > 
> > This collides with the refactoring of hmm, to be done in terms of
> > devm_memremap_pages(). I'd rather not introduce another common
> > function *beneath* hmm and devm_memremap_pages() and rather make
> > devm_memremap_pages() the common function.
> > 
> > I plan to resubmit that cleanup after Plumbers. So, unless I'm
> > misunderstanding some other benefit a nak from me on this patch as
> > it
> > stands currently.
> > 
> 
> Ok, Dan, I will wait for your new refactoring series before
> continuing
> reviewing this series.

Hi Pavel,

thanks for reviewing the other patches.
You could still check patch4 and patch5, as they are not strictly
related to this one.
(Not asking for your Reviewed-by, but I would still like you to check
them)
I could use your eyes there if you have time ;-)

Thanks
Oscar Salvador
