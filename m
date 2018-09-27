Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A59EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E913A21531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vw+qNAkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E913A21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeI0TVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:21:00 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35581 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeI0TVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:21:00 -0400
Received: by mail-it1-f193.google.com with SMTP id 139-v6so7563214itf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HO1xaU1LWsbi3J6EOvumEptSmG/vNd7a3ZJ8EL8KtIw=;
        b=Vw+qNAkvcA/UTlbMCcweWd/YXhDGx9GwJEZlfiA9T28TmOIa/cQ7roA7hLDCxLUMfX
         aQMLfwl/a5juw20x9ZzaEW6YREf/bbG+66Ev+BcJgXQjldNTj8G2/CxJAwgrfHbzGMRl
         qiXoxnxcUwihYdtL9QOud7HVHVsZA+7u3P/Hmtu6SYzDpDSlf52KTSeUcqP6DLLtA/1T
         9dRGvxY0Ky4hsKsla4qTYDNbuv4G4zQjaqtj5S64+fmReOoPjn2bb5eTmGF0VQqwDeCP
         j5bERRTSi3kwJmq93TsG/FmUGpWKbRfjLtVmylsLNkOGPMhp8tkSyxMnbQ6CoNZifjNJ
         QY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HO1xaU1LWsbi3J6EOvumEptSmG/vNd7a3ZJ8EL8KtIw=;
        b=rOaCcALw9Wmc38sidT4R7EGWZXsbnd/lcn/mb/6gBgjeIc9QrENUFCsZX7tsFfHTDm
         d6D+lk9TrO3jN1bJwOwBnwp2y+Kh6Aki0iyop9awD4fdFWVc/Fs9VyjgHYO3LnnXmsdA
         Z3jLWgKWai5llX3PHrdWx3NKzS8H6Quc3s2KWVR7+zLH3ebeuSuEHYw/i3TeYKfb5a0S
         Qy9O9dhpNObJRzGFWx8U9pnsACvwkBgh4OjVaP1GdW+eKJtS0OtZYHpxP7uW1QgIDq/R
         4HEjjxjNGP6t7MPnc8BoGDWocS93Vfs6M9cq3tCmEJl9cETBG5PA3tsI50IbUe1Camnb
         p/LQ==
X-Gm-Message-State: ABuFfogaIrx9gIdwoqZdORWC3DYAO2FikLEmGZEoLhwMVBTL70FrPWr1
        ROPlA0ZD7eMFC97V9xWp0CV2t1X81Z/KsCtTKJ6vAQ==
X-Google-Smtp-Source: ACcGV62xRN8Y/dRFN8Z2NJzbS4M2AO0eqHAC8KpZKTKAekTOkL7hBoZ9KNbItDiSv8UHZyQ/L7JaScAfvman+ZXmAHc=
X-Received: by 2002:a24:c0c5:: with SMTP id u188-v6mr9253357itf.57.1538053369675;
 Thu, 27 Sep 2018 06:02:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 06:02:29
 -0700 (PDT)
In-Reply-To: <de41f26b-efe6-9985-cf38-169c18791cd6@gmail.com>
References: <00000000000084e2450576c817cc@google.com> <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
 <7fcb1c03-6976-9b34-601d-5f50b74c5b0a@gmail.com> <CAM_iQpX4sKSPFXgEjU-be=he=91+=3Bm9KvP3CMciA9zi2b-6g@mail.gmail.com>
 <CACT4Y+YbfOYDHJjeK-88wQDg2oSF3fqsaWBhkDwnDr+KUsLnDA@mail.gmail.com>
 <CACT4Y+YbQbZ7XTPK1HLvPiR9rmSm7Cz0H2LJAFfYfAta1Y3CiQ@mail.gmail.com> <de41f26b-efe6-9985-cf38-169c18791cd6@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Sep 2018 15:02:29 +0200
Message-ID: <CACT4Y+ZvoVsL_BjBWr7QPnXOPGXqkqKfo-NQcox7vaAFPWVUVg@mail.gmail.com>
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

On Thu, Sep 27, 2018 at 3:00 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 09/27/2018 01:10 AM, Dmitry Vyukov wrote:
>
>>
>> Would a stack trace for call_rcu be helpful here? I have this idea for
>> a long time, but never get around to implementing it:
>> https://bugzilla.kernel.org/show_bug.cgi?id=198437
>>
>> Also FWIW I recently used the following hack for another net bug. It
>> made that other bug involving call_rcu way more likely to fire. Maybe
>> it will be helpful here too.
>>
>> diff --git a/net/core/dst.c b/net/core/dst.c
>> index 81ccf20e28265..591a8d0aca545 100644
>> --- a/net/core/dst.c
>> +++ b/net/core/dst.c
>> @@ -187,8 +187,16 @@ void dst_release(struct dst_entry *dst)
>>                 if (unlikely(newrefcnt < 0))
>>                         net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
>>                                              __func__, dst, newrefcnt);
>> -               if (!newrefcnt)
>> -                       call_rcu(&dst->rcu_head, dst_destroy_rcu);
>> +               if (!newrefcnt) {
>> +                       if (lock_is_held(&rcu_bh_lock_map) ||
>> +                               lock_is_held(&rcu_lock_map) ||
>> +                               lock_is_held(&rcu_sched_lock_map)) {
>> +                               call_rcu(&dst->rcu_head, dst_destroy_rcu);
>> +                       } else {
>> +                               synchronize_rcu();
>
> dst_release() can be called in context we hold a spinlock, this would be bad to reschedule here.

I am not suggesting to commit this. This is just a hack for debugging.
It in fact lead to some warnings, but still allowed me to reproduce
the bug reliably.

>> +                               dst_destroy_rcu(&dst->rcu_head);
>> +                       }
>> +               }
>>         }
>>  }
