Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C90BECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 03:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21D22083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 03:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21D22083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJVLRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 07:17:50 -0400
Received: from foss.arm.com ([217.140.101.70]:41766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbeJVLRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 07:17:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C30AAA78;
        Sun, 21 Oct 2018 20:01:13 -0700 (PDT)
Received: from [10.163.1.17] (unknown [10.163.1.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 323BD3F5D3;
        Sun, 21 Oct 2018 20:01:06 -0700 (PDT)
Subject: Re: [PATCH V2 1/5] mm/hugetlb: Enable PUD level huge page migration
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        punit.agrawal@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        steve.capper@arm.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
 <1539316799-6064-2-git-send-email-anshuman.khandual@arm.com>
 <20181019080959.GL18839@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7d32fcdc-1ee3-7666-3b33-eda14ca8b380@arm.com>
Date:   Mon, 22 Oct 2018 08:31:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019080959.GL18839@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2018 01:39 PM, Michal Hocko wrote:
> I planed to get to review this earlier but been busy. Anyway, this patch
> should be applied only after movability one to prevent from
> (theoretical) bisectability issues.

Sure, I can change the order there.

> 
> I would probably fold it into the one which defines arch specific hook.

Hmm but that may be like doing two functionality changes together. Adding one
more conditional check and at the same time wrapping it over with a new name
which is part of a new scheme. I would suggest keeping the patches separate.
