Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5E6E3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E40A20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E40A20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935954AbeFMOkc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:40:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:52565 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935815AbeFMOkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:40:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 25FA0AB3C;
        Wed, 13 Jun 2018 14:40:30 +0000 (UTC)
Date:   Wed, 13 Jun 2018 16:40:28 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Andreas =?UTF-8?B?R3LDvG5iYWNoZXI=?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: Quilt vs gmail (Was: [PATCH 0/3] sched/swait: Convert to full
 exclusive mode)
Message-ID: <20180613164028.0f7b520b@endymion>
In-Reply-To: <CAHpGcMKj1MNyc0XJuKxf727jtNhiKpL3AuR_+pRZipWXG+V08w@mail.gmail.com>
References: <20180612083449.100099222@infradead.org>
        <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
        <20180612171420.GU12217@hirez.programming.kicks-ass.net>
        <20180613143247.1b749c83@endymion>
        <CAHpGcMKj1MNyc0XJuKxf727jtNhiKpL3AuR_+pRZipWXG+V08w@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 15:27:31 +0200, Andreas Grünbacher wrote:
> All of that may be correct, but those headers apparently do break
> email based patch reviewing on Thunderbird and Gmail now, and that's
> not very likely to change. If we continue with our current practice,
> we'll end up frustrating users. On top of that, i we make this an
> optional feature, quilt users may think that using that option is a
> good idea when they will actually break their recipients' workflows.
> As Thomas Gleixner wrote in the other thread, most recipients will
> already have a way to deal with messages from other sources that don't
> include patch filenames, so let's just get rid of Content-Disposition
> headers in quilt for good.

It always feels bad to me to work around an issue in one piece of
software when the bug is clearly in another piece of software. I'm not
sure why fixes on the correct side of the problem should be unlikely.
The behavior is clearly broken and against the RFC, and there may be
other sources than quilt triggering the bug. Thunderbird is open
source, the problem is identified, it shouldn't be that hard to fix it.
Gmail is a different story, of course, but I guess there are some
developers maintaining it too.

That being said... I agree that recipients of such e-mails most likely
already have an alternative solution in place for non-quilt sources, so
probably removing the Content-Disposition header is not going to cause
too much trouble. So feel free to go ahead and remove it if you think
this is the best thing to do. If some users complain about the change,
I'll let you deal with them ;-)

-- 
Jean Delvare
SUSE L3 Support
