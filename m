Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B467C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E276920685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnStTyta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E276920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeI2BAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:00:02 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:41254 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeI2BAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:00:01 -0400
Received: by mail-lj1-f181.google.com with SMTP id y17-v6so6741732ljy.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=HAD3WdQFUOdp9MFdr8NXoZ6oAgspMLPbOgqExa7wGgQ=;
        b=bnStTytaZYTADujWGvCtxJUiW8+b8AQ/79cr+RRf4FRd5yM0fr4l5CFD97iwwyfvMy
         KFPVO6UuS+jZDjAzcMf3lQIaf/SSKmOB7tOyt2Gy6by18Nkb+f9uLw0hAL44uHVQy2zo
         XX8oHcoMR4jNHzwhHlqAiXUQTg8ckYuI5GpWBrBbGtSO+BtLNgdmBXW2p4LAKPVLS5yz
         l6eKdyXKzelU48qGnNtak1Y3I/wJ0qewATrg08RU1bsE7Qp7Qk5FpsDRHMa9UTnOdSYq
         BIelcvc1FXZ27LjTa3dG4+I/G1gXta+vSpsah4HwZztWcO9LhTPY3fqn2s5v2u89X3a6
         Oydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=HAD3WdQFUOdp9MFdr8NXoZ6oAgspMLPbOgqExa7wGgQ=;
        b=Y7G3hBceS7VWnWok0iawrywlOinFRRviy9HYr+P6UqRFqeXKD1dNSDZ8ESjsaXBH0Q
         F8ci6sj6GHCGQH/lWgTDJ1dk5RHB3FYPfnWmWhpdKaEr6yEHLsATEf20ctjBKMZnzO76
         sIRqnjUUH1/1SCP2d62zwfwPr3x/gCo/TX1FJfH3hznwIee4ASS/5LBmkj32XbPKEZI4
         YHDC0oXfDFiWxKq7ZohPZBh8F50AierzvHBxhMvDR8ImrdGGcZPyE2i4DFklLovhyW5o
         wlO0QIG2Jf9x3X0thE1hX+bjBLRpQi9ficRWXNg37zzTKbXg2r8q40V9AFqTyC1PkPfI
         inIw==
X-Gm-Message-State: ABuFfojdkFgMg1KdgC1X2qCzgHdNAASP7Na1CJ9mEAty4fOw+zLmgEfY
        zB6hHEfUW0ZHVrxCpHNo67dY707HC9rU1w6RYcoy+g==
X-Google-Smtp-Source: ACcGV61xEepsqUhx3fphZNHESpKX8/39/zKFGi8+8NcJda0DDex57ukiNEGsQjASbFn0e0JBrYy7tSusOrIUdMECemc=
X-Received: by 2002:a2e:9883:: with SMTP id b3-v6mr4104319ljj.171.1538159696820;
 Fri, 28 Sep 2018 11:34:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:278e:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 11:34:55
 -0700 (PDT)
In-Reply-To: <20180926203355.rfmezs3lbmlcvv3x@gmail.com>
References: <87zhwbj8xe.fsf@redhat.com> <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org> <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
 <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
 <CAMjeLr-a4cCrs0cF0aBRoeeXXLwiM835BXqhP9ZoeLB8=w=YKw@mail.gmail.com>
 <8c18dcc5-9028-672f-1449-359ac3d73592@petrovitsch.priv.at>
 <CAMjeLr-j1XhZJgcvsP5z6SHCDmbUA=rMyfvQpX40qKBK+2ojbw@mail.gmail.com>
 <9be16b08-7aa9-d42e-24c0-f054af39b78a@petrovitsch.priv.at>
 <CAMjeLr_cx5+96NGedcYB-MjugA53_j+tksP0Na8W9GY-PAhoZA@mail.gmail.com> <20180926203355.rfmezs3lbmlcvv3x@gmail.com>
From:   "\\0xDynamite" <dreamingforward@gmail.com>
Date:   Fri, 28 Sep 2018 13:34:55 -0500
Message-ID: <CAMjeLr8fQbD1akKBYLO3Me7BkF_10+XHYPT9hQG5Nekqvt_GNw@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        "\\0xDynamite" <dreamingforward@gmail.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
        Theodore Tso <tytso@mit.edu>, fche@redhat.com,
        riel@surriel.com, ec429@cantab.net,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> You did it again.  You changed words.  I said intended for the public,
>> and you ended your sentence with "intended to be published".
>>
>> Like it or not, both the law and English grammar have ambiguities.
>> People put up with them because they share a common intuition (in a
>> lot of cases) of what each other means.
>>
>> If you share a birthday card with your personal love note inscribed
>> and the birthday girl sends it around to everyone at the party, have
>> you been violated?  She might argue:  how did you expect it to remain
>> private if you knew there were several people invited to the birthday
>> party?
>
> English does have oddities, agreed.  However, open source code is
> definitely intended for the public as well.

I think your wording is a bit sloppy.  As an engineer, I might publish
my designs, but do I intend them for the general public?  Only if I'm
in some kind of teacher-mode where I hope the public can learn from my
designs.  However, RMS started GNU with the idea of a COMMUNITY -- a
particular community:  one of fellow coders.

If others learn from the code by its nature as open source, that
doesn't mean the license implies that it is INTENDED for the public,
just that it was OPEN to it.  It is the same difference between
*marketing* your business and just "setting up shop" with an open
door.  Once you've marketed the business, you've created an implied
contract of "intent to deliver".

Subtle, but significant, difference.

Mark
