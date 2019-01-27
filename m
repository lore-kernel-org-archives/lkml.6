Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101E0C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC3E2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MZPHg0tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfA0NfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 08:35:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37336 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfA0NfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 08:35:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so6095934pgb.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 05:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0t8jTWZDEYo+Yt4XC5Knr5JwLIvHmprPwkJs/XNpzcw=;
        b=MZPHg0tk4gp8CD0e30v6fPbcn3q2tjH34SuTas9igmjK92QXAbNWpTGevFfzvA9v/4
         x44XbW8asiH6Zb6o+J+owDFyoJbozaaKzfo4aQw6yo6dQ5oLX6lItL1hVXqQ+4EhH5Ar
         PJKoNgzLu6vSCRTRkcP4eoNGvjBWYoQtq14lSLjnOLdW2S3jJryA8gPEQkxUe3p8Zq01
         C0MQjJP9FhqwbcH6bXIdLTY9sIQnVmxWmDTdqsUtOMIldiE/kHfCareZakK04oFeRQAG
         fIr/UeuiVxltEWnX5OXf8XwBleF002IBxUwtNYIFauJCIFJ1N4gV9Uek0BEP6kRN40A/
         m9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0t8jTWZDEYo+Yt4XC5Knr5JwLIvHmprPwkJs/XNpzcw=;
        b=bCSrPDjxinM9Mvz5GhR9l5SCLm5CP3aPHclQIo4vvLzHXc/5W8qtISzVD4TpwyCTP5
         wMoOltB1+x/L4GO3GCFwTX4MmQ5u80h/ZW1N10l/fykD1/ey0JZBQVbwc8/LueHzxQXR
         X2w2Vw5RzAGsbxlluM22mRsdsKbIVCNxlgAVbjBTY2znI1+BWxeXPdeSR7Yu/XfkIBt4
         /jaMquOrqGGiiXRmQ6Ax5vQjOad6xSE7TMX8xU70ZUIWcwGjhGThNDRT+WUJcLqF1bh5
         82tFrgZ1USG2Y9cTirHj/Jb1nhp5Fvh/MH1Q2JGPOqcfREJByq4u0SMUkyDYzrva3gPg
         gY4Q==
X-Gm-Message-State: AJcUukcneu9IJdnJ1v2oZf8x/17KvYA5JPKnyLtOmhnanyUTziY9oDB/
        ljMPCKzsd4n+lCLYE8BbHTp5vA==
X-Google-Smtp-Source: ALg8bN7ICA0/mw36+3pjYW0evPU5kqJKpYFa3ZekQ3ANAC89HBUH7DDK5x+n3yd8eF4juvzMJBbAVA==
X-Received: by 2002:a63:df50:: with SMTP id h16mr16624276pgj.421.1548596121636;
        Sun, 27 Jan 2019 05:35:21 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m85sm47295276pfj.171.2019.01.27.05.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 05:35:20 -0800 (PST)
Subject: Re: upstream boot error: can't ssh into the instance (2)
To:     Dmitry Vyukov <dvyukov@google.com>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+4df6ca820108fd248943@syzkaller.appspotmail.com>,
        Ming Lei <ming.lei@redhat.com>
References: <00000000000027601e05806bf6be@google.com>
 <CACT4Y+aH2wo8rdaiZJd7s6Ct3b8mDeuvOj8CsvystV9T10+b-g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ace6b631-3e4b-3da5-f280-463a1bb41d97@kernel.dk>
Date:   Sun, 27 Jan 2019 06:35:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aH2wo8rdaiZJd7s6Ct3b8mDeuvOj8CsvystV9T10+b-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/19 1:05 AM, Dmitry Vyukov wrote:
> On Sun, Jan 27, 2019 at 9:01 AM syzbot
> <syzbot+4df6ca820108fd248943@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    7930851ef10c Merge tag 'scsi-fixes' of git://git.kernel.or..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1002c77f400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
>> dashboard link: https://syzkaller.appspot.com/bug?extid=4df6ca820108fd248943
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+4df6ca820108fd248943@syzkaller.appspotmail.com
> 
> 
> Mainline tree crashes on boot.
> +generic_make_request maintainers
> 
> [    7.485069] ==================================================================
> [    7.486411] BUG: KASAN: use-after-free in generic_make_request+0x14dd/0x1810
> [    7.487539] Read of size 2 at addr ffff8880a39618d4 by task swapper/0/1
> [    7.488689]

Ah duh, not sure how I missed that:

+                       bio_set_flag(bio, BIO_QUEUE_ENTERED);
                        ret = q->make_request_fn(q, bio);
+                       bio_clear_flag(bio, BIO_QUEUE_ENTERED);

Ming, we can't touch bio after ->make_request_fn(), it could very well be
completed already.

-- 
Jens Axboe

