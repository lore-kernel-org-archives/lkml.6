Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nZEIORNRGltcAgAAmS7hNA
	; Fri, 08 Jun 2018 09:50:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 46A00606FA; Fri,  8 Jun 2018 09:50:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SORTED_RECIPS autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1694660275;
	Fri,  8 Jun 2018 09:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1694660275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeFHJuY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:50:24 -0400
Received: from www62.your-server.de ([213.133.104.62]:39094 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeFHJuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:50:22 -0400
Received: from [178.197.248.12] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fRE2D-0008Je-ME; Fri, 08 Jun 2018 11:50:17 +0200
Subject: Re: KASAN: null-ptr-deref Write in xdp_umem_unaccount_pages
To: syzbot <syzbot+979217770b09ebf5c407@syzkaller.appspotmail.com>,
        bjorn.topel@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, magnus.karlsson@intel.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000037bf29056e114a86@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7459a2d0-011b-d439-bef2-cb0b4e574c4b@iogearbox.net>
Date: Fri, 8 Jun 2018 11:50:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <00000000000037bf29056e114a86@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24643/Fri Jun  8 06:37:57 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 08:17 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1c8c5a9d38f6 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a72bdf800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4f1acdf888c9d4e9
> dashboard link: https://syzkaller.appspot.com/bug?extid=979217770b09ebf5c407
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12aca2af800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161d4ddf800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+979217770b09ebf5c407@syzkaller.appspotmail.com

#syz fix: bpf, xdp: fix crash in xdp_umem_unaccount_pages
