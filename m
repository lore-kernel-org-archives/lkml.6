Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD8AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02AB21B18
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503407AbfBNWgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:36:04 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:50360 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393758AbfBNWgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:36:03 -0500
Received: by mail-it1-f198.google.com with SMTP id p66so12902125itc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9F3FWN/JdnZo0Fjde0G/oynfGZafxcDbbY/YXEc6qnw=;
        b=eNMtVw6bVyfDM5tO3NkdbzDrI44InFpZH/WV0mEO35Ic4BRLmU0BrrZKIHur2g7HOz
         ahcpayAZp2rliYDCjwoyXkdIwWeh/cB0RzvTr6UqYGD8/rM9Nkruf0P9T50EvNxVuW7i
         R++WEGGS+pYbG/Cr9vffsh6csI78xBoVlSUu0NyqBfa3dVKsQg406Qj71frrgcM4+nBI
         9r3Vo/U4h4KCB6T1Vc1Z3OmEveLP0PZbWzUoYDcZ2E5nqwMN5+cve3GGHewIf+AQbBK2
         lzXa+im1SLMYfaPbGkGWviSPfFExWPDN/tzHmFUA70TPmwBmqRp5Ic4iVISbpAJArb3Y
         IWPg==
X-Gm-Message-State: AHQUAuaT4w8PYcE3SgiPJTiS4k5SCWCHVZ33r9yGk5EVdhe/uPoqdwd4
        3dMctUZDoLRLgMeGYAhMy+hA/WCTKr64bHoOEgY12f4F4BuG
X-Google-Smtp-Source: AHgI3IaIkfKNmvMYVnj5+nTqDd9a3ztDWHUDkKuVQkkMslZkQe5lfjwk2cEjxxno42x1IClDOYCiaQncI1qQ6rvVKvcwIHxJUGJH
MIME-Version: 1.0
X-Received: by 2002:a5d:9057:: with SMTP id v23mr4717430ioq.6.1550183763067;
 Thu, 14 Feb 2019 14:36:03 -0800 (PST)
Date:   Thu, 14 Feb 2019 14:36:03 -0800
In-Reply-To: <CAHRSSEx0ifKf-bA9NGwXak0DhWt6Xfxe+SQgfEEdNcyVAPwb_Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088c7d60581e2483f@google.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (2)
From:   syzbot <syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        maco@android.com, syzkaller-bugs@googlegroups.com,
        tkjos@android.com, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

failed to checkout kernel repo  
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/linux-next:  
failed to run  
["git" "fetch" "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git" "linux-next"]:  
exit status 128
fatal: Couldn't find remote ref linux-next



Tested on:

commit:         [unknown]
git tree:        
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  
linux-next
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17832048c00000

