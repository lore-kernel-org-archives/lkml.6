Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B279AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8168C21916
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTfnPHX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfBAKvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:51:04 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44047 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbfBAKvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:51:03 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so5282209iod.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 02:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PNRpVTdLN6Dx5TfJoc6n0FURs2N2rTCUidq84xQ/wM=;
        b=KTfnPHX2cKdJ63GqToTDSDq8IWNYGtthHRSjYOB7VZHMpTXCSGBn4hoo4K0M7KUdoU
         TISmGaloUqUWjxsZZW40v+eyZB0ZpXdEiiHPz9JD6FzmdDhP115sQVtaZenjbouViZwN
         zpC6wAK9/x0ksSni39JSfw5bgQ8FjfvlD+KWdAc56lLchMggiSJSLoHOyhVr8XBtWBA+
         OyzGRHPtk/qzgL3fIH0fp+IwCb5xNFM3ehtwY+2w1RfFODQs6yy7WDsJ8L+2fpd0zNei
         1iGpkn83aBJs1xDuDAh76HJhbPSM48p12ChZ/inLdOPK5pr+cnFGlsQSrJ5lexWjZ/j3
         3BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PNRpVTdLN6Dx5TfJoc6n0FURs2N2rTCUidq84xQ/wM=;
        b=FRaV+ltj68xovOlZ8g/+tUJZDvr/Uq8Vc/Em7Ehs32RoKgnexS8KioLGNEZVMjqv/8
         dHtt7Bx/JMW5lV+BSRvsk5Cr9jp93SWOVeOYZV4F9ON9QhA7VJ8fL/UUnfpXGUO7zITi
         GeZU+rx1tfq976sqh4WSht1sHAP0Vke7cAa7EmdbQt5Ta7d5/ackyY+IaoLfsW3JXMuT
         StGkhMdLjl/61A+1wmkEALPe03wdWZOJgPmJ/mFXEelVGsHZOk5NnWH0ntT3stBp3ZeD
         AqaK6cJVPWkuDWjcjxLou/9NoPBYINuaOqRL2VJ3YDc7OuNwbQZhTufdMT0n/lxtlrvt
         A80g==
X-Gm-Message-State: AHQUAuZJSoqnPVjIMQOHZF+WXUNK85PF7l416bc22O/PMMgSvP2fyPcR
        dkJMuksjK9qNjOf7qMDJJOE3tGvy38GFFqTAGkoltw==
X-Google-Smtp-Source: AHgI3IZBkTGlsM2UUW8HLuhMaTRqQiOCTMKLNTky5qY0LgVJ5q6JFENd6qQzLzGyhuFRcLD1AUTxc04vEoZaTCTdL84=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr7898787iom.11.1549018261894;
 Fri, 01 Feb 2019 02:51:01 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c178e305749daba4@google.com> <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov> <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov> <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
 <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com> <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
 <e598f3c7-22bc-91c2-2f47-0eec068f5180@I-love.SAKURA.ne.jp>
 <CACT4Y+YXsD4f+ngzN7SGXcUGBn-jG1KeyrZJBzcUWo-AbdTe4w@mail.gmail.com>
 <05340d28-36c2-267e-d54e-416fddfba211@i-love.sakura.ne.jp>
 <CACT4Y+Ynyy-bMK4cxhgNoAaauFdjzExuELM6u0amksbR4wy7GQ@mail.gmail.com> <71e3652b-b222-0c3f-8b48-5980ddcaeb93@i-love.sakura.ne.jp>
In-Reply-To: <71e3652b-b222-0c3f-8b48-5980ddcaeb93@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 1 Feb 2019 11:50:50 +0100
Message-ID: <CACT4Y+Z036bZfN1-_VaQ5EorwFt_tpPm=RTnrYN5qKV_ebgoFw@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
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
        Laurent Bigonville <bigon@debian.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 11:44 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/02/01 19:09, Dmitry Vyukov wrote:
> > Thanks for the explanations.
> >
> > Here is the change that I've come up with:
> > https://github.com/google/syzkaller/commit/aa53be276dc84aa8b3825b3416542447ff82b41a
>
> You are not going to apply this updated config to upstream kernels now, are you?
> Removing CONFIG_DEFAULT_SECURITY="apparmor" from configs used by upstream kernels
> will cause failing to enable AppArmor (unless security=apparmor is specified).


We do use  security=apparmor, see:
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-apparmor.cmdline
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-selinux.cmdline
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-smack.cmdline


> I guess you can apply this updated config to linux-next kernels given that
> you replace
>
>   CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>
> with
>
>   CONFIG_LSM="yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo"
>
> so that AppArmor is enabled instead of SELinux.
>
> >
> > I've disabled CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER (it
> > actually looked like omitting a user-space loader that I don't have is
> > the right thing to do, but okay, it indeed does not with =y).
> >
> > For now I just enabled TOMOYO and SAFESETID.
> > I see the problem with making both linux-next and upstream work. If we
> > use a single config and lsm= cmdline argument, then on upstream all
> > kernels will use the same module (they won't understand lsm=). But if
> > we add security= then it will take precedence over lsm= on linux-next,
> > so we won't get stacked modules.
>
> Right.
>
> >
> > Let's go with (c) because I don't want an additional long-term maintenance cost.
>
> OK.
>
> > If I understand it correctly later we will need to replace:
> > security=selinux
> > security=smack
> > security=apparmor
> >
> > with:
> > lsm=yama,safesetid,integrity,selinux,tomoyo
> > lsm=yama,safesetid,integrity,smack,tomoyo
> > lsm=yama,safesetid,integrity,tomoyo,apparmor
>
> Yes. Thank you.
