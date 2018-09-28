Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D97FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3079216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5hNOrnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3079216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeI1OTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:19:14 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50760 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeI1OTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:19:14 -0400
Received: by mail-it1-f196.google.com with SMTP id j81-v6so1588770ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HWpsdd2Fka1HgGR3nWvg3f1+1jEYCBt7S6Rp6t1rgWo=;
        b=Q5hNOrnEuqR8WClhtxeSAOXX4ERBqtRCGgy+1udIcVj7KfGjjjsyN03g2aAOzjn+5X
         1jo55Kka0BKNVAftyzpvi+gHGZ2SHSq3hq8dk7pVfzAadl2uzQGXGWPaTE+CV0Dn4sfW
         /lKM0O9EAbNARKAraOM5eCxCvdZAQWiePVmvqROqnxh+IiCiZjOsVHx+A515SsBFfucf
         PYSLr2jrOakdRcUi6TxW5WFHGL6lYM2tc64vUtqPs4iOLm1m6uVMB/l2cTYOIh0oN/da
         hOdv65oSshKoKO7FAQ/dXWs/tPSMwOeJmDhV3chQEW/CoWyogty/Ejg6/OcmZs81jDxN
         HG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HWpsdd2Fka1HgGR3nWvg3f1+1jEYCBt7S6Rp6t1rgWo=;
        b=aQH7lHUpVdA7YXqQus7GvObrXTB3hSDfK5iNfF2uMFbMpb8txLhuNojg8F6V8wmxGa
         IKaVltV8G24YdsS+SD+Fj/AG5x0zMrD7IslzPH/IIpwr4NzLte9DwUIgVJDqMioHf5ek
         ql44xsqqy/3oygcUAh5w5vGp26Y8uOvcUhT46f9YF3tkxN0DGjsX/CFEJ+0DnVNiurP/
         xc7QuDj0lDniZt/8YVykkcfWWQt/Htx8a2FogSywOvVTNy4Vg9+VqgtOiepmc31Sj88l
         uTc/av7uMUB40619U8scC92Uxf2Zs8yO/WjmwkEs/h0jqobRB+RaqZHflVJ/1jym7Z5/
         6Mdg==
X-Gm-Message-State: ABuFfohbwihcWapchLkJNhR1H+ilraRD1PmeDdCzFyAQwyFZwab3S0P1
        ZWmIXaYIQ56Xfww94/22pBTJMhFO1m7Szmk3oOiSxw==
X-Google-Smtp-Source: ACcGV61Bbp/H582NR5c9JZmA33h1yxw4eIbSK4oc54jRV5ZiVaepVE02s8tXnzcXhmf8Koszcki3YYUx/IMhlktnMbI=
X-Received: by 2002:a24:3383:: with SMTP id k125-v6mr734646itk.14.1538121404508;
 Fri, 28 Sep 2018 00:56:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 00:56:23
 -0700 (PDT)
In-Reply-To: <20180928070042.GF3439@hirez.programming.kicks-ass.net>
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 28 Sep 2018 09:56:23 +0200
Message-ID: <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 9:00 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > Hello,
>> >
>> > syzbot found the following crash on:
>> >
>> > HEAD commit:    c307aaf3eb47 Merge tag 'iommu-fixes-v4.19-rc5' of git://gi..
>> > git tree:       upstream
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=13810df1400000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=aaa6fa4949cc5d9b7b25
>> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> >
>> > Unfortunately, I don't have any reproducer for this crash yet.
>> >
>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com
>>
>> +LOCKDEP maintainers,
>>
>> What does this BUG mean? And how should it be fixed?
>>
>> Thanks
>>
>> > BUG: MAX_LOCKDEP_CHAINS too low!
>
> Is the his result of endlessly loading and unloading modules?
>
> In which case, the fix is: don't do that then.

No modules involved, we don't have any modules in the image. Must be
something else.
Perhaps syzkaller just produced a workload so diverse that nobody ever produced.
