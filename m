Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0D4208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0D4208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966417AbeFOUYe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:24:34 -0400
Received: from www62.your-server.de ([213.133.104.62]:32808 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966118AbeFOUYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:24:33 -0400
Received: from [178.197.249.15] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fTvGo-0003Dw-RY; Fri, 15 Jun 2018 22:24:30 +0200
Subject: Re: WARNING: kmalloc bug in memdup_user (3)
To:     syzbot <syzbot+0f92a17b0706231d0a09@syzkaller.appspotmail.com>,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000005ff424056c5476bf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <aa1656af-e347-f8a9-9def-1eaa165eb805@iogearbox.net>
Date:   Fri, 15 Jun 2018 22:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0000000000005ff424056c5476bf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24665/Fri Jun 15 14:39:28 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 05:35 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    c5c7d7f3c451 Merge branch 'bpf-sock-hashmap'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1626ae37800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=10c4dc62055b68f5
> dashboard link: https://syzkaller.appspot.com/bug?extid=0f92a17b0706231d0a09
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=126a5197800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1598c477800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0f92a17b0706231d0a09@syzkaller.appspotmail.com

#syz fix: bpf: fix sock hashmap kmalloc warning
