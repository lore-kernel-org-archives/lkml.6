Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE2AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49B6208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49B6208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeH0Vpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:45:39 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:37370 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeH0Vpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:45:39 -0400
Received: by mail-io0-f197.google.com with SMTP id l6-v6so12998294iog.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 10:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=T9mcVtCoeZpwpJvGkP3T2nHtxtYdBpk62g8+I7TPGgs=;
        b=GLLfa+MaOe8s7OZhNoAO0WFLJ/1ht9gnno12jGDzzqsIk/zsY56cMDuuq71a+xuxrW
         4xDb7MduLYUECB70NKrTl0MWEfK2mDAu7DDe2MrTuihvvKDrg9godwFUgG8FkSMChVZ/
         iDA7RTHcEZqgikK1vIUQ8WfjJrpgi3Dz1yJoLCSeHDiRkWW5xiF+HYTHeYFdD9ScMJnO
         fYgVWx0veJGTe3ccGpL+DzKUj/8f6X6ojAAfClbLBGP5hr1m3khmFSc0+aihr9ri/olG
         gdmj0TILAzOMilCEQqxm+MB8Bdxk+nGOuYgTMUbpoTZTzPcL5cwCnCEmrkeK0PAt5WgB
         WYqg==
X-Gm-Message-State: APzg51CDMEvx0cs1Rl/TQO5igahpeK5quxQKwt5HV8bxvPPNS2Ah23qc
        8PyOQJ5dJ90zpzh+HetgTHm7sT9DN/BOaC5xh76o0nr3QPbE
X-Google-Smtp-Source: ANB0VdY5y2wj9PMPcw9XSHBDCFP5krU/qclCnaeEDlwcmiZiLqGQN9V9iviHo1nRDc+DbZkDE5tQ9jhKvLXzmQ7TEMr5agjRlZ/q
MIME-Version: 1.0
X-Received: by 2002:a02:491c:: with SMTP id z28-v6mr5965160jaa.55.1535392682926;
 Mon, 27 Aug 2018 10:58:02 -0700 (PDT)
Date:   Mon, 27 Aug 2018 10:58:02 -0700
In-Reply-To: <0000000000000956640571197f98@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074e86d05746e77cc@google.com>
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

HEAD commit:    2ad0d5269970 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14f7f36a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79e695838ce7a210
dashboard link: https://syzkaller.appspot.com/bug?extid=903cdd6bce9a6eb832a4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c5a07a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+903cdd6bce9a6eb832a4@syzkaller.appspotmail.com

0000000077534c7d: ffff8801d3be2188 (0xffff8801d3be2188)
00000000d99670e0: ffff8801cf5dbdf0 (0xffff8801cf5dbdf0)
0000000092c01301: ffff8801cf5dbd10 (0xffff8801cf5dbd10)
0000000039ac4013: ffffffff86c00d4a (do_softirq_own_stack+0x2a/0x40)
00000000f205f6c7: ffff8801cf5dbd10 (0xffff8801cf5dbd10)
WARNING: kernel stack frame pointer at 0000000092c01301 in  
syz-executor0:4993 has bad value 0000000097e4bf07
==================================================================
BUG: KASAN: stack-out-of-bounds in schedule_debug kernel/sched/core.c:3283  
[inline]
BUG: KASAN: stack-out-of-bounds in __schedule+0x1a18/0x1ec0  
kernel/sched/core.c:3393
Read of size 8 at addr ffff8801cf630000 by task syz-executor0/4993

CPU: 1 PID: 4993 Comm: syz-executor0 Not tainted 4.18.0+ #190
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:

The buggy address belongs to the page:
page:ffffea00073d8c00 count:1 mapcount:-512 mapping:0000000000000000  
index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 dead000000000100 dead000000000200 0000000000000000
raw: 0000000000000000 0000000000000000 00000001fffffdff ffff8801aee52b80
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801aee52b80

Memory state around the buggy address:
  ffff8801cf62ff00: f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00 00
  ffff8801cf62ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801cf630000: f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2 04 f2 f2 f2
                    ^
  ffff8801cf630080: f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00 00 00 00
  ffff8801cf630100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
==================================================================

