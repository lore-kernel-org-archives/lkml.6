Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A79FC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440142087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440142087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeGIMfa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:35:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932645AbeGIMf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:35:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E585ADAB;
        Mon,  9 Jul 2018 12:35:25 +0000 (UTC)
Date:   Mon, 9 Jul 2018 14:35:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional
 processes
Message-ID: <20180709123524.GK22049@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com>
 <20180705164621.0a4fe6ab3af27a1d387eecc9@linux-foundation.org>
 <alpine.DEB.2.21.1807061652430.71359@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807061652430.71359@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-07-18 17:05:39, David Rientjes wrote:
[...]
> Blockable mmu notifiers and mlocked memory is not the extent of the 
> problem, if a process has a lot of virtual memory we must wait until 
> free_pgtables() completes in exit_mmap() to prevent unnecessary oom 
> killing.  For implementations such as tcmalloc, which does not release 
> virtual memory, this is important because, well, it releases this only at 
> exit_mmap().  Of course we cannot do that with only the protection of 
> mm->mmap_sem for read.

And how exactly a timeout helps to prevent from "unnecessary killing" in
that case?
-- 
Michal Hocko
SUSE Labs
