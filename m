Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5458FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F56021019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfAVOqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:46:04 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:44943 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfAVOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:46:04 -0500
Received: by mail-it1-f197.google.com with SMTP id x82so13282477ita.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 06:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tZ75i4rbvSM77zRbeSNhYTFR1GllBSkW3HGwpNt3Sd8=;
        b=pV7hlLPLUb5wxk8GdNPDAKKWkEUOaKkyLYyDF6rG/Pe9dXduVcxJ54IAVc4buBIu6T
         G8w727faS8UWkJ6YCfuFA4RPBtKUGeddLdoXogcITpKJnFnlhyXGLT7WR97gDiYiiAbM
         VUMN69/8AvPuSq6DfWu53Yfjwqp6m+DXlnu/kr2CJN1v+LvN89bDJdL7wj7bZLCaH+ax
         lULaaYgPZ21VM5pEhxTCVYvI43gs37Ah0hSpiN2RQLlXbnJS59AdYrH3gtAGJOc9RZ+Q
         e4nOESmmZ+mWd+vcbgnCUqXHOFMCrnY0WkjZ/gRdnLcYM6OYQ0lJytP4AHEibFdPoIAI
         gCiA==
X-Gm-Message-State: AHQUAuaE3SeJTuqKBIIPVHmJkBLmXktJmWEFFbJWtuX1Wof2YB+4lCHM
        O3OP3twgSKN568G9rEbZ9P74Ss/9Sflll2aCR2D5bMA7cqw7
X-Google-Smtp-Source: ALg8bN6p8giWAHu3JMN3RnBjUiUatuUrVBTpnvYgJFWxz/LCZYQAwSYrekaoWTh6GWbMEDf1jW/MHGAAv/4QDE9z7F0IXyY/XD6L
MIME-Version: 1.0
X-Received: by 2002:a5d:9ad7:: with SMTP id x23mr917387ion.21.1548168363115;
 Tue, 22 Jan 2019 06:46:03 -0800 (PST)
Date:   Tue, 22 Jan 2019 06:46:03 -0800
In-Reply-To: <CACT4Y+bEsav4r82z5rE1b0rH==VpU7FEK7DzuqTu3AV+w0Ve9g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005609bd05800d09e9@google.com>
Subject: Re: possible deadlock in shmem_fallocate (2)
From:   syzbot <syzbot+4b8b031b89e6b96c4b2e@syzkaller.appspotmail.com>
To:     arve@android.com, dvyukov@google.com, hughd@google.com,
        joelaf@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, tkjos@google.com,
        willy@infradead.org, xieyisheng1@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+4b8b031b89e6b96c4b2e@syzkaller.appspotmail.com

Tested on:

commit:         48b161983ae5 Merge tag 'xarray-5.0-rc3' of git://git.infra..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=864ab9949c515a07
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1064a9a0c00000

Note: testing is done by a robot and is best-effort only.
