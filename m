Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F1AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7946621480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7946621480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbeHPG4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 02:56:55 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51549 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeHPG4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 02:56:55 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fq9TP-0008Ei-In; Wed, 15 Aug 2018 22:01:23 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fq9TN-000431-Ma; Wed, 15 Aug 2018 22:01:23 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzbot <syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com>,
        jlayton@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <0000000000007f59610573509684@google.com>
        <000000000000f4136d0573512103@google.com>
        <20180814191129.GN7906@fieldses.org>
        <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
Date:   Wed, 15 Aug 2018 23:01:15 -0500
In-Reply-To: <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
        (Dmitry Vyukov's message of "Tue, 14 Aug 2018 13:50:20 -0700")
Message-ID: <87o9e3gdtg.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fq9TN-000431-Ma;;;mid=<87o9e3gdtg.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19FUXP5VmTkD7ZwQqgZWhrbAzagn/bmm9U=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: general protection fault in send_sigurg_to_task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Tue, Aug 14, 2018 at 12:11 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>> On Mon, Aug 13, 2018 at 06:33:02AM -0700, syzbot wrote:
>>> syzbot has found a reproducer for the following crash on:
>>>
>>> HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
>>> git tree:       linux-next
>>
>> I fetched linux-next but don't have 5ed5da74de9e.
>
> Hi Bruce,
>
> +Stephen for the disappeared linux-next commit.
>
> On the dashboard link you can see that it also happened on a more
> recent commit 4e8b38549b50459a22573d756dd1f4e1963c2a8d that I do see
> now in linux-next.
>
>> I'm also not sure why I'm on the cc for this.
>
> You've been pointed to by "./scripts/get_maintainer.pl -f fs/fcntl.c"
> as maintainer of the file, which is the file where the crash happened.

You need to use your reproducer to bisect and find the commit that
caused this.  Otherwise you will continue to confuse people.

get_maintainer.pl is not a good target for automated reporting
especially against linux-next.

Eric
