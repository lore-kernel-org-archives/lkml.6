Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7735C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B0C20020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B0C20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030272AbeFSRSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:18:09 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:35305 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966552AbeFSRSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:18:06 -0400
Received: by mail-io0-f197.google.com with SMTP id r16-v6so657778ioj.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=+PePamGElnwr2T7qmkeLV0vPtxqAlcIlOl6pXh9QsHA=;
        b=m1tbOovtQlEQxd7LLUjVD7p/xl0SwTUUjRK79+AGhkPgSZnm7A+8DSbw8XnhKnuEak
         spsRnrAN85sZ4xwgWlkaW1P2lX0m25960COey5izjiXIDXgvNXyaacLrtHGZZJlPs6TI
         1MBVXzzlPZFG/1qOCZQfHHvcqr0fPVVD4vc+UzlqyJqt2S+3KPi/SGwtv34gtb/0JCaZ
         A+a1Qo1NMeAahWLWUFjzT+Krb0oCCQ7NQVJ/QkUukwfCO3HJqkZq9Z/M6tq8e8G24ndE
         aw3b6m7Zj3LMnClyF4U71fQe42k5ASgHLXB6QhuMKY8pES/9hYwpdHt9nS4FvSbwuzJH
         C9Gg==
X-Gm-Message-State: APt69E1gvTa5eZDwEeAois39ra0uUpJa+F9GurJBaiVMp9MOoTYVmVIE
        ceUl5IeZzanZM605BQt7pyMa/5B1ZHhMTxhNqOXJpRf2j841
X-Google-Smtp-Source: ADUXVKKzVlaEknhZLsiZZHnSsF4FWS3YkHRI5gY5YHJkkqwjnyg5/RsWNhaBGZL709PLI3by2sVtyI6p7CX+FjtEQc5bTDAj/eFl
MIME-Version: 1.0
X-Received: by 2002:a6b:bb42:: with SMTP id l63-v6mr7181313iof.101.1529428686107;
 Tue, 19 Jun 2018 10:18:06 -0700 (PDT)
Date:   Tue, 19 Jun 2018 10:18:06 -0700
In-Reply-To: <20180619171513.GT24375@twin.jikos.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b7ae5056f01dda9@google.com>
Subject: Re: Re: WARNING in close_fs_devices
From:   syzbot <syzbot+ceb2606025ec1cc3479c@syzkaller.appspotmail.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     clm@fb.com, dsterba@suse.com, dsterba@suse.cz, jbacik@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jun 05, 2018 at 06:17:03AM -0700, syzbot wrote:
>> syzbot found the following crash on:

>> HEAD commit:    716a685fdb89 Merge branch 'x86-hyperv-for-linus' of  
>> git://..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15c5f46f800000
>> kernel config:   
>> https://syzkaller.appspot.com/x/.config?x=4f65cd4286737868
>> dashboard link:  
>> https://syzkaller.appspot.com/bug?extid=ceb2606025ec1cc3479c
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller  
>> repro:https://syzkaller.appspot.com/x/repro.syz?x=1251799f800000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177f3edf800000

>> IMPORTANT: if you fix the bug, please add the following tag to the  
>> commit:
>> Reported-by: syzbot+ceb2606025ec1cc3479c@syzkaller.appspotmail.com

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git  
> test-syzbot-fs-devices

unknown command "test"


> The patches are work in progress but pass fstests and should address
> these syzbot reports:

> https://syzkaller.appspot.com/bug?extid=ceb2606025ec1cc3479c
> syzbot+ceb2606025ec1cc3479c@syzkaller.appspotmail.com

> https://syzkaller.appspot.com/bug?extid=909a5177749d7990ffa4
> syzbot+909a5177749d7990ffa4@syzkaller.appspotmail.com

> https://syzkaller.appspot.com/bug?extid=923aa93978c7ad27a9b1
> syzbot+923aa93978c7ad27a9b1@syzkaller.appspotmail.com
