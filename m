Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE13C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76FD20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="j0NXcSyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76FD20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeHaUPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:15:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44558 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbeHaUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:15:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id g6-v6so10349304lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65NarGhfN2XCP1e46WQY+ZVm97UzJG2fjE8dK4dfQbA=;
        b=j0NXcSykMPGp8LTlY0GehLqTYDMsyBDpT+xF7uQBjPxdi07CWnV44HlBZ1Uo8PHJiY
         jKW8DGYN1t1DzmCjxJ4Z6IFIIBq+uNoRqr5E9N+c3Wuui5uv+Xiy83qcU5GuE96zx5LA
         MO9TUoIjdiOSVciv9Q9+BcW1XNutyXXpgKwQ3+ht3vHqKJHbBwCZ6g7iNxmUBO3LWA2f
         ONwJYAn9sVm8r92w7DcjrDsu39Sierjv+rgV46JUzZ52X9C9SjHe9Gulcqdie1QmHjMC
         mOWWIbKw8BT2UhS8vv8l50sn3qQLyd4H5tht/N8iYl0MDGo4d7hBS//4u6m/nwgQYry2
         iYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65NarGhfN2XCP1e46WQY+ZVm97UzJG2fjE8dK4dfQbA=;
        b=V5or/6s6Bkz8PnzShSRrMfwpZcBOZLkrDpr2kwLi2RrGC2uNyrjm6+bgKPhdYtEPGP
         WDqn6nM01YqgU9k+oWUUnSnR3B4u/s5MYRFbLlcRAM+LzWnANPCcjOztccHDAAtmcoex
         Bui5RbNlITYkQck8K7oWKmn8O/SIbW4tSUGg0SDkDTMK7rPJFvZXaUko9YDWLqVcZ0Wj
         oiqOnVWRpHhFfy61/XhtC4+jt1nMk+ePrJH57+6Jrw7wsJWfSf+d+NqdNDvbyx9NorCL
         gq83Xvh9WotOODFvl8w5EWvds1DHNtZOPCS81/XVxdy05iThH60/Ype2QGUXd9sM2wMV
         NsoQ==
X-Gm-Message-State: APzg51By3WB+S4h4Y7RQaLUv2wLwjtbTyHdeOmrhUoj2F9AjmpjWaOAp
        JO4bN2EtZns5zZA5GDQFPvQWO1zrPD9glBJUA5sy
X-Google-Smtp-Source: ANB0VdZ8CpeiwPi9Mfk61CxrUSc/irVzMA9fD5HLHvfDyhOnSp7rtlJ5Y75DXv9jSksh4hxpxEV6eTKwUllFshTyFug=
X-Received: by 2002:a19:d78d:: with SMTP id q13-v6mr7567488lfi.27.1535731649491;
 Fri, 31 Aug 2018 09:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c178e305749daba4@google.com> <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
In-Reply-To: <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 31 Aug 2018 12:07:18 -0400
Message-ID: <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Stephen Smalley <sds@tycho.nsa.gov>, dvyukov@google.com
Cc:     syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com,
        tyhicks@canonical.com, john.johansen@canonical.com,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:01 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 08/29/2018 10:21 PM, Dmitry Vyukov wrote:
> > On Wed, Aug 29, 2018 at 7:17 PM, syzbot
> > <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
> >> git tree:       net-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
> >
> > Hi John, Tyler,
> >
> > I've switched syzbot from selinux to apparmor as we discussed on lss:
> > https://github.com/google/syzkaller/commit/2c6cb254ae6c06f61e3aba21bb89ffb05b5db946
>
> Sorry, does this mean that you are no longer testing selinux via syzbot?
>   That seems unfortunate.  SELinux is default-enabled and used in
> Fedora, RHEL and all derivatives (e.g. CentOS), and mandatory in Android
> (and seemingly getting some use in ChromeOS now as well, at least for
> the Android container and possibly wider), so it seems unwise to drop it
> from your testing altogether.  I was under the impression that you were
> just going to add apparmor to your testing matrix, not drop selinux
> altogether.

It is also important to note that testing with SELinux enabled but no
policy loaded is not going to be very helpful (last we talked that is
what syzbot is/was doing).  While syzbot did uncover some issues
relating to the enabled-no-policy case, those are much less
interesting and less relevant than the loaded-policy case.

-- 
paul moore
www.paul-moore.com
