Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78915C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142F920867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNUmVCDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142F920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeIDTS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:18:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37784 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeIDTS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:18:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so1826137pfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=coWdoHRL6z9PC7dYlC5R6Mj3FGq2bxqtoPEAzZFtnLU=;
        b=JNUmVCDCWgr57UqFD6Z7MHR6z5SJPsaqMsi70uNc5y76bME6LsI4dSfSBL2HWULeu8
         rgmMm3y5idWoh0kTveVVy3eHlmDo/xlYNdgw9qWFsEvoidUofosDE0LUsq/MKg9Af8Jw
         spHAMk9uwx+f0jp/uw/gBDJDIKZfZnEpfHH2aNvvPuY52ze91buvjKn1MW4E8284do+z
         RWviMEZ8bAjqLrmy88bSNpmz6XuoY7J27RvGfQFM2b8Bu6r5buB0P5B9BcdNPE4vfr3R
         TwDeFthxF7L7Olgsfi3L2mJ8uU2sCI0t+w7JTYeOQCwZR+vgVaT2WoWvrSG/aJX9Zrl8
         0jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=coWdoHRL6z9PC7dYlC5R6Mj3FGq2bxqtoPEAzZFtnLU=;
        b=oXXNInjapfTVHAeGOD7Ys0bM637YGrbM7F/5HlT4A4pgd/fuJbMjnJmwcyaoAfCtoD
         W/PPa1LqOSPGfmYZtTltTwdqFQpTbrFisjosP6zNTqdfJHdut5/FkpYrRAlyWgRCdWS3
         Ltu3qm1mQp0dxOXaLsjzmOKsyhRpUNFZs3f36mkMXCwbV7wAEKW8/1OUc7JFp9kx10Zi
         ofdPJwewyCbgMOI1SwRKvTsykQBnmRdg8xH0dnzaYG7mcLMLY1BxkWuCiUI755G35DrI
         rNo4RmWp4zXWwUOX5MWwv+3DtJDrp2FJugTW0fOnSlCAXrti3seaVUamZBVDvoLzHrvV
         15Og==
X-Gm-Message-State: APzg51A6U4+/9xXF1yWjSaadjHCtM/Ivna91dDzvIUU9Mh02nU2jfKgH
        v59XV0+f9M4p7iB8MNJpfSiehvrTmjGIKZdmzaV9Vw==
X-Google-Smtp-Source: ANB0VdaWDzEpEDMw5hB92pzQ5EthrCa4MfjHphpfSx7SrR0XkTKWt8pMzN5NZtOHOWZwHf59/EpPR1vrhMaMENADWAs=
X-Received: by 2002:a62:3001:: with SMTP id w1-v6mr35017896pfw.19.1536072812594;
 Tue, 04 Sep 2018 07:53:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 4 Sep 2018 07:53:11
 -0700 (PDT)
In-Reply-To: <5806108.mdyebWjNCB@liv>
References: <000000000000c178e305749daba4@google.com> <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <5806108.mdyebWjNCB@liv>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 4 Sep 2018 16:53:11 +0200
Message-ID: <CACT4Y+ZVHit9C-w78mEUEtpZjyncaR_3S5fu_KZk2YuBtthK9w@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Russell Coker <russell@coker.com.au>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 3:16 PM, Russell Coker <russell@coker.com.au> wrote:
> On Tuesday, 4 September 2018 10:57:15 PM AEST Stephen Smalley wrote:
>> > I installed the tools, and we started loading policy.
>> > But then it turned out that wheezy policy does not allows mounting
>> > cgroup2 fs and maybe some others even in non-enforcing mode. As far as
>> > I understand that's because the policy does not have definition for
>> > the fs, and so loading bails out with an error.
>
> The aim has always been with SE Linux in Debian that the policy will support
> the kernel from the next release and from the previous release.  Much of this
> comes from upstream, but sometimes we have to go out of our way to get it.
> Sometimes if you want to run unusual combinations of kernel and OS Debian
> doesn't get a backport of the policy to support it in which case I often have
> a special policy on my site to do it.
>
> It seems strange that you wouldn't be able to mount a filesystem in permissive
> mode.  Which program was trying to mount it?  Was it systemd?  It might be a
> systemd bug.


The program was our binary, but also reproducible with just mount
utility. I don't think the program matters, it's just that mount
system call returns an error. It also looked weird to me that selinux
fails the syscall in permissive mode. Maybe it's just a bug? Fixing
that would resolve our problem, and it the easiest way to resolve it.

Here is the script we use to build images:
https://github.com/google/syzkaller/blob/master/tools/create-image.sh
If you run it in qemu and try to mount cgroup2, it should fail.


>> > We need cgroup2 both for testing and for better sandboxing (no other
>> > way to restrict e.g. memory consumption). Moreover, we did not test
>> > any actual interesting interactions with selinux (there must be some?
>> > but I don't know what are they).
>> > So I had to uninstall the tool and policy is not loaded again.
>> > I investigated building a newer debian image with debootstrap (which
>> > should have newer policy I guess). But they don't work, some cryptic
>> > errors in init. Other people reported the same.
>> > So that's we are. I don't have any ideas left...
>
> It would be nice to know what the errors are.  Although we aren't really
> interested in bug reports from Wheezy, Stretch is the current stable release.

The errors were unrelated to selinux, the image just failed to bring
up network or something. So it was just unusable.
Other people reported the same:
https://groups.google.com/forum/#!searchin/syzkaller/wheezy|sort:date/syzkaller/DJdHAsTXWVw/XXr8KMfgBQAJ
https://groups.google.com/forum/#!searchin/syzkaller/wheezy|sort:date/syzkaller/bgkbvqbjnfA/tlH7SGwCDQAJ

Again, if you change wheezy to stretch here, it should reproduce the problem:
https://github.com/google/syzkaller/blob/master/tools/create-image.sh



>> So why not ask for help from the SELinux community?  I've cc'd the
>> selinux list and a couple of folks involved in Debian selinux.  I see a
>> couple of options but I don't know your constraints for syzbot:
>>
>> 1) Run an instance of syzbot on a distro that supports SELinux enabled
>> out of the box like Fedora. Then you don't have to fight with SELinux
>> and can just focus on syzbot, while still testing SELinux enabled and
>> enforcing.
>>
>> 2) Report the problems you are having with enabling SELinux on newer
>> Debian to the selinux list and/or the Debian selinux package maintainers
>> so that someone can help you resolve them.
>>
>> 3) Back-port the cgroup2 policy definitions to your wheezy policy,
>> rebuild it, and install that.  We could help provide guidance on that.
>> I think you'll need to rebuild the base policy on wheezy; in
>> distributions with modern SELinux userspace, one could do it just by
>> adding a CIL module locally.
>
> I could backport that myself and put the package on my apt repository.  Tell
> me what version of the kernel you are using and I'll have a look at it.

We are testing upstream master as well as 4.4, 4.9 and 4.14.
We need some modifications to:
https://github.com/google/syzkaller/blob/master/tools/create-image.sh
produce image with working policy.
