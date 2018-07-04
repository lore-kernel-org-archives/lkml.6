Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D965C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C4B246DE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C4B246DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeGDC07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:26:59 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60813 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeGDC06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:26:58 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w642Qk4R001089;
        Wed, 4 Jul 2018 11:26:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Wed, 04 Jul 2018 11:26:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w642Qkp7001083;
        Wed, 4 Jul 2018 11:26:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w642Qk6k001082;
        Wed, 4 Jul 2018 11:26:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201807040226.w642Qk6k001082@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional processes
From:   penguin-kernel@i-love.sakura.ne.jp
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
MIME-Version: 1.0
Date:   Wed, 04 Jul 2018 11:26:46 +0900
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com> <alpine.DEB.2.21.1807031841220.110853@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1807031841220.110853@chino.kir.corp.google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> Ping?
> 
> This can be something that can easily be removed if it becomes obsoleted 
> because the oom reaper is always able to free memory to the extent of 
> exit_mmap().  I argue that it cannot, because it cannot do free_pgtables() 
> for large amounts of virtual memory, but am fine to be proved wrong.

This is "[PATCH 3/8] mm,oom: Fix unnecessary killing of additional processes." in my series.

> 
> In the meantime, however, this patch should introduce no significant 
> change in functionality and the only interface it is added is in debugfs 
> and can easily be removed if it is obsoleted.
> 
> The work to make the oom reaper more effective or realible can still 
> continue with this patch.
> 
