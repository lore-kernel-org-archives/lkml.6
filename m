Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C04C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B5020C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B5020C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390443AbeGKVlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:41:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58042 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbeGKVlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:41:25 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B4FC6EB7;
        Wed, 11 Jul 2018 21:35:06 +0000 (UTC)
Date:   Wed, 11 Jul 2018 14:35:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC PATCH] mm, page_alloc: double zone's batchsize
Message-Id: <20180711143505.5ccb378fb67dc6ba8fa202a3@linux-foundation.org>
In-Reply-To: <20180711055855.29072-1-aaron.lu@intel.com>
References: <20180711055855.29072-1-aaron.lu@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 13:58:55 +0800 Aaron Lu <aaron.lu@intel.com> wrote:

> [550 lines of changelog]

OK, I'm convinced ;)  That was a lot of work - thanks for being exhaustive.

Of course, not all the world is x86 but I think we can be confident
that other architectures are unlikely to be harmed by the change, at least.

