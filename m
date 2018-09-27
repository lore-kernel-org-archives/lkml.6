Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A972FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6453D216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3d11sg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6453D216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeI1AYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:24:20 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35985 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbeI1AYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:24:20 -0400
Received: by mail-it1-f196.google.com with SMTP id c85-v6so8705800itd.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VZr7aKi47sTyD8Ll+KpFi2h+MuNYiH03XRvcg5PzOaU=;
        b=V3d11sg49oJOt4vybPmktOWJcE+kGHmXfutNcJYwNm4mhJXEmxlv4VaKucJv5UqTtZ
         LnUZ1zUeO3bodT9oz66cQGMlogp9ovseo02lRBEWWUQh4UeBJhTnDQXDzEB0s9NiH5RF
         o86M9bmsJvERHkQ/njGjcfZ+Q7BYu4vJBJhLuyHB6WFss/p52O9Nx07rIGwTM+CNs9Y7
         qiaxICfUQDuBWIr0y9ZOhjs25b5m3N7PgM+TIMDesH2Fh9T9pCw7qWK0EI9ut/lRDGtM
         IyqGYpSQ3j6PMM9eyAMsTApQgPiKJBzz6pyjpQsbgD7u4GSoM1eOgNBERIFtZHCuedBR
         aJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VZr7aKi47sTyD8Ll+KpFi2h+MuNYiH03XRvcg5PzOaU=;
        b=D+Anh3TYboEdvLDehOH5dwRuZgKhK5vLtC0UaXYFsSAsoXYTOUqEGSIVI3vQg1Ex4d
         3jE4XX22Qj93VY+acpMNU1Vf8YZ3sy82unX6nfElWm0WMVSN63zpJZobA+jQq0aobKaM
         54fCko8Mt79d7KdE+x/pbOByZOv63p3vYCM7Vm2F1b2cPJfSzwQGXwWrtcxSwbxRy/GU
         8fNnSUtAmqcPDGFrDzTgT0uGXkC9Ophrlnkt3bGUUQ6jMT2b4YWuWzJirYB7rntgHw7M
         HXkfrTjhJZ4VU05XV3bLKfjDM7gXE4T8UYgLIgIAanh4laS+DsAPFWNw2q5Y9PH1Vmqr
         UY7A==
X-Gm-Message-State: ABuFfogRIp3gy+2aC5WF6zlfIXrSvDhUB3VYTGIgTI+kPdbCPEAdTx1g
        kWnPY19UjRCsnh59PrSJr88OSL2vubRs+NfTul6LNw==
X-Google-Smtp-Source: ACcGV613NpsEl1ZjgjzYXcWB0TzjGR0+Q7nzDK8E4L87LCZW2bGX93hYJGHo+SAkUs35prlTk3CjV9Cyh+cGd1oQsJY=
X-Received: by 2002:a02:88f7:: with SMTP id b52-v6mr11102688jak.25.1538071492067;
 Thu, 27 Sep 2018 11:04:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 11:04:31
 -0700 (PDT)
In-Reply-To: <CAM_iQpUpe5J30_aOzDUHrxiC7hXyQfH6-R7TM_L==gkj_XTu5w@mail.gmail.com>
References: <00000000000084e2450576c817cc@google.com> <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
 <7fcb1c03-6976-9b34-601d-5f50b74c5b0a@gmail.com> <CAM_iQpX4sKSPFXgEjU-be=he=91+=3Bm9KvP3CMciA9zi2b-6g@mail.gmail.com>
 <CACT4Y+YbfOYDHJjeK-88wQDg2oSF3fqsaWBhkDwnDr+KUsLnDA@mail.gmail.com>
 <CACT4Y+YbQbZ7XTPK1HLvPiR9rmSm7Cz0H2LJAFfYfAta1Y3CiQ@mail.gmail.com> <CAM_iQpUpe5J30_aOzDUHrxiC7hXyQfH6-R7TM_L==gkj_XTu5w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Sep 2018 20:04:31 +0200
Message-ID: <CACT4Y+bzKdys4gV=aNH8NvAEMVuoznnhgju3nxiGSgnp21U5hQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tcf_block_find
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
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

On Thu, Sep 27, 2018 at 7:50 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Thu, Sep 27, 2018 at 1:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> Would a stack trace for call_rcu be helpful here? I have this idea for
>> a long time, but never get around to implementing it:
>> https://bugzilla.kernel.org/show_bug.cgi?id=198437
>
> Yes. Generally speaking, showing backtrace of call_rcu()
> or schedule_work(0 etc. is very helpful, we are more interested
> in who calls call_rcu() than what that RCU callback does.
>
> BTW, yesterday I asked syzbot to test this:
> https://github.com/congwang/linux/commit/b7815584cf1c0bbb79e8f6fe3e4b66ba10375560
> I still don't get any result.

I see that test job. It's in some dead loop, now trying to run for 37'th time.
I've just pushed a fix a bug that could have caused it (fuzzing the
fuzzer, we should go deeper!):
https://github.com/google/syzkaller/commit/98b28ead6ceaf22064b9715cc1950848d2bdef0b
If it won't help, I will take a look tomorrow.


> For this specific bug, we should hold a refcnt in dev->qdisc, I don't
> even see how call_rcu() could be invoked, unless of course we mess
> up with qdisc refcnt.
