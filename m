Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B08C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2AD218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeLRVqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:46:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36326 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeLRVqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:46:46 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 326F5DB9;
        Tue, 18 Dec 2018 21:46:45 +0000 (UTC)
Date:   Tue, 18 Dec 2018 13:46:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Oscar Salvador <osalvador@suse.de>, vbabka@suse.cz,
        pavel.tatashin@microsoft.com, rppt@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for
 HugePages
Message-Id: <20181218134644.6770936603f7640f415918a7@linux-foundation.org>
In-Reply-To: <20181218073655.GB30879@dhcp22.suse.cz>
References: <20181217225113.17864-1-osalvador@suse.de>
        <20181217150726.6eea4942005516d565dae488@linux-foundation.org>
        <20181218073655.GB30879@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 08:36:55 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> > > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

> > cc:stable?
> 
> See http://lkml.kernel.org/r/20181217152936.GR30879@dhcp22.suse.cz. I
> believe nobody is simply using gigantic pages and hotplug at the same
> time and those pages do not seem to cross cma regions as well. At least
> not since hugepage_migration_supported stops reporting giga pages as
> migrateable.
> 
> That being said, I do not think we really need it in stable but it
> should be relatively easy to backport so no objection from me to put it
> there.

OK, done.  Sasha would have grabbed it anyway :(
