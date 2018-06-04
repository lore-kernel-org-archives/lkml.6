Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeFDGwm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:52:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:53778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeFDGwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:52:41 -0400
Date: Mon, 4 Jun 2018 08:52:38 +0200
From: Michal Hocko <mhocko@kernel.org>
To: ufo19890607@gmail.com
Cc: akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v7 2/2] Refactor part of the oom report in dump_header
Message-ID: <20180604065238.GE19202@dhcp22.suse.cz>
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
 <1527940734-35161-2-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527940734-35161-2-git-send-email-ufo19890607@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 02-06-18 19:58:52, ufo19890607@gmail.com wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> The dump_header does not print the memcg's name when the system
> oom happened, so users cannot locate the certain container which
> contains the task that has been killed by the oom killer.
> 
> I follow the advices of David Rientjes and Michal Hocko, and refactor
> part of the oom report in a backwards compatible way. After this patch,
> users can get the memcg's path from the oom report and check the certain
> container more quickly.

I have earlier suggested that you split this into two parts. One to add
the missing information and the later to convert it to a single printk
output. Reducing the overhead from PATH_MAX to NAME_MAX is a good step
but it still really begs an example why we really insist on a single
printk and that should be in its own changelog.

Sorry if that was not clear previously.
-- 
Michal Hocko
SUSE Labs
