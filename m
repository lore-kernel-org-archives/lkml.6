Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B35C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AA12087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AA12087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJJWLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:11:42 -0400
Received: from nautica.notk.org ([91.121.71.147]:41016 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbeJJWLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:11:42 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 538ECC009; Wed, 10 Oct 2018 16:49:10 +0200 (CEST)
Date:   Wed, 10 Oct 2018 16:48:55 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        Ron Minnich <rminnich@sandia.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: BUG: corrupted list in p9_read_work
Message-ID: <20181010144855.GB20918@nautica>
References: <000000000000ca61cd0571178677@google.com>
 <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica>
 <CACT4Y+Y0JS17HaC8u6f2jz_wSuLnSTbUrGmMpN+fH2FT3H2cYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y0JS17HaC8u6f2jz_wSuLnSTbUrGmMpN+fH2FT3H2cYQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Wed, Oct 10, 2018:
> > Back to the current patch, since as I said I am not confident this is a
> > good enough fix for the current bug, will I get notified if the bug
> > happens again once the patch hits linux-next with the Reported-by tag ?
> > (I don't have the setup necessary to run a syz repro as there is no C
> > repro, and won't have much time to do that setup sorry)
> 
> Yes, the bug will be reported again if it still happens after the
> patch is merged (not just into linux-next, but into all tested trees,
> but it does not matter much). So marking bugs as fixed tentatively is
> fine if that's our best guess.

Ok, thanks for confirming...

> But note that syzbot can test fixes itself on request. It boils down
> to just giving it the patch and the base tree:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

.. and for clarifying that bit, let's try that! :)

#syz test: git://github.com/martinetd/linux e4ca13f7d075e551dc158df6af18fb412a1dba0a

-- 
Dominique
