Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id X4yhMmwfHltcRwAAmS7hNA
	; Mon, 11 Jun 2018 07:07:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F2A45607A4; Mon, 11 Jun 2018 07:07:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8EED4605A5;
	Mon, 11 Jun 2018 07:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EED4605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbeFKHHZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:07:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:34823 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754066AbeFKHHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:07:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75E01AE61;
        Mon, 11 Jun 2018 07:07:22 +0000 (UTC)
Date: Mon, 11 Jun 2018 09:07:20 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>,
        akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v7 2/2] Refactor part of the oom report in dump_header
Message-ID: <20180611070720.GA13364@dhcp22.suse.cz>
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
 <1527940734-35161-2-git-send-email-ufo19890607@gmail.com>
 <20180603124941.GA29497@rapoport-lnx>
 <CAHCio2ifo3SNH9E3GX2=q1a=MNiNnoCu+2a++yX5_xMBheya5g@mail.gmail.com>
 <CAHCio2in8NXZRanE9MS0VsSZxKaSvTy96TF59hODoNCxuQTz5A@mail.gmail.com>
 <20180604045812.GA15196@rapoport-lnx>
 <CAHCio2gj-DoOek0RN718TCLZsOpNPd6Ua88HPijdqezuySDjaw@mail.gmail.com>
 <20180610051215.GA20681@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180610051215.GA20681@rapoport-lnx>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 10-06-18 08:12:16, Mike Rapoport wrote:
> On Fri, Jun 08, 2018 at 05:53:14PM +0800, 禹舟键 wrote:
> > Hi Mike
> > > My question was why do you call to alloc_constrained in the dump_header()
> > > function rather than pass the constraint that was detected a bit earlier to
> > > that function?
> > 
> > dump_header will be called by three functions: oom_kill_process,
> > check_panic_on_oom, out_of_memory.
> > We can get the constraint from the last two
> > functions(check_panic_on_oom, out_of_memory), but I need to
> > pass a new parameter(constraint) for oom_kill_process.
> 
> Another option is to add the constraint to the oom_control structure.

Which would make more sense because oom_control should contain the full
OOM context.
-- 
Michal Hocko
SUSE Labs
