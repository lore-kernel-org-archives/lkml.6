Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195FEECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29D72098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTFp+MAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29D72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbeIXTRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:17:39 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35005 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbeIXTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:17:39 -0400
Received: by mail-it1-f196.google.com with SMTP id 139-v6so10389540itf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vbh+QkqFOS1mpPI7VNq21NTg36d6Xym2Vz1F6SyU6P4=;
        b=nTFp+MAxyhMU0I1y6JoPeAh274ygU5Cv9h20PUMGKGP/MMime4Ac02hmgoDDbZk3NL
         JeyFYi5RNESF5SS2oUnvKN+OIoQtTeGb+ezeYKp330y5Xl3oZXSvjr6PRjWaIrpc+TPd
         8vB0l09yPst5Z8YiOR1Y9ZJloC2lduDq1w/iLwytqFOJQgSztpNJ3ZNNqtI0hJLy2kn1
         MKruHwUGTpHa33FVdUWVqVHgQxLA+y5n0rFVTZ4p53cMFRMiAsCSbFnyGO9NHez2RuEX
         HsNuNPuzrfoOo/t9x9pLFRdgkdkwWnBQnU/06oCu49gESnkQihbffMY5plOwj5hlMVUV
         /FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vbh+QkqFOS1mpPI7VNq21NTg36d6Xym2Vz1F6SyU6P4=;
        b=BqRdihfboybxxmSLMywMN4BKxkECulKxuDMuELgW3hMW81Kp/tVXSHv6M5uffuq0Ci
         h9nlk7IX/5W44ieeDMk7EHl/AuMhmFCc07n0w/ULv2ZhjU+5AnAlpqUA0Esh1cWAmGnG
         c+diFrs+otp3X2Vy28pRInuBFBVGzSgZrNiigjSbDkeV9KNFJjQVO7iGuL3rXXpbRxUv
         7/JDFyPCjHa1t6lFc/SSOCMbjP1i98V+a5sVynb9nI5gIWHyuG7NwwnuojyTEaL2wpkF
         laRbMCzE3nM6VqFA3aKvzZ8FZLW1gx+Y8+c2UWYG5ANDgTSDnGMRKlk09XOyxkprXRQd
         u9VQ==
X-Gm-Message-State: APzg51DkZmylS3S4KH3/yW9S0Cv+mVhuk3qTld0Tm7fbXcQYBg9IiXT7
        OmQn8zOAyQg0uBlHvdH33J8pah4IB2UZKjp0kuuwOQ==
X-Google-Smtp-Source: ACcGV61cYJ/w15oCHYWJV2/R5jMhmCqseBwBctvZhVoFv8uw9dVKOdpxA/TcY3jhH0dYLn6ZAboP/sctHtOrrAgjt4w=
X-Received: by 2002:a24:140f:: with SMTP id 15-v6mr7931338itg.57.1537794930317;
 Mon, 24 Sep 2018 06:15:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 06:15:09
 -0700 (PDT)
In-Reply-To: <348002473.15454693.1537737330932.JavaMail.zimbra@redhat.com>
References: <956405482.15417289.1537693839327.JavaMail.zimbra@redhat.com>
 <1722725855.15417291.1537693865632.JavaMail.zimbra@redhat.com>
 <CACT4Y+anBfjFnKget7zu75uZVOV6ZT3-RPshaVt2a_4R3ararg@mail.gmail.com> <348002473.15454693.1537737330932.JavaMail.zimbra@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Sep 2018 15:15:09 +0200
Message-ID: <CACT4Y+YEnZsVMjKRmpM3eGtw=2O10k8S3a=Ltodaf77T7tut_A@mail.gmail.com>
Subject: Re: general protection fault in usb_find_alt_setting
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     syzbot 
        <bot+c99ecc8a2c68eb7e06cf2f652e60d63d6fbe2f31@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 11:15 PM, Vladis Dronov <vdronov@redhat.com> wrote:
