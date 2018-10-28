Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DF2ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F91020843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei4OmGbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F91020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeJ1Tw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 15:52:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37585 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeJ1Tw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 15:52:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id o14so4983617oth.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 04:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoBdfcRiaVEHFB5Jm23iN91BJyij07w+KRhsgAhhdUQ=;
        b=Ei4OmGbW31h7xATkmdrworvdjvV/DwRSl0oIqEHDP1zFqaAZEPxewkv2rdhgoeq+Wv
         Kq+JOMNj+MhzQk/emORX3aMVsyYNm2EL5Iq35bXAxgqFfyXVqq8+jyHmQ0i/IdWjHZQY
         cQnaNmJ24l99uuIRKjiesvQ8/RXxPJrWfaIsarM/1xaPkhNdhhp+kuVdAEEKdRovxcfs
         XrWdwx/sWFvTdA/XdPa1paE4jbxjmkjdPwwWWApsxDZQ6bJeJ7YsCu8kh+JXm/m1Erlq
         2xiXOXn95NJcSsLwJb/GOtkD//lpQqu1w6CUsAyY65orM2M0vBc0emQH9knUuZKW6H0b
         ZZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoBdfcRiaVEHFB5Jm23iN91BJyij07w+KRhsgAhhdUQ=;
        b=dkZlDtwSVpYx/Jcne50ox9aotMjH8mu9nZY9cIv6LJoiS5hMzPAQaSZ1d7cLc5EoEl
         RMIFDKI/xnBZcdMRzBAUh0JGUFZSyZOw69TrBJFd8VFiM8hKgm+gAAXMB8M9cmqunDaY
         IykYn9eNCQ6iBNffTyysD6hUCMXBXKpupMpmIqMIa1mXNKUA3pamX/xA9Zm4mlNtLvJs
         c2WPLHeN5XucoICnbdvVRNgpnwxJSDuBlwy8kURxHt/2JNPXeh9sL85UWBUlTTljaBMT
         EzwAoAK/3dd0uGDGUdJthC6walaj3ar2F/V73JRAmD9iNrmP+VLnfm0MtdgnyJmxQmvn
         eeFQ==
X-Gm-Message-State: AGRZ1gKhR5qahA7+y305XTPpHje+kAcNnSDLQbFE6zKqxkTjQ/YF4+8j
        Eu3OAHE4jafmhXMScEX8TIs8T2t3ibhX+3dA/nA=
X-Google-Smtp-Source: AJdET5ffKgyz0yIxiTz/OMvvS73F9UsXyRaFJvXNcNcmrYDTh+Au0hCM7GeB6H3R4oKuACSJ2TcUkEcb1pjJlreimKE=
X-Received: by 2002:a9d:5910:: with SMTP id t16mr5732504oth.99.1540724886617;
 Sun, 28 Oct 2018 04:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
 <20181024204036.8799-1-palmer@sifive.com> <20181024204036.8799-3-palmer@sifive.com>
 <CAEn-LTovzRncSKCGv8wUTL6FkzcC+Hw1EBGe+Rc4GQyEgcK1uA@mail.gmail.com> <CAHC9VhT015tz4qZZ=vM6FowsUXLv-RYeBrH4C8d6jvg=XHumHA@mail.gmail.com>
In-Reply-To: <CAHC9VhT015tz4qZZ=vM6FowsUXLv-RYeBrH4C8d6jvg=XHumHA@mail.gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Sun, 28 Oct 2018 12:07:55 +0100
Message-ID: <CAEn-LTonSqSG8GtgVmwt7ToJ2NZKsGEaWndmA0Q7Lzm316CFbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: Add support for SECCOMP
To:     Paul Moore <paul@paul-moore.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        eparis@redhat.com, Kees Cook <keescook@chromium.org>,
        luto@amacapital.net, Will Drewry <wad@chromium.org>,
        wesley@sifive.com, dhowells@redhat.com, tglx@linutronix.de,
        Philippe Ombredanne <pombredanne@nexb.com>,
        gregkh@linuxfoundation.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:36 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Oct 25, 2018 at 2:31 PM David Abdurachmanov
> <david.abdurachmanov@gmail.com> wrote:
> > On Wed, Oct 24, 2018 at 10:40 PM Palmer Dabbelt <palmer@sifive.com> wrote:
> > > From: "Wesley W. Terpstra" <wesley@sifive.com>
>
> ...
>
> > Palmer,
> >
> > Half of the patch seems to touch audit parts. I started working on audit
> > support this morning, and I can boot Fedora with audit traces.
> >
> > [root@fedora-riscv ~]# dmesg | grep audit
> > [    0.312000] audit: initializing netlink subsys (disabled)
> > [    0.316000] audit: type=2000 audit(0.316:1): state=initialized
> > audit_enabled=0 res=1
> > [    7.288000] audit: type=1130 audit(1529665913.772:2): pid=1 uid=0
> > auid=4294967295 ses=4294967295 msg='unit=systemd-remount-fs
> > comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
> > terminal=? res=success'
> > [    7.684000] audit: type=1130 audit(1529665914.176:3): pid=1 uid=0
> > auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd"
> > exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> > res=success'
> > [..]
> >
> > I am still working on audit user-space support for better testing.
> >
> > I suggest we first implement audit and then seccomp.
>
> FYI, while small and far from comprehensive, we do have a test suite
> we use for basic validation of the audit kernel bits which may be
> helpful while you're working on the audit enablement:
>
> * https://github.com/linux-audit/audit-testsuite

Currently I checked the following to work:
- /proc/self/loginuid (required by DNF [package manager])
- auditctl (checked several different example rules from internet)
- aulast
- aulastlog
- ausearch
- ausyscall
- aureport
- autrace (compared some syscalls to strace: order and
  return value/input arguments seems to be correct)

I checked audit-testsuite yesterday and it seems to be only for
x86-64 / x86-32. After adjusting it (MODE, syscalls) I am at:

Failed 4/14 test programs. 19/88 subtests failed.

I don't plan to look further in the failure, e.g.:
- syscall_socketcall: that's an old stuff and not relevant to
  new arches
- syscall_module: Fedora kernel currently is not compiled
  with kernel loadable module support
- filter_exclude: two tests fail because id -Z doesn't print
  any categories, but "semanage login -l" output is identical
  between x86_64 and riscv64
- netfilter_pkt: don't have CONFIG_IP_NF_MANGLE enabled

Fedora kernel currently has minimal CONFIG_* options
and is built without loadable module support.

I will send the patches for review soon.

david
