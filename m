Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DA1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D418A208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2N9c60y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D418A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLGHD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:03:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42797 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGHD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:03:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so2832620edp.9;
        Thu, 06 Dec 2018 23:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jc+9QEwAUmeYNkWb8nKF35MO4J1fTs964fNOmFUuxcI=;
        b=Z2N9c60yaAbwHUhkVoGYSePZLmbVkwykd01X/ugDDrIdtHHvlZ7mYiUVIaG134x3pW
         bzJTsz3GSG8QVYShPJuY+Xg/iPoM1EWL7bOkQq/9SdeOZvSLCeDQ7/qzj49OotbohFBz
         MwGr7QVqdi2/jAXcj3Q5kDtNJQSzYWyPsLDMHafRNwz6a+UJUcT8uvG61a20ogxLCcSb
         ufMA49D9GxH+5Bl3JTTql6uTpBkzPZ1+G1eIwDOchux/c/QRVi8amsWpKLp3YKoetTUE
         ZVehOQQ4pFtMfruPre3ESC2H0KyFs1re6QKcP4OLXyt6JUof4bZ4mMU1QTNPMeGoaFDn
         4gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jc+9QEwAUmeYNkWb8nKF35MO4J1fTs964fNOmFUuxcI=;
        b=RDItJjvPw28PsuscOXFfOfaWnhgkKH8uHehObZgU5o7II17xq//oH0ZCMk0aqWgVRh
         jHRVw7Ox5YLn5dMOzjwJ7CViaLocgxetvrZT2iX1iz01lEE+1n6x++k8vAg8eLo49zCM
         2K/5xc3awvfbQUngbi6f9SqSGUYX1ht0S/D6SP967RLaPajX+z69p2zVwalv+3/cT8u9
         sjYVFDWzn4338CZrfv2EChVYpf0xjoZ7FV3HpmucFDcDQ1hFjfd5MLjNB9eyDS1q8zEm
         OscNeVJpJgTDTXN556qz61ZWoUFEnNX2EMOiTWKwOJe6jzNPIzsaEuM9id3/LRYI66oV
         8z6w==
X-Gm-Message-State: AA+aEWZty9hmkArfNyPutmAIYGjZMoQZlq8I6+WpyowItd61ucYSP0lv
        6OgZj4oDWlVXFuJMpDscyCFK25i99zNWdYxCwgM=
X-Google-Smtp-Source: AFSGD/W7Y/jDwQ75jx6m3C8mGLFyhltC3IAfaLBc09PuOdNT8kD3QOqXr1fRRT7sBBYRaU3eneZvRYlFhYw2uBcxo3A=
X-Received: by 2002:a50:da43:: with SMTP id a3mr1252296edk.62.1544166234432;
 Thu, 06 Dec 2018 23:03:54 -0800 (PST)
