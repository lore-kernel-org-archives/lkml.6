Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C43C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5A0208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5A0208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeJPGcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:32:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeJPGcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:32:18 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C42C11B95;
        Mon, 15 Oct 2018 22:45:00 +0000 (UTC)
Date:   Mon, 15 Oct 2018 15:44:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-Id: <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
References: <20180925120326.24392-2-mhocko@kernel.org>
        <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com>
        <20181005073854.GB6931@suse.de>
        <alpine.DEB.2.21.1810051320270.202739@chino.kir.corp.google.com>
        <20181005232155.GA2298@redhat.com>
        <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com>
        <20181009094825.GC6931@suse.de>
        <20181009122745.GN8528@dhcp22.suse.cz>
        <20181009130034.GD6931@suse.de>
        <20181009142510.GU8528@dhcp22.suse.cz>
        <20181009230352.GE9307@redhat.com>
        <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com>
        <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 15:30:17 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> At the risk of beating a dead horse that has already been beaten, what are 
> the plans for this patch when the merge window opens?

I'll hold onto it until we've settled on something.  Worst case,
Andrea's original is easily backportable.

>  It would be rather 
> unfortunate for us to start incurring a 14% increase in access latency and 
> 40% increase in fault latency.

Yes.

>  Would it be possible to test with my 
> patch[*] that does not try reclaim to address the thrashing issue?

Yes please.

And have you been able to test it with the sort of workloads which
Andrea is attempting to address?
