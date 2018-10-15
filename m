Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567FCC71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2136B20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2136B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJPCR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:17:28 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54501 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeJPCR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:17:27 -0400
Received: by mail-io1-f72.google.com with SMTP id l21-v6so5419848ioc.21
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=s/S7HWnua8pUWFb1yVLV6oa5zlYJ6LpVOP3Ble4F9Js=;
        b=XGgk7zGm4U36Oe7w0UsLqtU2+r27czdza8qkVrFJoI5qAlJr0GqeSMXjcpDa5Z0kMD
         GlBm0K3uDLzdiMw0rQAYAs+yMFZ2498gxvJerjzIviW5mNsieVWYBEjzt1JZXNRtFcdP
         n4pti2+9XckAM3hAcpipRR7RoWGrbNYzYIPJGljo73wvlJiEnjyz/dOunrcJ2ToKG/WP
         6RcF4V1XykF686b2EzmTG/ffOLOD715eTWBEZW7WanFH6J+ZEV6N/3XCpUEUdQttAUc4
         vzx4rMJ6ERGR0gbUrt2oEyyMZaO6A4Zgjo2AHU0cyJLY0SDTgavOHA6BjkOVhfP6hFVk
         8irA==
X-Gm-Message-State: ABuFfoicZSukQiJ10U5NMP71Wa2JGirXLsMi3kU6kKLbbG4qwETFYxon
        pEkKs4dP6wl1krzs/Q0ku0DDp5Q4JOlA262CaANsYt5FWniL
X-Google-Smtp-Source: ACcGV60BcG5cBVDoPvgfwzdgtQWn+Sr0AiVHiWo7KU6WupxF0vYU2xwhtECaBMtzzD2boHd0mEAPqfRpqlWGmG+4NC8lbzoKryXr
MIME-Version: 1.0
X-Received: by 2002:a24:17c5:: with SMTP id 188-v6mr14450744ith.19.1539628262509;
 Mon, 15 Oct 2018 11:31:02 -0700 (PDT)
Date:   Mon, 15 Oct 2018 11:31:02 -0700
In-Reply-To: <CAAeHK+wJVFv-8AHFG3V3tOdkzw9D63Ztot_tb=oR-QVNXWPoXw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac561a057848a358@google.com>
Subject: Re: WARNING in usb_submit_urb (3)
From:   syzbot <syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com>
To:     Thinh.Nguyen@synopsys.com, andreyknvl@google.com,
        felipe.balbi@linux.intel.com, garsilva@embeddedor.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com

Tested on:

commit:         f0a7d1883d9f afs: Fix clearance of reply
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3f55cb3dfcc6c33
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164eab91400000

Note: testing is done by a robot and is best-effort only.
