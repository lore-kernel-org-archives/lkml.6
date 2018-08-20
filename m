Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B73DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2636021531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2636021531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeHTHpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 03:45:04 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:50751 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeHTHpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 03:45:04 -0400
Received: by mail-it0-f69.google.com with SMTP id n194-v6so13462695itn.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 21:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=e0pBrixIBY55EOp6Pbjz8NZ7v9zJN7+yKL6cLHXZYaM=;
        b=BlgsU7Oaf1h465Ug6hcVMjXg3gMvrns3QI4LBjhjO8WG5tgYvv9io3nEcGsjfntrdi
         mKngrC3N2Rxz/3jk34TvU1Esa6JtAjs3rm8WEncQg5PeDucLEJVFm0mlKRCV1gaYUuLv
         OYnesSVOkiANjJuofylYQnUOmWZCnJsKGSgIH3lUJqz5Cb5CYG7V4VXw3QF/8X2+3D+4
         dGqCbbeGsfJXqgD4R5mtcLWMNp7QtRH588pRfew+rdZI3ekczNksd7IeNGdNUKPWjKSU
         X2DPhscqi9Q+XZwqqHVxzJ1u38DQ+9Wka8ekWXP2bHPb8VjZwOcCIXzkJGaGiUmhK1sC
         /gUQ==
X-Gm-Message-State: AOUpUlEaKull+wVb8ekqBdeuicW/C/+Q72ncWCQnMLpWvNPH21pMCHBG
        nkpkYF+0iyVz+LjQP1i3oUD6FM3Us/Qez/B2lTy9BIa8gltE
X-Google-Smtp-Source: AA+uWPxOUbQzYQUdUNRMIfTi7bF9c5Kf5QP3svShm5HOYti/BsEl5Dnp1qNerDAekH0WmfV5IaXM4CLzzZgoTNnWfQAh2nbBLnMc
MIME-Version: 1.0
X-Received: by 2002:a24:39c2:: with SMTP id l185-v6mr3881076ita.51.1534739462559;
 Sun, 19 Aug 2018 21:31:02 -0700 (PDT)
Date:   Sun, 19 Aug 2018 21:31:02 -0700
In-Reply-To: <00000000000056268e05737dcb95@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d22100573d66078@google.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
From:   syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>
To:     ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d7857ae43dcc Add linux-next specific files for 20180817
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c72fce400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b10cd1ea76bb092
dashboard link: https://syzkaller.appspot.com/bug?extid=30209ea299c09d8785c9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15df679a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15242741400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com

IPVS: stopping master sync thread 4657 ...
IPVS: stopping master sync thread 4663 ...
IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,  
id = 0
IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,  
id = 0
IPVS: stopping master sync thread 4664 ...
unregister_netdevice: waiting for lo to become free. Usage count = 1

