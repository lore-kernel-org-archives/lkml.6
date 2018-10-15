Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5834C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBCB2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HsY8NHt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBCB2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJPAGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:06:32 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34093 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeJPAGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:06:31 -0400
Received: by mail-it1-f194.google.com with SMTP id l127-v6so27962543ith.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9tJkIwmiNogKfVSRiq92FISnq/IqExHnXn8s8fQC5EY=;
        b=HsY8NHt/gvHOz7zjuwjYgpzsCXYCZMPTmZkTH9rcpJKnBKv7N721yiUzflUSHwt4rE
         6Si2+R/kIyuZhDf2APs6RBjSv3TAnsU4x6qrzwIZiakC/WqWighl2w7LiFwhXmHB/gzG
         QW7OwyZuNR6SCX4+M60jz5mHUXsSQ5n77U8O+mDl4oSVLoKeXxlFDOw7DL57o4clq6Hi
         DYE0QBVXFNw4Uft/2R4yQUYSEDZEyY5eDH4ye/IDxmue1aSTgzvtYZzliP5gISJayYWY
         GUHWxy/rZgBWlx0fVG2oZVx44RpauIfdCvFn6G57LVemQLhd4aYIQVzuUK2ZtIDNhQ7E
         KvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9tJkIwmiNogKfVSRiq92FISnq/IqExHnXn8s8fQC5EY=;
        b=Psr80WYsFDLJEunRHdIdaENsUA5RpoFZ0HLBBLJZvxbCvMqqQJUAE+Cu3qpRk89uI5
         iWlSq1L2zBd51fT0vtGXHCdSiTrNcpGPy7Z452vUbCKEBUiG8NNYtASvPww6xIg69k+n
         anoF58Jme5kIFN0TCrkkt+hWavi9vEnWUV55po+YBgBgoUZTr4CmLMHvQgX7WFHB3+7y
         /tnlRr2K2xFsXMiR64ZFjLoH0iyvMMzC1aDflquBEBh2GSo+KZTi0Dbu8jpPhbNonr7D
         BKbx5HgNqsX7qHPV40GcCxCsHzvnytLYrpyKOLjYTzhzZp1u5eUvooufoT7V6lmgpqsW
         IEWw==
X-Gm-Message-State: ABuFfohetximqVYSQ8tr4uYcE6bX+y51yTBYjfAX1HBeGryl2ZaOP/Qy
        fV1oAN+iGUsCDpk+aluuthvv3upeznj3j35Lz0fxrQ==
X-Google-Smtp-Source: ACcGV60uef3BkrhVxteNq2QGe4T6SJErFm1g6A8eU8dAQ914k0TsaMfW/tEeCX1bYiY314z6XF7ZzjhiNN2AHK88lSo=
X-Received: by 2002:a24:de54:: with SMTP id d81-v6mr11419026itg.41.1539620436298;
 Mon, 15 Oct 2018 09:20:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3d47:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 09:20:35
 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1810151120060.1394-100000@iolanthe.rowland.org>
References: <00000000000050c44f05780f6bbe@google.com> <Pine.LNX.4.44L0.1810151120060.1394-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 15 Oct 2018 18:20:35 +0200
Message-ID: <CAAeHK+zc-JyzxTAtv7tuVAw8Aut2uAfGP7FfNmseALY1ZBgcNQ@mail.gmail.com>
Subject: Re: WARNING in usb_submit_urb (3)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com>,
        Thinh.Nguyen@synopsys.com,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 5:22 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Fri, 12 Oct 2018, syzbot wrote:
>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    9dcd936c5312 Merge tag 'for-4.19/dm-fixes-4' of git://git...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=123b8da1400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=24a30223a4b609bb802e
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13888991400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1476e5e6400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com
>>
>> IPVS: ftp: loaded support on port[0] = 21
>> ------------[ cut here ]------------
>> usb usb7: BOGUS urb flags, 1 --> 0
>> WARNING: CPU: 0 PID: 5828 at drivers/usb/core/urb.c:503
>> usb_submit_urb+0x717/0x14e0 drivers/usb/core/urb.c:502
>> Kernel panic - not syncing: panic_on_warn set ...
>
> This should have been fixed by commit 7a68d9fb8510 ("USB: usbdevfs:
> sanitize flags more").  Was that commit not present in the kernel you
> tested?

The commit is there, AFAICT. This must be a different issue.
