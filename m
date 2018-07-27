Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0045AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13A0205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbIMpBKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13A0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbeG0UW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:22:27 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32778 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389071AbeG0UW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:22:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id l10-v6so10857830oii.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UUXia3jkB5Mx64zl5cZXDir3z5Z+GAZBsrme8FApiZ0=;
        b=jbIMpBKqVbuyJYC7xKLu2BY2WjT+mKgb2k9NJ1uKuOU96T0l7l0GGqhWo2U0abvSxC
         PIsKE+luqTe9j3BY2qsMP7LEkZDHNKoIwE0ti9KQ4mugGkDAmGorFO0/lo1+fExpdLb/
         ksl+s9soGdaHgF0GZKYR3dcQXeglDH1D2P0+t9UVyPwiEkR2KAU6LcA3Km0tV0MpUfvB
         WmEWX6Vcsw3ENwbBwHSl8ma8pc+2I9YhWLml4TWCKVLfsyAZTErPXvmkO9fmAowgVHTp
         zO6g4r/mXHfhzqaROrnaSzvKPj6+5ag8aTH0rIypdvTygVdErZ3WbFirLMFlhoOhSdb/
         S7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UUXia3jkB5Mx64zl5cZXDir3z5Z+GAZBsrme8FApiZ0=;
        b=mXHB1j2xSyNdUVpIu6atBIQ8J2d0wOzTL7OBDP9GYA3Y5KiiTbIFNJL1AWiFVmMAJW
         vGu3QNiNLr+xSQiYboL9+vK/GuD9zinoyTLLOMXUIuknqQgYqpL8gaRbTvHD+wQeizQB
         I7aF1VGyw4TJ1UTDjDRfBYXgkmLY96fpYrWnpYQGmlMwIhn+SHIfSYQEvsYO+PBCBdy9
         659jb9dpA9q8+FPSimw7R6+Biy6etyb/Xn1Lr2xE5RTSsEBR2aXS9EYnkoknXR0Ow+G6
         FDIHN1TGv/UbxAZgT+MK9+kI2Dp2KO/qetM+oZclMHOWgrHiCoZ86sGHOO58qkSJ0yIJ
         9Y9w==
X-Gm-Message-State: AOUpUlHrFqHTytpXUH5WCyXH+LqlRi7AIFdvvUPm9xxK0D3xWPBNAK6V
        V83mVmR5ARRb7dkIBgqhZk9CItApoJ/hJx6e5NQNzQ==
X-Google-Smtp-Source: AAOMgpfxyNOagXKoraijXxphpgDdx/H46RVvdVfHFY2FpQOhsgMj4hwWDct7zMqatSVD89Cz4WuEZgPNXHRHjnInWsw=
X-Received: by 2002:aca:6044:: with SMTP id u65-v6mr8256642oib.323.1532717954594;
 Fri, 27 Jul 2018 11:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180725202238.165314-1-salyzyn@android.com> <20180725210717.3b807191@vmware.local.home>
 <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com> <20180726153153.GA8327@kroah.com>
 <CAKwvOdk9s+=kUwcPGQzZNxR7eOGAiiasAyWhZxgKom4_6h+oxA@mail.gmail.com>
 <20180726181558.25a5c3b8@gandalf.local.home> <753E9YR1QhdsPhsFoYuXCwfUzfyntDrc_A93hMUkktMi7lbh3KUZMcbfqKVWUfi15zYhuiDFant-ROa4QNV5shx74ff4hGngq2BOJDv-hq4=@protonmail.ch>
 <CAG48ez1U=5nTOrnOqwMuXhdER-7XxJUYLcyYNuczwasQLQ0gXA@mail.gmail.com>
 <20180727094730.3a448629@gandalf.local.home> <CAKwvOdmg4DSSwy9YBccYWzc+6ZU2yKSSFmfnj72wqbYDJU0gzw@mail.gmail.com>
 <20180727143141.4b53d554@gandalf.local.home> <CAMx4XWv3OazvURuN1XU2+5C5tNDzPuTniMn_T=XTA4P8_uwS_A@mail.gmail.com>
 <CAG48ez25zgjTQRux_rk1fn2DUVthtK31dRU9cxE+55pBGmYjXQ@mail.gmail.com>
In-Reply-To: <CAG48ez25zgjTQRux_rk1fn2DUVthtK31dRU9cxE+55pBGmYjXQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 27 Jul 2018 20:58:48 +0200
Message-ID: <CAG48ez1MdupASE1DMt0OWXv+rqZO-2GAbfDthEQcvNXrc2pTsQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
To:     salyzyn@google.com
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Golden_Miller83@protonmail.ch, Greg KH <greg@kroah.com>,
        Kees Cook <keescook@google.com>, salyzyn@android.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc jeffv

