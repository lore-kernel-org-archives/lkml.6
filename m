Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeFBLT5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 07:19:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeFBLT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 07:19:56 -0400
Date: Sat, 2 Jun 2018 04:19:40 -0700
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v7 1/2] Add an array of const char and enum
 oom_constraint in memcontrol.h
Message-ID: <20180602111940.GA31754@bombadil.infradead.org>
References: <CAHCio2hrYo6f35cT69+xa5BwUXpwYXXm76GppUBB2WTrKonaFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2hrYo6f35cT69+xa5BwUXpwYXXm76GppUBB2WTrKonaFQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 02, 2018 at 07:06:44PM +0800, 禹舟键 wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> This patch will make some preparation for the follow-up patch: Refactor
> part of the oom report in dump_header. It puts enum oom_constraint in
> memcontrol.h and adds an array of const char for each constraint.

This patch is whitespace damaged.  See the instructions for using git
send-email with gmail: https://git-scm.com/docs/git-send-email

> +static const char * const oom_constraint_text[] = {
> + [CONSTRAINT_NONE] = "CONSTRAINT_NONE",
> + [CONSTRAINT_CPUSET] = "CONSTRAINT_CPUSET",
> + [CONSTRAINT_MEMORY_POLICY] = "CONSTRAINT_MEMORY_POLICY",
> + [CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
> +};
> +

Um, isn't this going to put the strings in every file which includes
memcontrol.h?
