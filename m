Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA190C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F6322545
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F6322545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933685AbeGFRSV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:18:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:40320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932910AbeGFRST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:18:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69E9EB054;
        Fri,  6 Jul 2018 17:18:18 +0000 (UTC)
Date:   Fri, 6 Jul 2018 10:18:12 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH 2/6] ipc: reorganize initialization of kern_ipc_perm.seq
Message-ID: <20180706171812.7kbleqyxjbggd4y7@linux-r8p5>
References: <20180705055920.19611-1-manfred@colorfullife.com>
 <20180705055920.19611-3-manfred@colorfullife.com>
 <CACT4Y+YyZT+JRyUcYRD83V13M-k91XUp1qkpBCUCkGfamLgDTg@mail.gmail.com>
 <7143da44-448b-8beb-7583-1a5516623649@colorfullife.com>
 <20180705145656.962e34582646b7a28d221f4a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180705145656.962e34582646b7a28d221f4a@linux-foundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2018, Andrew Morton wrote:

>On Thu, 5 Jul 2018 17:12:36 +0200 Manfred Spraul <manfred@colorfullife.com> wrote:
>
>> Hi Dmitry,
>>
>> On 07/05/2018 10:36 AM, Dmitry Vyukov wrote:
>> > [...]
>> > Hi Manfred,
>> >
>> > The series looks like a significant improvement to me. Thanks!
>> >
>> > I feel that this code can be further simplified (unless I am missing
>> > something here). Please take a look at this version:
>> >
>> > https://github.com/dvyukov/linux/commit/f77aeaf80f3c4ab524db92184d874b03063fea3a?diff=split
>> >
>> > This is on top of your patches. It basically does the same as your
>> > code, but consolidates all id/seq assignment and dealing with next_id,
>> > and deduplicates code re CONFIG_CHECKPOINT_RESTORE. Currently it's a
>> > bit tricky to follow e.g. where exactly next_id is consumed and where
>> > it needs to be left intact.
>> > The only difference is that my code assigns new->id earlier. Not sure
>> > if it can lead to anything bad. But if yes, then it seems that
>> > currently uninitialized new->id is exposed. If necessary (?) we could
>> > reset new->id in the same place where we set new->deleted.
>> Everything looks correct for me, it is better than the current code.
>> Except that you didn't sign off your last patch.
>>
>> As next step: Who can merge the patches towards linux-next?
>
>Me.
>
>But it's unclear which patchset we're talking about.  What's the plan
>here?  To combine both efforts?

I'm thinking this series will conflict with the ipc rhashtable fixes I
sent out earlier (https://lkml.org/lkml/2018/6/21/727).

Thanks,
Davidlohr
