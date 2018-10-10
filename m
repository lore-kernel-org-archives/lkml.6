Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C131AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728B32086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728B32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJJXv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:51:58 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:32930 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJXv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:51:58 -0400
Received: by mail-io1-f71.google.com with SMTP id c5-v6so5146108ioa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 09:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qx9IkOOCNzfOV5x8Zofo/YWAGO4Dj2N4bGcrdMsvjsg=;
        b=oVbV7Z4IGNoNGDJyyesaVlc1lSJD6H1EtPq5SMe3fXS2sDBcqYKQGisATCp9oz0KzI
         07Zj5u6QttOM6DaILIWz6o7cWB6J/X7hhrEcqj0KtLk4kzkqdmUTqtPa7nesrP+zQnL3
         3gHCIECsjyrXT5w2AaEloWElaSo15XxqZJJQn08mRMsjzwy6tAzwbDoAnUKU4fzI4jxj
         ch6Wd7beZ+tns0DuDSORLw6un6H/d5L/N/IYKACLawr/9nKKk0TZKk/GcuyKAP0Qkn32
         xIo9qOr5h2SUdgdDej3496SWkNyhMrm8CANtKrZKl+WzDnci9yJeDed/z+aEvlW7wbdp
         dPug==
X-Gm-Message-State: ABuFfohHnRlFfpxu19aoB8O9Ho1A3EkM6ZKfkmqfxXSvi/oyNrah7LDr
        Lmi7XiaIAs6eNysUzAf8S91Pjg5YzYZ1FrlxBOXJTwNvAjnP
X-Google-Smtp-Source: ACcGV61AxTH4NTX2K4sGB5iymx1ppHbE+dQwkDyzhMwIUwuOJxZ4E9a/IwoJAl/WJi1KkOHTf8MS+GYkUAQAJXPu/M9WZQ213in5
MIME-Version: 1.0
X-Received: by 2002:a6b:920b:: with SMTP id u11-v6mr23270341iod.36.1539188942952;
 Wed, 10 Oct 2018 09:29:02 -0700 (PDT)
Date:   Wed, 10 Oct 2018 09:29:02 -0700
In-Reply-To: <20181010161003.GA5371@nautica>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fdfe40577e25a4e@google.com>
Subject: Re: BUG: corrupted list in p9_read_work
From:   syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, dvyukov@google.com,
        ericvh@gmail.com, linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com

Tested on:

commit:         e4ca13f7d075 9p/trans_fd: abort p9_read_work if req status..
git tree:       git://github.com/martinetd/linux.git for-syzbot
kernel config:  https://syzkaller.appspot.com/x/.config?x=fada1c387645ed03
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Note: testing is done by a robot and is best-effort only.
