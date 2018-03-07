Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520464464; cv=none;
        d=google.com; s=arc-20160816;
        b=Ohc0ssLAQt450IGkVdViXHiWO5SCLKNgjOEdE/0rn25xuNHrSKy7/q8sj8qKtQ3yZS
         g8nXNHEoOskfFkN7BCcvdxaiECXqZ85xrkBEIJVMUVvbmTF1RB9Izpid8AiB9GQewFPg
         fkrPaP/Z4qgtJ75hKeRoi3YfCa+ghyqu1uvHxstOF0HKqO4WF5+lVYnce+QzCuVUsAFa
         c2kh1L1wCEQrlRmU3Ex5WFAaKl4KVDMWRkWyYzS6dZdZFbxNd+FoslSkJ7Qp0SBwJK8/
         4yyPZRXlBO4gzEwjdG4j1afkG1XDMFbEd/SDb85SaS6+92QOFstm0hTlO8pvYxvk15tM
         X3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=MFK8wB1IAOOFV4ANHaTa/EhS+6LTQz5ihz5SEVNSRJ4=;
        b=rjBajZFwgV/Nan7h6en/AJbhk2b0+7OsW6FanJj3tntYUA+YCGW40W1xykNASgugyZ
         scwk63f0li+TFAwGnedtTHva1l4nbLg0GIFqc6HkveNXgtRge7ekPOO3WdlctdBdgLlI
         JkkBJRLwMfCpm7Sv3ga0is6d9JKjrUH6XF/xtsfDu2Fn55qnkvuzqQd0WhWGibqbaSAc
         2qnJ0qrX/PQ5zyuKs/9930fX0CLIx5ev4yeRF44e8NlJjhj6gmonA3yV5A1FDmL4px6T
         l6plzQFj9nFhNy7YAUpWucrGgfPzzGdwkf50voMQPiYV/+j/1uYLPCExH3PJWIrXLT2R
         EqLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mU79a+Zs;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mU79a+Zs;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELtEiAfJksJxbiHwxx/yK5ER1fLNpGuIj05dc2nj8DvsYSjoBx+cUm4w1AMHiNR5R/bdRvg9HLI0P52lpn0JSpk=
MIME-Version: 1.0
In-Reply-To: <20180307214624.D4361772@viggo.jf.intel.com>
References: <20180307214624.D4361772@viggo.jf.intel.com>
From: Kees Cook <keescook@google.com>
Date: Wed, 7 Mar 2018 15:14:23 -0800
Message-ID: <CAGXu5jLy9jNW-M3sC9-hy3+QFMHyzgo8frEnFCL6nnL9Yp-WKQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] docs: clarify security-bugs disclosure policy
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Tim Chen <tim.c.chen@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317071955827625?=
X-GMAIL-MSGID: =?utf-8?q?1594322546549307847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 1:46 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> I think we need to soften the language a bit.  It might scare folks
> off, especially the:
>
>          We prefer to fully disclose the bug as soon as possible.
>
> which is not really the case.  Linus says:
>
>         It's not full disclosure, it's not coordinated disclosure,
>         and it's not "no disclosure".  It's more like just "timely
>         open fixes".
>
> I changed a bit of the wording in here, but mostly to remove the word
> "disclosure" since it seems to mean very specific things to people
> that we do not mean here.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@google.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>
>  b/Documentation/admin-guide/security-bugs.rst |   24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff -puN Documentation/admin-guide/security-bugs.rst~embargo2 Documentation/admin-guide/security-bugs.rst
> --- a/Documentation/admin-guide/security-bugs.rst~embargo2      2018-03-07 13:23:49.390228208 -0800
> +++ b/Documentation/admin-guide/security-bugs.rst       2018-03-07 13:42:37.618225395 -0800
> @@ -29,18 +29,20 @@ made public.
>  Disclosure
>  ----------
>
> -The goal of the Linux kernel security team is to work with the
> -bug submitter to bug resolution as well as disclosure.  We prefer
> -to fully disclose the bug as soon as possible.  It is reasonable to
> -delay disclosure when the bug or the fix is not yet fully understood,
> -the solution is not well-tested or for vendor coordination.  However, we
> -expect these delays to be short, measurable in days, not weeks or months.
> -A disclosure date is negotiated by the security team working with the
> -bug submitter as well as vendors.  However, the kernel security team
> -holds the final say when setting a disclosure date.  The timeframe for
> -disclosure is from immediate (esp. if it's already publicly known)
> +The goal of the Linux kernel security team is to work with the bug
> +submitter to understand and fix the bug.  We prefer to publish the fix as
> +soon as possible, but try to avoid public discussion of the bug itself
> +and leave that to others.
> +
> +Publishing the fix may be delayed when the bug or the fix is not yet
> +fully understood, the solution is not well-tested or for vendor
> +coordination.  However, we expect these delays to be short, measurable in
> +days, not weeks or months.  A release date is negotiated by the security
> +team working with the bug submitter as well as vendors.  However, the
> +kernel security team holds the final say when setting a timeframe.  The
> +timeframe varies from immediate (esp. if it's already publicly known bug)

Nit: I think "a" is missing. I was expecting: "... already a publicly known ...

>  to a few weeks.  As a basic default policy, we expect report date to
> -disclosure date to be on the order of 7 days.
> +release date to be on the order of 7 days.

Otherwise, yeah, looks good.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
