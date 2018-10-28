Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F031C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B33D20664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E0kPpUFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B33D20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJ2D7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 23:59:23 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37821 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJ2D7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 23:59:23 -0400
Received: by mail-lf1-f44.google.com with SMTP id a82-v6so4413733lfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6BJpW0vXjcIVioybbeiZn3kl7deE/HxdKfdFeb2/JsI=;
        b=E0kPpUFD4aswCOwk3oBt5zYSCGeJH6Wxinee34z8J3KTNeHz4o/j6fAS9mDKSm8muR
         aAW4rqBUxg7XhqmfjzIWfaVJwe8+YqSRiPC1eiyVX2B8TlOlgja23bTX61zWu6PSFqlT
         m4bp6UdUUrA4tjuu9bI77E1urA3OJCMt27Rwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6BJpW0vXjcIVioybbeiZn3kl7deE/HxdKfdFeb2/JsI=;
        b=BN4lQuSTXjJiTdRBEaYwzJioQ+CKDk8dpYL1iYYzt5eU2S4z3wQPdFnwIWF/+vvW6L
         8sUAoauiz+pHbX31ekOoSulImu/EIqeLaqfJ1fF1kjsxtN6p4YtZY9QvL8c/qRv4Ukw8
         5ERdjo1m2IiQLaNflU0c/yxvL4+NDgvYC6mWXggPCcyQV3H3qzxrnDUQg4fliy2ovsTp
         93enCnMLn8YnNyXk6uJT7PDbBZXLBjJHtjfTkdxz/8PoNbdC4waAVJV4hYpzITUMPU3M
         Ku7DmEKuArepZwnZzfU/cg4qCwuFU7149hB+o422v687Vy7xT0wAbh0pXepoVW1M0C6l
         KZSg==
X-Gm-Message-State: AGRZ1gK+SE8rIoV5cTdFOdmu8cNE3IiJbIohCCZFBp+AiMdLqsGwkbU/
        x1K6ayBNpaSq6u1Fx531DpYHPucETBI=
X-Google-Smtp-Source: AJdET5ftRMHfVhoJ7iLxo44Uq7JonFDvjkr5xZ5EmBDfui0J8ECt0CClR68WrZM97gbB5c7bX2alvA==
X-Received: by 2002:a19:978c:: with SMTP id z134mr1103477lfd.109.1540754026769;
        Sun, 28 Oct 2018 12:13:46 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id k137-v6sm275388lfe.43.2018.10.28.12.13.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 12:13:46 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id g8-v6so2802679ljk.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 12:13:45 -0700 (PDT)
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr2267976ljc.120.1540754025288;
 Sun, 28 Oct 2018 12:13:45 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 12:13:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
Message-ID: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
Subject: Logitech high-resolution scrolling..
To:     Harry Cutts <hcutts@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I use a Logitech MX Anywhere 2S mouse, and really like it. I have
the scroll-wheel unlocked, because I like flicking once to scroll a
lot.

However, the new high-res scroll code means that the scroll wheel
action is now much too sensitive. It's not even stable - it will
scroll back-and-forth a bit occasionally, and in fact it sometimes
seems to scroll not because I touch the scroll-wheel, but because the
movement of the mouse itself causes the scroll wheel to move slightly
and wiggle the scroll action.

So the recent change to enable the high-res scrolling really seems a
bit *too* extreme.

Is there some middle ground that turns the mouse from "look at it
sideways and it starts scrolling" to something slightly more
reasonable?

                      Linus