On Fri, Jul 27, 2018 at 8:47 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Jul 27, 2018 at 8:41 PM Mark Salyzyn <salyzyn@google.com> wrote:
> >
> > Any system can chose to change the permissions of a sysfs node, default=
, DAC (and MAC) is just layers of multi-level security (or lack thereof). A=
s well intentioned as a default DAC is in the kernel, leaking kernel addres=
ses is still an attack surface that we want to close tightly.
> >
> > For instance on Android:
> >
> >      chmod 0755 /sys/kernel/debug/tracing
> >
> > is in the common init.rc file ...
> >
> > If DAC has been adjusted at runtime to permit access to the node, I wou=
ld think that if the caller does not have all the credentials/capabilities,=
 we do want the addresses to be abstracted by the kernel.
>
> If you adjust the access controls on debugfs to permit things that
> aren't possible upstream, you may have to add new access controls to
> ensure that that doesn't lead to security issues. And, in fact, you
> did:
>
> walleye:/ # ls -laZ /sys/kernel/debug
> total 0
> drwxr-xr-x 100 root root u:object_r:debugfs:s0             0 2018-07-27 1=
8:08 .
> drwxr-xr-x  19 root root u:object_r:sysfs:s0               0 1970-06-04 1=
0:30 ..
> [...]
> drwxr-xr-x   6 root root u:object_r:debugfs_tracing:s0     0
> 1970-01-01 01:00 tracing
> drwxr-xr-x   2 root root u:object_r:debugfs:s0             0
> 1970-01-01 01:00 tsens
> drwxr-xr-x   2 root root u:object_r:debugfs:s0             0
> 1970-01-01 01:00 tzdbg
> drwxr-xr-x   4 root root u:object_r:debugfs_ufs:s0         0
> 1970-01-01 01:00 ufshcd0
> drwxr-xr-x   2 root root u:object_r:debugfs:s0             0
> 1970-01-01 01:00 usb
> drwxr-xr-x   2 root root u:object_r:debugfs:s0             0
> 1970-01-01 01:00 usb-pdphy
> drwxr-xr-x   2 root root u:object_r:debugfs:s0             0
> 1970-01-01 01:00 usb_diag
> drwxr-xr-x   2 root root u:object_r:debugfs:s0             0
> 1970-01-01 01:00 vmem
> -r--r--r--   1 root root u:object_r:debugfs:s0             0
> 1970-01-01 01:00 wakeup_sources
> drwxr-xr-x   2 root root u:object_r:debugfs:s0             0
> 2018-07-27 18:07 wcd_spi
> drwxr-xr-x   2 root root u:object_r:debugfs:s0             0
> 2018-07-27 18:07 wdsp0
> drwxr-xr-x   2 root root u:object_r:debugfs_wlan:s0        0
> 2018-07-27 18:07 wlan0
> drwxr-xr-x   3 root root u:object_r:debugfs:s0             0
> 2018-07-27 18:07 wlan_qdf
>
> Stuff in the debugfs mount is labeled as "debugfs", with a few
> exceptions. And the SELinux policy locks down access to debugfs:
>
> public/domain.te:neverallow { domain -init -vendor_init -system_server
> -dumpstate } debugfs:file no_rw_file_perms;

And yes, if you check from an ADB shell, you can still access the
mentioned file even on walleye:

walleye:/ $ ls -lZ /sys/kernel/debug/tracing/printk_formats
-r--r--r-- 1 root root u:object_r:debugfs_tracing:s0 0 1970-01-01
01:00 /sys/kernel/debug/tracing/printk_formats
walleye:/ $ cat /sys/kernel/debug/tracing/printk_formats
0xffffff9c60ba04de : "Rescheduling interrupts"
0xffffff9c60ba04f6 : "Function call interrupts"
0xffffff9c60ba050f : "CPU stop interrupts"
0xffffff9c60ba0523 : "Timer broadcast interrupts"
0xffffff9c60ba053e : "IRQ work interrupts"
0xffffff9c60ba0552 : "CPU wakeup interrupts"
0xffffff9c60ba0568 : "CPU backtrace"
0xffffff9c619a6600 : "rcu_sched"
0xffffff9c619a6a40 : "rcu_bh"
0xffffff9c619a6ef8 : "rcu_preempt"

But that's only because you're coming from "shell" context, and
"shell" context has explicitly been granted access to files labeled as
debugfs_tracing:

# systrace support - allow atrace to run
allow shell debugfs_tracing_debug:dir r_dir_perms;
allow shell debugfs_tracing:dir r_dir_perms;
allow shell debugfs_tracing:file rw_file_perms;
allow shell debugfs_trace_marker:file getattr;
allow shell atrace_exec:file rx_file_perms;

Normal apps can't access it, AFAICS.

If you think that the contents of this particular file should not be
exposed, because you think that even someone with ADB access or in
traceur_app context shouldn't be able to see those pointers, then you
may wish to make a change to how you're labeling tracefs files.
