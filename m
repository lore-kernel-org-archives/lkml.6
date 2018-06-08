Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NmMMGGioGlvKQAAAmS7hNA
	; Fri, 08 Jun 2018 16:02:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7FFD1607DC; Fri,  8 Jun 2018 16:02:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE8mM5it"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 95E3B605A5;
	Fri,  8 Jun 2018 16:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95E3B605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeFHQCi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:02:38 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39045 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeFHQCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:02:35 -0400
Received: by mail-io0-f196.google.com with SMTP id f1-v6so16464020ioh.6;
        Fri, 08 Jun 2018 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r8tY78+2+Z28SFnxV21mz5yUc2biIP0rIh/fc9mmmeE=;
        b=UE8mM5itQUEBHSyktgky7f7O885S4qos4fg+J7Pmc73tUd5A9s2oEkWXZB6/QwNeLx
         V4ceO+24IDItvrw4SxQwjQQPjblaUtXJRZO1+Zf/qiWPeqnoHb01CawaYopz3qQmyp8H
         6xA8mrHuc5LNY5qOgryDJDNRl6bx9YAPNB/tNlt6oxC6YCMZnCybWf/2Xh/Wch9XlG/s
         zsfJvMDENHlU+Vgr05pEAvNUgjEk6GHHrpQHCd0ogLGTwJvIKSqOHK4LFRuiUrSulEbr
         /SNFJnrnGER97QAdIwxOYNZKEhcdBNyCye8tiBvOFwzZo0m6SZht50ptX/vlXICvXGPB
         XXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r8tY78+2+Z28SFnxV21mz5yUc2biIP0rIh/fc9mmmeE=;
        b=c2v/QP3KcN+lF1AUDrWT7DX95FvQzDeX3Mxy+QdD7LSu4fO+qyQPxWOfkMw/Er0pRy
         fRGe35sOKwwzY0ABZkogtH4j5AxpelIcENJEbRDqn/T7kaH9bMKsNz9xVltwedFh0fZf
         QuM1s/D6997eAurPRAmURJvOIY6zPlsh7z3kDuoJzy4n+2nT0mV2lQyVrWi9ERm+Yhc5
         x0ZYj6GodPcxJuQid3AK6eLQP3XNEVTgR+CUH6zWzjq/5aDlsBZMwUk9QL25Ny5h0e3Q
         6fsKC07OL9PCXaqVwqq1Pe3BkvsHLvKvM+uLBSs8lUv+xd8E0EAfmDC6eaP5zglPdgCr
         2N5Q==
X-Gm-Message-State: APt69E0gk1SQG4ygRQtn/o1TXVGOLZoVRDlMVicNHCvVXO6dc19wvUlH
        iz6mIUaKQyV/MF73JywELvY=
X-Google-Smtp-Source: ADUXVKIFzk3aF6qIQIOLgalFar56yvpLQHo+SKihfWoaZUHx/LK3WK/JQDbm4gPUuKyqZhUnmNV3uw==
X-Received: by 2002:a6b:b0c3:: with SMTP id z186-v6mr5793746ioe.220.1528473754641;
        Fri, 08 Jun 2018 09:02:34 -0700 (PDT)
Received: from [192.168.86.235] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id l82-v6sm939750itl.25.2018.06.08.09.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 09:02:33 -0700 (PDT)
Subject: Re: general protection fault in bpf_tcp_close
To: Dmitry Vyukov <dvyukov@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: syzbot <syzbot+0ce137753c78f7b6acc1@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <00000000000098e65b056d184a11@google.com>
 <7257c52b-7632-e313-6e80-a4bc1f8a6bf0@iogearbox.net>
 <CACT4Y+bN1jHcqovkBu5szmUqNHe3WRS1doOi9v3N6VnxZS7z4g@mail.gmail.com>
From: John Fastabend <john.fastabend@gmail.com>
Message-ID: <6de0b5d4-b29e-c089-2119-3236a506af42@gmail.com>
Date: Fri, 8 Jun 2018 09:02:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bN1jHcqovkBu5szmUqNHe3WRS1doOi9v3N6VnxZS7z4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 09:58 AM, Dmitry Vyukov wrote:
> On Mon, May 28, 2018 at 12:15 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> [ +John ]
>>
>> On 05/26/2018 11:13 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    fd0bfa8d6e04 Merge branch 'bpf-af-xdp-cleanups'
>>> git tree:       bpf-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=11da9427800000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b632d8e2c2ab2c1
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=0ce137753c78f7b6acc1
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+0ce137753c78f7b6acc1@syzkaller.appspotmail.com
>>
>> Should be fixed by: https://patchwork.ozlabs.org/patch/920695/
> 
> #syz fix: bpf: sockhash fix race with bpf_tcp_close and map delete
> 

Hi, actually that patch was dropped because it needed an update. I
should have a new patch today/tomorrow though and will add the
correct fix tag then.

Thanks,
John
