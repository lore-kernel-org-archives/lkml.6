Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A69C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D96920817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="qo/Nxfta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D96920817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeKSGt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:49:59 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39523 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeKSGt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:49:59 -0500
Received: by mail-io1-f68.google.com with SMTP id j18-v6so8723406iog.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FUwG6V1I17FoKidXXdsHXAHVVi+GK9rin42p8Ud4644=;
        b=qo/NxftaZ01+eUqSB5EH6Hhg+Evk8PRMAo9Dw77YtExuHovL5mxV8QTVVYSDcQzvmb
         IeYz08bAaQ5AooQZosCM2R3OsizYSmjbFGinnSyIfe71gNqziFJ0OQCd7bmdQgDA1oBC
         fofrgYJdu2i+ibEtu7YwnyfDx2tZADXbFSgSy2fdvVjtIlVDatiDmQoA9YidO4KWJQkL
         um7Ky7u2yMYAl4Vmwgfiobe+vM4hRZH9DHoMCESAz1H7mh4+I/wl4j+PK73H3/iPBWRe
         EX2+AgkIbBXptlb5PfTHKuB5dAIsRTzMknzkTmDXqKe3gX8FEeDT/Y9il+x6kTxGtrjc
         gYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FUwG6V1I17FoKidXXdsHXAHVVi+GK9rin42p8Ud4644=;
        b=Hn4aYShKEuzxic4Q6Z6B/ZkH6PlhLukqKyGhiQ8kZG9guf7pOHsk1j7rh15xKyL1jI
         E3BAHQHvRJL76Ox0wQUwhG/ybhtrr0bSGy/5aLPrppkWnzY5ctiA3pvS7Zg96p/KhMWy
         a+Vx0L4lrRIJM1lVJOWeirKxFVSjWm8h2uRNBvLiQwhrxd546nfpdJbc3CARL0/LRNU7
         y8NlwEfm32BM+hDDQ1Z3N+TFiSf8jM5vBhV9+B3GZJ2DiQlXyK2oE0UW9FZ1oPBi/XW+
         O2X1s9kclkuw0qtLzwix4mq2BlRLZ9WUYbZH5LiPAI2+jLIVRwqmYcUgLoxkbKcIy/rp
         0k5g==
X-Gm-Message-State: AGRZ1gLoyvktE1QEsJKdi7CdGLSPK230zcsOluACEaFu/LCFS+owupB0
        zAlH9gKuD5qQ1E1egrMCHjBDBA==
X-Google-Smtp-Source: AFSGD/Xp4PmGE3D2YNiIg4tFT0PCvR7rHm7d2724sate06r087FZya2cl7Xn8CNgACqW4UklXxfdzw==
X-Received: by 2002:a6b:9382:: with SMTP id v124-v6mr15103381iod.260.1542572923233;
        Sun, 18 Nov 2018 12:28:43 -0800 (PST)
Received: from [192.168.1.143] (c-71-205-112-160.hsd1.co.comcast.net. [71.205.112.160])
        by smtp.gmail.com with ESMTPSA id z191-v6sm12892516itb.31.2018.11.18.12.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 12:28:42 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
Date:   Sun, 18 Nov 2018 13:28:41 -0700
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <608F2959-800D-46EE-A7CD-8C972ACD2F02@amacapital.net>
References: <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com> <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com> <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org> <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com> <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com> <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com> <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com> <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com> <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com> <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com> <20181118190504.ixglsqbn6mxkcdzu@yavin> <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
To:     Daniel Colascione <dancol@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 18, 2018, at 12:44 PM, Daniel Colascione <dancol@google.com> wrote:=

>=20

>=20
> That is, I'm proposing an API that looks like this:
>=20
> int process_kill(int procfs_dfd, int signo, const union sigval value)
>=20
> If, later, process_kill were to *also* accept process-capability FDs,
> nothing would break.

Except that this makes it ambiguous to the caller as to whether their curren=
t creds are considered.  So it would need to be a different syscall or at le=
ast a flag.  Otherwise a lot of those nice theoretical properties go away.

> Yes, that's what I have in mind. A siginfo_t is small enough that we
> could just store it as a blob allocated off the procfs inode or
> something like that without bothering with a shmfs file. You'd be able
> to read(2) the exit status as many times as you wanted.

I think that, if the syscall in question is read(2), then it should work *on=
ce* per struct file.  Otherwise running cat on the file would behave very od=
dly.

Read and poll have the same problem as write: we can=E2=80=99t check caps in=
 read or poll either.=
