Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0549DC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC81221A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="I2fbLXpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC81221A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbeHFRhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:37:47 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44887 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732713AbeHFRhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:37:46 -0400
Received: by mail-qt0-f196.google.com with SMTP id b15-v6so14205030qtp.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2GqIl2Igk9YwCWaoMedz8uktj2Dvrc+kRj9fzcXAx2Y=;
        b=I2fbLXpA5/dyePV4VturmfTyLqz6fcZBzwMIvPkUyRMnANcFekann+eVsyFNFIauoE
         CZ90ElaC6jZJFKzbVRdh8hopa+Oxlu28iXcGew41Xdh5chsfbIKgFGC1tZq5Eq7ZVysT
         PsrjzkIxHHSJ8WbFkYDxqdUNp6Kwbin47XzJgFOzSq2XtcYi3e0/hRlvjeikEC1ael49
         wIS7bpTS+Og40GPPB9BMf8gpvYkyOGV+R+6SnnUNJbBoiKyDYK3zfSRvJj5E3u79R5TI
         SJepTyJB3ZuJTe7kEdNNxIOIdfGz/qoSBn6vQ365BE/hekrS2wFiGUj7C6Jiv3TRNfeT
         qBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2GqIl2Igk9YwCWaoMedz8uktj2Dvrc+kRj9fzcXAx2Y=;
        b=WtVQS+39gKbkwTf1urrAvB5O2vJ9O1Vbrr8eO5EsGcDg4VeRjpMUnLDD1bk57m53Jv
         jzvAUG3ZvMjhDBdqQHWsr6cAPRO3HCFFgkh0Ug0wJ/OgEjZGdHRcSCTDcf+v54djyacG
         TXi/zFNdMURRfjZaULSdYTbbPntJ3bdmf+orapSaEz1LHW0def0hmE3fmfZTFhPTd+uM
         cBKAD2zQTErjj3Wnaa8o1DmovpsKuwrhVpYPtyNPLii60fpWfXJTS8dLoZMK04/o/7fG
         GaXZpZZ1sD80ErCFCT0Bu3X4ZkZtBvTkZ4LxgIlzc/LOKy20rfWsgV1hqnZsK9F0knlC
         3txA==
X-Gm-Message-State: AOUpUlEDNarwIXQa++CMT35hDUBln6MQYgtmlujHFqLriF6golVcYx5G
        OQnFcoru8tYJL+oMIouqP3bPcg==
X-Google-Smtp-Source: AAOMgpdpbGaSmmcGmUrGdy62OVioA4WMUYy5aVXPleX4clQsWWrz5k0h3yRZuWTVh6GGMNPlulhkeg==
X-Received: by 2002:a0c:91b5:: with SMTP id n50-v6mr13333847qvn.90.1533569289303;
        Mon, 06 Aug 2018 08:28:09 -0700 (PDT)
Received: from localhost (pool-96-246-38-36.nycmny.fios.verizon.net. [96.246.38.36])
        by smtp.gmail.com with ESMTPSA id q18-v6sm8441882qtg.82.2018.08.06.08.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 08:28:08 -0700 (PDT)
Date:   Mon, 6 Aug 2018 11:31:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dmitry Torokhov <dtor@google.com>
Subject: Re: WARNING in try_charge
Message-ID: <20180806153107.GD9888@cmpxchg.org>
References: <0000000000005e979605729c1564@google.com>
 <20180806091552.GE19540@dhcp22.suse.cz>
 <CACT4Y+Ystnwv4M6Uh+HBKbdADAnJ6otfR0GoA20crzqV+b2onQ@mail.gmail.com>
 <20180806094827.GH19540@dhcp22.suse.cz>
 <CACT4Y+ZJsDo1gjzHvbFVqHcrL=tFJXTAAWLs9mAJSv3+LiCdmA@mail.gmail.com>
 <20180806110224.GI19540@dhcp22.suse.cz>
 <CACT4Y+awxBatn3GQc7EWHVfHqMLKC9eVKjQMbJkCk0Po-X4VDQ@mail.gmail.com>
 <20180806142124.GP19540@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806142124.GP19540@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 04:21:24PM +0200, Michal Hocko wrote:
> On Mon 06-08-18 13:57:38, Dmitry Vyukov wrote:
> > On Mon, Aug 6, 2018 at 1:02 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > > If you have a strong reason to believe that this is an abuse of WARN I
> > > am all happy to change that. But I haven't heard any yet, to be honest.
> > 
> > WARN must not be used for anything that is not kernel bugs. If this is
> > not kernel bug, WARN must not be used here.
> 
> This is rather strong wording without any backing arguments. I strongly
> doubt 90% of existing WARN* match this expectation. WARN* has
> traditionally been a way to tell that something suspicious is going on.
> Those situation are mostly likely not fatal but it is good to know they
> are happening.

I have to agree with Dmitry here. WARN should indicate a real kernel
issue, not user input that knowingly triggers undesirable behavior in
the kernel. It's our assert() for states we don't think are possible.

I would wager that MOST developers and users understand it that way.
