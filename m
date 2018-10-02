Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE5BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217E220666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Aqs14QSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217E220666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeJBVhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:37:14 -0400
Received: from imap.thunk.org ([74.207.234.97]:37488 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbeJBVhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=R0ZdSZq0rYUudrwTEAIAyDOaDp23v/Ybz+eU4LHcz9U=; b=Aqs14QSKD/YCqfsjMylmXDrzZR
        S4PMCucuM0DObW8uVwVHzSczUVQ+iflrgl2hPt3XXdmsxkyGvmxFettKWVyu652zU5xAGKe1JF8Xz
        10ujWCn9bhAvoTOQPwPFXuXtBSOpS7cB2pViSsUJzKnhJ9VszooMN/uF8CUHdUgZw53c=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g7M3A-0005cU-Sh; Tue, 02 Oct 2018 14:53:24 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CC0677A55B3; Tue,  2 Oct 2018 10:53:22 -0400 (EDT)
Date:   Tue, 2 Oct 2018 10:53:22 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+0e7e90fff14568b11ebe@syzkaller.appspotmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in jbd2_journal_commit_transaction
Message-ID: <20181002145322.GE17537@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+0e7e90fff14568b11ebe@syzkaller.appspotmail.com>,
        jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000314dab05769dd5b6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000314dab05769dd5b6@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 06:19:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    46c163a036b4 Add linux-next specific files for 20180921
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1283fef1400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=20ea07a946ad19d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=0e7e90fff14568b11ebe
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d6792a400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1610b21a400000

#syz dup: INFO: task hung in ext4_fallocate
