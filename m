Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1343C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B853A2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B853A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeKHBAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:00:53 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:49365 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKHBAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:00:53 -0500
Received: by mail-io1-f69.google.com with SMTP id v23-v6so19601974ioh.16
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GuD7afXlqFPeVmZ6ponVM0hAcTmfrQhiEYmv1LNCctg=;
        b=mNhMZHOlD44MTaYedrOWJEyyLH1q0Y5lqUsxaKCu0GU9yo2PWh8ovzheIhwMQ83jF/
         H1hjGvAolXFXLVVfI55ebg1pLkVOohRFw6odzphAQf33z6/8nsIve1Ui4SFwwqKvLFlH
         QrIPNLzgzTEMVXcQ5+Ff2jF13zKXvkYdJo+Kcyo1G08I8dcDhX+uPe/f5CFbBxQdVp1i
         lHtV6WuUnExO2bQKU9qC+8hi9ucMyhHX1CcHtmfr2bTN2oLzLac1rPuthFHpEupFmoZl
         Ner3Z7+b0uiNT/5CBwhM/3gTM98FxAL9hJJEj/+acv1exhFmOIVcWoL3TT0GrLpWili0
         cuFQ==
X-Gm-Message-State: AGRZ1gL2oemuoiBskcfo5OtpvPMmefI40zoBb2We27pRdIWAyLuQ0tsu
        ytzDQRRib2pxvr1LHWbEmFifJKP4V9aHeoBCPCZ14vQdAh+R
X-Google-Smtp-Source: AJdET5c0JY99JV3mstKRSN65fGde3XlIDTh1jHlCQ9ma6v+1JJ8zTtA8CM7yq5ZRDca36Wg37p9PzsTMCPsXtTrvwZXwlynZgTR0
MIME-Version: 1.0
X-Received: by 2002:a24:9ec3:: with SMTP id p186-v6mr384821itd.11.1541604602624;
 Wed, 07 Nov 2018 07:30:02 -0800 (PST)
Date:   Wed, 07 Nov 2018 07:30:02 -0800
In-Reply-To: <CAJfpegu3wunM+=psdDSsr1pQ23MJyKCSnz6LapHDg8nnFa+ASg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b944c3057a14cad7@google.com>
Subject: Re: INFO: task hung in fuse_sb_destroy
From:   syzbot <syzbot+6339eda9cb4ebbc4c37b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+6339eda9cb4ebbc4c37b@syzkaller.appspotmail.com

Tested on:

commit:         59fc453b21f7 Merge branch 'akpm' (patches from Andrew)
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea045471e4c756e8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b6042b400000

Note: testing is done by a robot and is best-effort only.
