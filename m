Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85192C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491D2214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491D2214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbeIXXRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:17:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:38400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728758AbeIXXRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:17:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5CCF0AD66;
        Mon, 24 Sep 2018 17:14:44 +0000 (UTC)
Date:   Mon, 24 Sep 2018 19:14:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     "prakash.sangappa" <prakash.sangappa@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com
Subject: Re: [PATCH V2 0/6] VA to numa node information
Message-ID: <20180924171443.GI18685@dhcp22.suse.cz>
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
 <20180913084011.GC20287@dhcp22.suse.cz>
 <375951d0-f103-dec3-34d8-bbeb2f45f666@oracle.com>
 <20180914055637.GH20287@dhcp22.suse.cz>
 <91988f05-2723-3120-5607-40fabe4a170d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91988f05-2723-3120-5607-40fabe4a170d@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-09-18 12:01:18, Steven Sistare wrote:
> On 9/14/2018 1:56 AM, Michal Hocko wrote:
[...]
> > Why does this matter for something that is for analysis purposes.
> > Reading the file for the whole address space is far from a free
> > operation. Is the page walk optimization really essential for usability?
> > Moreover what prevents move_pages implementation to be clever for the
> > page walk itself? In other words why would we want to add a new API
> > rather than make the existing one faster for everybody.
> 
> One could optimize move pages.  If the caller passes a consecutive range
> of small pages, and the page walk sees that a VA is mapped by a huge page, 
> then it can return the same numa node for each of the following VA's that fall 
> into the huge page range. It would be faster than 55 nsec per small page, but 
> hard to say how much faster, and the cost is still driven by the number of 
> small pages. 

This is exactly what I was arguing for. There is some room for
improvements for the existing interface. I yet have to hear the explicit
usecase which would required even better performance that cannot be
achieved by the existing API.

-- 
Michal Hocko
SUSE Labs
