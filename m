Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA36C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149902077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETXyvksQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149902077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeIEPim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:38:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45981 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeIEPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:38:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so3296877pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 04:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9xJTY1xDduTxwwDa9jWKjwDwCVlnrxDsChig++cEITs=;
        b=ETXyvksQa5shL9FspT6wSGnQ1auBGv2alc+4DcM6tUJws2OUax78FDc9cNZhmh64qE
         +TJ+ggqtCWDeFeihOoTaBdNm/5EsyX2fai2tvObmtnEhtbBK4VHb+MQDmikdLXxtVVum
         wBZr2MFmhwUr+6Uft2t78xQFTNCdIqRgRjuQsA/SjifiBfVSBPZwGWuGN2C/MYRd7SW1
         dnFGJdxUDOAsRNKTwi5elf7MQvYmR5aAaPQlZK83bdYSRHh4KPLMor1lEb/t/uipunTf
         VLUbTWf3ebf3zAJ4ok4VcSp1WP7PnsgfaFPQetHK9hNCfYc9YWjcv1ORnUWvEq/sl27Y
         EytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9xJTY1xDduTxwwDa9jWKjwDwCVlnrxDsChig++cEITs=;
        b=rVo8D3vijxxrLxVKKAtyLuncitVdTp/006NhpocLV6xNleMd6XiQsWd6Lii46EI/RF
         1wQmvoqkjyteuHTmkA8OwIwCjGOdicxYPYCv/aSeYbbHf6hd0Ou8WZ0VHPvIb8YMCyvN
         mXjFr/H6JdgGfpAswQYg9X1Qy3E70iNg8jJgCB/hmasLaig8MOixRQ67cb2tA/S2ZOvH
         oerOQ9MqXWB/gwqrT40beTgAe9eYNnww+0Johrq7oz8UB1dPm8xHkS6RJew9sMEThkzx
         JLI39Cfr6y0gkb3GrP/marAM9hp6E/cgQcqblIUbnjxd74AR47xm+OeSWDUl0oDU8azT
         QtvQ==
X-Gm-Message-State: APzg51CRFmeiIFFKnIzVVQXIflVYGE42/KdzpWsE+4BKa/Ibi2E/Nkus
        9OutsEIs91Bj1KtJT0jjAnLI/hGHerH0jOlgaYEP3w==
X-Google-Smtp-Source: ANB0VdYXVFzUKWaa0vpA3VhZnBkVIKlAGXwpjdtYBflaCwLh6xuqjd3jb8e11NVzocHfW1kEujjL4k9xm/QzK4/Ikbo=
X-Received: by 2002:a62:4494:: with SMTP id m20-v6mr40011516pfi.205.1536145736746;
 Wed, 05 Sep 2018 04:08:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 5 Sep 2018 04:08:35
 -0700 (PDT)
In-Reply-To: <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
References: <000000000000c178e305749daba4@google.com> <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov> <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov> <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov> <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov> <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 5 Sep 2018 13:08:35 +0200
Message-ID: <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 3:21 AM, Paul Moore <paul@paul-moore.com> wrote:
>> >>>> So why not ask for help from the SELinux community? I've cc'd the selinux
>> >>>> list and a couple of folks involved in Debian selinux.  I see a couple of
>> >>>> options but I don't know your constraints for syzbot:
>> >>>>
>> >>>> 1) Run an instance of syzbot on a distro that supports SELinux enabled
>> >>>> out
>> >>>> of the box like Fedora. Then you don't have to fight with SELinux and can
>> >>>> just focus on syzbot, while still testing SELinux enabled and enforcing.
>> >>>>
>> >>>> 2) Report the problems you are having with enabling SELinux on newer
>> >>>> Debian
>> >>>> to the selinux list and/or the Debian selinux package maintainers so that
>> >>>> someone can help you resolve them.
>> >>>>
>> >>>> 3) Back-port the cgroup2 policy definitions to your wheezy policy,
>> >>>> rebuild
>> >>>> it, and install that.  We could help provide guidance on that. I think
>> >>>> you'll need to rebuild the base policy on wheezy; in distributions with
>> >>>> modern SELinux userspace, one could do it just by adding a CIL module
>> >>>> locally.
>> >>>
>> >>>
>> >>> Thanks, Stephen!
>> >>>
>> >>> I would like to understand first if failing mount(2) for unknown fs is
>> >>> selinux bug or not. Because if it is and it is fixed, then it would
>> >>> resolve the problem without actually doing anything (well, at least on
>> >>> our side :)).
>> >>
>> >>
>> >> Yes, I think that's a selinux kernel regression, previously reported here:
>> >> https://lkml.org/lkml/2017/10/6/658
>> >>
>> >> Unfortunately I don't think it has been fixed upstream.  Generally people
>> >> using SELinux with a newer kernel are also using a newer policy. That said,
>> >> I agree it is a regression and ought to be fixed.
>> >
>> >
>> > How hard is it to fix it? We are on upstream head, so once it's in we
>> > are ready to go.
>> > Using multiple images is somewhat problematic (besides the fact that I
>> > don't know how to build a fedora image) because syzbot does not
>> > capture what image was used, and in the docs we just provide the
>> > single image, so people will start complaining that bugs don't
>> > reproduce but they are just using a wrong image.
>>
>> I'll take a look and see if I can provide a trivial fix.
>
> As a FYI, Stephen provided a patch and it has been merged into the
> selinux/next tree.


Thanks! I've re-enabled selinux on syzbot:
https://github.com/google/syzkaller/commit/196410e4f5665d4d2bf6c818d06f1c8d03cfa8cc
Now we will have instances with apparmor and with selinux.



> * git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>
>   Author: Stephen Smalley <sds@tycho.nsa.gov>
>   Date:   Tue Sep 4 16:51:36 2018 -0400
>
>    selinux: fix mounting of cgroup2 under older policies
>
>    commit 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
>    broke mounting of cgroup2 under older SELinux policies which lacked
>    a genfscon rule for cgroup2.  This prevents mounting of cgroup2 even
>    when SELinux is permissive.
>
>    Change the handling when there is no genfscon rule in policy to
>    just mark the inode unlabeled and not return an error to the caller.
>    This permits mounting and access if allowed by policy, e.g. to
>    unconfined domains.
>
>    I also considered changing the behavior of security_genfs_sid() to
>    never return -ENOENT, but the current behavior is relied upon by
>    other callers to perform caller-specific handling.
>
>    Fixes: 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
>    CC: <stable@vger.kernel.org>
>    Reported-by: Dmitry Vyukov <dvyukov@google.com>
>    Reported-by: Waiman Long <longman@redhat.com>
>    Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>    Tested-by: Waiman Long <longman@redhat.com>
>    Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> --
> paul moore
> www.paul-moore.com
