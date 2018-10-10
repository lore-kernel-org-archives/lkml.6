Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340DA2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AbgbIrko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340DA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJKCFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:05:36 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54518 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJKCFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:05:35 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so9611882ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ajAazKErrzGlccUc71eAb79ImBRVG7tVJ/hvOQwvD/8=;
        b=AbgbIrkoqXAGciMpbn6th+P0NtBHVpprMmrLkhBYM+DO6I+BDe2+zvB6CamN0789pw
         p7Z6oOPFcAj/2J1Z7enzF5ygCXdkSPYt/JR2bCsMp0LVh+dAluWIkSOlX6xQuRokxN6g
         7TXcjQaw0W2svR/Dnn9JoiVVLZCyexaCrp3zFMkF0eMxHKJpBsj3D1jXhKxYTlJVvP42
         9PzkdujiaywogsQbtUNiGIxKlkpiphY3bNNFevAL7Tdr3po5g0iFWlLlv5bkiJOyi5Rw
         vjUxHxWXTRh2zuUImV0gkvJ7P+bUVdHGiL+zoAD1WFNS7kLBGuKHrxrf6j44MDqXnVUU
         kPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ajAazKErrzGlccUc71eAb79ImBRVG7tVJ/hvOQwvD/8=;
        b=pFm05Tu+WvWPGeOw3nQtceB9ac7J4VJqCGe5AfpdSSo7vjl7Zv+0eYc2vaomWkmT/B
         oawedTNRcIrEcnDJA85+n+UwqCJjOJx1nl72wXYzBrjZHWdinNKTj9ktIzURb4Nc9Wqk
         5GkOcIY6jTUNxHIIacv+Wych7Gy4zVLcjlJo5Uv1b3hcYCnarMFRseLWQqFRmjmXRbZy
         sydBbX3KZYvwGyuTJ2NYLD/Vot/DIKJTOt3kgeHvGhh9AL0YA/fy9PS9W35mfioI32mB
         arMkdihbv1btMdBAnvmzAxygtFbdSdeUE3GhXSq3pCyPv+695fMxD/hmoFG5ygAEUNWo
         7WHA==
X-Gm-Message-State: ABuFfoho3xQD8/ZwBmOd4tZecv1+CKKzDs+/CgxqIJhezaDkND8vR7BK
        AZNS8Zbix5oaHezqMMXv7rG+f010VjMDs4umQ09Wog==
X-Google-Smtp-Source: ACcGV60n5+S2+SFFBQpfeVFnh7BSi66vGSizj5d7O/idqu9Xwg/yPL+l4qdJT5RIzz4wYGiKBBuXOmf8YNBLE4+0zJA=
X-Received: by 2002:a24:24c9:: with SMTP id f192-v6mr1573647ita.144.1539196930154;
 Wed, 10 Oct 2018 11:42:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 11:41:49
 -0700 (PDT)
In-Reply-To: <79b7f7a1-1287-1341-7f30-c9491c4d0e4d@kernel.org>
References: <0000000000004643360575102706@google.com> <62457d9f-0732-3886-0381-bbf5df738467@kernel.org>
 <CACT4Y+bycsbrkeT8PHYxfooTkw2VyCAONY_BH2dTuZKtvCj3pg@mail.gmail.com> <79b7f7a1-1287-1341-7f30-c9491c4d0e4d@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 20:41:49 +0200
Message-ID: <CACT4Y+asX7wquthAmyFO6EjaJq=8VET-WytG7PvZdO2AT5rmWA@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in vhci_hub_control
To:     Shuah Khan <shuah@kernel.org>
Cc:     syzbot <syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Valentina Manea <valentina.manea.m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 1:21 AM, Shuah Khan <shuah@kernel.org> wrote:
> On 10/02/2018 10:42 AM, Dmitry Vyukov wrote:
>> On Tue, Oct 2, 2018 at 6:04 PM, Shuah Khan <shuah@kernel.org> wrote:
>>> On 09/04/2018 12:52 PM, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    420f51f4ab6b Merge tag 'arm64-fixes' of git://git.kernel.o..
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=126a6f0e400000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bccc1fe10b70fadc78d0
>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121caa46400000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ed8ab6400000
>>>
>>> C producer doesn't reproduce the problem on 4.19-rc5. Does this C producer
>>> depend on state of the machine? i.e what is the status of vhci_hcd - are
>>> there any devices attached?
>>
>> Hi Shuah,
>>
>> syzbot always runs tests reproducers on a clean machine. There is some
>> state are running a Debian wheezy init, but no test/fuzz/stress
>> workload is run before the reproducer.
>> syzbot also uses VMs, so there are no real devices attached. And it's
>> GCE VMs (not qemu), and I think GCE does not even emulate any USB
>> devices.
>>
>> An obvious thing to try would be to use the exact commit and config
>> syzbot gave (rather than 4.19-rc5).
>> You can also take the image syzbot uses here:
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce
>>
>>
>>> I can see the problem looking at the code and fix is easy. However, I would
>>> like be able to reproduce it and verify the fix works. Also this would be a
>>> good regression for the driver I could consider adding to selftests.
>>
>> syzbot can test fixes for bugs with reproducers:
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
>> So it can test your fix. But this obviously won't help with a test.
>>
>
> Tried the same config and no luck. Any chance you have the complete dmesg?

By "complete" you mean "from the boot"? If yes, then no, we don't keep
it, full output can be huge and it's not a moving part.

I've captured boot output from another similar machine, unfortunately
dmesg buffer is not large enough to fit it all, so not sure if you
will find what you are looking for there:
https://gist.githubusercontent.com/dvyukov/11b83aeda0466a0f171451d86ab36e15/raw/57121db6cf1bbb5e57c08746241b03904bde95f6/gistfile1.txt
