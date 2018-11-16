Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175E7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9E32087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9E32087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389354AbeKPUqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:46:23 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:40182 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeKPUqX (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 16 Nov 2018 15:46:23 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 16 Nov 2018 11:34:37 +0100
Received: from [149.44.172.157] (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Fri, 16 Nov 2018 10:34:20 +0000
Message-ID: <1542364443.3020.3.camel@suse.com>
Subject: Re: [PATCH 3/5] mm, memory_hotplug: drop pointless block alignment
 checks from __offline_pages
From:   osalvador <osalvador@suse.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Date:   Fri, 16 Nov 2018 11:34:03 +0100
In-Reply-To: <20181116083020.20260-4-mhocko@kernel.org>
References: <20181116083020.20260-1-mhocko@kernel.org>
         <20181116083020.20260-4-mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 09:30 +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> This function is never called from a context which would provide
> misaligned pfn range so drop the pointless check.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

I vaguely remember that someone reported a problem about misaligned
range on powerpc.
Not sure at which stage was (online/offline).
Although I am not sure if that was valid at all.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

