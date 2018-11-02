Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67998C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D712081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihJToZ8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D712081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeKBWkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:40:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38300 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBWkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:40:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id f24so1689928otl.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiBj4MNKBy7fOpxwwS5hRmTxjV00jauWji3Oo4eSyFw=;
        b=ihJToZ8+XnHw33trEUWuPenyaV2K6vcx/9Lbd6fLp2bni26va5F+Cr+6dkeR9yBh/H
         hnTpsxM/Y6aOM8uVVvMAZxioV15M6kVFVb3NsCXfACjdb+u5WM5XpOwpKAHJIQV4B/hZ
         ohR0bxRmYGXpzvjUAAJGfYlGuoTUV+hjtK03muq8WN1c9m6CBRTs/JlYT2BqWmRtmaTA
         sobPGS8ValyGPn4+cFB34mrYnaB2aYkg4jsbJLzD2/QGYZbpkeD2S3Yz3Ot2RrnF66A/
         58TGOK/xGEQdEMa95LNC3Yim3rEdXAf7tKa+4Ufhb4Odffw11Hrv/hLy4ASR7RToERLi
         4E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiBj4MNKBy7fOpxwwS5hRmTxjV00jauWji3Oo4eSyFw=;
        b=USCYQacMfikk25AR967ykPPEP1H48Ws7tRbIOqQrEVz/be0HOrdy9ZWlxhbbRyjojU
         UU+c6CRgY4N69ucoZWwlqyuGY0WazbovmD9RSmJD7i8F51u5Wc91syc3AS1wTVFG89Qc
         FnlgQzlZvIQ+o59UrYQjssBeoLTEkBdUgtw1q9hdKmSKvFRScjJ7rfMjSGB01wLu4nk+
         Niepq7ukPrmPaJ1x6Rn/fFnBJhwar+JgwhGNDkIwQaAMaTTm6iOEohda5cBbi6I2Ltj1
         ng+Skpk/yy2tMqdVMpVhfwqeRwN3SaRks80KlyvuCzjaWRwVbPUPoGaAX2LYZnlxLrNX
         G49A==
X-Gm-Message-State: AGRZ1gJrQ8Hk8G3q8UwTF9gK06U0IrtPd+AqV9+MwiN5TvVofNZ1JnrM
        asVVAhZVnpORRuv/y5RQnJFuIkCN/UN/0aRG2SE=
X-Google-Smtp-Source: AJdET5ftJ9HhlISux4LD7TcI//eYvYqZqLhxk+peFA6/YoJdUYMs10zrDR+nanjEYpGqt7Gt9imUtCyyLXj3CYEtNNs=
X-Received: by 2002:a9d:2fac:: with SMTP id r41mr6741407otb.169.1541165578824;
 Fri, 02 Nov 2018 06:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAEn-LTonSqSG8GtgVmwt7ToJ2NZKsGEaWndmA0Q7Lzm316CFbA@mail.gmail.com>
 <mhng-71c7a4db-432a-4f97-86cd-1fe16091a6c8@palmer-si-x1c4>
In-Reply-To: <mhng-71c7a4db-432a-4f97-86cd-1fe16091a6c8@palmer-si-x1c4>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Fri, 2 Nov 2018 14:32:47 +0100
Message-ID: <CAEn-LTr6eTgy4HsxT2y_LhXXtQczJNZmQJdY-em-maDOcFL9fA@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: Add support for SECCOMP
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Paul Moore <paul@paul-moore.com>, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, eparis@redhat.com,
        Kees Cook <keescook@chromium.org>, luto@amacapital.net,
        Will Drewry <wad@chromium.org>, wesley@sifive.com,
        dhowells@redhat.com, tglx@linutronix.de,
        Philippe Ombredanne <pombredanne@nexb.com>,
        gregkh@linuxfoundation.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 9:27 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Sun, 28 Oct 2018 04:07:55 PDT (-0700), david.abdurachmanov@gmail.com wrote:
> > On Thu, Oct 25, 2018 at 10:36 PM Paul Moore <paul@paul-moore.com> wrote:
> >>
> >> On Thu, Oct 25, 2018 at 2:31 PM David Abdurachmanov
> >> <david.abdurachmanov@gmail.com> wrote:
> >> > On Wed, Oct 24, 2018 at 10:40 PM Palmer Dabbelt <palmer@sifive.com> wrote:
> >> > > From: "Wesley W. Terpstra" <wesley@sifive.com>
> >>
> >> ...
> >>
> >> > Palmer,
> >> >
> >> > Half of the patch seems to touch audit parts. I started working on audit
> >> > support this morning, and I can boot Fedora with audit traces.
> >> >
> >> > [root@fedora-riscv ~]# dmesg | grep audit
> >> > [    0.312000] audit: initializing netlink subsys (disabled)
> >> > [    0.316000] audit: type=2000 audit(0.316:1): state=initialized
> >> > audit_enabled=0 res=1
> >> > [    7.288000] audit: type=1130 audit(1529665913.772:2): pid=1 uid=0
> >> > auid=4294967295 ses=4294967295 msg='unit=systemd-remount-fs
> >> > comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
> >> > terminal=? res=success'
> >> > [    7.684000] audit: type=1130 audit(1529665914.176:3): pid=1 uid=0
> >> > auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd"
> >> > exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> >> > res=success'
> >> > [..]
> >> >
> >> > I am still working on audit user-space support for better testing.
> >> >
> >> > I suggest we first implement audit and then seccomp.
> >>
> >> FYI, while small and far from comprehensive, we do have a test suite
> >> we use for basic validation of the audit kernel bits which may be
> >> helpful while you're working on the audit enablement:
> >>
> >> * https://github.com/linux-audit/audit-testsuite
> >
> > Currently I checked the following to work:
> > - /proc/self/loginuid (required by DNF [package manager])
> > - auditctl (checked several different example rules from internet)
> > - aulast
> > - aulastlog
> > - ausearch
> > - ausyscall
> > - aureport
> > - autrace (compared some syscalls to strace: order and
> >   return value/input arguments seems to be correct)
> >
> > I checked audit-testsuite yesterday and it seems to be only for
> > x86-64 / x86-32. After adjusting it (MODE, syscalls) I am at:
> >
> > Failed 4/14 test programs. 19/88 subtests failed.
> >
> > I don't plan to look further in the failure, e.g.:
> > - syscall_socketcall: that's an old stuff and not relevant to
> >   new arches
> > - syscall_module: Fedora kernel currently is not compiled
> >   with kernel loadable module support
> > - filter_exclude: two tests fail because id -Z doesn't print
> >   any categories, but "semanage login -l" output is identical
> >   between x86_64 and riscv64
> > - netfilter_pkt: don't have CONFIG_IP_NF_MANGLE enabled
> >
> > Fedora kernel currently has minimal CONFIG_* options
> > and is built without loadable module support.
> >
> > I will send the patches for review soon.
>
> Thanks!

I fixed the last issue I see with SECCOMP this morning.
I also have patch on top of libseccomp-2.3.3.

Testsuite results for SIM:

Regression Test Summary
 tests run: 4434
 tests skipped: 88
 tests passed: 4434
 tests failed: 0
 tests errored: 0

Testsuite results for LIVE:

Regression Test Summary
 tests run: 6
 tests skipped: 0
 tests passed: 6
 tests failed: 0
 tests errored: 0

Then tested a couple examples manually w/ and w/o BPF and it
performed the same as on x86_64 (also checked exit codes &
strace output).

Upstream libseccomp has now more tests. Once I rebase & re-test
with master of libseccomp, I will send both.

david
