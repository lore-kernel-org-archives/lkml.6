Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DFBC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 05:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D2320BF2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 05:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D2320BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeHRI5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 04:57:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33932 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeHRI5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 04:57:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fqu8z-0002ph-11; Fri, 17 Aug 2018 23:51:25 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fqu8x-0007Ec-Cn; Fri, 17 Aug 2018 23:51:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
References: <87efft5ncd.fsf_-_@xmission.com>
        <20180724032419.20231-7-ebiederm@xmission.com>
        <87k1orgdoo.fsf_-_@xmission.com>
        <CACT4Y+bYFatW=CMgH4M6AjtjO297gbQ8xwnEV0_f7J64FLQ4QQ@mail.gmail.com>
        <87pnyg7rw3.fsf@xmission.com>
        <20180817122414.df0eee974434d170b1a54c31@linux-foundation.org>
Date:   Sat, 18 Aug 2018 00:51:14 -0500
In-Reply-To: <20180817122414.df0eee974434d170b1a54c31@linux-foundation.org>
        (Andrew Morton's message of "Fri, 17 Aug 2018 12:24:14 -0700")
Message-ID: <87bma01aul.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fqu8x-0007Ec-Cn;;;mid=<87bma01aul.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+0wPqu6Un8DXrVbZLk7jbsepb7U09EAnM=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal: Don't send signals to tasks that don't exist
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> Dude, lighten up.

This was in response to being asked by a the maintainers of a bot that has
wasted copious quanties of my time to please not waste their time.

To prevent the wasting of time it was requested that when syzbot would
be enabled on linux-next again that it only report issues when there is
a reproducer, and it can narrow the issue down to at least the branch in
linux-next the issue occured on.  I thought there was general agreement
on that point.

That very much did not happen in this case.  So I heard a request to not
waste the time of a bot from people who have not taken what appear to be
reasonable steps to not waste my time.

I am especially annoyed that the bot despite having a reproducer was not
able to at least narrow it down to the branch in linux-next.

I was dismayed when I saw the syzbot report triggered someone to remove
themselves from MAINTAINERS.

Further I actually received a bug report (not found one by luck when I
was skimming through a mailing list) from another group of people whose
automated testing also found the issue and were able to succesfully root
cause the issue.  So I know good but reports are possible on this issue.

In short.  I have been burned by syzbot.  I don't see evidence of change.
I am grumpy.

Eric

