Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B53C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260B12183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="TyxhgytX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfB0O5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:57:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40026 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfB0O5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:57:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id w6so14234567ljd.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 06:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E67zeY3nROhnXlGvd1QdmAOU/WKqKBq98SlPNUZar1U=;
        b=TyxhgytXQD33xjhIzX8T6k9hIYTk2ryIqPpubVDPF1Z6pXrlvKS2f+l5nEMbhJ6lGu
         0ok/K56CNLphAa5kFHzO+0QI3+7/I94M4SlDWR+md1PQrfr1z7WsL5Z2DplChd/5zdMM
         ryeMIp9yzuWoVCiF3GULarLHct7zFysTjRjYgOIbBzaoxuHmwYIx1tAUPVYMjzJk2OJ6
         b1XzOzdA4gmauc3WLbE1B60nQr8yOPTNy9zIf0QzZwjjftVvU541w6Hqn9Um4ezggx1i
         mMjR6lqhPyVPNWpiSoONeT1o17Yrt1zpZrm5Wzk/FUQ8s4p7t/jqeaCshTrWJddTahJx
         +qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E67zeY3nROhnXlGvd1QdmAOU/WKqKBq98SlPNUZar1U=;
        b=je6g315w21QVNw/k1utK1kaIb9p1ZbTINikQjip+2nDcJz4V55le3Dj7LjnxxVFNpi
         ZZOVeUzCzOZkJJjcBmiyjfvSXOzPH5VG5bX+32ZHuAL0POCYMMUzN8odTFhuXgz7Ew0N
         Msk6GfKKibVIARP6HIpgt+mlIyiR4O+HLC2XrXAlvejqf4o99iXnq5YPQXXdaluVcc5o
         ecPdH21olPv9b4PwwNg3f3tvFkrUbwZdeJd95M025a+5F2rb52QTXKgw0cH7WssNwa8X
         dBLRsp9VIXtMM0JG3voxEaAq8W8XBNhCxhr77BS8HD8k+MPDeomTJZhRD3GRmdYXrVMq
         hoGQ==
X-Gm-Message-State: APjAAAVfQcRogxQBMzaWXNJONn/nxKAid5MdKd5ljlR/iDIzXn2o2SKl
        wPB3bfhDXY3ICadbuM8ac2vYblfWmRNsk0kWOhsVAIC+7A==
X-Google-Smtp-Source: AHgI3Ibp3gj+hOkjQPmDPDXxWsJSOvfNrLfkvOtrhAcIvlSrr9cjsNdAB+nZw7FenyzmnFs1nRIVMp6Xr+tmKrCpSLk=
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr1721708ljk.169.1551279434018;
 Wed, 27 Feb 2019 06:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20190109124044.GA11935@altlinux.org> <20190117203444.jrnaoqnpuztcjfx3@madcap2.tricolour.ca>
 <20190208222219.GA12864@altlinux.org> <20190227141259.GA22352@altlinux.org>
