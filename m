Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2947C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ED120666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="oorXtI1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ED120666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeJBVeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:34:44 -0400
Received: from imap.thunk.org ([74.207.234.97]:37282 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbeJBVeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DJIkIc09SRPDgabdsNtVXVOvcZue0pZFcoeBGnQhiaU=; b=oorXtI1DoSpnkN66i6Zkdej/Z6
        hDJ4ykKbdAw1hAKakdBcuXUCB6lLhuT9S3+kgSCNA5hkdDQhm5SL6nD0S9c4NpiDaqNLZD9mGOMbV
        r4mVKV2ZFUlXCZlpzd/ofcscU7hW6jEMeG35f1NgiowlYML3j+m7FbUrdJNau7skPYcA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g7M0l-0005ay-QW; Tue, 02 Oct 2018 14:50:55 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CFCA77A55B3; Tue,  2 Oct 2018 10:50:53 -0400 (EDT)
Date:   Tue, 2 Oct 2018 10:50:53 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+4c0fa7d385ea5af34e91@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in integrity_inode_free
Message-ID: <20181002145053.GD17537@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+4c0fa7d385ea5af34e91@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000009581bf0576c16d3a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009581bf0576c16d3a@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:47:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    846e8dd47c26 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a59d56400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
> dashboard link: https://syzkaller.appspot.com/bug?extid=4c0fa7d385ea5af34e91
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

#syz dup: general protection fault in rb_erase
