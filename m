Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A70FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D08C20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfAVO0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:26:04 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:35127 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbfAVO0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:26:04 -0500
Received: by mail-io1-f72.google.com with SMTP id x12so19649531ioj.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 06:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ncWC1sQSGq8dCoDCHGdc0UKCVRQPCUtJfaMUbHP+6As=;
        b=CzZhzAGWEjnHdXWRzKhiu5QMwYIxRWWRFk3tQtzWhlJF1hl6/5GcJRPtteWhoTzwAc
         rS4wcOImPaBrVaZbeOKGbY0WCGcxRcN4viWBJnq3w+7GmVh0rIwThS29UTghC/Xuvk2e
         aJhHDRFg/0v+FGRvDw4k3MF4/K4UVedqf3gYaZvp+4ZJuV/zEPNTsFXvB3blYcWjbx/y
         3HAIXUNcgxznRxfg7+6Kl1dKLeXSrTrPDW00QyEUFJENktT10Xer3rwkwtadadJa4eSL
         cLwhkZk/v6if90KTOUNDKwjJCv7aGnYUEf/Q75wkmY8m+oUENk6UrZeBH+TQHW6ZThTV
         JuQA==
X-Gm-Message-State: AJcUukcBWFhQoCMipYwgroCi/qG/IoGP+NDb+eSP4y8yg8wwsEYD5wIV
        8FV3v/sYnNqAcwJrN0jeWiIQb2mK3r3kW6fCkUmPMqmus1d+
X-Google-Smtp-Source: AHgI3IYLIwd0btNqvZ17JMk25EAWayJgMsh9D8yoQUA+QmySAdi7O8cHBh//V1EsXGAcyVM5KW297wrM0/sM9/0hC5qcw3aN6gHn
MIME-Version: 1.0
X-Received: by 2002:a5e:d50b:: with SMTP id e11mr848606iom.25.1548167163571;
 Tue, 22 Jan 2019 06:26:03 -0800 (PST)
Date:   Tue, 22 Jan 2019 06:26:03 -0800
In-Reply-To: <CACT4Y+YNgYqynkhv7DMCCkO+xFebrpWfTXwdyeYsN=RkWmLiYw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6738b05800cc19e@google.com>
Subject: Re: possible deadlock in vfs_fallocate
From:   syzbot <syzbot+148c2885d71194f18d28@syzkaller.appspotmail.com>
To:     arve@android.com, devel@driverdev.osuosl.org, dvyukov@google.com,
        ebiggers3@gmail.com, gregkh@linuxfoundation.org, joelaf@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        tkjos@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+148c2885d71194f18d28@syzkaller.appspotmail.com

Tested on:

commit:         48b161983ae5 Merge tag 'xarray-5.0-rc3' of git://git.infra..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd3a020d055fa2e8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e6d908c00000

Note: testing is done by a robot and is best-effort only.
