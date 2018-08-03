Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D70EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5752173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5752173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbeHCKoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:44:12 -0400
Received: from www62.your-server.de ([213.133.104.62]:52366 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHCKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:44:12 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1flVlU-0007LY-Tj; Fri, 03 Aug 2018 10:48:52 +0200
Received: from [2a02:120b:c3f4:b8b0:b5ea:3969:d380:aafd] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1flVlU-000S6H-Ou; Fri, 03 Aug 2018 10:48:52 +0200
Subject: Re: KASAN: use-after-free Read in bpf_cgroup_storage_release
To:     syzbot <syzbot+25554ab865a12b51c66f@syzkaller.appspotmail.com>,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f3b1570572779079@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <91d96b6a-6025-05a6-82c6-a6889d20d06c@iogearbox.net>
Date:   Fri, 3 Aug 2018 10:48:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <000000000000f3b1570572779079@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24807/Fri Aug  3 02:50:20 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 07:59 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    fc2a3b5dd618 Merge branch 'bpf-cgroup-local-storage'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a6a1c8400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3bfcc1651962483
> dashboard link: https://syzkaller.appspot.com/bug?extid=25554ab865a12b51c66f
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12c4b9b4400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e9d6f0400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+25554ab865a12b51c66f@syzkaller.appspotmail.com

#syz fix: 82c018d734a7 Merge branch 'bpf-cgroup-local-storage'
