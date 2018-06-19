Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8FAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5751720836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5751720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967172AbeFSS1D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:27:03 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:38029 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966078AbeFSS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:27:02 -0400
Received: by mail-io0-f199.google.com with SMTP id g22-v6so787193ioh.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nN0GavMQ+IQ6+0Eycgw1rHAkRu6R234bKIxSuLL3pNU=;
        b=Gl2yC/itoLs3se2l3AsHYsKmspnXZg6aSwFmQ82J8CFQKqBssvx3Nn3BRnoL+f7j1p
         xCxE2uYSF5mqIOU7Ck2S4JSwBx1Y0zvq3QDqXyACuw+vFXSLjkb67hq0rdio0Mf4T+Rp
         w56VyXY2qFV0Wxt6AWYAHFMg7+lo7pO709P8doqpGQApM/BifimXhvtsE9enaOxz1ZKs
         wVCRT7gmgQGoM9Ek4SUM8EA/U7eA1kPwIJJUHkPr2baU5GEFLryDrL57ejcDTPos1Rih
         eTXfoxXoJD5VqFJnPRd7c3kKu14dvEyrq/Z15FLnomKxQXX9BQQs85UShvRxrQ1oUbTf
         obpg==
X-Gm-Message-State: APt69E1w/snzUZCX6N/hJk9Mso5qJb9LCyqTv+hrB3ZBi55F+RRyeS+A
        ltr7iad3p8X6UU5BrJCrQ3MqBwj03zcoY0GwwONFKaqv1Hol
X-Google-Smtp-Source: ADUXVKKOmNMyvd7nhiwgG9/NxrASeov4metP2K0Ax7jLtvYJPtk7QGLxDWp5/6mBCY5waUNZdBiH09dTMeCHhQTugrI2Xb29EpIW
MIME-Version: 1.0
X-Received: by 2002:a24:b51b:: with SMTP id v27-v6mr6688492ite.17.1529432821575;
 Tue, 19 Jun 2018 11:27:01 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:27:01 -0700
In-Reply-To: <20180619180539.GV24375@twin.jikos.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009b775056f02d421@google.com>
Subject: Re: general protection fault in open_fs_devices
From:   syzbot <syzbot+909a5177749d7990ffa4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, dsterba@suse.cz, jbacik@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
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
syzbot+909a5177749d7990ffa4@syzkaller.appspotmail.com

Tested on:

commit:         b0b8c45747a5 wip streamline uuid locking in btrfs_mount_root
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/test-syzbot-fs-devices
kernel config:  https://syzkaller.appspot.com/x/.config?x=26c272eeaa8c437e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Note: testing is done by a robot and is best-effort only.
