Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 08EA2C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FAD208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FAD208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935931AbeFMXCB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:02:01 -0400
Received: from www62.your-server.de ([213.133.104.62]:39265 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935070AbeFMXCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:02:00 -0400
Received: from [178.197.249.11] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fTElt-0003Mq-H9; Thu, 14 Jun 2018 01:01:45 +0200
Subject: Re: KASAN: slab-out-of-bounds Read in bpf_skb_change_head
To:     syzbot <syzbot+567faa843005dda30737@syzkaller.appspotmail.com>,
        ast@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000009920d3056e8d57a9@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3db1d6a4-1059-fec7-00c7-77d26fd5b3c2@iogearbox.net>
Date:   Thu, 14 Jun 2018 01:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0000000000009920d3056e8d57a9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24660/Wed Jun 13 22:44:30 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 12:17 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    75d4e704fa8d netdev-FAQ: clarify DaveM's position for stab..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16bd21af800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a601a80fec461d44
> dashboard link: https://syzkaller.appspot.com/bug?extid=567faa843005dda30737
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1039185f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e85cff800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+567faa843005dda30737@syzkaller.appspotmail.com

#syz fix: bpf: reject passing modified ctx to helper functions
