Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B91C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1677820835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9YnLYOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1677820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeJKPOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:14:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43393 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeJKPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:14:47 -0400
Received: by mail-io1-f66.google.com with SMTP id y10-v6so5880901ioa.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 00:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=azu7HN5I/Vv4MsmDGn9VCAaSfPoYtm+XdYIDmv1hcj8=;
        b=l9YnLYOowRiduzmMDBcIrnAKn9sG//O5lJvL75rOjAsHDkMEmLATaSLhkxOBDgZbUI
         0NO4wt4c2esroiPd0ehtOXuxuBxe3RUmXYItaVg1jgaTibw/yhY/UeoO7UGCbp9IRGD3
         68uxiVDkQ7/vaq0glc8FfngIZnLKU9V6u0jSao4qNhb3VH5lRGpHv6gv4OJdFV4OMifY
         oeK0ev999ijllmCb7YCo5HIDzgHEPm+LFSYd/LSiyq+m1EKp035jYERlgFXS38CKiZWU
         2Gya30ydoAwA2G+evhz3c9+CSQbPtNh5BVHH7jR74DEThhPJc/2iTf0D/wS1YqKPF/JG
         Ri6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=azu7HN5I/Vv4MsmDGn9VCAaSfPoYtm+XdYIDmv1hcj8=;
        b=DEo/zk7EVj4YSZGPVhj1BhX5U75AukIcdkmPERfVwohLFggFTD2K1hDZ8mQ3/j6Py5
         QmZyzEWeYECKF4lW+DnDZZ4k9vxyxwHmd9vICGx4xJFAKbko5ixjgMEUCcduSQLqt3EL
         BIRJi6drGYzaJlmYlE3JTa+EHA0Zao6J7bT5R0hrd8XFIhZ5wZPPJ9s47U6uZQzIuPqR
         jTew2m1+Wcbsrq91g+30Fe62j1EQciHypzl8e8SGVgT9JT2jJ5+ftm7kSIDwBHzZRLIH
         WsiHGY24F4P2n9F5Dz2c0GsJZpSOxjZc7NIbQXpeY2AVOLoWOw1kUsnq4UKn9cxJz87z
         G4hA==
X-Gm-Message-State: ABuFfohFKhRKVIs8+iWEKMRKuoQhNXKZWQf6c5gsvePfiZbVmIO170QU
        MSl80x+2nMfUWAfG+rPlPMFiScqLf6wO3ONqm0Lkzw==
X-Google-Smtp-Source: ACcGV62HwD91auko7jimahmSHXyYBKX20NpW+/26KpGlj/fzSlJKFoKY+1ldPmW0gTq0Aw8eg5twk4H/oJi2ZKwN9ww=
X-Received: by 2002:a6b:6209:: with SMTP id f9-v6mr318804iog.11.1539244122481;
 Thu, 11 Oct 2018 00:48:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 00:48:21
 -0700 (PDT)
In-Reply-To: <7aab2f8c-a962-8ed3-b8ce-6cf77eb418c2@kernel.org>
References: <0000000000004643360575102706@google.com> <62457d9f-0732-3886-0381-bbf5df738467@kernel.org>
 <CACT4Y+ZeN-acGM_Y+W_sWLcd-0NAjQ9qfBfGGrwE85AhB+ne0A@mail.gmail.com> <7aab2f8c-a962-8ed3-b8ce-6cf77eb418c2@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Oct 2018 09:48:21 +0200
Message-ID: <CACT4Y+ZH71cximCEzxmK0FY4MfujhUuohGkHFtjZKAejJa9dTQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in vhci_hub_control
To:     Shuah Khan <shuah@kernel.org>
Cc:     syzbot <syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:26 PM, Shuah Khan <shuah@kernel.org> wrote:
> On 10/10/2018 01:42 PM, Dmitry Vyukov wrote:
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
>>>
>>> I can see the problem looking at the code and fix is easy. However, I would
>>> like be able to reproduce it and verify the fix works. Also this would be a
>>> good regression for the driver I could consider adding to selftests.
>>
>>
>>
>> Are you sure you used the provided config/commit?
>> I've followed these instructions:
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce
>> and the C repro gave me this in a second:
>
> I managed to reproduce and fix it. I did add reported by tag as well.
>
> Here is fix:
> https://patchwork.kernel.org/patch/10628833/
>
> Sudip verified the patch.

Great. Thanks!
