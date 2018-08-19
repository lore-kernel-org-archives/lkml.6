Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A791C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 11:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4987E20BEC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 11:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4987E20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeHSOeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 10:34:10 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:39447 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeHSOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 10:34:10 -0400
Received: by mail-io0-f198.google.com with SMTP id x5-v6so10971231ioa.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 04:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SXA1t5TbSpBXYpsB7H1pYbX3kz739RdMR2nW17M74AY=;
        b=gUom57kA1pTB43IwBB5EI09WbrfWBievkJ/7Qs0WU/s/lKz5+xFbJYot0PO3k0XUhr
         V5THt2ABn7KV1TWvX60qWljbNE1+nw8TOuS/fANX1ph4VqfPJ1QsEMWL2fpsQLD3Axyl
         e2BqZxoH2647sAISPprP6RoDij5EKHCRiyElJfFQ0Iq19sXioicTgv9QEJ0ZT08ue45/
         LQd5gOTm7drOhoTTwEpPTilaj6CJ7XNhswjUMuiiB9Sf+qP6VzMnds7vn8W82eWMhCsK
         uLZpD90mb+g2fdz7rvYCjchwshgGQlWhmWgKgSE0dQyEfoRZDv3spYdq7a92Wzu5SfRh
         63pA==
X-Gm-Message-State: AOUpUlHhQUgCgi2dCnlSzHW3jJYyR0n4dNqCH4NYcx/gchQQgadgR0iw
        L7TCSISSCcE/PT2LjvI6GtpPcs+GCA65Y2TU3WY2P+KbHKzP
X-Google-Smtp-Source: AA+uWPxmNsCy5sJPgRrRuq3Rmv1klSD5f9bRxneokspaGt38cS3mAAl0ae3s1Pptzyg7Ke9WKwk/ILt1FB16/QIWWUFoDhqsFsgt
MIME-Version: 1.0
X-Received: by 2002:a6b:1504:: with SMTP id 4-v6mr19317306iov.79.1534677782630;
 Sun, 19 Aug 2018 04:23:02 -0700 (PDT)
Date:   Sun, 19 Aug 2018 04:23:02 -0700
In-Reply-To: <CAOQ4uxiA2ba2EuQkgttA7rRMYgGnEPZQX-f8g12M8gDTaeht7Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000141d150573c80415@google.com>
Subject: Re: WARNING in __fsnotify_recalc_mask
From:   syzbot <syzbot+c34692a51b9a6ca93540@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

patch is already applied


Tested on:

commit:         2df79a019776 fsnotify: fix false positive warning on inode..
git tree:       https://github.com/amir73il/linux.git/fsnotify-fixes
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11717bf2400000

