Return-Path: <wvw@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524632024; cv=none;
        d=google.com; s=arc-20160816;
        b=ybVr4su6KZAAFpyCUVJmyQFiuhOdPGTKkW384aaDMOtuQWvxCRZSbbydwXRtwiRDbb
         mFG4pCafMeN2AFEGEtTOwHV9CurFZYCxypBbxu56HfSWPTI1jLOiX4e1I1/MfwXPqseA
         03cX7xoeiA1ucIFF8GpfI5wmjc8gibmhkz3uZvzx5vRMh6wwGTxLuq6A/Az1aywXdDLf
         IGL33n4Bkv1Oc1EScteNGc8bgxyuvMJyC47+0byWYo6Jkfy9J/xOqOaP9upBbx5vq9R2
         aME84f47yWqxSFXqmLuDSgKuX3ypVhHXVpAdADBlgP024w/CIOpGhdM+rp5fuLKyNZV0
         tnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AqAzEcgrn7IIhkzHkhsLi8Wfzx7hew/NctTdQ6ur4fk=;
        b=lSZebT2v9dvOtT5lnmmtydU2i5U7Z19d8sYdESRKQogWRsh30MJ0KoEulGC6pR2kN1
         E52J/7Z2L4ReGrz0lHdW+ucj1kIoXebwVU6u7RshISdGxPBS+r6suUjfkebMhrCZ8g/6
         7noX6qnu8ykFZSR3SzTf1SyQCR5/0+95S90VVgmwok4h8u2hPuNX0542HL5uTdZYiJXV
         pT2prm9t/NwAyKEA4hfbxf1Tjz0FbDFF/Er+kcrMEWjkJwy6RcWwnEJ4T6+GvfYLOF3R
         X+UC1oWYS9sSbDpTLBNceBNuhCbrmioqvpPgcXO6tYxNkB2yjoU5wRbrTrcyBzMpzmoW
         anRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SHS9VYpe;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SHS9VYpe;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4956XmTSK2misaFHAT+mgdDRtGwYa7N3NNjS5VV+3Heo5NtbJGFBLqevVpi0TfScv9TQmQdEiOn6V1rZJXyZNM=
MIME-Version: 1.0
References: <20180424180812.215900-1-wvw@google.com> <20180424145056.7c29ea18@gandalf.local.home>
 <CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
 <20180424151416.397fbbde@gandalf.local.home> <CAGXk5yriz2CtCN-vkL0q7gdpV+f8+9GJH-FT+v3KBLb-fWoCZA@mail.gmail.com>
 <20180424152607.71fbee34@gandalf.local.home>
In-Reply-To: <20180424152607.71fbee34@gandalf.local.home>
From: Wei Wang <wvw@google.com>
Date: Wed, 25 Apr 2018 04:53:33 +0000
Message-ID: <CAGXk5yo-9E7xOibMSWzPKgiduLrjzBA2+i0nhPNKiFnfyL7mUA@mail.gmail.com>
Subject: Re: [PATCH] do not call trace_printk on non-debug build
To: Steven Rostedt <rostedt@goodmis.org>
Cc: gregkh@linuxfoundation.org, Wei Wang <wei.vince.wang@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>,
	Alexei Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598692550101230043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 12:26 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> A lot of kernel developers use trace_printk() and I want to make it as
> easy to use as possible. I don't want to add a config to enable it,
> because that would be something that could be rather annoying.

> Let's add it to checkpatch and see if that can draining the swamp of
> abusers.


Currently I see f2fs trace is using this when having CONFIG_F2FS_IO_TRACE,
so I am not sure how checkpatch would work. How about we add a BUILD_BUG
surrounded by a config which would let us flag abuse easily on build time?

> -- Steve
