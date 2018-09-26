Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FA3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BBB2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BBB2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeIZO24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:28:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:56240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbeIZO2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:28:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6314AFE4;
        Wed, 26 Sep 2018 08:17:10 +0000 (UTC)
Date:   Wed, 26 Sep 2018 10:17:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill@shutemov.name, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 -mm] mm: brk: dwongrade mmap_sem to read when
 shrinking
Message-ID: <20180926081708.GG6278@dhcp22.suse.cz>
References: <1537922816-108051-1-git-send-email-yang.shi@linux.alibaba.com>
 <1537922816-108051-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537922816-108051-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-09-18 08:46:56, Yang Shi wrote:
> brk might be used to shinrk memory mapping too. Use __do_munmap() to
> shrink mapping with downgrading mmap_sem to read.

same comment wrt the changelog as for the previous patch.
-- 
Michal Hocko
SUSE Labs
