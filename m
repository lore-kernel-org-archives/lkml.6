Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F89C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C6220892
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20150623.gappssmtp.com header.i=@nigauri-org.20150623.gappssmtp.com header.b="J5kyt5+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C6220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbeLCDhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:37:40 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52280 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeLCDhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:37:40 -0500
Received: by mail-it1-f194.google.com with SMTP id i7so7125372iti.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 19:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cjfsQWOKigLeA72jmzn+Ohyghsn42SCqMOuPnXsRS/4=;
        b=J5kyt5+JprtGir3Ixayfd0HUF/OFoyYYOScfGubiK/YnVxgRh7gaVdCmnsACge8XnN
         8vcNpCGYmopIbp6p6H6x8lbbBfPHHP8/X9+AnOjBjGuDKL/tRrLwGQ+vOEZ8pikys2JK
         tnsxKJ+5bdse6zU7P0Yj98swwHYA1YV0ED/MkFshcBp13DmyiD6n9tyJljAm/APSWyfx
         0YbfoVlchIYGk86ymtvEQGmSRgwQwVedzht4seYw9VrX/aGpUk3sXUFwtuCS/5VTz8Ht
         NGeCt5NrpxQVhZhvr1xBGGEzJi2rax6A+afdTwppqf1Eh66CPUHWUbknGyh4gVlCYP5l
         gV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cjfsQWOKigLeA72jmzn+Ohyghsn42SCqMOuPnXsRS/4=;
        b=FovRJL1nUj6KmaMu65pz+u1oxgG4D4au27EYGgfCPkJA/jn8q2Fj31WgC+bkADh+eU
         kLCGzUSFmALfMYg3OwQe5Hfwk5DWy3TSrP9H5qIBDmxlq7neENkR0Jf8kX8Uk2jWAUJL
         qvPtqm5xiucLaD8dEopfg5mFvW9ULnAKKvF4t8pU+3fAAxMwEagiP0ZzJsAVZ1uZTFI1
         W3FLXHhP4Gge4Er661aXsAeDDDrNWJ93xQxCAHUj4xh0z/0TXpCn9xM4pH/InAO6oMf4
         xAmD+z6bIKDoxEOUEpA5f6058X4Zems8gq52rGgZMXmwefqHhfh+YgrtcZIPerNfd6N9
         6CyQ==
X-Gm-Message-State: AA+aEWZ72FMVi79qzThKRzXk6s4nwAiby6ikMf1Rep8yXylMR7Pfyfgv
        CeTCZcdY24eq8Yl2K55NoDc4HH3Im2bSfPE8PGY/
X-Google-Smtp-Source: AFSGD/XR8OZKiyLganNzSD6fh/zpk6aF1YWfcznqSe+NYeklZ68XpwKt6b1WUMJqK9U2L4W6qsof8y/ixtN9EHTDCJo=
X-Received: by 2002:a24:130a:: with SMTP id 10mr6565648itz.58.1543808253820;
 Sun, 02 Dec 2018 19:37:33 -0800 (PST)
MIME-Version: 1.0
References: <1488160439-7140-1-git-send-email-nobuhiro.iwamatsu.kw@hitachi.com>
 <CAGXu5jLEU2n8jUjXhCiOAqfonMKov6rTv5-3KWSt4EmOEUn5Bg@mail.gmail.com>
In-Reply-To: <CAGXu5jLEU2n8jUjXhCiOAqfonMKov6rTv5-3KWSt4EmOEUn5Bg@mail.gmail.com>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Mon, 3 Dec 2018 12:37:11 +0900
Message-ID: <CABMQnVLh1_KZXr2nHrijGoOVk36-=D2w7Hq9hmbHFnu2Oa1u2g@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] pstore: ramoops: support multiple pmsg instances
To:     keescook@chromium.org
Cc:     anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Remove nobuhiro.iwamatsu.kw@hitachi.com from To.

Hi,

I am already leaving Hitachi.
However, I would like to merge these patches into the kernel. I will
resume work.

Best regards,
  Nobuhiro

2018=E5=B9=B411=E6=9C=8830=E6=97=A5(=E9=87=91) 8:33 Kees Cook <keescook@chr=
omium.org>:
>
> On Sun, Feb 26, 2017 at 5:54 PM Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.kw@hitachi.com> wrote:
> > The following series implements multiple pmsg. This feature allows user=
space
> > program to control individual content aging or priority.
>
> I'd like to take a look at this series again, if you're still
> interested in upstreaming it. :) There were a lot of things that
> needed refactoring in pstore to sanely deal with this, and I think
> we're there now. Is this still desired?
>
> Thanks,
>
> -Kees
>
> >
> > If a pstore backend module(e.g. ramoops) requires the multiple pmsg ins=
tances
> > when registering itself to pstore, multiple /dev/pmsg[ID] are created. =
Writes
> > to each /dev/pmsg[ID] are isolated each other. After reboot, the conten=
ts are
> > available in /sys/fs/pstore/pmsg-[backend]-[ID].
> >
> > In addition, we add multiple pmsg support for ramoops. We can specify m=
ultiple
> > pmsg area size by its module parameter as follows.
> >
> >  pmsg_size=3D0x1000,0x2000,...
> >
> > I did check the operation of this feature on CycloneV (socfpga) Helio b=
oard.
> >
> > v5:
> >   Add commit: "pstore: Change parameter of ramoops_free_przs()"
> >     - I forgot addition to previous patch series.
> >   Update commit: "pstore: support multiple pmsg instances"
> >     - Fix comment.
> >     - Fix initialization of num_pmsg.
> >
> > v4:
> >   Rebase to 4.10-rc5
> >   The following patches have been removed from this series as similar f=
unctions
> >   were modified by other commit.
> >      - pstore: Replace four kzalloc() calls by kcalloc() in ramoops_ini=
t_przs()
> >      - pstore: Change parameter of ramoops_free_przs()
> >      - pstore: Rename 'przs' to 'dprzs' in struct ramoops_context
> >      - ramoops: Rename ramoops_init_prz() to ramoops_init_dprzs()
> >
> > v3:
> >   Rebase to v4.8.
> >   Split patch.
> >   merged device_create().
> >   Remove Blank lines.
> >   Update documentiation of DT binding.
> >   Update parsing function of ramoops_pmsg_size, add NULL termination.
> >   Update module parameters for pmsg_size list.
> >
> > Hiraku Toyooka (2):
> >   pstore: support multiple pmsg instances
> >   selftests/pstore: add testcases for multiple pmsg instances
> >
> > Nobuhiro Iwamatsu (3):
> >   pstore: Change parameter of ramoops_free_przs()
> >   ramoops: Add __ramoops_init_prz() as generic function
> >   ramoops: support multiple pmsg instances
> >
> >  Documentation/admin-guide/ramoops.rst              |  22 ++
> >  .../bindings/reserved-memory/ramoops.txt           |   6 +-
> >  fs/pstore/pmsg.c                                   |  23 +-
> >  fs/pstore/ram.c                                    | 317 +++++++++++++=
+++-----
> >  include/linux/pstore.h                             |   1 +
> >  include/linux/pstore_ram.h                         |   8 +-
> >  tools/testing/selftests/pstore/common_tests        |  21 +-
> >  .../selftests/pstore/pstore_post_reboot_tests      |  27 +-
> >  tools/testing/selftests/pstore/pstore_tests        |  14 +-
> >  9 files changed, 342 insertions(+), 97 deletions(-)
> >
> > --
> > 2.11.0
> >
>
>
> --
> Kees Cook



--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
