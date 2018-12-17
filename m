Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091E5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E0D2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeLQXH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:07:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeLQXH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:07:28 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 36707B5E;
        Mon, 17 Dec 2018 23:07:27 +0000 (UTC)
Date:   Mon, 17 Dec 2018 15:07:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@suse.com, vbabka@suse.cz, pavel.tatashin@microsoft.com,
        rppt@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for
 HugePages
Message-Id: <20181217150726.6eea4942005516d565dae488@linux-foundation.org>
In-Reply-To: <20181217225113.17864-1-osalvador@suse.de>
References: <20181217225113.17864-1-osalvador@suse.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 23:51:13 +0100 Oscar Salvador <osalvador@suse.de> wrote:

> v1 -> v2:
> 	- Fix the logic for skipping pages by Michal
> 
> ---

Please be careful with the "^---$".  It signifies end-of-changelog, so
I ended up without a changelog!

> >From e346b151037d3c37feb10a981a4d2a25018acf81 Mon Sep 17 00:00:00 2001
> From: Oscar Salvador <osalvador@suse.de>
> Date: Mon, 17 Dec 2018 14:53:35 +0100
> Subject: [PATCH] mm, page_alloc: Fix has_unmovable_pages for HugePages
> 
> While playing with gigantic hugepages and memory_hotplug, I triggered
> the following #PF when "cat memoryX/removable":
> 
> ...
>
> Also, since gigantic pages span several pageblocks, re-adjust the logic
> for skipping pages.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

cc:stable?
