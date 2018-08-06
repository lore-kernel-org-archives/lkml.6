Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C3EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE4821A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE4821A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbeHFVWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:22:32 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:55531 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHFVWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:22:31 -0400
Received: by mail-io0-f199.google.com with SMTP id p2-v6so1290625iom.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 12:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UwDp/HX5KfemQ5UoMPfG5bYs6TSr3/0pGwhRsomZCCc=;
        b=i7uhQOGYNxYN+mj1f7YklfLbUQ21nO7TJW0TTp1idWtAzl5C+pTAtgvmWJ4m26c4Ax
         Bqj3B5faNuwwj1PkEdfHXcdBGa/79isqYzYeJ1D/jyAQfO/h2iGL0OE/tb3CdoXRP74s
         DwJNBHlrZw6rkTQ6K97B/Yg9wH766S7NMzT9/F+gWMjJLpI3Dv3C1dyBgSSWGQLB3qgm
         V7BtUVkow5zGF228jOYOxXK+S/2Bgov4LOK18FUp4VY7YrGGpnD/xybYkbBEzMg5FFYA
         znmEF9ZhjTfURCBRMCqERtrXZo/qEhRGJP27og/aArPAaMMOZgGqnFloH9XsbjT6+UYA
         0o8A==
X-Gm-Message-State: AOUpUlGmpCeP5O4iH6E8+XLj6DErUiiut0iE7jmou8paO3z4aB+Hxuwd
        2JOaGdA6cqX2CX3rYpRO3AV31UloST7pEERt1LN5wWfSzN/w
X-Google-Smtp-Source: AA+uWPzkw1V7+DEiVgf3qtDqaO7FfJ7+TayHiSR+Nk/GMcp45RkGn6iHSp1J7yN5kW4eUesdn2wkMDJ0OL/1nr/96FvCPXIcIHOR
MIME-Version: 1.0
X-Received: by 2002:a24:2cf:: with SMTP id 198-v6mr5384466itu.56.1533582722563;
 Mon, 06 Aug 2018 12:12:02 -0700 (PDT)
Date:   Mon, 06 Aug 2018 12:12:02 -0700
In-Reply-To: <20180806185554.GG10003@dhcp22.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006986c30572c90de3@google.com>
Subject: Re: WARNING in try_charge
From:   syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com

Tested on:

commit:         116b181bb646 Add linux-next specific files for 20180803
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4f38be7c2c519d5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147b3a72400000

Note: testing is done by a robot and is best-effort only.
