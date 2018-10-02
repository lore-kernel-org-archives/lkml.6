Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13860C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F4D206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F4D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbeJBWtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:49:16 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:52462 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbeJBWtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:49:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 5CB5EC2443;
        Tue,  2 Oct 2018 16:05:09 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Py2cb4f0RFv7; Tue,  2 Oct 2018 16:05:09 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 32B15C243B;
        Tue,  2 Oct 2018 16:04:57 +0000 (UTC)
Subject: Re: KASAN: slab-out-of-bounds Read in vhci_hub_control
To:     syzbot <syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        valentina.manea.m@gmail.com
References: <0000000000004643360575102706@google.com>
Cc:     Shuah Khan <shuah@kernel.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <62457d9f-0732-3886-0381-bbf5df738467@kernel.org>
Date:   Tue, 2 Oct 2018 10:04:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0000000000004643360575102706@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 12:52 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    420f51f4ab6b Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=126a6f0e400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
> dashboard link: https://syzkaller.appspot.com/bug?extid=bccc1fe10b70fadc78d0
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121caa46400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ed8ab6400000

C producer doesn't reproduce the problem on 4.19-rc5. Does this C producer
depend on state of the machine? i.e what is the status of vhci_hcd - are
there any devices attached?

I can see the problem looking at the code and fix is easy. However, I would
like be able to reproduce it and verify the fix works. Also this would be a
good regression for the driver I could consider adding to selftests.

thanks,
-- Shuah
