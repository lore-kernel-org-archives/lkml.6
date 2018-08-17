Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27718C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DCA21BE4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ELNN+xPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DCA21BE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeHQVr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:47:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46415 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbeHQVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:47:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so3854068pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E/a9YIirtqurfiiAWnp+NJz038uA11GtM3qGddpWnGs=;
        b=ELNN+xPAjNHnXhTVAj/sas8b3XbktTvHVREzEOdCGodIhVOK7dk9fa8Xr1eIdtbVFb
         lfSnorusFJuED4+jBaYkU6U3JY1+WLMr66YvEXyHefcSHJOLNv1Yw64FrspZKqWvz86P
         kq6X8n7hK8Wnc7AgYOP4q3ks/zkKQrXnbuzT2QOzGyA/sZ76Sgzwa9yCxIKxICdkat8z
         5wbrtm6yLlerBmqf8yNlcybinFM6/+9+5i+P84yQ9mfEEUtzBkpdyOsp2GrhkGZ6kME2
         74JSE6I3Q2Sbr9BM81P1yuklQwF8U3+lO91m4YhxnhXp1uiy4HzRUwozBKMdcTJ+5M9N
         NKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E/a9YIirtqurfiiAWnp+NJz038uA11GtM3qGddpWnGs=;
        b=oReuW0ssMUVyeg+Esbd2W91P6tEkV989tFyxgVef1fVYupVB2u90MNFm7qm+DOsFh1
         Zy3e7tqNz9LPH9cZbPsvWh/KYKYSZ661IS9e0KpEeME5v1tUZACjNFG9xgFXlyEaRnZI
         MzmKsAugwLreaGCnRv4B5OamK/lxWFxeRbgS20oTI79lhKv4re8fQ88+XQkdXl339gSZ
         n8qXQaHTnOkHWNxiBy/UWUw1be3ycQhNTXnicGFhZJdYZLoVedbHmU36tj3HiBE4cqFS
         OHi729OXDa4AKU4GuOgKKmR24k6A9cYW9CvsWBDL937Xr3LR6mAlH5I2KUxICjLzLo15
         p+2A==
X-Gm-Message-State: AOUpUlFhrc1dcvm170wV/iVJGDbSVsad98Cs1WEAxnBPEGBZfIlSazAj
        bF+otd9LW+lGPa/i2nToTowLqIx68b2TmxLkWLB0oQ==
X-Google-Smtp-Source: AA+uWPyr5HGB4OskhmSVkqaFLDcTZlE51hGVKQBckTAwo82FiOPBtlgSeAXjswt60Y+ltg09Ho6Hp7Zjll61u5/eltM=
X-Received: by 2002:a62:a05:: with SMTP id s5-v6mr37598953pfi.147.1534531380979;
 Fri, 17 Aug 2018 11:43:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 17 Aug 2018 11:42:40
 -0700 (PDT)
In-Reply-To: <87d0ugc0pk.fsf@xmission.com>
References: <0000000000007f59610573509684@google.com> <000000000000f4136d0573512103@google.com>
 <20180814191129.GN7906@fieldses.org> <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
 <87o9e3gdtg.fsf@xmission.com> <CACT4Y+Yjj-n5BQvZhhM41fxxm57ABP1azEnrodmjZ65VrOcoxA@mail.gmail.com>
 <87d0ugc0pk.fsf@xmission.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Aug 2018 11:42:40 -0700
Message-ID: <CACT4Y+YHObUEbmf4UYopmjCceN6nd4nck_iV0JtpBO6zGixm5A@mail.gmail.com>
Subject: Re: general protection fault in send_sigurg_to_task
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzbot <syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com>,
        jlayton@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 11:22 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Dmitry Vyukov <dvyukov@google.com> writes:
>
>> On Wed, Aug 15, 2018 at 9:01 PM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>> Dmitry Vyukov <dvyukov@google.com> writes:
>>>
>>>> On Tue, Aug 14, 2018 at 12:11 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>>>> On Mon, Aug 13, 2018 at 06:33:02AM -0700, syzbot wrote:
>>>>>> syzbot has found a reproducer for the following crash on:
>>>>>>
>>>>>> HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
>>>>>> git tree:       linux-next
>>>>>
>>>>> I fetched linux-next but don't have 5ed5da74de9e.
>>>>
>>>> Hi Bruce,
>>>>
>>>> +Stephen for the disappeared linux-next commit.
>>>>
>>>> On the dashboard link you can see that it also happened on a more
>>>> recent commit 4e8b38549b50459a22573d756dd1f4e1963c2a8d that I do see
>>>> now in linux-next.
>>>>
>>>>> I'm also not sure why I'm on the cc for this.
>>>>
>>>> You've been pointed to by "./scripts/get_maintainer.pl -f fs/fcntl.c"
>>>> as maintainer of the file, which is the file where the crash happened.
>>>
>>> You need to use your reproducer to bisect and find the commit that
>>> caused this.  Otherwise you will continue to confuse people.
>>>
>>> get_maintainer.pl is not a good target for automated reporting
>>> especially against linux-next.
>>
>> Hi Eric,
>>
>> We will do bisection.
>> But I afraid it will not give perfect attribution for a number of reasons:
>>  - broken build/boot which happens sometimes for prolonged periods and
>> prohibits bisection
>>  - elusive races that can't be reproduced reliably and thus bisection
>> can give wrong results
>>  - bugs introduced too long ago (e.g. author email is not even valid today)
>>  - reproducers triggering more than 1 bug, so base bisection commit
>> can actually be for another bug, or bisection can switch from one bug
>> to another
>>  - last but not least, bugs without reproducers
>> Bisection will add useful information to the bug report, but it will
>> not necessary make attribution better than it is now.
>>
>> Do you have more examples where bugs were misreported? From what I see
>> current attrition works well. There are episodic fallouts, but well,
>> nothing is perfect in this world. Humans don't bisect frequently and
>> misreport sometimes. I think we just need to re-route bugs in such
>> cases.
>
> I have yet to see syzbot make a good report.  Especially against
> linux-next.

Well, first of all, we are not aware of any massive problems because
nobody tells us. What are the systematic problems that affect lots of
reports?

I took few recent ones. Anything wrong with them?

https://lkml.org/lkml/2018/7/15/230
https://lkml.org/lkml/2018/7/18/992
https://lkml.org/lkml/2018/4/19/705
https://groups.google.com/forum/#!msg/syzkaller-bugs/F7KnbAmMa7E/VSbaYHyQCAAJ
