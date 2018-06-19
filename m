Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837BDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4CD20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4CD20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030404AbeFSRmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:42:08 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:33139 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030225AbeFSRmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:42:04 -0400
Received: by mail-io0-f198.google.com with SMTP id s19-v6so709420iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eE5UTXlqWBaalpy9COEzXZrNyhp1J2FjzD52vmXA44w=;
        b=Z7nXKxxj/YxjfSbVTocBnePI+5SA90FnhdT3yLDAhhw4YUvqMpwza/I6mx4+9ifyjy
         UmEATgqJH4bxt56IZB2gxHsRBxhZtfeP47kYb134z7DPWWDbnBaT5MEmZkQSFHrv39QK
         mw/TllKQtKn0QoNZ4dVHgrIduuVhvt/MLX/5HjyLwCV0p7DIe78OrTaZvztN2MJbGJEs
         pEsXow5YoMEmZfa6AhRyk3rewlt5pAVWX9r9Cbq/8fRUOsSIappF5dY0cqG8ztpNB3GC
         /yPVkFYDFbK113i3RG/s6VzQiny361wg0Ie2XOWZOxxUY99DeRcNDZnL4bgvrOip1AQG
         XppQ==
X-Gm-Message-State: APt69E2xzjIiEPg/6MiN7ns0HuCoLGfm/VNAopegnVbcpK39v7B9I6FM
        AXJpJdY+LNxlLeorsEFLMTZQ8HxssfhmUF/E5b+gOte/2YI2
X-Google-Smtp-Source: ADUXVKJBd+1Z8ulInM+ua30INbyWMz1qa8rZ9hmjtVL8U6FG4nRwV9IFJrC2lca39fvAafR8+PMhXoGPUE9sqXTuXQQ6+Hyjacb2
MIME-Version: 1.0
X-Received: by 2002:a02:b155:: with SMTP id s21-v6mr7803017jah.53.1529430122691;
 Tue, 19 Jun 2018 10:42:02 -0700 (PDT)
Date:   Tue, 19 Jun 2018 10:42:02 -0700
In-Reply-To: <20180619171720.t2tgzr5aonqzo2c4@twin.jikos.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c0243056f02336a@google.com>
Subject: Re: WARNING in close_fs_devices
From:   syzbot <syzbot+ceb2606025ec1cc3479c@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, dsterba@suse.cz, jbacik@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+ceb2606025ec1cc3479c@syzkaller.appspotmail.com

Tested on:

commit:         b0b8c45747a5 wip streamline uuid locking in btrfs_mount_root
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/test-syzbot-fs-devices
kernel config:  https://syzkaller.appspot.com/x/.config?x=26c272eeaa8c437e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Note: testing is done by a robot and is best-effort only.
