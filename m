Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B3CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AA320020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AA320020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030288AbeFSRSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:18:21 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:40531 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030229AbeFSRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:18:08 -0400
Received: by mail-io0-f199.google.com with SMTP id r10-v6so639476ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=+4Bil8CpJ2iS60qRX/Vncgw3MPJld8YSGkWkK73vHAY=;
        b=hgz6PuB2jwWshbHl+oURv0f+lXjwhk6ptNwf+tkAWpgES9OkWwICkvTm7Xn+4txRp8
         JAo7iBZrNFMFXDlcO8RgbEKS5eiv9hdHzbsdA5LyW0Wk1Op3qgk3xOYq6SZRT6OIuSsD
         D+HuioR72fOSuOQTQ058H5236FtYuEMpggzkxkMa+5BAtxd95NKsldCKV0gweW3vtDos
         xU3OhbUTuxW2N3l3HxbMp6+XUOEoQfBtlJfl1/BdZR4EMeLtSuQfvUkNCKYCq7Tihaw6
         b4ZPB5SZtCqOq3NHbQEy1JHklkovDxV5yXzqhrIlDb7U/ud6/0gcdV8fE49Fe9ZWVdai
         MJYw==
X-Gm-Message-State: APt69E0oQLPbtw3/wRgQkG2zRyU4GCSaZvXBncqqCOE7nr3bmCmJAiWS
        kUUwc7U2DL/GKvGPWdY1d4mQDw1z1dG0b/3hvxlvxZ4gJJKv
X-Google-Smtp-Source: ADUXVKJi/81x13Frxv270rISPE6wOKuCeFOs2qfVa5Cbsqzu2o7EYF4mVDZhxjvhaNttPTHyCsRcKGe5pkAIw0YUtvzpeZqqPG8c
MIME-Version: 1.0
X-Received: by 2002:a6b:244:: with SMTP id 65-v6mr6486411ioc.76.1529428687860;
 Tue, 19 Jun 2018 10:18:07 -0700 (PDT)
Date:   Tue, 19 Jun 2018 10:18:07 -0700
In-Reply-To: <20180619171513.GT24375@twin.jikos.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a63ad7056f01dd32@google.com>
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

> --
> You received this message because you are subscribed to the Google  
> Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an  
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit  
> https://groups.google.com/d/msgid/syzkaller-bugs/20180619171513.GT24375%40twin.jikos.cz.
> For more options, visit https://groups.google.com/d/optout.