> Hello, Dmitry,
>
> Thank you for the reply. I probably do not properly understand how
> syzcaller works then. Can you please, have a look at my reasoning.
>
> The bug:
>
> https://syzkaller.appspot.com/bug?id=4b88ff5aa6aa88f9283a45cc62f16e55b0722131
> (Reported-by: syzbot+c99ecc8a2c68eb7e06cf2f652e60d63d6fbe2f31@syzkaller.appspotmail.com,
> "[upstream] general protection fault in usb_find_alt_setting")
>
> was not fixed. it was closed as invalid, so, afaiu, all the work has stopped for it.
>
> So syzbot did not wait until the fixing commit reached all tested trees, and the
> crash was not spotted again _after_ that.
>
> Then I look at the bug:
>
> https://syzkaller.appspot.com/bug?id=a0ec6260a1d37288a4508250fe30a5604ceec666
> (Reported-by: syzbot+19c3aaef85a89d451eac@syzkaller.appspotmail.com,
> "[upstream] general protection fault in usb_find_alt_setting (2)")
>
> And I see the crash happens at the same place _and_ at the same code:
>
> (bug id=a0ec6260a1d3)
> RIP: 0010:usb_find_alt_setting+0x38/0x310 drivers/usb/core/usb.c:231
> Code: ... fd 48 8d 7b 04 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 86 02 00 00
> (bug id=4b88ff5aa6aa)
> Code: ... fd 48 8d 7b 04 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 a1 02 00
> RIP: usb_find_alt_setting+0x38/0x310 drivers/usb/core/usb.c:231 RSP: ffff88005893f610
>
> This makes me be sure these are the same bug (dup) which are fixed by the same
> commit "USB: handle NULL config in usb_find_alt_setting()".
>
> As I'm kinda a perfectionist, I would like to mark (bug id=4b88ff5aa6aa) as
> fixed by this commit and not closed as invalid.


My bad: I did not check status of the first version of the bug:
https://syzkaller.appspot.com/bug?id=4b88ff5aa6aa88f9283a45cc62f16e55b0722131

The thing is that "fixed" and "invalid" are considered terminal states
for a bug. syzbot ignores all commands for them. This was done to
avoid races between re-opening an old bug and syzbot creating a new
version of the same bug at the same time. And also to simplify overall
process: bugs moving monotonically to terminal states. So at the
moment it's unfortunately not possible to go back and say that this
was a dup rather than invalid, like one would do in a real bug
tracker.
As a rule of thumb: things still on dashboard need some action, things
that are already not on the dashboard do not need any attention.

The reason for closing the first one was noted here:
https://groups.google.com/d/msg/syzkaller-bugs/Iqf80RqXK14/SSYd1aAtAQAJ
Taking into account the huge number of bugs, it can make more sense to
clean up the dashboard from old, most likely irrelevant bugs to
increase chances of fixing other bugs. In this case it was a wrong
decision, probably a part of a sweeping clean up. But syzbot created a
new bug for this since it started happening again, so in the end
everything worked as intended.

I understand this all can look somewhat confusing initially. The
system built as an attempt to chew hundreds of bugs per month with
limited human resources.

But we need perfectionists for lots of the open bugs on the dashboard!
https://syzkaller.appspot.com#upstream


> ----- Original Message -----
>> From: "Dmitry Vyukov" <dvyukov@google.com>
>> On Sun, Sep 23, 2018 at 11:11 AM, Vladis Dronov <vdronov@redhat.com> wrote:
>> > #syz fix: USB: handle NULL config in usb_find_alt_setting()
>> > #syz dup: general protection fault in usb_find_alt_setting (2)
>>
>> Same here.
>> syzbot process designed in such way that it will not open second
>> version of the bug (2) for the same bug. syzbot waits until the fixing
>> commit reaches all tested tree and only then closes a bug. If the
>> crash is spotted again _after_ that, then syzbot creates second
>> version of the bug (2). But at that point it has to be a different bug
>> requiring a different fix.
>> So this should not be a dup, and should not fixed with the same commit
>> as the first version.
