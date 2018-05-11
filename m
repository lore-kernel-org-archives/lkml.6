Return-Path: <jannh@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526047140; cv=none;
        d=google.com; s=arc-20160816;
        b=y5IqqzXNjXxvZifo5k6XMjUqWvyT4KX3Z+tKYxI2JSxgS9OC54TCMlefVC3IweR9Kj
         vNIdKFwhBbZJChtaBu1ufR3fxD6ijZ9J47UfQOXiTtTtiyF7wA2EQeKnztxwDotgICX+
         ALfCBt8ATi7xFm7KX75qdoZjIPDgoSSNYlB4lmXM9ny5t6oaBVWnJkdooirCo7+320ez
         u4Ap3E0L2u5tH5d9/C3DydmTgUpMEK2ehg88ueHhwuLe+VfOBXc9Ss/8o7q4AMj9FOAW
         G43gH695YHafPWaS3nemuKhgk6xoKwVvl0FCJfrhg/YAROwDxa6i4i1uj6cgXYQw84NL
         dqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=y2aEfJF0AKUrPnnqFqECnKFMYxALQ8hKNJvu6oHprr8=;
        b=Tco8T3ADfvN2RsBpUuu4wSf30VvVcnr8RqHsl+t5O3z5nZsjtlHbDeR+RJ/9xVKaW7
         PSGGbs71qO233hukmP0mKD9KUthyRDf57H9eECHhTrg45wSDgpF954Vfsqq41XSs1F4r
         mw2l8ppV8Glt42lVSNXBpDvm8QBkkBBHcCg4QfGw0Blk7voJ/5+HwAViRzkkP1by82SJ
         MyOGhc35PSjdjn5QiB+DwrdbSvbuUXS/gxd2LtYlxo7OypYnIRNPWn4teFvzNpJ0pL0O
         X83OJnvL1lhHGai9xVu6ZHR94VlXhvvsLW2yeGdzCo7mZc21D61fJ7WfHXTadUFt7PVL
         8a4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BY4tH93L;
       spf=pass (google.com: domain of jannh@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jannh@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BY4tH93L;
       spf=pass (google.com: domain of jannh@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jannh@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZpuuWCnAwy/C16EksJm3Hjs+lvOv6Wt67zY77ix7LOsqn4PMdndQm9lW9Mt6NGgYkqWXY+gLFOBHgSyCbshDN4=
MIME-Version: 1.0
In-Reply-To: <20180511093707.GA1403@comp-core-i7-2640m-0182e6>
References: <20180511093707.GA1403@comp-core-i7-2640m-0182e6>
From: Jann Horn <jannh@google.com>
Date: Fri, 11 May 2018 15:58:39 +0200
Message-ID: <CAG48ez0bXvp1iF=HqyhEP1p5B6PRR07_j0qRoypJqs8x3Z+=mw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] proc: add option to mount only a pids subset
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
	aniel Micay <danielmicay@gmail.com>, Jonathan Corbet <corbet@lwn.net>, bfields@fieldses.org,
	Stephen Rothwell <sfr@canb.auug.org.au>, Solar Designer <solar@openwall.com>,
	"Dmitry V. Levin" <ldv@altlinux.org>, Djalal Harouni <tixxdz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600160557264356413?=
X-GMAIL-MSGID: =?utf-8?q?1600176407304893105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 11:37 AM, Alexey Gladkov
<gladkov.alexey@gmail.com> wrote:
> This allows to hide all files and directories in the procfs that are not
> related to tasks.

/proc/$pid/net and /proc/$pid/task/$tid/net aren't in scope for this
protection, even though they contain information about the whole
network namespace of the task, right?
