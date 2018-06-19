Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC42C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A704C20020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A704C20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030224AbeFSRSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:18:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:38153 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966368AbeFSRSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:18:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 163CFAC44;
        Tue, 19 Jun 2018 17:18:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A2BA4DA82B; Tue, 19 Jun 2018 19:15:14 +0200 (CEST)
Date:   Tue, 19 Jun 2018 19:15:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+ceb2606025ec1cc3479c@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, jbacik@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in close_fs_devices
Message-ID: <20180619171513.GT24375@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        syzbot <syzbot+ceb2606025ec1cc3479c@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, jbacik@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000b9e25a056de4dd10@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b9e25a056de4dd10@google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 06:17:03AM -0700, syzbot wrote:
> syzbot found the following crash on:
> 
> HEAD commit:    716a685fdb89 Merge branch 'x86-hyperv-for-linus' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15c5f46f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4f65cd4286737868
> dashboard link: https://syzkaller.appspot.com/bug?extid=ceb2606025ec1cc3479c
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1251799f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177f3edf800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ceb2606025ec1cc3479c@syzkaller.appspotmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git test-syzbot-fs-devices

The patches are work in progress but pass fstests and should address
these syzbot reports:

https://syzkaller.appspot.com/bug?extid=ceb2606025ec1cc3479c
syzbot+ceb2606025ec1cc3479c@syzkaller.appspotmail.com

https://syzkaller.appspot.com/bug?extid=909a5177749d7990ffa4
syzbot+909a5177749d7990ffa4@syzkaller.appspotmail.com

https://syzkaller.appspot.com/bug?extid=923aa93978c7ad27a9b1
syzbot+923aa93978c7ad27a9b1@syzkaller.appspotmail.com
