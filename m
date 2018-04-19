Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeDSTOH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:14:07 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36068 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbeDSTOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:14:06 -0400
X-Google-Smtp-Source: AIpwx4+Fg0PH+r0ERmUXzJJug1RqfMo7SvDtwS1KudX5vXEFP5SRueOC3rHlce4Z0i5zt9j0qG5NxQ==
Date: Thu, 19 Apr 2018 12:14:04 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc: mhocko@kernel.org, akpm@linux-foundation.org, aarcange@redhat.com,
        guro@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper
 unmap
In-Reply-To: <201804191945.BBF87517.FVMLOQFOHSFJOt@I-love.SAKURA.ne.jp>
Message-ID: <alpine.DEB.2.21.1804191212530.157851@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com> <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com> <20180418075051.GO17484@dhcp22.suse.cz> <alpine.DEB.2.21.1804181159020.227784@chino.kir.corp.google.com>
 <20180419063556.GK17484@dhcp22.suse.cz> <201804191945.BBF87517.FVMLOQFOHSFJOt@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018, Tetsuo Handa wrote:

> current code has a possibility that the OOM reaper is disturbed by
> unpredictable dependencies, like I worried that
> 
>   I think that there is a possibility that the OOM reaper tries to reclaim
>   mlocked pages as soon as exit_mmap() cleared VM_LOCKED flag by calling
>   munlock_vma_pages_all().
> 
> when current approach was proposed.

That's exactly the issue that this patch is fixing, yes.  If you brought 
that possibility up then I'm sorry that it was ignored.
