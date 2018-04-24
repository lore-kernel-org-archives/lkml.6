Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeDXWZ4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:25:56 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:45028 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeDXWZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:25:53 -0400
X-Google-Smtp-Source: AIpwx4+QYdXua3VqOqzQhAbiIPaA400d7kS6ffpHqbLd2ggc94DooNVIurNNoi9evRl6sJ85huc5hw==
Date: Tue, 24 Apr 2018 15:25:51 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc: mhocko@kernel.org, akpm@linux-foundation.org, aarcange@redhat.com,
        guro@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper
 unmap
In-Reply-To: <201804250657.GFI21363.StOJHOQFOMFVFL@I-love.SAKURA.ne.jp>
Message-ID: <alpine.DEB.2.21.1804241525280.238665@chino.kir.corp.google.com>
References: <201804221248.CHE35432.FtOMOLSHOFJFVQ@I-love.SAKURA.ne.jp> <alpine.DEB.2.21.1804231706340.18716@chino.kir.corp.google.com> <201804240511.w3O5BY4o090598@www262.sakura.ne.jp> <alpine.DEB.2.21.1804232231020.82340@chino.kir.corp.google.com>
 <201804250657.GFI21363.StOJHOQFOMFVFL@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Tetsuo Handa wrote:

> > One of the reasons that I extracted __oom_reap_task_mm() out of the new 
> > oom_reap_task_mm() is to avoid the checks that would be unnecessary when 
> > called from exit_mmap().  In this case, we can ignore the 
> > mm_has_blockable_invalidate_notifiers() check because exit_mmap() has 
> > already done mmu_notifier_release().  So I don't think there's a concern 
> > about __oom_reap_task_mm() blocking while holding oom_lock.  Unless you 
> > are referring to something else?
> 
> Oh, mmu_notifier_release() made mm_has_blockable_invalidate_notifiers() == false. OK.
> 
> But I want comments why it is safe; I will probably miss that dependency
> when we move that code next time.
> 

Ok, makes sense.  I'll send a v3 to update the comment.
