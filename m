Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB958C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0E02147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0E02147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJQHJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:09:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbeJQHJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:09:26 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 72A812DF8;
        Tue, 16 Oct 2018 23:16:45 +0000 (UTC)
Date:   Tue, 16 Oct 2018 16:16:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Mel Gorman <mgorman@suse.de>, David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-Id: <20181016161643.9c16164889b4d99d6eff6763@linux-foundation.org>
In-Reply-To: <20181016231149.GJ30832@redhat.com>
References: <20181009094825.GC6931@suse.de>
        <20181009122745.GN8528@dhcp22.suse.cz>
        <20181009130034.GD6931@suse.de>
        <20181009142510.GU8528@dhcp22.suse.cz>
        <20181009230352.GE9307@redhat.com>
        <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com>
        <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
        <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org>
        <20181016074606.GH6931@suse.de>
        <20181016153715.b40478ff2eebe8d6cf1aead5@linux-foundation.org>
        <20181016231149.GJ30832@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 19:11:49 -0400 Andrea Arcangeli <aarcange@redhat.com> wrote:

> This was a severe regression
> compared to previous kernels that made important workloads unusable
> and it starts when __GFP_THISNODE was added to THP allocations under
> MADV_HUGEPAGE. It is not a significant risk to go to the previous
> behavior before __GFP_THISNODE was added, it worked like that for
> years.

5265047ac301 ("mm, thp: really limit transparent hugepage allocation to
local node") was April 2015.  That's a long time for a "severe
regression" to go unnoticed?

