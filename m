Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F60C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA16F208A3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA16F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeGGTBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 15:01:04 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:56610 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753905AbeGGTBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 15:01:03 -0400
Received: by mail-it0-f69.google.com with SMTP id g4-v6so12348755itf.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 12:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qifOunqrXvtoI/ypKRubNY5AzJqr2U8VV8tT7aHHk3M=;
        b=O4x5l1ZgjPY3ojKeuT19D1NxtVzzJM8NQMVaGf0Q7zqob8rg7HbXDx/cvCc2aDzao8
         87yX08YkrO0KI6MmulKzf1muY5M5LgjosFJGv3AM6taMdWMegsGEC8qSDs0vJjLwRU96
         G+vZIuAGAaVQZgZ8XEb/qpbTLJililD1xJ3rkJwBD1m4gwHj66n30zAxyNaPc2SNVdzM
         kIV3VTqncQcdActp4WzJKtTWL0mFhoKHU8kVPBFinl+7ommjZF/Xjset0Yal6DAQ5ec4
         6/FciOLm2UfiMN0vcrbdB3/+0VPn214Do08CJqnTdrNYutIQ6FAjS8645tKUwSxGlyPZ
         p10g==
X-Gm-Message-State: APt69E30t+SghkqltoWfzdZ1L5aRPORQTTPcjjhV4GDwr9vqrbUrOhBj
        LzppByqpRP2SE6swkQyWpP6qUlkaQ2bEuvaf9ZBUaNze7fI+
X-Google-Smtp-Source: AAOMgpelL8uUssZ1EtAfUDNkuuOo2fUyu+Z2D8qKCi8LQoweBmeXKlly06Iek9Y9QvLjIBy5dzAGXuoKr5UksITkClOSxozbDSin
MIME-Version: 1.0
X-Received: by 2002:a6b:8cd5:: with SMTP id o204-v6mr6279976iod.62.1530990062684;
 Sat, 07 Jul 2018 12:01:02 -0700 (PDT)
Date:   Sat, 07 Jul 2018 12:01:02 -0700
In-Reply-To: <1612449.5GibSviISC@positron.chronox.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7542605706d66a3@google.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
From:   syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        smueller@chronox.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com

Tested on:

commit:         a00de5aa4da3 kmsan: delete some dead code
git tree:       https://github.com/google/kmsan.git/master
kernel config:  https://syzkaller.appspot.com/x/.config?x=b11f4cfb262ee607
compiler:       clang version 7.0.0 (trunk 334104)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a9badc400000

Note: testing is done by a robot and is best-effort only.
