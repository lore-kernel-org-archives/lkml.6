Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TkGBKiRGHlt8ewAAmS7hNA
	; Mon, 11 Jun 2018 09:52:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8B711607A4; Mon, 11 Jun 2018 09:52:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZrURjMR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1A143606FA;
	Mon, 11 Jun 2018 09:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A143606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932872AbeFKJw0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:52:26 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42574 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeFKJwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:52:22 -0400
Received: by mail-pg0-f66.google.com with SMTP id c10-v6so3874447pgu.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 02:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=shh1amOMZ+ZPO/xKPliKw0fJj/CpG1+1elyZQ2+CVM8=;
        b=pZrURjMRdSarGqTa4d7Ur+ydF2s9RMhq/vsXpCSI4N+MYr2EIGKQcS6Pv4RbYnp6kG
         dcXnvGymeCIlXD0zR650/z1t4tynNWrCue2ESDY6P4I2SgSExE4+f2oQXr4CoVp2hHnX
         ePfEfzy/vU/Rl2Q/5HIxoa89/n8B2KZUjcANejxTis95noGFULcPfccb8as/NCuhIsuP
         wRcKVMPmqipORTgiidtEaR5JwE3dwMBgZttqe/MRUn8UmBFSTQVD2jQ2OFCYCah5DNUB
         YD0DEwoApp8StsXjn0vthkXq114DVKBInD0KXQKtw9Kgc4zDJg/xFv5S3tEkbRsRsUTE
         JZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=shh1amOMZ+ZPO/xKPliKw0fJj/CpG1+1elyZQ2+CVM8=;
        b=E4pQoeNcfyZbpYEvGUPWOkwFoWEyBrViN6wqoq7duzfy50T1Gq6WeElJ6WGeClPeiP
         EtllK4ZylI80F/wM5wvkh7NRVk9RFdIPV9kY3FfmTRDyhKKSy6afm2dqVJct2VzVGuJp
         rqRTJ73i7oW/fMyfJJ2SdCI3IPfUe0XBf0yQh9QkoamVZ63GvD/o0vWQZMy1uxzK52+F
         iX7/bWfGdZDO0ndutGcz/vLOay0UsWqwpIVD6oiQzEAXxyWEpzzvdgo1dWv9vyIpNYup
         iVVNh0ZVt9xa1k1PQgDwwnOYIFX8HlNTUc9NEoUcUHRbWctRRFCZpsYU8TfzFsBHSP1q
         cOnw==
X-Gm-Message-State: APt69E0UzSj96jYI8jj7g+a9djLjZUGVuD3MaYqLtB69GUrD/HCT61o1
        inZNV2mRc6UYxuSH2cDi5lDwpLOQDbxmWAoXWONG/Q==
X-Google-Smtp-Source: ADUXVKIJBGdpBYeabiOlWTZQfu7iCF0cdtzGojzB29/86vUb3I9QBrJWshmn5r3zCOMCawigmkcNKC8HTP6o69gIN78=
X-Received: by 2002:a65:490d:: with SMTP id p13-v6mr13727352pgs.84.1528710741445;
 Mon, 11 Jun 2018 02:52:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 11 Jun 2018 02:52:00
 -0700 (PDT)
In-Reply-To: <76483220-226b-bf3c-d529-ea839d6624c6@iogearbox.net>
References: <000000000000c64842056e4b4326@google.com> <76483220-226b-bf3c-d529-ea839d6624c6@iogearbox.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 11 Jun 2018 11:52:00 +0200
Message-ID: <CACT4Y+boO990R6a9kGtx-UZpZPeB2bwhgvyUjPvEFOpbzxJKrg@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bpf_skb_change_proto
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: syzbot <syzbot+d2d729bdde65dee3eae6@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 11:42 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 06/10/2018 05:27 PM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    a16afaf7928b Merge tag 'for-v4.18' of git://git.kernel.org..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1338f6bf800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=314f2150f36c16ca
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d2d729bdde65dee3eae6
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1173381f800000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171f90cf800000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+d2d729bdde65dee3eae6@syzkaller.appspotmail.com
>
> #syz fix: bpf: reject passing modified ctx to helper functions


On a related note, it seems that it still can unwind past
bpf_skb_change_proto. I think the "net.core.bpf_jit_kallsyms = 1"
sysctl should have been reached syzbot by the time of crash. Are you
sure that's the only thing requires? We are using frame pointer
unwinder just in case.
