Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA83216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fn3s7O/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA83216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeI0UB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:01:26 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40918 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeI0UB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:01:26 -0400
Received: by mail-it1-f194.google.com with SMTP id h23-v6so7677399ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fF7YeV8DRJQ6wodqB/cmX5YbHihGdvbx+v71/YD/rmk=;
        b=Fn3s7O/aukSgl1ZknW6081HPpwGW7J1pFmruZ0ftj1k1VC4D6lhxhcKY3e+aZSfLYz
         +ncik3+flfww+QtKBKDhHZZfYEPt95clJ4lykei8rMGlEnAOiyw21tBHXpTT6ioeBfx0
         sHIE0r2C8CYwSvCmMsH+78fgTFmmAQojqSdtsHeA5cWXpiEd+t60Db3vniWz7h6BZz7l
         dTVsuQHCtThSUfeJMu/BaTTZO6i0GDFAupV9YqOHyp2BoryV3mjrhwHdAs0wzYNaJ68l
         CNkhJvOOn7Z3k7YSv6j3QlVdf+aHDAHSLRjuE44btPB+ShKTVYg6J5L5JXULYB9p+z1B
         6LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fF7YeV8DRJQ6wodqB/cmX5YbHihGdvbx+v71/YD/rmk=;
        b=mErZozUhDKfAx5v/vWn0WLrVgfOWGZ64H4ArLaFDyx7b1XsFZvdHDuRi43A/gOUS0w
         T2wtHSdufUG5pLLtZ8qCyq1oj2gbhpTEnPgQkhEF/UN02enM/b006wiAt8e0W+uv47Qg
         W/bmFhOBrFAnDzuouCngVTKB5JK+DAFNDKnxfsckY+1Rm6gQodA0JoVmxe7uIcmGr6hD
         qF5PHbp1ymLzPlDVBtmDki8enSz4uGG2t4ExxLyAjbVE1MsuWHVZ99B1oBIFz6rzj+zG
         hJrqeKrsXRSfeNagy5FJ7V1oZpLEOboQxNehKssibLjWE04pMfdXT5AUnZlXJ55AqAqM
         dnIA==
X-Gm-Message-State: ABuFfojnBK68FYaO0+cGjVGKa0WVcz//cLoixxZLXM4gKNG/hBnotF9P
        lgu56PBwnW959RWYcQSwUC9Oae+Z/G8l0pPV8T+hyg==
X-Google-Smtp-Source: ACcGV60tnolufpG3gK+PG/nPDvbHXHcoJXqhaTYblsAjDYyKyfC7ZUBL8O0FKADKunHCltPnm6Hj2jA+N02uhc3V9Jc=
X-Received: by 2002:a24:e187:: with SMTP id n129-v6mr9125036ith.47.1538055786722;
 Thu, 27 Sep 2018 06:43:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 06:42:45
 -0700 (PDT)
In-Reply-To: <10a02f06-2e6c-e70b-2766-012a835d3a57@gmail.com>
References: <00000000000084e2450576c817cc@google.com> <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
 <7fcb1c03-6976-9b34-601d-5f50b74c5b0a@gmail.com> <CAM_iQpX4sKSPFXgEjU-be=he=91+=3Bm9KvP3CMciA9zi2b-6g@mail.gmail.com>
 <CACT4Y+YbfOYDHJjeK-88wQDg2oSF3fqsaWBhkDwnDr+KUsLnDA@mail.gmail.com>
 <CACT4Y+YbQbZ7XTPK1HLvPiR9rmSm7Cz0H2LJAFfYfAta1Y3CiQ@mail.gmail.com>
 <de41f26b-efe6-9985-cf38-169c18791cd6@gmail.com> <CACT4Y+ZvoVsL_BjBWr7QPnXOPGXqkqKfo-NQcox7vaAFPWVUVg@mail.gmail.com>
 <10a02f06-2e6c-e70b-2766-012a835d3a57@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Sep 2018 15:42:45 +0200
Message-ID: <CACT4Y+Z24_ak+42mUGxMWBcBdXFYXFGKomPe0QzFUX+YSSkV+Q@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tcf_block_find
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 3:24 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On 09/27/2018 06:02 AM, Dmitry Vyukov wrote:
>
>> I am not suggesting to commit this. This is just a hack for debugging.
>> It in fact lead to some warnings, but still allowed me to reproduce
>> the bug reliably.
>>
>
> Had you got more meaningful stack traces ?
>
> (Showing which context was actually doing the dst_release())

nope... I just handed off the instructions to Wei since she said she
can't reproduce it.


>>>> +                               dst_destroy_rcu(&dst->rcu_head);
>>>> +                       }
>>>> +               }
>>>>         }
>>>>  }
>
> Thanks.
