Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CCKuCP5RGlt9EwAAmS7hNA
	; Fri, 08 Jun 2018 09:53:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0A847607A4; Fri,  8 Jun 2018 09:53:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 97BE760290;
	Fri,  8 Jun 2018 09:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97BE760290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeFHJw7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:52:59 -0400
Received: from www62.your-server.de ([213.133.104.62]:39332 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeFHJw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:52:57 -0400
Received: from [178.197.248.12] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fRE4k-0008S5-Nq; Fri, 08 Jun 2018 11:52:54 +0200
Subject: Re: KASAN: use-after-free Read in bpf_csum_update
To: syzbot <syzbot+3d0b2441dbb71751615e@syzkaller.appspotmail.com>,
        ast@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000bec587056dc547ba@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <732ecdd6-135d-7a3e-6c06-fb098c65d76f@iogearbox.net>
Date: Fri, 8 Jun 2018 11:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <000000000000bec587056dc547ba@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24643/Fri Jun  8 06:37:57 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 01:36 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    bcece5dc40b9 bpf: Change bpf_fib_lookup to return -EAFNOSU..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=161e2c6f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4078980b886800c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3d0b2441dbb71751615e
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17cb5adf800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ebf19f800000

#syz fix: bpf: reject passing modified ctx to helper functions
