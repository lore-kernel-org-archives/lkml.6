Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22017C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4D821871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeLRNwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:52:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:44876 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeLRNwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:52:05 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gZFmx-0006Kg-Qx; Tue, 18 Dec 2018 13:51:59 +0000
Date:   Tue, 18 Dec 2018 13:51:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        DmitryVyukov <dvyukov@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at fs/inode.c:LINE!
Message-ID: <20181218135159.GV2217@ZenIV.linux.org.uk>
References: <00000000000051e9c2057d31a563@google.com>
 <20181217072144.GQ2217@ZenIV.linux.org.uk>
 <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 06:42:35PM +0800, Ian Kent wrote:

> Sorry Al, that's my bad.
> 
> See https://www.ozlabs.org/~akpm/mmotm/broken-out/autofs-fix-possible-inode-leak-in-autofs_fill_super.patch
> 
> I think this will fix it, I'll forward it to Andrew if you agree:

Just drop it and be done with that.  d_make_root(NULL) returns NULL,
no need to check that in the caller.  There is no leak in the mainline;
the calling conventions for d_make_root() are chosen that way
just for that reason - to minimize the amount of cleanups needed.
