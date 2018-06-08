Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id l44EKY0hGlseUgAAmS7hNA
	; Fri, 08 Jun 2018 06:27:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 64E59608C9; Fri,  8 Jun 2018 06:27:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 192C1607DC;
	Fri,  8 Jun 2018 06:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 192C1607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeFHG1k (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:27:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751244AbeFHG1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:27:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AD8FC12A8;
        Fri,  8 Jun 2018 06:27:38 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 735A010EE6CA;
        Fri,  8 Jun 2018 06:27:36 +0000 (UTC)
Date: Fri, 8 Jun 2018 14:27:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pagupta@redhat.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v4 3/4] mm/sparse: Add a new parameter 'data_unit_size'
 for alloc_usemap_and_memmap
Message-ID: <20180608062733.GB16231@MiWiFi-R3L-srv>
References: <20180521101555.25610-1-bhe@redhat.com>
 <20180521101555.25610-4-bhe@redhat.com>
 <8ff7638c-d3ee-a40c-e5cf-deded8d19e93@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff7638c-d3ee-a40c-e5cf-deded8d19e93@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 08 Jun 2018 06:27:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 08 Jun 2018 06:27:38 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/18 at 03:48pm, Dave Hansen wrote:
> On 05/21/2018 03:15 AM, Baoquan He wrote:
> > It's used to pass the size of map data unit into alloc_usemap_and_memmap,
> > and is preparation for next patch.
> 
> This is the "what", but not the "why".  Could you add another sentence
> or two to explain why we need this?

Thanks for reviewing, Dave.

In alloc_usemap_and_memmap(), it will call
sparse_early_usemaps_alloc_node() or sparse_early_mem_maps_alloc_node()
to allocate usemap and memmap for each node and install them into
usemap_map[] and map_map[]. Here we need pass in the number of present
sections on this node so that we can move pointer of usemap_map[] and
map_map[] to right position.

How do think about above words?

Thanks
Baoquan
