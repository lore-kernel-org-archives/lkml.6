Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD0BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C600F22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hALzE4eW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C600F22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbeKOEGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:06:23 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36232 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeKOEGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:06:23 -0500
Received: by mail-it1-f196.google.com with SMTP id w7-v6so25260683itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 10:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+u9cfa/TTF/uy2o+d2SBUGl/+F7AsRzMtsTN9wc4rW0=;
        b=hALzE4eWK9dzsmS9Pxdaht0tHKnRuKiRI59nvdvANVeTcaB3sBX0iDrgsK9D1zv5J0
         trcZOqG5sB3N41i7f+mBCOcvwJtdU9fFO73FHVewaFuLlMw/PZdJE+1DHgpqAuNhHvG+
         G+kaF67JZ6K/OuoEModdU35BrClI63NXbqrENh3La9yweDEQ0LvWwCyH6tEqLVzOyg4m
         C5n4801az1bVUUUqS/xff33jAABRQdspxfE5PRcYwo5/uLVkaecu46g6fEXpBWH36zRC
         nLC/PwPnEy/SxgO9CkTymr/46nGQPxSp7y2yITDhDQc2QMGOLinb303P4Y/+9TDawnRa
         iWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+u9cfa/TTF/uy2o+d2SBUGl/+F7AsRzMtsTN9wc4rW0=;
        b=Z3KTkTqGpzWe/RGneWQLmGx7GbOVCP0WcekeUkoOOc76Xu1awQSNkASxovboZyq/dQ
         HuSAlOGTeCcyFgoE7c98UtZnSnB1S5yZaYz0IcZtHSoHEvxtpRIWyivwpMUdmOdqeXdQ
         aCgPAzVNL0ElpIFquZx7nci+7ynJSoKoddCdNWLr5etyZ3rkz1WZqA0CYurwcqMJCAU7
         KnQsxWiHswQPM7Wvh36t29uCcRRL9kCxvNvnM6RxYaZvIJQMlLz3FhjpoxVWMIAMnPn6
         1qMBbR8F7WshBmjoiqGXI3YK3AGHDt/ft8EH6g7K9M9TUncSGW8oDDH4yOXHGYN1eMgq
         ktzA==
X-Gm-Message-State: AA+aEWZoZM4GwkCGJaraqocQkPyfV8Cl/ErYsyn7RRyLlGQbJTKqgMUa
        fmjxeEgPDXZTGuVRGl1bq/t5mZDVnXoDNogVsU1syQ==
X-Google-Smtp-Source: AFSGD/U8Nc+Ze3x7JaefP58K64Pdmg2+BmGDyNfnJDz9nXJeGP+WBolQtff2ldPMvw+XOWiJH+IoI2tQ6y53bQ7hWgk=
X-Received: by 2002:a24:e0b:: with SMTP id 11-v6mr2519346ite.41.1542218529866;
 Wed, 14 Nov 2018 10:02:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:7050:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 10:02:09
 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1811131532270.1503-100000@iolanthe.rowland.org>
References: <000000000000214dc1057a74d206@google.com> <Pine.LNX.4.44L0.1811131532270.1503-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 14 Nov 2018 19:02:09 +0100
Message-ID: <CAAeHK+xVmCd6xEB42ML8wjUrwi0YcuoXdrykxCNs7sKjMo0QWQ@mail.gmail.com>
Subject: Re: WARNING in usb_submit_urb (4)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+7634edaea4d0b341c625@syzkaller.appspotmail.com>,
        Thinh.Nguyen@synopsys.com,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 9:37 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 12 Nov 2018, syzbot wrote:
>
>> syzbot has found a reproducer for the following crash on:
>>
>> HEAD commit:    e12e00e388de Merge tag 'kbuild-fixes-v4.20' of git://git.k..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=100e4ef5400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f215f21f041a0d7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=7634edaea4d0b341c625
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ce6fbd400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+7634edaea4d0b341c625@syzkaller.appspotmail.com
>
> I tried reproducing this bug on my own system, following the
> instructions at
>
> https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md
>
> The reproducer failed to run properly.  It produced the following
> output:
>
>
> $ ./syz-execprog -cover=0 -threaded=1 -repeat=1 -procs=4 /tmp/repro.syz
> 2018/11/13 15:29:32 parsed 1 programs
> 2018/11/13 15:29:32 executed programs: 0
> 2018/11/13 15:29:32 result: failed=false hanged=false err=executor 3: failed: tun: ioctl(TUNSETIFF) failed (errno 1)
> loop failed (errno 0)
>
>
> tun: ioctl(TUNSETIFF) failed (errno 1)
> loop failed (errno 0)
>
>
> The system is Fedora 28 running the 4.18.16-200.fc28.x86_64 kernel.
> What should I do to investigate further?

Hi Alan,

Looking at "errno 1", it seems that syz-execprog doesn't have enough
privileges to execute this ioctl, so you might need to run it as root.

However the absence of a C reproducer points to the fact that this is
some kind of a race condition. Those are quite sensitive to timing,
and any difference in the used setup might affect their
reproducibility. I would recommend building the exact kernel revision
with the provided config. For me it took around 3 minutes to
syz-execprog before I saw the WARNING.

Thanks!
