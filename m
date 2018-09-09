Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DC4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7195220857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7195220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeIISFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 14:05:43 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:51117 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeIISFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 14:05:42 -0400
Received: by mail-it0-f71.google.com with SMTP id n194-v6so36170901itn.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 06:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Z3+E3mz2Rhx9mnCGgt5DmLAs6FsFBge5C/6ZXTt80hk=;
        b=BtXttqDnpfkOcfBtrv08YcstEz5r6PKWRNf4+fNnggo4r24aJ6vmOt/yqZHWUz1cNI
         NwBHQYcVuOHWslIVHiwLPqd3+UREDANJ9FybYzwsaTMtAMaOPpcDwPz8FmQ6kxcZ3+3A
         7TGQNLVPOdl4w8rNr/H0Gp5sThCkD3EBjjJ8qoLHg7qLOhhkTcKtWN/JJTKdcWDr9e2T
         AbZssjVwMzeHuxkLbBoRb2M/k+mdOcO8T6xCcFhyJEDhKiE2f3pfMU6H5FVNi+0ikEh/
         K8NkVz4VaqGo0aJEfGRuImeBProdWHX38W8tgFabhZBXG9mFd2koI99jFNdSl9pfZ57T
         Y/UQ==
X-Gm-Message-State: APzg51AO1qVm7nlyUPs/Qz2eL4kolYK9AdLI+U87r5prlkLqtAJTgj9N
        /Im/z2eceTsvrifWRJMhsvpIDxiVavJU0mcJiYOFoWMS+uhq
X-Google-Smtp-Source: ANB0VdZNog32aic5lqVGEylbATvU6OZYm5ribEcfQ7/AqImJn9Yuatlwa9fwGSoghxZhOz/1T4bTttPC/0gRZedArG3e+rkQ1ay2
MIME-Version: 1.0
X-Received: by 2002:a6b:4511:: with SMTP id s17-v6mr13602516ioa.29.1536498962708;
 Sun, 09 Sep 2018 06:16:02 -0700 (PDT)
Date:   Sun, 09 Sep 2018 06:16:02 -0700
In-Reply-To: <0000000000000956640571197f98@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000debf740575700af9@google.com>
Subject: Re: WARNING: kernel stack frame pointer has bad value (2)
From:   syzbot <syzbot+903cdd6bce9a6eb832a4@syzkaller.appspotmail.com>
To:     ak@linux.intel.com, dvyukov@google.com, ebiggers@google.com,
        hpa@zytor.com, jgross@suse.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        megha.dey@linux.intel.com, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    28619527b8a7 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=14800f0a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=903cdd6bce9a6eb832a4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a79cbe400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172a3d01400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+903cdd6bce9a6eb832a4@syzkaller.appspotmail.com

00000000d154fefb: 000000000044a069 (0x44a069)
000000006f318b9e: 0000000000000033 (0x33)
000000007d449f84: 0000000000000246 (0x246)
00000000e7603b48: 00007f129ff8fce8 (0x7f129ff8fce8)
00000000187b73f3: 000000000000002b (0x2b)
WARNING: kernel stack frame pointer at 00000000c37350d4 in  
syz-executor951:10824 has bad value 00000000530130ef

