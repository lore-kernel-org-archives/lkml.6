Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C05C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094D1206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBeZ6rQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094D1206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeIDUE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:04:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42086 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeIDUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:04:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so1876963pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CFGSssjhwJkeBxk01DmUDwccjRTEiGhOyMCVWBN88DU=;
        b=YBeZ6rQFmHgCnfY0FECRDk8V8uVnMeT0B2HfIY/gzYvamUN1q7nXaIG6pXmsvwkzXH
         ylN1citp7MEH3YulniEhHhuUS3S3fTe/wvA+bQUL8+Facp+Juksb7cJJpXY01L+bSq4r
         e02xr0hwiLBM/Oz3ognxksTZb5DIuap99Eay7RZH5UITD+ztppVKgb9CmATww2UjeKIC
         P4fs32o/FxPM4v+IAwWJ5k4cKQMc3mH0rcUsoapSavGSwA1Hec6uJomqkkgLRXt/eHs3
         HJQxOkyqWvS9I937+5Hv72zYzMGvknCE4cLA9vvSJYjrVFvIc2ej0GXA+GBHaSF35tLC
         7CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CFGSssjhwJkeBxk01DmUDwccjRTEiGhOyMCVWBN88DU=;
        b=HHHmTsm5Brru2lZ7ekf9O1q4/kxxnxNOPruO6Ov8xBuayMCtJqzpf5zlPZjqcGll53
         8Pg5Kgxo9a/3r74++/WZdR+7MkAT+Y3xwjwe/VhSRCBwj7IEXWcTuY71kaO1i/luv0Ma
         FHz6yw1+FEQdR6/conmqw3kc0DRD9RzJVuB4/gNrug6CEy2j5DLwpu82reT4avBCuMeo
         0XtCSsxuK2xvnF/4velioeIvmRD+XxtA2CmlB5zakeYo33sA4a8FCuM1jm8FvGCl39HU
         GX9AO1KbwWbbHJU9vMnEaoH/HFBaOID3SSTNIZd+9W3rkwe2N7nRJjjDpEDwYSOzgJE3
         A0AA==
X-Gm-Message-State: APzg51A0822dbtM0TTKqV6A1kFw5p3x5rnk5OR3+2tsRAcLoJGtp3I3B
        BywuxECXCbWVpMChfiqq3wHtoPRMr2nuiQhxbRnjSQ==
X-Google-Smtp-Source: ANB0VdZRGcZw0WeY1eFcRY4TIXydMdr6e9Ro0Ya+FL52Xk2QpOMCBrzsDOdbfIVybap0ruTihUJf5lJZ7rz6sDaoqfU=
X-Received: by 2002:a63:8e4a:: with SMTP id k71-v6mr31816226pge.45.1536075528670;
 Tue, 04 Sep 2018 08:38:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 4 Sep 2018 08:38:27
 -0700 (PDT)
In-Reply-To: <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov>
References: <000000000000c178e305749daba4@google.com> <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov> <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov> <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 4 Sep 2018 17:38:27 +0200
Message-ID: <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        "russell@coker.com.au" <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 5:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> So why not ask for help from the SELinux community? I've cc'd the selinux
>>> list and a couple of folks involved in Debian selinux.  I see a couple of
>>> options but I don't know your constraints for syzbot:
>>>
>>> 1) Run an instance of syzbot on a distro that supports SELinux enabled
>>> out
>>> of the box like Fedora. Then you don't have to fight with SELinux and can
>>> just focus on syzbot, while still testing SELinux enabled and enforcing.
>>>
>>> 2) Report the problems you are having with enabling SELinux on newer
>>> Debian
>>> to the selinux list and/or the Debian selinux package maintainers so that
>>> someone can help you resolve them.
>>>
>>> 3) Back-port the cgroup2 policy definitions to your wheezy policy,
>>> rebuild
>>> it, and install that.  We could help provide guidance on that. I think
>>> you'll need to rebuild the base policy on wheezy; in distributions with
>>> modern SELinux userspace, one could do it just by adding a CIL module
>>> locally.
>>
>>
>> Thanks, Stephen!
>>
>> I would like to understand first if failing mount(2) for unknown fs is
>> selinux bug or not. Because if it is and it is fixed, then it would
>> resolve the problem without actually doing anything (well, at least on
>> our side :)).
>
>
> Yes, I think that's a selinux kernel regression, previously reported here:
> https://lkml.org/lkml/2017/10/6/658
>
> Unfortunately I don't think it has been fixed upstream.  Generally people
> using SELinux with a newer kernel are also using a newer policy. That said,
> I agree it is a regression and ought to be fixed.


How hard is it to fix it? We are on upstream head, so once it's in we
are ready to go.
Using multiple images is somewhat problematic (besides the fact that I
don't know how to build a fedora image) because syzbot does not
capture what image was used, and in the docs we just provide the
single image, so people will start complaining that bugs don't
reproduce but they are just using a wrong image.


>>> As for exercising SELinux, you'll exercise SELinux just by enabling it
>>> and
>>> loading a policy, since it will perform permission checking on all object
>>> accesses.   But you can get more extensive coverage by running the
>>> selinux-testsuite.  We only test that on Fedora and RHEL however, so
>>> getting
>>> it to work on Debian might take some effort.
>>
>>
>> That's good.
>> I just thought that there is some potential in making the policy
>> interact more with what the fuzzer does. With respect to fs accesses,
>> it works within own temp directory, and I guess the policy is actually
>> all the same for everything it does in that directory. There also may
>> be something related to extended attributes, context changes, etc?
>
>
> Yes, by default, your fuzzer is going to just run in a single security
> context and all files it creates will have a single security context. So the
> policy side of things won't be interesting and probably everything will be
> allowed (if it runs in the unconfined context), but you'll still exercise
> many code paths.  The selinux-testsuite would trigger many process context
> changes and create files under varying contexts, so that would be more
> complete in its coverage.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/b2b38348-f3a4-6498-c9b8-1090532f6a23%40tycho.nsa.gov.
>
> For more options, visit https://groups.google.com/d/optout.
