Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeBHTNC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:13:02 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:42181 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHTNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:13:01 -0500
X-Google-Smtp-Source: AH8x224b5D3o/1s+H5yvlAMW8MQDHpLvoRF/VWFQ5cTjTkU7HNThK0OZUnfWZk8dLvlh/kgtQ25Gqw==
Date: Thu, 8 Feb 2018 11:12:48 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mhocko@suse.com, hughd@google.com
Subject: Re: [PATCH] mm/migrate: Rename various page allocation helper
 functions
In-Reply-To: <5458c2c9-3534-c00d-7abf-3315debbf896@linux.vnet.ibm.com>
Message-ID: <alpine.LSU.2.11.1802081059190.16719@eggly.anvils>
References: <20180204065816.6885-1-khandual@linux.vnet.ibm.com> <5458c2c9-3534-c00d-7abf-3315debbf896@linux.vnet.ibm.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018, Anshuman Khandual wrote:
> On 02/04/2018 12:28 PM, Anshuman Khandual wrote:
> > Allocation helper functions for migrate_pages() remmain scattered with
> > similar names making them really confusing. Rename these functions based
> > on type of the intended migration. Function alloc_misplaced_dst_page()
> > remains unchanged as its highly specialized. The renamed functions are
> > listed below. Functionality of migration remains unchanged.
> > 
> > 1. alloc_migrate_target -> new_page_alloc
> > 2. new_node_page -> new_page_alloc_othernode
> > 3. new_page -> new_page_alloc_keepnode
> > 4. alloc_new_node_page -> new_page_alloc_node
> > 5. new_page -> new_page_alloc_mempolicy
> 
> Hello Michal/Hugh,
> 
> Does the renaming good enough or we should just not rename these.

I'll neither ack nor nack, I don't greatly care: my concern was
to head you away from gathering them into a single header file.

Though alloc_new_node_page seems to me a *much* better name than
new_page_alloc_node; and I'm puzzled why you would demand this
conformity of some but not all of the functions of that type.

Hugh
