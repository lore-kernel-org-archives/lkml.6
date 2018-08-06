Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E461C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6DD21A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6DD21A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeHFNfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:35:40 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:57057 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbeHFNfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:35:40 -0400
Received: by mail-io0-f198.google.com with SMTP id i13-v6so9516483ioq.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 04:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hRAWzR5kobE8+52QC391sjcvMY8+WZtoZ3BdxqcWMKQ=;
        b=EJXe2lLFw29A6BYu/k66y85WUIcMVWtdPpG3mJt0ZC6YmIV7G21fTD+QZofiBRsZIn
         tEapdUO2pyQ69kAZp2/OtB4N5W6V2LWPHVmYnfh7/evpu8MQ4tmfwqk8uYFCpKQiQbrj
         dxLrZzaRPu0q2weh46haOPV1GYHuUXdaefYRiR07YnequIF0TtxaRgG2Rl6uBshdOBjE
         Sl3MfTkhGB4N99Rp1GK0QQKiTMuiXRes5eSOusxPpp2fJxf/cdv/WJB/KCgKEDWjxaay
         9wFc8BonxSj0PaOZe/dHFvRzd1/O2jg5jzDTkFwyyGoK636kh7RyF2O9VMWy1ppBUauw
         PrRw==
X-Gm-Message-State: AOUpUlGjDhRB6atOO7AMtQgH3OGzndbMPywW8WTKnVgK0W1nbTVQoiZV
        sEn5WnpJrC7bdWMRoIux+W/VfrD5fGmvotc1KDVZNqxpgASL
X-Google-Smtp-Source: AA+uWPw2igTAWTgSK8vhNomI8TzuPIuoSJBakBYp7sske3sBg0RbiHTJ4fPZzhSYEYR3f5LU4VKiQpmm5fIX8AedO7Grlhhgj6nX
MIME-Version: 1.0
X-Received: by 2002:a24:5452:: with SMTP id t79-v6mr4486464ita.21.1533554822502;
 Mon, 06 Aug 2018 04:27:02 -0700 (PDT)
Date:   Mon, 06 Aug 2018 04:27:02 -0700
In-Reply-To: <884de816-671a-44d4-a6a1-2ad7eff53715@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070698b0572c28ebc@google.com>
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

commit:         8c8399e0a3fb Add linux-next specific files for 20180806
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b6bc1781e49e93e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fe18e2400000

Note: testing is done by a robot and is best-effort only.
