Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0828DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991C12082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apX/Orti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991C12082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeHaBJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:09:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41451 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaBJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:09:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so4436686pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8+l8HGpr4taN9rRvMJvqLy9icOQONdFaTDwQ6jli574=;
        b=apX/OrtiDYqq48e2Bn/TvmCzeWnIRwl/SQ3hb68gYEUJsAvqAql/jDYnW1UetFmwFt
         rZ0vVvzog+tH/FKPIaGUuVnABBzOndqN7HPL8cuVI82mnl9PlyiQDQ0Icbt/nTMgz0y7
         erbzAP4O6AjD2lYpxEVXEtbanp2ERTeOaQjKFz1I3C1kdVq+WMI2H0OiRCPpTsO+JIFC
         V75sSHGiX8zF7k+vdNG0SRLiyLXpicks/IpwkalM1/72ZI/4CFkFqUg+6W2ZwGJ5SeLn
         1P4RLwsTESYk8vdPqfNhtyLCh0AVuerj4xOTnC2Z9O77hAY4LpHlofV4J9iCYYRg7Baa
         Tb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8+l8HGpr4taN9rRvMJvqLy9icOQONdFaTDwQ6jli574=;
        b=EdQxQJnlA8DeHVHZlnE1S5up89vyihOoLkqRa8oAo8pm/QDNiQyI7k5o6p34u2P0Y9
         wefjJaaI/8qMg7QDQPlAOD5rktIO8tRpgtOgAqUoA5kXmCRPifVpw2sjKv7aSK5bEEPL
         1GWUdD41F1Y1n7iL/tXfqtLqO3+f/jVu+s0dkOXBJ1cCDeCLc4ZC0V9rmt+R8gvVT3qJ
         MN5fknPS+OfPOzywa0+fT/kmvCdY2LNddNzuV16v3agk3PNwm4TUh1ADm90xoAIbd9kC
         oayQckyaEp5DIeSbOcHb1YGsfmTCCm7NE4/WCGNekNPrQxs/YmmDv+uSTc7UvjRCgK5o
         8gIA==
X-Gm-Message-State: APzg51CXjPYBXldtSUFj7Q1s6fAJywmB/PhxZn3eUH3duasaamahasyg
        /eIhkixpZ4lez8mbkKsPV/ndP04eGd7wmJiXKFb1Lg==
X-Google-Smtp-Source: ANB0VdZz8ZR0F8KyQLkB2f8YJfmE7Ltq5dquxbQT74fzut/kHNYHv5xZi0QwKzjewa7b9nuEtIqWci6SbCy5Fbd1YeA=
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr12303501pfb.29.1535663154427;
 Thu, 30 Aug 2018 14:05:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 30 Aug 2018 14:05:33
 -0700 (PDT)
In-Reply-To: <355351e8-71fa-6db9-ad2a-43115cc2e80e@oracle.com>
References: <000000000000010a4d0574ab4743@google.com> <355351e8-71fa-6db9-ad2a-43115cc2e80e@oracle.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 30 Aug 2018 14:05:33 -0700
Message-ID: <CACT4Y+YLLqmq5Qp0N6bDviqC_X5ODmAwjYsRaMAvufzOLg4mFQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in rds_bind
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     syzbot <syzbot+915c9f99f3dbc4bd6cd1@syzkaller.appspotmail.com>,
        linux-rdma@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 1:56 PM, Santosh Shilimkar
<santosh.shilimkar@oracle.com> wrote:
> On 8/30/2018 11:31 AM, syzbot wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    2dca2cbde67a kmsan: fix build warnings with CONFIG_KMSAN=n
>> git tree:       https://github.com/google/kmsan.git/master
>
>
> BTW, can you please fix your git url since this one doesn't work.

I will fix this. Thanks.

But just to unblock you, it's git repo/branch, i.e.
https://github.com/google/kmsan.git is repo, and branch is master.


> This tree is not vanila kernel.org tree(4.19.0-rc1+ #36), so would be
> good to get the line numbers correct for sources.
>
> Regards,
> Snatosh
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/355351e8-71fa-6db9-ad2a-43115cc2e80e%40oracle.com.
>
> For more options, visit https://groups.google.com/d/optout.
