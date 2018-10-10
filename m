Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A140BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7455F214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7455F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeJJWLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:11:43 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51925 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeJJWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:11:43 -0400
Received: by mail-io1-f69.google.com with SMTP id z9-v6so2717944iog.18
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=7wxISKftTbbHg1I9o2oAP09peQQ7ZMJu0yJ95nqOzgs=;
        b=GwtM2XZ0vbduAKBW0GfjQg02KRXf2vb/cncm6cw4lBLzDAnLIdeRjiZap0wL+F2eHr
         Hlw/NCI+PbdmWfetCwCJzfWbmJ+w1o+i+d6NIX2m5D0SLlUfJ8B3aso6EiAdfRrhmsWr
         B//xoG0RC3H/PTY1FrWQOqtHyUKBUgN5E58UIU26JcdOxdM2r7EEKLPQdFkJeELGj1XC
         OPTaQjwfPr40ql5wXDihFvFzUjI//oOZ2HUUOMfyhYMC0/CUYA1AVctx53DlLd2QODg+
         Pq7Ghp8VzgBe4/npZECQLKVCSOl40LltV3mU2nIwzppnrP7iJ2b46dnbeCcDv6Hact65
         iTLA==
X-Gm-Message-State: ABuFfoiuKqf5uvbexdOUVLCnf7GYFJI+6nyZdaFFCdKAJRblbANAeZUF
        Ha0U8KSHtgnsVLxJzASU3Uqh/kiaAd/ldW6lS/j/VGJ8yd8g
X-Google-Smtp-Source: ACcGV61Yc7iRxNSTTwbzFnY4wDwFKrkINfYT//nL/OJ2/WQKVK6MT3Ex7mCGp7wDVFySe+AIpNtv5+0O3KsPyk1V476f44u5z3eY
MIME-Version: 1.0
X-Received: by 2002:a24:dd45:: with SMTP id t66-v6mr990838itf.5.1539182951432;
 Wed, 10 Oct 2018 07:49:11 -0700 (PDT)
Date:   Wed, 10 Oct 2018 07:49:11 -0700
In-Reply-To: <20181010144855.GB20918@nautica>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010889e0577e0f5f2@google.com>
Subject: Re: Re: BUG: corrupted list in p9_read_work
From:   syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     asmadeus@codewreck.org, davem@davemloft.net, dvyukov@google.com,
        ericvh@gmail.com, linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Dmitry Vyukov wrote on Wed, Oct 10, 2018:
>> > Back to the current patch, since as I said I am not confident this is a
>> > good enough fix for the current bug, will I get notified if the bug
>> > happens again once the patch hits linux-next with the Reported-by tag ?
>> > (I don't have the setup necessary to run a syz repro as there is no C
>> > repro, and won't have much time to do that setup sorry)

>> Yes, the bug will be reported again if it still happens after the
>> patch is merged (not just into linux-next, but into all tested trees,
>> but it does not matter much). So marking bugs as fixed tentatively is
>> fine if that's our best guess.

> Ok, thanks for confirming...

>> But note that syzbot can test fixes itself on request. It boils down
>> to just giving it the patch and the base tree:
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

> .. and for clarifying that bit, let's try that! :)

> #syz test: git://github.com/martinetd/linux  
> e4ca13f7d075e551dc158df6af18fb412a1dba0a

"git://github.com/martinetd/linux" does not look like a valid git repo  
address.


> --
> Dominique
