Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AB5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F9E218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohxof4Xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F9E218A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeHQUbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:31:33 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46070 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHQUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:31:33 -0400
Received: by mail-pl0-f65.google.com with SMTP id j8-v6so3999592pll.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+4L8D8St/lR7jXEzhf3YzxxLgWXAssaQBhH5e65VdHg=;
        b=ohxof4Xhk0AmDULPGoveJiLoI+AXV4V/zCRVx3St9mjwo5Tcxt++e2s00BXapyVd/2
         hxcU8QiDSs/eg8nz+3TMY/e6NswKI4boxsxwn4+T31a+laDGQeorNlN8lT7qs7z4ibDB
         Q+Rmlvf3r5MDnfBATvS7Pf1hYE0JvFtMxRe2EvtDI29PrQZdzQbPHAOd0dJOAIPZmh9v
         pgCksD88P37ym7XeZPLDTdwEqgPfp9Zh8/F3Dt2aVpiSUa3RMzBCNEauh/pD6G/3QjYu
         aR9HXwaOTf6AFAss6NkC/4ZHU5Ojaj+OJ7jfsfas1V5MnDQeMQCaryt7QAWisTQGZOXy
         uzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+4L8D8St/lR7jXEzhf3YzxxLgWXAssaQBhH5e65VdHg=;
        b=s2K/vRUSQZoMfEdPGFWAvL4S0JXbzF32CqBWllMAh664cBnrPUZia24qYzRNuTMfVE
         wVyGjQssVn/FK9Li2EPKiUU2GYNLRSOC2emYk1/unLsaPNDZURBA0xD749XJyfkq5NX/
         adnhrVH77G2ypZP/HKa/3+tFVMhxcmr3j6W1LbOZ+qd3BZhHFySkLKa2xiTa+9ZMO3nd
         Nyp6hKfUiMZhgvViXuRlnbXaxKAtLwlb6F8yuvzOC/96iQFpMKo2ZDL9WhBJi1rH1WQj
         xikJXsBDs++lbz3zlc7KGJLSNpL5h2fJX7JygZyiESVEG79g+0dwKT+ZOs9peOs+HR3n
         bdaw==
X-Gm-Message-State: AOUpUlHGNKN0iABER0NlTtpYUskLv7y5oOZKk9qL2+mTbPRi4FfoTyA5
        Q4xwMhkEnZtOpdUAO+qnstksLz/V1w8SoIdLu5EqqFG+
X-Google-Smtp-Source: AA+uWPx8pOGqbQ0KW6pl/0LhL52R30wQTGeLL9fdAirbV55iRLyiM6MUiUmD9xyXxB/P/VKsiO+PPEedeKD+UcwWByg=
X-Received: by 2002:a17:902:6f10:: with SMTP id w16-v6mr15639547plk.216.1534526839237;
 Fri, 17 Aug 2018 10:27:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 17 Aug 2018 10:26:58
 -0700 (PDT)
In-Reply-To: <87o9e3gdtg.fsf@xmission.com>
References: <0000000000007f59610573509684@google.com> <000000000000f4136d0573512103@google.com>
 <20180814191129.GN7906@fieldses.org> <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
 <87o9e3gdtg.fsf@xmission.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Aug 2018 10:26:58 -0700
Message-ID: <CACT4Y+Yjj-n5BQvZhhM41fxxm57ABP1azEnrodmjZ65VrOcoxA@mail.gmail.com>
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

On Wed, Aug 15, 2018 at 9:01 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Dmitry Vyukov <dvyukov@google.com> writes:
>
>> On Tue, Aug 14, 2018 at 12:11 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>> On Mon, Aug 13, 2018 at 06:33:02AM -0700, syzbot wrote:
>>>> syzbot has found a reproducer for the following crash on:
>>>>
>>>> HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
>>>> git tree:       linux-next
>>>
>>> I fetched linux-next but don't have 5ed5da74de9e.
>>
>> Hi Bruce,
>>
>> +Stephen for the disappeared linux-next commit.
>>
>> On the dashboard link you can see that it also happened on a more
>> recent commit 4e8b38549b50459a22573d756dd1f4e1963c2a8d that I do see
>> now in linux-next.
>>
>>> I'm also not sure why I'm on the cc for this.
>>
>> You've been pointed to by "./scripts/get_maintainer.pl -f fs/fcntl.c"
>> as maintainer of the file, which is the file where the crash happened.
>
> You need to use your reproducer to bisect and find the commit that
> caused this.  Otherwise you will continue to confuse people.
>
> get_maintainer.pl is not a good target for automated reporting
> especially against linux-next.

Hi Eric,

We will do bisection.
But I afraid it will not give perfect attribution for a number of reasons:
 - broken build/boot which happens sometimes for prolonged periods and
prohibits bisection
 - elusive races that can't be reproduced reliably and thus bisection
can give wrong results
 - bugs introduced too long ago (e.g. author email is not even valid today)
 - reproducers triggering more than 1 bug, so base bisection commit
can actually be for another bug, or bisection can switch from one bug
to another
 - last but not least, bugs without reproducers
Bisection will add useful information to the bug report, but it will
not necessary make attribution better than it is now.

Do you have more examples where bugs were misreported? From what I see
current attrition works well. There are episodic fallouts, but well,
nothing is perfect in this world. Humans don't bisect frequently and
misreport sometimes. I think we just need to re-route bugs in such
cases.
