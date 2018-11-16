Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0A4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA79A20866
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA79A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389558AbeKPWHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:07:42 -0500
Received: from foss.arm.com ([217.140.101.70]:50256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbeKPWHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:07:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 709E380D;
        Fri, 16 Nov 2018 03:55:39 -0800 (PST)
Received: from [10.163.1.125] (unknown [10.163.1.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A24DA3F718;
        Fri, 16 Nov 2018 03:55:37 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 0/5] mm, memory_hotplug: improve memory offlining failures
 debugging
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>, Baoquan He <bhe@redhat.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20181116083020.20260-1-mhocko@kernel.org>
Message-ID: <8a91e93d-386d-f0bc-d639-a696bb37a34e@arm.com>
Date:   Fri, 16 Nov 2018 17:25:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181116083020.20260-1-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/2018 02:00 PM, Michal Hocko wrote:
> Hi,
> this has been posted as an RFC [1]. I have screwed during rebasing so
> there were few compilation issues in the previous version. I have also
> integrated review feedback from Andrew and Anshuman.
> 
> I have been promissing to improve memory offlining failures debugging
> for quite some time. As things stand now we get only very limited
> information in the kernel log when the offlining fails. It is usually
> only
> [ 1984.506184] rac1 kernel: memory offlining [mem 0x82600000000-0x8267fffffff] failed
> without no further details. We do not know what exactly fails and for
> what reason. Whenever I was forced to debug such a failure I've always
> had to do a debugging patch to tell me more. We can enable some
> tracepoints but it would be much better to get a better picture without
> using them.
> 
> This patch series does 2 things. The first one is to make dump_page
> more usable by printing more information about the mapping patch 1.
> Then it reduces the log level from emerg to warning so that this
> function is usable from less critical context patch 2. Then I have
> added more detailed information about the offlining failure patch 4
> and finally add dump_page to isolation and offlining migration paths.
> Patch 3 is a trivial cleanup.
> 
> Does this look go to you?
> 
> [1] http://lkml.kernel.org/r/20181107101830.17405-1-mhocko@kernel.org
> 

Agreed. It has been always difficult to debug memory hot plug problems
without a debug patch particularly to understand the unmovable pages
and their isolation failures in the range to be removed. This series
is definitely going to help improve the situation.
