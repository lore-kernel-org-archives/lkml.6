Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C4778C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D70208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D70208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935554AbeFMStG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:49:06 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:37675 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935219AbeFMStD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:49:03 -0400
Received: by mail-io0-f199.google.com with SMTP id g20-v6so2897678ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 11:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yR2BKtt4Kda9f6fXZ4PLl3U5Og25f4i1jVspaSqvSAM=;
        b=rxxXOPRVZIY0zE7my8yMdFnLwQamgROvX95KnbwMsjEGKVuXzIcY1BE9WkeI59hxdt
         kHiUoN28/P8duz0D+x94Ybm6trBwFtUXktPGPHiaq/u16vksbGGfNLrY+wl9KimTvfZF
         lHl1tH75fCdZ3sZ929exhSM+aPJSQvTs3kDG6IBJCtmFG4b8Y3frfvg8nuRIUuVqnGuV
         ++c42bpYd09ZJY7/uPUf7zGtDlxm+aMjnQDHYtcjyhqvwO4A7GbgWfiTyZVqZZpNZvBt
         qaysh9BnzINFr0/el0MzEkQgw/oX+Ypo4jv/Jpw+WXp756JDWpzn1oQQlWytI3k5BIbq
         IQ1Q==
X-Gm-Message-State: APt69E1r210PFrcIdxcOp/W/clEnYFAU9+GVDVjY8ila4ycf97dh/A8U
        6lPhkC5Ax/pR9Qm8hmauuUdzmiOafSJDlv7z0WiSeyhGhHd5
X-Google-Smtp-Source: ADUXVKIXJC+OvSJmX41U8y8LCL3NemeOFvyHFT4AUqjp3t9kJ5Yk6ySRiO4Pr4ed04+8LfuqadP/tNse2WW5pVnf4TQqtBuVZJb7
MIME-Version: 1.0
X-Received: by 2002:a6b:f403:: with SMTP id i3-v6mr2635746iog.26.1528915742773;
 Wed, 13 Jun 2018 11:49:02 -0700 (PDT)
Date:   Wed, 13 Jun 2018 11:49:02 -0700
In-Reply-To: <26c434ee-0a0a-fbba-282c-dabddfac652e@iogearbox.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd582a056e8a6f29@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bpf_skb_vlan_push
From:   syzbot <syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
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
syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com

Tested on:

commit:         be779f03d563 Merge tag 'kbuild-v4.18-2' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=68d8eba98e3f8e88
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Note: testing is done by a robot and is best-effort only.
