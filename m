Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1992310-1527381126-2-5357612529695706283
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527381126; b=RFc3Ex3VHFo+mEag3lwaz/eYijphK8n9PgKwA3hQu3z+8mTrCk
    FZQQMRSDWBDaeF1cqB+JR47TnstH4cW08r6V+ARTTXi/qTUG1Ojgk8tfSFhWuhJ6
    StJefPcqMg7yLRTEayx5GCI4Fof0wjkSJA92SKqvdGkEVgl+53ICXGZpIqD2ToTM
    LsEfL0xEqwtcuyyMPcCcNjn8yxRWuCbcB3vp4CvryZ5ET7AaCFgO3+8GnnnfIVQ2
    Fwqzjq+zQCWCV+HOqAdzvUs9dJS2IXqSm52oWc8DSaWq0PCBA8vFrcbSwq28A734
    egEhau1LM9NGKCCSsH+PKw6dZcnUedzT9QRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527381126; bh=SgC+VvLcnVQa9IX/svXaFr1Idp/rpllTjiULQf9uri
    k=; b=JUcrNI0VH2Rpr/hwbnrlwTJBMi8mDYht/vDwlgjxKc6DTcG84L2Tw6ms5r
    XLM2FwmdZ3py2wvLB3CQ6ye8UdDdgQ8TN6WdlV34PzuJuGfjYGfSW+FryQVdB0Fg
    r2brQGf0NashhY5t3rEMpaY5nveK4lhmXkV756q1QNNo/EzjlWa2scqbNg5dGTS/
    2J+VdmvK8aA6I3W+PDP2WSkoXc591zaFGInq8cl700f2vPxzcCeHdpgqxRu9mMft
    QCjMNdFbA5Dusf5gSqNCHsbTjCVFYSZnglZgelqa2KOnLFcb7Q6o9zNwqiMCKYnI
    rM5Zy4nGJ9j7cvBcik1mDQrGV8Xg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=C2hZEw7f
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=GZ8+oLgO x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=CnBp942i;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=C2hZEw7f
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=GZ8+oLgO x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=CnBp942i;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFT3gFcVESXIuwXexgBMWW7ElTJlKk+stu5P6DhQlOCAEJj6+nhmjcI1HU6BCHND51UfINiOzBlOay+9R+gMOzaTA6GFJKHAQyx12qqkFAkkwb9/V9fe
    hKyEBnwNRYalSSNEcpgmyxY7y5LK15+n3c6WpsYmgQZQp0pPA46rTZtvDhDa1yoNbDUfqZflA/TZ1sybHoR82rKYCV3YmmOOajV16VDS21NewQz4Qoi0LYbT
    ljn4i3iFoorPZK/JxRJYgw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=PCMa7anLKuqG1YL6EnAA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032475AbeE0Ab7 (ORCPT <rfc822;linux@kroah.com>);
        Sat, 26 May 2018 20:31:59 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33695 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032456AbeE0Ab6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 26 May 2018 20:31:58 -0400
