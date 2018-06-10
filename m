Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vpWZGTW1HVsQGwAAmS7hNA
	; Sun, 10 Jun 2018 23:33:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 49A4B60795; Sun, 10 Jun 2018 23:33:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D71D1600D0;
	Sun, 10 Jun 2018 23:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D71D1600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeFJXdE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 19:33:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753531AbeFJXdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 19:33:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BCD6401EF03;
        Sun, 10 Jun 2018 23:33:03 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 658E16B409;
        Sun, 10 Jun 2018 23:32:59 +0000 (UTC)
Date: Mon, 11 Jun 2018 07:32:56 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pagupta@redhat.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v4 3/4] mm/sparse: Add a new parameter 'data_unit_size'
 for alloc_usemap_and_memmap
Message-ID: <20180610233256.GF16231@MiWiFi-R3L-srv>
References: <20180521101555.25610-1-bhe@redhat.com>
 <20180521101555.25610-4-bhe@redhat.com>
 <8ff7638c-d3ee-a40c-e5cf-deded8d19e93@intel.com>
 <20180608062733.GB16231@MiWiFi-R3L-srv>
 <74359df3-76a8-6dc7-51c5-27019130224f@intel.com>
 <20180608151748.GE16231@MiWiFi-R3L-srv>
 <6cb5f16f-68a6-84af-c7e6-1a563133fac8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb5f16f-68a6-84af-c7e6-1a563133fac8@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 10 Jun 2018 23:33:03 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 10 Jun 2018 23:33:03 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/18 at 09:13am, Dave Hansen wrote:
> On 06/08/2018 08:17 AM, Baoquan He wrote:
> > 
> > Then inside alloc_usemap_and_memmap(), For each node, we get how many
> > present sections on this node, call hook alloc_func(). Then we update
> > the pointer to point at a new position of usemap_map[] or map_map[].
> 
> I think this is the key.
> 
> alloc_usemap_and_memmap() is passed in a "void *" that it needs to
> update as things get consumed.  But, it knows only the quantity of
> objects consumed and not the type.  This effectively tells it enough
> about the type to let it update the pointer as objects are consumed.
> 
> Right?
> 
> Can we get that in the changelog?

Hmm, I like above sentences very much, thanks.

Do you means putting it in changelog, but not commit log of patch 3/4,
right? I can do this when repost.

Thanks
Baoquan