MIME-Version: 1.0
References: <18d54cd3edbf4fd3a7c01962f41ead58@cnbox5.mioffice.cn> <CADd0cq1HHv4xXn0tEWb4SfQ2XvoH33O1d1rogojj=hBTm+Lwww@mail.gmail.com>
In-Reply-To: <CADd0cq1HHv4xXn0tEWb4SfQ2XvoH33O1d1rogojj=hBTm+Lwww@mail.gmail.com>
From:   =?UTF-8?B?56iL5rSL?= <d17103513@gmail.com>
Date:   Fri, 7 Dec 2018 15:03:37 +0800
Message-ID: <CADd0cq2mQ-A4XRKi9Am3BN=zQ2QfPe2TNkKnQcxrMoPzeSC0DQ@mail.gmail.com>
Subject: Re: > [PATCH] Security: Handle hidepid option correctly
To:     Andrew Morton <akpm@linux-foundation.org>, nnk@google.com
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Nick. Would mind giving this patch an "Acked-by"?
This issue causes any Android who uses latest kernel cannot mount proc
with "hidepid=3D2" option. Which causes problems
=E7=A8=8B=E6=B4=8B <d17103513@gmail.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:26=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Anyone who can review my patch?
>
> =E7=A8=8B=E6=B4=8B <chengyang@xiaomi.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=
=8830=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8810:34=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> > Here is an article illustrates the details.
> > https://medium.com/@topjohnwu/from-anime-game-to-android-system-securit=
y-vulnerability-9b955a182f20
> >
> > And There is a similar fix on kernel-4.4:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D99663be772c827b8f5f594fe87eb4807be1994e5
> >
> > Q: Other filesystems parse the options from fill_super().  Is proc spec=
ial in some fashion?
> > A: According to my research, start_kernel will call proc_mount first, a=
nd initialize sb->s_root before any userspace process runs. If others want =
to mount it, all options will be ignored.
> >      AOSP change here: https://android-review.googlesource.com/c/platfo=
rm/system/core/+/181345/4/init/init.cpp
> >      At first I though we should mount it with MS_REMOUNT flag. But ker=
nel will crash if we did this.
> >
> > Q:  Why is this considered to be security sensitive?  I can guess, but =
I'd like to know your reasoning.
> > A: See the article above. It's part of Android sanbox.
> >
> >
> > > [PATCH] Security: Handle hidepid option correctly
> >
> > Why is this considered to be security sensitive?  I can guess, but I'd =
like to know your reasoning.
> >
> > On Thu, 29 Nov 2018 19:08:21 +0800 mailto:d17103513@gmail.com wrote:
> >
> > > From: Cheng Yang <mailto:chengyang@xiaomi.com>
> > >
> > > The proc_parse_options() call from proc_mount() runs only once at boo=
t
> > > time.  So on any later mount attempt, any mount options are ignored
> > > because ->s_root is already initialized.
> > > As a consequence, "mount -o <options>" will ignore the options.  The
> > > only way to change mount options is "mount -o remount,<options>".
> > > To fix this, parse the mount options unconditionally.
> > >
> > > --- a/fs/proc/inode.c
> > > +++ b/fs/proc/inode.c
> > > @@ -493,13 +493,9 @@ struct inode *proc_get_inode(struct super_block
> > > *sb, struct proc_dir_entry *de)
> > >
> > >  int proc_fill_super(struct super_block *s, void *data, int silent)  =
{
> > > -struct pid_namespace *ns =3D get_pid_ns(s->s_fs_info);
> > >  struct inode *root_inode;
> > >  int ret;
> > >
> > > -if (!proc_parse_options(data, ns))
> > > -return -EINVAL;
> > > -
> > >  /* User space would break if executables or devices appear on proc *=
/
> > >  s->s_iflags |=3D SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
> > >  s->s_flags |=3D SB_NODIRATIME | SB_NOSUID | SB_NOEXEC; diff --git
> > > a/fs/proc/root.c b/fs/proc/root.c index f4b1a9d..f5f3bf3 100644
> > > --- a/fs/proc/root.c
> > > +++ b/fs/proc/root.c
> > > @@ -98,6 +98,9 @@ static struct dentry *proc_mount(struct file_system=
_type *fs_type,
> > >  ns =3D task_active_pid_ns(current);
> > >  }
> > >
> > > +if (!proc_parse_options(data, ns))
> > > +return ERR_PTR(-EINVAL);
> > > +
> > >  return mount_ns(fs_type, flags, data, ns, ns->user_ns,
> > > proc_fill_super);  }
> >
> > Other filesystems parse the options from fill_super().  Is proc special=
 in some fashion?
> >
> > #/******=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=
=E5=90=AB=E6=9C=89=E5=B0=8F=E7=B1=B3=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=
=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=
=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=81=E6=
=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=BD=
=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=
=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E5=
=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=88=96=E6=95=
=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=
=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=
=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=
=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=
=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=81 Th=
is e-mail and its attachments contain confidential information from XIAOMI,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!******/#
