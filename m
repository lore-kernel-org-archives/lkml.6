Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3E755C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E65208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E65208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935389AbeFMSmf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:42:35 -0400
Received: from www62.your-server.de ([213.133.104.62]:49466 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbeFMSme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:42:34 -0400
Received: from [178.197.249.11] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fTAj0-0003Hz-EH; Wed, 13 Jun 2018 20:42:30 +0200
Subject: Re: KASAN: slab-out-of-bounds Read in bpf_skb_vlan_push
To:     syzbot <syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com>,
        ast@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000000c58c2056e8a3a27@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <edbf0ff2-39a4-c6be-5257-219a06cfa3ba@iogearbox.net>
Date:   Wed, 13 Jun 2018 20:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0000000000000c58c2056e8a3a27@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24659/Wed Jun 13 14:39:08 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 08:34 PM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger crash:
> 
> Reported-and-tested-by: syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         be779f03d563 Merge tag 'kbuild-v4.18-2' of git://git.kerne..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/--
> kernel config:  https://syzkaller.appspot.com/x/.config?x=68d8eba98e3f8e88
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Note: testing is done by a robot and is best-effort only.

#syz fix: bpf: reject passing modified ctx to helper functions
