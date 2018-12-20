Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E00C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E902186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390223AbeLTWsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:48:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbeLTWsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 17:48:51 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C200BE2A;
        Thu, 20 Dec 2018 22:48:50 +0000 (UTC)
Date:   Thu, 20 Dec 2018 14:48:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        Oscar Salvador <OSalvador@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH] mm, memory_hotplug: do not clear numa_node
 association after hot_remove
Message-Id: <20181220144849.375f554ed6d1f968807aa6db@linux-foundation.org>
In-Reply-To: <f9dd3dd0-3b20-446f-a131-70180fb733bf@arm.com>
References: <20181108100413.966-1-mhocko@kernel.org>
        <20181108102917.GV27423@dhcp22.suse.cz>
        <048c04ae-7394-d03f-813e-42acdc965dd2@arm.com>
        <20181109075914.GD18390@dhcp22.suse.cz>
        <f9dd3dd0-3b20-446f-a131-70180fb733bf@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 16:34:29 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> > 
> > Do you see any problems with the patch as is?
> 
> No, this patch does remove an erroneous node-cpu map update which help solve
> a real crash.

I think I'll take that as an ack.
