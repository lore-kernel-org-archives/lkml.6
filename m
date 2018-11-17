Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98D3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED9F2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED9F2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeKRCm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:42:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeKRCm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:42:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E44F3DDBD;
        Sat, 17 Nov 2018 16:25:47 +0000 (UTC)
Received: from ovpn-120-236.rdu2.redhat.com (ovpn-120-236.rdu2.redhat.com [10.10.120.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76AFA5D962;
        Sat, 17 Nov 2018 16:25:44 +0000 (UTC)
Message-ID: <93ee204b846462f9ead610e5afe737389724d0aa.camel@redhat.com>
Subject: Re: WARNING in static_key_disable_cpuslocked
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        syzbot+6cffdef928852907751c@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     Borislav Petkov <bp@suse.de>, Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sat, 17 Nov 2018 17:25:43 +0100
In-Reply-To: <CAKv+Gu8tJZUgL7q0R2KvGdyK+_y1U7KHQNDMpCmM7ZGprkKajg@mail.gmail.com>
References: <000000000000710037057ad9551e@google.com>
         <CAKv+Gu8tJZUgL7q0R2KvGdyK+_y1U7KHQNDMpCmM7ZGprkKajg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 17 Nov 2018 16:25:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2018-11-17 at 06:52 -0800, Ard Biesheuvel wrote:
> (+ Paolo, Dave)
> 
> On Sat, 17 Nov 2018 at 01:59, syzbot
> <syzbot+6cffdef928852907751c@syzkaller.appspotmail.com> wrote:
> > 
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11f1dc25400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6cffdef928852907751c
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10126533400000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+6cffdef928852907751c@syzkaller.appspotmail.com

This should be addressed in current net-next, by commit:

commit 9c48060141bd937497774546e4bb89b8992be383
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Thu Nov 15 02:34:50 2018 +0100

    udp: fix jump label misuse

Cheers,

Paolo

