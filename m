Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802B9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434A420825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434A420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbeKFHFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:05:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbeKFHFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:05:46 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E063830;
        Mon,  5 Nov 2018 21:44:01 +0000 (UTC)
Date:   Mon, 5 Nov 2018 13:44:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        dan.j.williams@intel.com, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
Message-Id: <20181105134400.f6f52f4db0f8d6a21446476e@linux-foundation.org>
In-Reply-To: <beaa1acf7423da7ee0f9bbc4cee2d14a@codeaurora.org>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
        <72215e75-6c7e-0aef-c06e-e3aba47cf806@suse.cz>
        <efb65160af41d0e18cb2dcb30c2fb86a@codeaurora.org>
        <20181010173334.GL5873@dhcp22.suse.cz>
        <a2d576a5fc82cdf54fc89409686e58f5@codeaurora.org>
        <20181011075503.GQ5873@dhcp22.suse.cz>
        <20181018191825.fcad6e28f32a3686f201acdf@linux-foundation.org>
        <20181019080755.GK18839@dhcp22.suse.cz>
        <c6289fada694462ed708174f9a1f3b6c@codeaurora.org>
        <beaa1acf7423da7ee0f9bbc4cee2d14a@codeaurora.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Nov 2018 15:12:27 +0530 Arun KS <arunks@codeaurora.org> wrote:

> On 2018-10-22 16:03, Arun KS wrote:
> > On 2018-10-19 13:37, Michal Hocko wrote:
> >> On Thu 18-10-18 19:18:25, Andrew Morton wrote:
> >> [...]
> >>> So this patch needs more work, yes?
> >> 
> >> Yes, I've talked to Arun (he is offline until next week) offlist and 
> >> he
> >> will play with this some more.
> > 
> > Converted totalhigh_pages, totalram_pages and zone->managed_page to
> > atomic and tested hot add. Latency is not effected with this change.
> > Will send out a separate patch on top of this one.
> Hello Andrew/Michal,
> 
> Will this be going in subsequent -rcs?

I thought were awaiting a new version?  "Will send out a separate patch
on top of this one"?

I do think a resend would be useful, please.  Ensure the changelog is
updated to capture the above info and any other worthy issues which
arose during review.

