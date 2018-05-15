Return-Path: <gladkov.alexey@gmail.com>
X-Google-Smtp-Source: AB8JxZpZqNLDz+1cdJJl1WP3Nv0Wi9x8SxImCgs26wkI7RntsvTMYVEUxVGcVR1BD7JjjL9So3EK
ARC-Seal: i=1; a=rsa-sha256; t=1526369386; cv=none;
        d=google.com; s=arc-20160816;
        b=E8mNVIPwOgPkw+tklvG6FrGnUz415AkRcNv55X69sVacBxQQexD4yn++7AWoOb5HUJ
         JRbDVHz7DFTuFRaeEXIn9ZFwtp/X2kh80P4MZThvk2lStiWR6HR+SrZbD74Xnuyq1eSH
         IKyYBnlUEJmZQFneKGw65vhMoDiAMwV4pLg0BMChNgT01OYSS9qw4/6E3LrwAtgI+gg/
         EMoVW4lMJORYCkc1E2LU3DFh7YxbNSYFCMeblgNO8Xoqr+IUQ7ttSU4aN9skM/Q8ESPO
         UQ99xHmZ6mB1X77AiFBXyoAWmI4Q4IVDksL6cF/+wuU7M0qE8lZKp65fKMtFWWt1Qmjv
         H8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=qSROvJe8kjVYt3x2G2upuUhZ7vVR5uZa+n85QQhd9JI=;
        b=hhcQERqKqsCAxGWiVvf9Nh4fHpe1Nuvsu/FHU66wZmxX3082CcbuD18gkeFlEF+ukP
         H36BJpuLTbFmHHAXNaFnGneFERKadzHxsK8l4HXnj7VzIw+SARXb3WXSGZ5tuCS8jBx1
         D0+QP95DfUdHYYk332bmOA1DsdrCSGZtKPtyymzLfsbdF4Nyvai/ObMCUK88qS67STSC
         Ph1ANvemayqdoxoe5oW8K67BNsFFDiKhxhzf3r91FtbTN+qcZK0H6fUm05XQ603nT6xq
         tLXeGZBmQcnrECxr8iLEJOFw/FB1zfZeZ1y6tSwtSeYxj4hcRvaQaWkVATgtNRHoRAoq
         LMcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gladkov.alexey@gmail.com does not designate 5.9.28.80 as permitted sender) smtp.mailfrom=gladkov.alexey@gmail.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gladkov.alexey@gmail.com does not designate 5.9.28.80 as permitted sender) smtp.mailfrom=gladkov.alexey@gmail.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Tue, 15 May 2018 09:21:54 +0200
From: Alexey Gladkov <gladkov.alexey@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	kernel list <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Jeff Layton <jlayton@poochiereds.net>,
	Ingo Molnar <mingo@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	aniel Micay <danielmicay@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, bfields@fieldses.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Solar Designer <solar@openwall.com>,
	"Dmitry V. Levin" <ldv@altlinux.org>,
	Djalal Harouni <tixxdz@gmail.com>
Subject: Re: [PATCH v5 1/7] proc: add proc_fs_info struct to store proc
 information
Message-ID: <20180515072153.GD28179@comp-core-i7-2640m-0182e6>
References: <20180511093445.GA1008@comp-core-i7-2640m-0182e6>
 <CAG48ez3xYHsKMkPJhjq-yrrTxMHmrHDov-P7bTy8T2xf_7=OAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3xYHsKMkPJhjq-yrrTxMHmrHDov-P7bTy8T2xf_7=OAQ@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600160408637786282?=
X-GMAIL-MSGID: =?utf-8?q?1600514306306704329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 03:49:13PM +0200, Jann Horn wrote:
> On Fri, May 11, 2018 at 11:34 AM, Alexey Gladkov
> <gladkov.alexey@gmail.com> wrote:
> > From: Djalal Harouni <tixxdz@gmail.com>
> >
> > This is a preparation patch that adds proc_fs_info to be able to store
> > different procfs options and informations. Right now some mount options
> > are stored inside the pid namespace which makes it hard to change or
> > modernize procfs without affecting pid namespaces. Plus we do want to
> > treat proc as more of a real mount point and filesystem. procfs is part
> > of Linux API where it offers some features using filesystem syscalls and
> > in order to support some features where we are able to have multiple
> > instances of procfs, each one with its mount options inside the same pid
> > namespace, we have to separate these procfs instances.
> >
> > This is the same feature that was also added to other Linux interfaces
> > like devpts in order to support containers, sandboxes, and to have
> > multiple instances of devpts filesystem [1].
> >
> > [1] http://lxr.free-electrons.com/source/Documentation/filesystems/devpts.txt?v=3.14
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Suggested-by: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> > ---
> [...]
> >  static struct dentry *proc_mount(struct file_system_type *fs_type,
> >         int flags, const char *dev_name, void *data)
> >  {
> > +       int error;
> > +       struct super_block *sb;
> >         struct pid_namespace *ns;
> > +       struct proc_fs_info *fs_info;
> > +
> > +       /*
> > +        * Don't allow mounting unless the caller has CAP_SYS_ADMIN over
> > +        * the namespace.
> > +        */
> > +       if (!(flags & MS_KERNMOUNT) && !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> > +               return ERR_PTR(-EPERM);
> 
> Is this correct?
> 
> The old code invoked a check with the same comment through mount_ns();
> however, this patch changes the semantics of the check.
> The old code checked that the caller has privileges over the user
> namespace that contains the PID namespace; in other words, it checked
> that the caller has privileges over the PID namespace. The current
> code just checks that the caller is privileged over its own user
> namespace.
> 
> As far as I can tell, this means that by doing something like this:
> 
>     unshare(CLONE_NEWNS|CLONE_NEWUSER);
>     mount("none", "/", NULL, MS_REC|MS_PRIVATE, NULL);
>     mount("proc", "/proc", "proc", 0, "newinstance,pids=all");
> 
> any process could create a new unrestricted procfs mount for its PID
> namespace, even if it is only supposed to have access to a more
> restricted procfs mount.

Hm... let me investigate this. It looks like mount with "newinstance"
option should fail if pid namespace is the same and the current and parent
user namespace do not match.

-- 
Rgrds, legion
