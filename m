Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816E02086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816E02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbeLMTns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:43:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:44610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728626AbeLMTno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:43:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6EDCACE8;
        Thu, 13 Dec 2018 19:43:42 +0000 (UTC)
Subject: Re: [PATCH] mm: Replace verify_mm_writelocked() by
 lockdep_assert_held_exclusive()
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <1544729885-30702-1-git-send-email-longman@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <f874f3d6-2f84-cd3a-a227-43496d8175a7@suse.cz>
Date:   Thu, 13 Dec 2018 20:40:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1544729885-30702-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/18 8:38 PM, Waiman Long wrote:
> Using down_read_trylock() to check if a task holds a write lock on
> a rwsem is not reliable. A task can hold a read lock on a rwsem and
> down_read_trylock() can fail if a writer is waiting in the wait queue.
>
> So use lockdep_assert_held_exclusive() instead which can do the right
> check when CONFIG_LOCKDEP is on.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

There's already a patch in mmotm removing this completely:
https://www.ozlabs.org/~akpm/mmots/broken-out/mm-mmap-remove-verify_mm_writelocked.patch

Vlastimil
