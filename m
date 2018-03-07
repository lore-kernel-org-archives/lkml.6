Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520382656; cv=none;
        d=google.com; s=arc-20160816;
        b=MTJeNIik4gzgJPit9KrC7dq4D4Vd5c2wsK+YydVkPvlsw3NwSrXApsD/kyM4CVeEH8
         z9B4pV/yIrBdAyN9Fgfu6MkRqnPvrTzsG7MmrCKmW3EutgsKEfqGL6E65wAcyEN7e7PV
         qO/qPBNRDGHbaji7ijZU8a+J7esf/So6Fa3IoL5SyxWoQsOnLl20cLdyvSl8SuE+z49P
         hhQNLHyc509Qcr0iX8vJnMFUFZfsuPJNLc0N4UVqpM1PNtt8NqwE9XQshg8EUC8vTp5K
         SFzM9XojzOvD+vfoJ0/d02A3IG7cTJeffwklQ6OhdVJdXEjcrm7+w5Y4FwpliZX+wHaI
         /w5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Y5CiQDT3VzA2kNY1pEiHnrmMfBEpjdyOA40aL+1xUcc=;
        b=L+uNAt1uqvMyJuVMjH5s9Ax10lRDsCNAmZIeFlWRA5xmmt8I7dbJfEQQYY+9zr+x44
         yPEx20pkCHHE/1YrA+8grON9A9DsZLIMjrEmZi6FDnxYLH6W5g8BMzxVB1ojRn4O2tSG
         stDdJJOp8NMw/P9n8ZQnkgqEZ1oLeffjGAAPOFW0J45JefDh7GzQWLvflZH1Os5R7ZsF
         Fvn00lDxAJqPH/WA5GaTUMhI3yLIW4tI+J+9Fw8moO6O2HYfjNgi1HnjcH+kyAIH2gfx
         5y9pLUOUaRBlizeZtZejt05Ez/BD+ge1iBkl134MP89X/jXwma0Aylyvhtf1y7gUHOtu
         R5Iw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=q5CO/jiT;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=q5CO/jiT;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELvN+9WtxFl1nT70vSLdhVqcFrY7IoR8mOEvpWUJ+zQmCB4/TD4OdCNtKxbh3hTT9Gw/I0KzQZQc+BZ8OFQpgHo=
MIME-Version: 1.0
In-Reply-To: <20180306233140.268BD8E1@viggo.jf.intel.com>
References: <20180306233140.268BD8E1@viggo.jf.intel.com>
From: Kees Cook <keescook@google.com>
Date: Tue, 6 Mar 2018 16:30:54 -0800
Message-ID: <CAGXu5j+LYqK7knp369PmWb00O2rRidyyS7q10NCgiobhCCbP4w@mail.gmail.com>
Subject: Re: [PATCH] docs: clarify security-bugs disclosure policy
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Andrea Arcangeli <aarcange@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594233094195809494?=
X-GMAIL-MSGID: =?utf-8?q?1594236764034969292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 3:31 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> I think we need to soften the language a bit.  It might scare folks
> off, especially the:
>
>          We prefer to fully disclose the bug as soon as possible.
>
> which is not really the case.  As Greg mentioned in private mail, we
> really do not prefer to disclose things until *after* a fix.  The
> whole "we have the final say" is also a bit harsh.
> [...]
>  ----------
>
> -The goal of the Linux kernel security team is to work with the
> -bug submitter to bug resolution as well as disclosure.  We prefer
> -to fully disclose the bug as soon as possible.  It is reasonable to
> -delay disclosure when the bug or the fix is not yet fully understood,
> -the solution is not well-tested or for vendor coordination.  However, we
> -expect these delays to be short, measurable in days, not weeks or months.
> +The goal of the Linux kernel security team is to work with the bug
> +submitter to bug resolution as well as disclosure.  We prefer to fully
> +disclose the bug as soon as possible after a fix is available.  It is
> +customary to delay disclosure when the bug or the fix is not yet fully
> +understood, the solution is not well-tested or for vendor coordination.
> +However, we expect these delays to typically be short, measurable in
> +days, not weeks or months.
> +
>  A disclosure date is negotiated by the security team working with the
> -bug submitter as well as vendors.  However, the kernel security team
> -holds the final say when setting a disclosure date.  The timeframe for
> -disclosure is from immediate (esp. if it's already publicly known)
> -to a few weeks.  As a basic default policy, we expect report date to
> -disclosure date to be on the order of 7 days.
> +bug submitter as well as affected vendors.  The security team prefers
> +coordinated disclosure and will consider pre-existing, reasonable
> +disclosure dates.
> +
> +The timeframe for disclosure ranges from immediate (esp. if it's
> +already publicly known) to a few weeks.  As a basic default policy, we
> +expect report date to disclosure date to be on the order of 7 days.

This seems reasonable. Though I have two thoughts related to "we have
final say" and why it was there:

Sometimes we get insane embargo requests, and Linus has wanted to go
public ASAP. The wording was chosen to let reporters know that it is
possible for issues that don't need to wait 7 days to not wait 7 days.
For example, letting security@kernel.org know about a flaw and then
tell us to sit on it for 2 months until some public presentation,
that's not going to happen.

Additionally, we frequently make all network bugs immediately public,
since the net subsystem tends to reject embargoes.

So, maybe we could be more explicit about these cases? Or explicitly
describe what "reasonable" means (it's only hinted at).

-Kees

-- 
Kees Cook
Pixel Security
