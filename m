Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8DEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33B82152C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snUNdAYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33B82152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeI1AJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:09:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40845 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1AJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:09:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so2487503pgm.7;
        Thu, 27 Sep 2018 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wNdvuPH8Fo4yHUpSovZ5JOJ201TLiNb2H53Y0ZFzD3o=;
        b=snUNdAYsW+ZjK8+NTBbdIyIoSyEKJ7HCZ6/dy1FaIQKmQw2eSGpUYgcAfonWyeEaTT
         nzujzkolnfO1GU7Eheb1WREgnQ8Lf3ndzPQPchPHd+FvolZa6gWMYfB9pn09Tcg7Gpf4
         VAogYdoUXHMh8HinkctElhB+DaqSicPFRfrJcC2NQn9TUVgx5Zr+Fz1IacdVe86BlG4B
         2eSDdzibaL/1R01LVZ/Ij0wOfpDHYN6YVvPasoiqvXvre9dfur7DYoP9VFSKkfs6tJTd
         fRVWOpAO22HNfaSmwhK2em8YVosCRF025VE8yIC1+IhQW7NDnpPpfqxcBfKYViCZEi7D
         yCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wNdvuPH8Fo4yHUpSovZ5JOJ201TLiNb2H53Y0ZFzD3o=;
        b=lIvOv6ymgGzuRuUsQp4wpxyKvrcRsPKBzkk/UXmT891TGhHWBxZ8bpyYDq3q83J+h5
         3/WQnwFaQ3Y3kwz/UX+H5WTixDtjWc6s61Cw0wAwROSj/xjErG7Lc8S1b/b+84UOUGlw
         2EUkKwFsPMLfXRrMRL+GTc0vQZfgC/16pzDmTLgsVvz8I4Xef8pnQpdB2/gDWUbhG6sk
         QB1/myUuMpKHX7QdlshgOHET/hi8Eppm+jom6QmFULj+nOykjGh0cF+YTQ9IHbwBTP9l
         WW/ntYTJjIrr9VE+O+01HZKOi28K/79aDlU32axeQZIhBv/ljvyHipzAEhk5PEPj7ZZ4
         mwdg==
X-Gm-Message-State: ABuFfohp4gfJ0cMRo+EZFH1BLe3s0XtpIvsL4qOZYfVyyGaI2QW24iQ7
        igN6wVevJnrh1wdo4L2h8AshKfYSEVpDgYBnAAk=
X-Google-Smtp-Source: ACcGV60qziZYxl2agn3Zph5Gee2QtI0kKiUyOMaHQQrgF6TaRADLyLsalhjPgNKvDn0Yc4q5PyjjeHjp36i9rN8bDio=
X-Received: by 2002:a62:f909:: with SMTP id o9-v6mr460434pfh.160.1538070612618;
 Thu, 27 Sep 2018 10:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000084e2450576c817cc@google.com> <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
 <7fcb1c03-6976-9b34-601d-5f50b74c5b0a@gmail.com> <CAM_iQpX4sKSPFXgEjU-be=he=91+=3Bm9KvP3CMciA9zi2b-6g@mail.gmail.com>
 <CACT4Y+YbfOYDHJjeK-88wQDg2oSF3fqsaWBhkDwnDr+KUsLnDA@mail.gmail.com> <CACT4Y+YbQbZ7XTPK1HLvPiR9rmSm7Cz0H2LJAFfYfAta1Y3CiQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YbQbZ7XTPK1HLvPiR9rmSm7Cz0H2LJAFfYfAta1Y3CiQ@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 27 Sep 2018 10:50:00 -0700
Message-ID: <CAM_iQpUpe5J30_aOzDUHrxiC7hXyQfH6-R7TM_L==gkj_XTu5w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tcf_block_find
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 1:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Would a stack trace for call_rcu be helpful here? I have this idea for
> a long time, but never get around to implementing it:
> https://bugzilla.kernel.org/show_bug.cgi?id=198437

Yes. Generally speaking, showing backtrace of call_rcu()
or schedule_work(0 etc. is very helpful, we are more interested
in who calls call_rcu() than what that RCU callback does.

BTW, yesterday I asked syzbot to test this:
https://github.com/congwang/linux/commit/b7815584cf1c0bbb79e8f6fe3e4b66ba10375560
I still don't get any result.

For this specific bug, we should hold a refcnt in dev->qdisc, I don't
even see how call_rcu() could be invoked, unless of course we mess
up with qdisc refcnt.
