Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DE1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081082089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081082089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389494AbeKPWJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:09:32 -0500
Received: from foss.arm.com ([217.140.101.70]:50314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeKPWJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:09:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD6F980D;
        Fri, 16 Nov 2018 03:57:28 -0800 (PST)
Received: from [10.163.1.125] (unknown [10.163.1.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B86C83F718;
        Fri, 16 Nov 2018 03:57:26 -0800 (PST)
Subject: Re: [PATCH 2/5] mm: lower the printk loglevel for __dump_page
 messages
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>, Baoquan He <bhe@redhat.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20181116083020.20260-1-mhocko@kernel.org>
 <20181116083020.20260-3-mhocko@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <77da3b3f-9f3e-560f-1f00-0eb8523447ef@arm.com>
Date:   Fri, 16 Nov 2018 17:27:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181116083020.20260-3-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2018 02:00 PM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> __dump_page messages use KERN_EMERG resp. KERN_ALERT loglevel (this is
> the case since 2004). Most callers of this function are really detecting
> a critical page state and BUG right after. On the other hand the
> function is called also from contexts which just want to inform about
> the page state and those would rather not disrupt logs that much (e.g.
> some systems route these messages to the normal console).
> 
> Reduce the loglevel to KERN_WARNING to make dump_page easier to reuse
> for other contexts while those messages will still make it to the kernel
> log in most setups. Even if the loglevel setup filters warnings away
> those paths that are really critical already print the more targeted
> error or panic and that should make it to the kernel log.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