In-Reply-To: <20190227141259.GA22352@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Feb 2019 09:57:02 -0500
Message-ID: <CAHC9VhSSq6VEMtACs756VA8dRyuPWQNhG6K12zjew99w73CiSg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Prepare syscall_get_arch for PTRACE_GET_SYSCALL_INFO
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 9:13 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Sat, Feb 09, 2019 at 01:22:19AM +0300, Dmitry V. Levin wrote:
> > On Thu, Jan 17, 2019 at 03:34:44PM -0500, Richard Guy Briggs wrote:
> > > On 2019-01-09 15:40, Dmitry V. Levin wrote:
> > > > syscall_get_arch() is required to be implemented on all architectures in order
> > > > to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO request:
> > > > syscall_get_arch() is going to be called from ptrace_request() along with
> > > > syscall_get_nr(), syscall_get_arguments(), syscall_get_error(), and
> > > > syscall_get_return_value() functions with a tracee as their argument.
> > > >
> > > > The primary intent is that the triple (audit_arch, syscall_nr, arg1..arg6)
> > > > should describe what system call is being called and what its arguments are.
> > > >
> > > > This patchset began as a series called "Prepare for PTRACE_GET_SYSCALL_INFO",
> > > > then I merged it into a series called "ptrace: add PTRACE_GET_SYSCALL_INFO request"
> > > > that also contains ptrace-specific changes.
> > > >
> > > > The ptrace-specific part, however, needs more attention to workaround problems
> > > > on niche architectures like alpha, while the syscall_get_arch() part is
> > > > straightforward, so I decided to split it out into a separate patchset that
> > > > just prepares syscall_get_arch() for PTRACE_GET_SYSCALL_INFO: it adds
> > > > syscall_get_arch() to those architectures that haven't implemented it yet,
> > > > and then adds "struct task_struct *" argument to syscall_get_arch()
> > > > on all architectures.
> > >
> > > Glad to see syscall_get_arch() added to the remaining arches.  As Paul
> > > said, it gets us closer to auditing syscalls on those remaining
> > > unsupported arches and getting rid of the extra CONFIG_AUDITSYSCALL.
> > > A little ironic that Eric (Paris) and I purged task_struct from
> > > syscall_get_arch() 5 years ago since everything could use current.
> > >
> > > > All patches from this patchset have been already reviewed, so it's ready
> > > > to be merged without waiting for the ptrace-specific part.  As it's all
> > > > about syscall_get_arch(), it should probably go via audit tree.
> > >
> > > ACK.
> > >
> > > Thanks Dmitry.
> >
> > Thanks.
> > Please let me know if some action related to this patch series is expected from me.
> >
> > > > Dmitry V. Levin (14):
> > > >   Move EM_ARCOMPACT and EM_ARCV2 to uapi/linux/elf-em.h
> > > >   arc: define syscall_get_arch()
> > > >   c6x: define syscall_get_arch()
> > > >   h8300: define syscall_get_arch()
> > > >   Move EM_HEXAGON to uapi/linux/elf-em.h
> > > >   hexagon: define syscall_get_arch()
> > > >   m68k: define syscall_get_arch()
> > > >   Move EM_NDS32 to uapi/linux/elf-em.h
> > > >   nds32: define syscall_get_arch()
> > > >   nios2: define syscall_get_arch()
> > > >   riscv: define syscall_get_arch()
> > > >   Move EM_UNICORE to uapi/linux/elf-em.h
> > > >   unicore32: define syscall_get_arch()
> > > >   syscall_get_arch: add "struct task_struct *" argument
>
> This is just a gentle ping of the series which is still applicable
> to v5.0-rc8 with one exception: "riscv: define syscall_get_arch()"
> is no longer needed as riscv already has syscall_get_arch() now.

Hi Dmitry,

I obviously think this patchset is a step in the right direction (I've
ACK'd it previously), and I have no problem merging this via the audit
tree, but I'm far from an expert on all the various arches listed, so
having the associated arch maintainer ACKs is important.  Based on the
mail I've seen, here is the current status of the maintainer ACKs:

* arc: good (vgupta@synopsys.com)
* c6x: good (msalter@redhat.com)
* h8300: missing
* hexagon: missing
* m68k: good (geert@linux-m68k.org)
* nds32: missing
* nios2: missing
* riscv: no longer needed
* unicore32: missing

... as you can see, we are missing a number of ACKs/reviews from some
of the smaller arches.  Granted, it has been over a month, and these
patches are relatively trivial, but if you could try one more time to
get the missing ACKs I would appreciate it.

If you still can't get a response from the various maintainers by the
time the upcoming merge window closes and -next opens for business,
I'll go ahead and merge the pile into audit/next and we'll cross our
fingers that nothing explodes.

It shouldn't.

I think :)

-- 
paul moore
www.paul-moore.com
