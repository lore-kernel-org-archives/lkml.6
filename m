Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526056774; cv=none;
        d=google.com; s=arc-20160816;
        b=ENPTPznKkMHVDRAVw96XZjo8nc10mFJQMztEH2aZFZ/tKapdhiogVSflcOPmJE+nTf
         bHGPpsOVv3RQ9R+DEyW1EcAUa6FEH34l+gTm4AqYnQNhMlxvs718N08ns3kaWMoFyDv1
         f+bFjtq82iZ1hiQeCEojUJa9LEmHSzU4HIj8ghrnSHPKKYQIr0L//0zoe1dAqfpG1FDi
         V7T6QH9TwipHvrAcwvIc/QDjn8rDGUyR0/OnpuUUbFnsG7Im12WvT7YOynRvWOR7XMRs
         UEBcHJcpE13bsmK7oAiVyr11D8j2lFNLnmRu8P9DqkJo9zBBMU/GYBMtErM4bsG2i8qe
         YeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/lOPEcgoMlt33sicscJH4oxbbryF4jHIwO6zI7do5Js=;
        b=HxjdUTrtIBHOY5WyY88dojALi5BI2LSJb5v/qwlKVapJJkyCz3DEGC8xTfHdlTa5Jg
         2CXYfmILcofNLyU8I5QsyhrEgja6Gg0KengsCkrtaM8grGIE5hNQVV0N0G68IXxqifge
         uiWc28ycojycQbr75ewLJ12ks6VgN5/H9ee4HHkkCmYikEEtUlIpUTI7ZBj7M18paTOk
         8qrZHDzcf1lScivzK0ls07GWLbimdsZXba1I1Lt3r+KSyZeBjsuFATqsm1KtMn8tB9gR
         dcuaI0iMXie3PbM/j/rR7k6ry6CkdvaocTnfuYtZxBtfdtMXto8qJgDDn6ayYkwigxb+
         Kwww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=gn7o5qie;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=gn7o5qie;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AB8JxZpI4NpbNsMbroySFW1tldkXqiweuOZVBMmH+JQqjv66OsK3e6zmPV1i26V/i3NVo7GSVgfi6/d76GLThnnf2tk=
MIME-Version: 1.0
References: <20180511093221.GA902@comp-core-i7-2640m-0182e6>
In-Reply-To: <20180511093221.GA902@comp-core-i7-2640m-0182e6>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 May 2018 09:39:23 -0700
Message-ID: <CA+55aFwZK+BMsm19sK-Wmfta6PcdvW6z-ghuKsb4PAwk19nRVg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] proc: modernize proc to support multiple private instances
To: gladkov.alexey@gmail.com, Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>, Andrew Lutomirski <luto@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	LSM List <linux-security-module@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Akinobu Mita <akinobu.mita@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Jeff Layton <jlayton@poochiereds.net>, Ingo Molnar <mingo@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Micay <danielmicay@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Solar Designer <solar@openwall.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Djalal Harouni <tixxdz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600160296507567102?=
X-GMAIL-MSGID: =?utf-8?q?1600186508210345244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 2:42 AM Alexey Gladkov <gladkov.alexey@gmail.com>
wrote:

> This is RFC v5 to modernize procfs and make it able to support multiple
> private instances per the same pid namespace.

So I have no big objections, but I would *really* like this to go through
Al's vfs tree.

Al? Have you looked at this series?

                  Linus
