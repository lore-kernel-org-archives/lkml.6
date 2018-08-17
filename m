Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3C2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E06208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E06208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeHQUGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:06:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbeHQUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:06:51 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51CBFCAA;
        Fri, 17 Aug 2018 17:02:42 +0000 (UTC)
Date:   Fri, 17 Aug 2018 19:02:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org,
        sthemmin@microsoft.com, Pavel Tatashin <pasha.tatashin@oracle.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>,
        haiyangz@microsoft.com, Dan Williams <dan.j.williams@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, osalvador@suse.de,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        devel@linuxdriverproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH RFC 1/2] drivers/base: export
 lock_device_hotplug/unlock_device_hotplug
Message-ID: <20180817170239.GF24945@kroah.com>
References: <20180817075901.4608-1-david@redhat.com>
 <20180817075901.4608-2-david@redhat.com>
 <20180817084146.GB14725@kroah.com>
 <5a5d73e9-e4aa-ffed-a2e3-8aef64e61923@redhat.com>
 <CAJZ5v0gkYV8o2Eq+EcGT=OP1tQGPGVVe3n9VGD6z7KAVVqhv9w@mail.gmail.com>
 <42df9062-f647-3ad6-5a07-be2b99531119@redhat.com>
 <20180817100604.GA18164@kroah.com>
 <4ac624be-d2d6-5975-821f-b20a475781dc@redhat.com>
 <20180817112850.GB3565@osiris>
 <ecc08303-96ee-76ad-fba4-0425413afa5a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc08303-96ee-76ad-fba4-0425413afa5a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 01:56:35PM +0200, David Hildenbrand wrote:
> E.g. When adding the memory block devices, we know that there won't be a
> driver to attach to (as there are no drivers for the "memory" subsystem)
> - the bus_probe_device() function that takes the device_lock() could
> pretty much be avoided for that case. But burying such special cases
> down in core driver code definitely won't make locking related to memory
> hotplug easier.

You don't have to have a driver for a device if you don't want to, or
you can just have a default one for all memory devices if you somehow
need it.  No reason to not do this if it makes things easier for you.

thanks,

greg k-h
