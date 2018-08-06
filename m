Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6E0C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B25A21A01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B25A21A01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeHFNIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:08:34 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:40346 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeHFNIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:08:34 -0400
Received: by mail-it0-f72.google.com with SMTP id 136-v6so12623206itw.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 04:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6N6V8pp9jIUmqihwsBb5IvV31uKHp1Z/p6N87VvJ1nU=;
        b=WowsYzM8xh4AU4pkWcbjcbzf/nrmGCuWkxpsoMdPoHdHPVUSreCHvE5I+yQOAqxeud
         +o59Y5pjOJyXR8oun8xKesm7hAFYkenvPLTuGwhC31Njqh4ikia3qBCJEOpl3WjhMR5q
         Btb4cJhpBCS27p4g/VtshogiQGBVNw2eoLt3UpeuiF5+dFZCUMtdoZE2fLwCUnmgNc+H
         ACv2Br1cpfy18QnueLxVR5imJbLj83fiSKnpVe6z4k38kPmxbfcRcPkril0cnUvN0JN6
         xRdwrF5W7rXgopX3VoMRkFnK1WxdsFuCLtdPyVjjvbfvbFcqOVBXd5WUQ9KSHnz6oac9
         PvbQ==
X-Gm-Message-State: AOUpUlGMllJ76yABiArlMenEGnBRHH9e3LXd8kjJn00/vrtBo33+F6xC
        cu0WhNV6wD3+mcgl+AbEFkGwB7sRxYMkvNuBFW9ISldcns0N
X-Google-Smtp-Source: AAOMgpfiebvwZHiA92Z8hv76DdmbfgqupdFc0o+2+8AO6QRD4DumVXhDhkdLXgZatrEtX50qdhXUryzdh3a15FMG9mJJmlc2FtSB
MIME-Version: 1.0
X-Received: by 2002:a02:601b:: with SMTP id i27-v6mr8261192jac.4.1533553202420;
 Mon, 06 Aug 2018 04:00:02 -0700 (PDT)
Date:   Mon, 06 Aug 2018 04:00:02 -0700
In-Reply-To: <CACT4Y+ZEAoPWxEJ2yAf6b5cSjAm+MPx1yrk70BWHRrnDYdyb_A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dfe4710572c22d67@google.com>
Subject: Re: WARNING in try_charge
From:   syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, syzkaller-bugs@googlegroups.com,
        vdavydov.dev@gmail.com
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

commit:         1ffaddd029c8 Linux 4.18-rc8
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bdb367561cb7285
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146f9830400000

Note: testing is done by a robot and is best-effort only.
