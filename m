Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C84CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2EF2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2EF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeJKGUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:20:13 -0400
Received: from nautica.notk.org ([91.121.71.147]:43981 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbeJKGUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:20:13 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 53F93C009; Thu, 11 Oct 2018 00:55:54 +0200 (CEST)
Date:   Thu, 11 Oct 2018 00:55:39 +0200
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
Subject: Re: Re: BUG: corrupted list in p9_read_work
Message-ID: <20181010225539.GD788@nautica>
References: <20181010144855.GB20918@nautica>
 <00000000000010889e0577e0f5f2@google.com>
 <20181010160022.GD20918@nautica>
 <20181010161003.GA5371@nautica>
 <CACT4Y+ayTAyRghU5VmJgBdKaHxNCyoXf0NxXLgMGQf8aiY37Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+ayTAyRghU5VmJgBdKaHxNCyoXf0NxXLgMGQf8aiY37Tg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Wed, Oct 10, 2018:
> yeeeep, this is bug:
> https://github.com/google/syzkaller/issues/728

Yeah, it makes sense ; I just had to stumble on it once :)

> Turns out git fetch of a named remote and just a tree work
> differently. The latter only fetches the main branch.
> 
> 'git fetch <repo> <hash>' is it a thing? Is it something that requires
> special server configuration? I remember something similar that wasn't
> able to fetch a random commit hash all the time...

With my version of git (2.19.1); this works with a local tree (git fetch
/path/to/repo ref) and with a github remote, but not with a gitolite
remote ; I don't think it's safe to assume it'll always work, but it can
work.

> The plan was to make a named remote and then fetch it, this should
> fetch everything.

Yeah, that's less efficient but that'd fetch all named branches at
least; probably safer than what I tried :)

Anyway, the fix seems to be a hit, so cool!

Thanks!
-- 
Dominique
