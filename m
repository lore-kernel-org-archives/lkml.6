Return-Path: <jannh@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526401180; cv=none;
        d=google.com; s=arc-20160816;
        b=Rr9rEymE/a5B/Wako0OrhG53JL2ve3iITCJtY2AnNXAoMXDEKcC+qqwSAe6a3jqWuz
         58yKLhGj6xbvKcQkxiGTkRdPqM0xKhZwAFx6+yDWgi08y/KgfbWeZnWSDUr6f9UV1Cgj
         iDxiXYMli+jFgLFmkFr4p+rU0DWhrLfH2Lo1CRQOw/+apahGQ2yiSoeS8hBLdrqaPkyn
         RGrMCTug0cZCW0gSqpY3WWXiDrrUmvnz5oOC1rIsYTqDOv3lot2pi5iOxZfiTDXocnLl
         twJ/hcTr1lDEGkJexWfCw+BGe72yUEbFS99yRXk1UDYRKiTCLK4Z8U7XFNk1AkmQ//Kl
         0Htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=xt4jMlpU1MDL6prVLBu06jW7EEDWTZ2fdQG9GZgNFKM=;
        b=uJYlxj+Q4QcjQST+hyHusmAm6XF9vATYiGXpPSHklwxptF8WaepSdE2bXABzmV8usg
         pwqz2mdGKiTN5JTDvVh3GKgm4dlr5OW+OjoGzUi1Su/dvDYzYjNTar3s4kWJn28+KHKK
         gHfuXq1htu0e1r14eVkMu9erdB2yUCyXGupQJGQ0QrX4Cg0d+C9Y4YRvJoHxfnrkaR43
         q0zfdYFJRtp0E2nRX8ayBL5ZBn/H3/q6cvhuzveTGuoVhgMBowzsOKKXYqeQ4bH6uzhJ
         xzIMRGoXscD6fX0ftwmNd2cU5Z9xohue5ynQYl5FDA5aC1oJOzxfqkzvUghSCQsuPV/G
         qvyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Sq5Hjf8s;
       spf=pass (google.com: domain of jannh@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jannh@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Sq5Hjf8s;
       spf=pass (google.com: domain of jannh@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jannh@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZqhiDV4ry0z5+TggSkvcktb0pYBghtRQq8sVXZMzeuu3tJJ+lDqMdp8bO/uYkS969mSIPls0XGfVspCcGVuthg=
MIME-Version: 1.0
In-Reply-To: <20180515072153.GD28179@comp-core-i7-2640m-0182e6>
References: <20180511093445.GA1008@comp-core-i7-2640m-0182e6>
 <CAG48ez3xYHsKMkPJhjq-yrrTxMHmrHDov-P7bTy8T2xf_7=OAQ@mail.gmail.com> <20180515072153.GD28179@comp-core-i7-2640m-0182e6>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 May 2018 18:19:18 +0200
Message-ID: <CAG48ez1T5v=iryQk0fPkUr2umRpfMrSPJ2pYcB5HDbc3-kYBUw@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] proc: add proc_fs_info struct to store proc information
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
	kernel list <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Akinobu Mita <akinobu.mita@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>, Jeff Layton <jlayton@poochiereds.net>,
	Ingo Molnar <mingo@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	aniel Micay <danielmicay@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Bruce Fields <bfields@fieldses.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Solar Designer <solar@openwall.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Djalal Harouni <tixxdz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600160408637786282?=
X-GMAIL-MSGID: =?utf-8?q?1600547644038423643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 9:21 AM, Alexey Gladkov
<gladkov.alexey@gmail.com> wrote:
> On Fri, May 11, 2018 at 03:49:13PM +0200, Jann Horn wrote:
>> On Fri, May 11, 2018 at 11:34 AM, Alexey Gladkov
>> <gladkov.alexey@gmail.com> wrote:
>> > From: Djalal Harouni <tixxdz@gmail.com>
>> >
>> > This is a preparation patch that adds proc_fs_info to be able to store
>> > different procfs options and informations. Right now some mount options
>> > are stored inside the pid namespace which makes it hard to change or
>> > modernize procfs without affecting pid namespaces. Plus we do want to
>> > treat proc as more of a real mount point and filesystem. procfs is part
>> > of Linux API where it offers some features using filesystem syscalls and
>> > in order to support some features where we are able to have multiple
>> > instances of procfs, each one with its mount options inside the same pid
>> > namespace, we have to separate these procfs instances.
>> >
>> > This is the same feature that was also added to other Linux interfaces
>> > like devpts in order to support containers, sandboxes, and to have
>> > multiple instances of devpts filesystem [1].
>> >
>> > [1] http://lxr.free-electrons.com/source/Documentation/filesystems/devpts.txt?v=3.14
>> >
>> > Cc: Kees Cook <keescook@chromium.org>
>> > Suggested-by: Andy Lutomirski <luto@kernel.org>
>> > Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
>> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
>> > ---
>> [...]
>> >  static struct dentry *proc_mount(struct file_system_type *fs_type,
>> >         int flags, const char *dev_name, void *data)
>> >  {
>> > +       int error;
>> > +       struct super_block *sb;
>> >         struct pid_namespace *ns;
>> > +       struct proc_fs_info *fs_info;
>> > +
>> > +       /*
>> > +        * Don't allow mounting unless the caller has CAP_SYS_ADMIN over
>> > +        * the namespace.
>> > +        */
>> > +       if (!(flags & MS_KERNMOUNT) && !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
>> > +               return ERR_PTR(-EPERM);
>>
>> Is this correct?
>>
>> The old code invoked a check with the same comment through mount_ns();
>> however, this patch changes the semantics of the check.
>> The old code checked that the caller has privileges over the user
>> namespace that contains the PID namespace; in other words, it checked
>> that the caller has privileges over the PID namespace. The current
>> code just checks that the caller is privileged over its own user
>> namespace.
>>
>> As far as I can tell, this means that by doing something like this:
>>
>>     unshare(CLONE_NEWNS|CLONE_NEWUSER);
>>     mount("none", "/", NULL, MS_REC|MS_PRIVATE, NULL);
>>     mount("proc", "/proc", "proc", 0, "newinstance,pids=all");
>>
>> any process could create a new unrestricted procfs mount for its PID
>> namespace, even if it is only supposed to have access to a more
>> restricted procfs mount.
>
> Hm... let me investigate this. It looks like mount with "newinstance"
> option should fail if pid namespace is the same and the current and parent
> user namespace do not match.

I don't understand that last sentence. What does "if pid namespace is
the same" mean, and what does "current and parent user namespace do
not match" mean?

Just changing "ns_capable(current_user_ns(), CAP_SYS_ADMIN)" to
"ns_capable(task_active_pid_ns(current)->user_ns, CAP_SYS_ADMIN)"
should be enough to get the old semantics again: It checks whether the
current task is capable over its PID namespace.
