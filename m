Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2275C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5369F2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gZhAdD7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5369F2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJCVnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:43:55 -0400
Received: from mta-p1.oit.umn.edu ([134.84.196.201]:38444 "EHLO
        mta-p1.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCVnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:43:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p1.oit.umn.edu (Postfix) with ESMTP id 5E9DA1D9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1538578510; x=1540392911; bh=IlJLfzKa9j
        r+ORaiaIegYdmgXRrDqSUsQqHshUKxjwo=; b=gZhAdD7sNqJ+epjjTwXNtmVEzU
        8w/GKpwlKqO/WkFWbvXggbQBm+7rbds4L/g92P7nYKHurOlB/E5nHe82UG2DMPPY
        OutEBFrYzxT8xLuS4b9iqEhdPaEJZ1diz8yc3j5nj4GoLrxJ2x0M6DJBIfFlzmcy
        EtSwWYRopaR6Hof+lqdmn0phymn0zQdhhpYKIwtqay2WQyf208BCjlrKI6s/tCiK
        2jHpB9itafhbv81t2MDGroZNRe9zgS9wegS68B4MsVsU5i4wyBfJSBGTXwpk3iPu
        Kl03jUEV23+w/Mm61FvufhR+rxwpkTpG9IpnkvNw7+qCemmG71igg+3YbIrg==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p1.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p1.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J0XKcDyR0t-g for <linux-kernel@vger.kernel.org>;
        Wed,  3 Oct 2018 09:55:10 -0500 (CDT)
Received: from mail-it1-f172.google.com (mail-it1-f172.google.com [209.85.166.172])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p1.oit.umn.edu (Postfix) with ESMTPSA id 383121D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 09:55:10 -0500 (CDT)
Received: by mail-it1-f172.google.com with SMTP id p64-v6so9310580itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:55:10 -0700 (PDT)
X-Gm-Message-State: ABuFfogDx8L4gWcgPGcRprOpFAZAcmH7QBJMyW6JzxZ04oQlQtulv8Te
        MyIkli/AWnSfokrZetKDrM0qRJx7V6xiV2XiAtw=
X-Google-Smtp-Source: ACcGV61oSwY+/vx8EY5rxCNZN4Y13B4bwcB0hYhscW2hY+J6WUQ/LWViDkve9M9fB7FAY9Gc6HODbH/176+6MQIalTs=
X-Received: by 2002:a24:9005:: with SMTP id x5-v6mr1600039itd.76.1538578509987;
 Wed, 03 Oct 2018 07:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <1538542259-11868-1-git-send-email-wang6495@umn.edu> <87h8i379af.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87h8i379af.fsf@ashishki-desk.ger.corp.intel.com>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Wed, 3 Oct 2018 09:54:34 -0500
X-Gmail-Original-Message-ID: <CAAa=b7diJTzf-Y=6VcYhQGztPTj0uT0MX7-N0YKLW45EpxpcAg@mail.gmail.com>
Message-ID: <CAAa=b7diJTzf-Y=6VcYhQGztPTj0uT0MX7-N0YKLW45EpxpcAg@mail.gmail.com>
Subject: Re: [PATCH] stm class: fix a missing-check bug
To:     alexander.shishkin@linux.intel.com
Cc:     Kangjie Lu <kjlu@umn.edu>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 2:57 AM Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
>
> Wenwen Wang <wang6495@umn.edu> writes:
>
> > In stm_char_policy_set_ioctl(), the 'size' field of the struct
> > 'stp_polic_id' is firstly copied from the user space and then checked,
> > because the length of the 'id' field in this struct, which represents an
> > identification string, is not fixed. If the 'size' field cannot pass the
> > check, an error code EINVAL will be returned. However, after the check, the
> > whole struct is copied again from the user space. Given that the user data
> > resides in the user space, a malicious user-space process can race to
> > change the size between the two copies. By doing so, the attacker can
> > bypass the check on the 'size' field and inject malicious data.
>
> How? The id->size is not used for anything.
>
> And even if there was a problem, this:
>
> > -     if (copy_from_user(id, arg, size)) {
> > +     if (copy_from_user(&id->master, (char __user *)arg + sizeof(size),
> > +                             size - sizeof(size))) {
>
> is completely pointless.

Given that id->size is not used, it should not be copied from the user
space. This code is used to remove such redundant copy.

>
> >               ret = -EFAULT;
> >               goto err_free;
> >       }
> >
> > +     id->size = size;
>
> So, if we did use id->size after the copying, we'd indeed have this line
> in the code. But since we don't, it's also pointless, so it's not there.
>
> Thanks,
> --
> Alex