X-Google-Smtp-Source: ADUXVKI0ExpyqABCxKL83Y3NHX5Nxw1DJ8MF7ZvCDU1TWVrp4xQh9JFfLPJ1a4srQ4pcv6aFaHVEWvsL8oU+Xh2CbHA=
MIME-Version: 1.0
In-Reply-To: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 26 May 2018 17:31:56 -0700
X-Google-Sender-Auth: h4FcRs9803G33zGE_Mfx8i4POac
Message-ID: <CAGXu5j+PHzDwnJxJwMJ=WuhacDn_vJWe9xZx+Kbsh28vxOGRiA@mail.gmail.com>
Subject: Re: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 26, 2018 at 7:50 AM, Salvatore Mesoraca
<s.mesoraca16@gmail.com> wrote:
> Prevent a task from opening, in "write" mode, any /proc/*/mem
> file that operates on the task's mm.
> /proc/*/mem is mainly a debugging means and, as such, it shouldn't
> be used by the inspected process itself.
> Current implementation always allow a task to access its own
> /proc/*/mem file.
> A process can use it to overwrite read-only memory, making
> pointless the use of security_file_mprotect() or other ways to
> enforce RO memory.

I went through some old threads from 2012 when e268337dfe26 was
introduced, and later when things got looked at during DirtyCOW. There
was discussion about removing FOLL_FORCE (in order to block writes on
a read-only memory region). But that was much more general, touched
ptrace, etc. I think this patch would be okay, since it's specific to
the proc "self" mem interface, not remote processes (via ptrace). This
patch would also have blocked the /proc/self/mem path to DirtyCOW
(though not ptrace), so that would be nice if we have similar issues
in the future. So, as long as this doesn't break anything, I'm for it
in general. I've CCed Linus and Jann too, since they've stared at this
a lot too. :P

Note that you're re-checking the mm-check-for-self in mm_access().
That's used in /proc and for process_vm_write(). Ptrace (and
mm_access()) uses ptrace_may_access() for stuff (which has a similar
check to bypass LSMs), so I'd be curious what would happen if this
logic was plumbed into mm_access() instead of into proc_mem_open().
(Does anything open /proc/$pid files for writing? Does anything using
process_vm_write() on itself?)

-Kees

>
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
>  fs/proc/base.c       | 25 ++++++++++++++++++-------
>  fs/proc/internal.h   |  3 ++-
>  fs/proc/task_mmu.c   |  4 ++--
>  fs/proc/task_nommu.c |  2 +-
>  4 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 1a76d75..01ecfec 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -762,8 +762,9 @@ static int proc_single_open(struct inode *inode, struct file *filp)
>         .release        = single_release,
>  };
>
> -
> -struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
> +struct mm_struct *proc_mem_open(struct inode *inode,
> +                               unsigned int mode,
> +                               fmode_t f_mode)
>  {
>         struct task_struct *task = get_proc_task(inode);
>         struct mm_struct *mm = ERR_PTR(-ESRCH);
> @@ -773,10 +774,20 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
>                 put_task_struct(task);
>
>                 if (!IS_ERR_OR_NULL(mm)) {
> -                       /* ensure this mm_struct can't be freed */
> -                       mmgrab(mm);
> -                       /* but do not pin its memory */
> -                       mmput(mm);
> +                       /*
> +                        * Prevent this interface from being used as a mean
> +                        * to bypass memory restrictions, including those
> +                        * imposed by LSMs.
> +                        */
> +                       if (mm == current->mm &&
> +                           f_mode & FMODE_WRITE)
> +                               mm = ERR_PTR(-EACCES);
> +                       else {
> +                               /* ensure this mm_struct can't be freed */
> +                               mmgrab(mm);
> +                               /* but do not pin its memory */
> +                               mmput(mm);
> +                       }
>                 }
>         }
>
> @@ -785,7 +796,7 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
>
>  static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
>  {
> -       struct mm_struct *mm = proc_mem_open(inode, mode);
> +       struct mm_struct *mm = proc_mem_open(inode, mode, file->f_mode);
>
>         if (IS_ERR(mm))
>                 return PTR_ERR(mm);
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 0f1692e..8d38cc7 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -275,7 +275,8 @@ struct proc_maps_private {
>  #endif
>  } __randomize_layout;
>
> -struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode);
> +struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode,
> +                               fmode_t f_mode);
>
>  extern const struct file_operations proc_pid_maps_operations;
>  extern const struct file_operations proc_tid_maps_operations;
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index c486ad4..efb6535 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -227,7 +227,7 @@ static int proc_maps_open(struct inode *inode, struct file *file,
>                 return -ENOMEM;
>
>         priv->inode = inode;
> -       priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
> +       priv->mm = proc_mem_open(inode, PTRACE_MODE_READ, file->f_mode);
>         if (IS_ERR(priv->mm)) {
>                 int err = PTR_ERR(priv->mm);
>
> @@ -1534,7 +1534,7 @@ static int pagemap_open(struct inode *inode, struct file *file)
>  {
>         struct mm_struct *mm;
>
> -       mm = proc_mem_open(inode, PTRACE_MODE_READ);
> +       mm = proc_mem_open(inode, PTRACE_MODE_READ, file->f_mode);
>         if (IS_ERR(mm))
>                 return PTR_ERR(mm);
>         file->private_data = mm;
> diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
> index 5b62f57..dc38516 100644
> --- a/fs/proc/task_nommu.c
> +++ b/fs/proc/task_nommu.c
> @@ -280,7 +280,7 @@ static int maps_open(struct inode *inode, struct file *file,
>                 return -ENOMEM;
>
>         priv->inode = inode;
> -       priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
> +       priv->mm = proc_mem_open(inode, PTRACE_MODE_READ, file->f_mode);
>         if (IS_ERR(priv->mm)) {
>                 int err = PTR_ERR(priv->mm);
>
> --
> 1.9.1
>



-- 
Kees Cook
Pixel Security
