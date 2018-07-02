Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559C5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F10C2524D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F10C2524D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeGBNj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:39:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:45966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751912AbeGBNjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:39:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 031C1AD12;
        Mon,  2 Jul 2018 13:39:54 +0000 (UTC)
Date:   Mon, 2 Jul 2018 15:39:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 0/5] mm: zap pages with read mmap_sem in munmap
 for large mapping
Message-ID: <20180702133953.GV19043@dhcp22.suse.cz>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 30-06-18 06:39:40, Yang Shi wrote:
> 
> Background:
> Recently, when we ran some vm scalability tests on machines with large memory,
> we ran into a couple of mmap_sem scalability issues when unmapping large memory
> space, please refer to https://lkml.org/lkml/2017/12/14/733 and
> https://lkml.org/lkml/2018/2/20/576.
> 
> 
> History:
> Then akpm suggested to unmap large mapping section by section and drop mmap_sem
> at a time to mitigate it (see https://lkml.org/lkml/2018/3/6/784).
> 
> V1 patch series was submitted to the mailing list per Andrew’s suggestion
> (see https://lkml.org/lkml/2018/3/20/786). Then I received a lot great feedback
> and suggestions.
> 
> Then this topic was discussed on LSFMM summit 2018. In the summit, Michal Hock
> suggested (also in the v1 patches review) to try "two phases" approach. Zapping
> pages with read mmap_sem, then doing via cleanup with write mmap_sem (for
> discussion detail, see https://lwn.net/Articles/753269/)

The cover letter should really describe your approach to the problem.
But there is none here.
-- 
Michal Hocko
SUSE Labs
