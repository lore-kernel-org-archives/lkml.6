Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8773ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E29C20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E29C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389210AbeGTNmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:42:11 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:33924 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388276AbeGTNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:42:10 -0400
Received: by mail-io0-f197.google.com with SMTP id f9-v6so8290928ioh.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Pt5Sa5jKmJSi4m3g4t58eZpDglKILk1Yn5jlz9pCJf0=;
        b=Tk3C5wW2Lau4WB0kkawzAN3BVVEmBehcP3JDUujm8RCrcqHC4ht+6DEvINlmpr7lX8
         Q0o1/I+eDZ9+Q/+QtYXGPFxgYs0W/Hpyvv/Ii5kdM2anDVm9zZr4PX8qTwjZkg7jBu5K
         RzFgBYXKvgMCwD4DYVo/TsSQZjclAtT9ag6gNpIDzdT/63hAlWE7sSWyiDTQUbkQxMaX
         37/HDjLNBsxqcE9T+N9ae1uZElyrvsDfQobKaFa+M3BdBWzwNLmTlAWZLvn/5P4uJzOs
         yCH7UixrNcpBUTaaiMRPJk1AIYmFlBaWXcJhLlAwGTUi08dwucYWNQudSS89Y9oRWp+y
         b11w==
X-Gm-Message-State: AOUpUlE4du/dF+lxCiCjAcC7Q6xm7+WKJ94hmwhZYlFZB9l1xyAEizko
        bgwLO3ut7vkc91ah9NgzQialmTe0k6/rLAWZjmWotn9nPLD+
X-Google-Smtp-Source: AAOMgpeJEzKrN2/RFuj2SueVXigppkk9jkGgUABScW52TvL/MNykhABEiJl0vSUj4cZ0fNE2Qw2SDoVGYeOENNul9HvualrBdMNr
MIME-Version: 1.0
X-Received: by 2002:a24:419d:: with SMTP id b29-v6mr896858itd.48.1532091242515;
 Fri, 20 Jul 2018 05:54:02 -0700 (PDT)
Date:   Fri, 20 Jul 2018 05:54:02 -0700
In-Reply-To: <20180720121421.151182440@linuxfoundation.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004611dc05716dca53@google.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
From:   syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, smueller@chronox.de,
        stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

commit:         cf8cd3cd03e2 kmsan: fix CONFIG_KMSAN=n build
git tree:       https://github.com/google/kmsan.git/master
kernel config:  https://syzkaller.appspot.com/x/.config?x=c21487206316bcc3
compiler:       clang version 7.0.0 (trunk 334104)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11fec658400000

Note: testing is done by a robot and is best-effort only.
