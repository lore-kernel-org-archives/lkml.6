Return-Path: <kernel-hardening-return-12743-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv9NbPI2fXy+H/yk4jgpJ+zUWv02PO5qD0L7rj98KA4FFyCeeH6deI3nivzHYRGMhJuzQr9
ARC-Seal: i=1; a=rsa-sha256; t=1522106296; cv=none;
        d=google.com; s=arc-20160816;
        b=S9Z41IyVAelUhZQWIDfRR4NuvpNsVyLGpSdgOQuYSLV8VAOSmydGBbKKdzdfdKxGiX
         m3uPYiw5v6D0kQK3a+dmyAmW100lr4GME8m9Hrd70GEiaRdlPLSCEiK48AptgerCc0+a
         VJhpwXcWRZmlrxTDoV6MqrqBWVOk/Dw59hXhKPhVUBwWfM6TyvE5XaVfaX6V4W56hW2M
         azLoaNVNyLH/Ax9MrJ9c09fp9z0HoIQBZjbPuq3SJofCQhW6RGBaGjo14S+fzzfUm+nL
         +SxpQ/8ajrY+hEVEYaCNky5vovxcnIHnsNHd6pitxwoQExF6oiYeaCUOEk+BHPG9Vcup
         gK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=CpwJlHjyWvEbtNPo/Oqedsq+G48OKRmp3eH7U1KL62I=;
        b=NhgKpUtn1i8thVBzmAHTUiWSUWECGeJSpzKnE0xvutgzFoqpXwniQIEGna6+SipHtx
         zTH6Ou6AraDNzxxuuJD/6AWR7UJhFFIW6KZD6KXjEo8+c6zjqp4unj2rbIcKCxhuVrAA
         A782awoOcOEu+QC7cg8iQTDttmH7vKsdLBuSdiDpkbljQowr+LXCqiqM4rsa0NPrSydj
         CdKUgsq9c9qZ/+XCny65IEp9/B2OfbifCcRqy+JRn+oRoa3JkUsP1tPUBIGI1quw/P5f
         nIKuf3bNrg0h67tuDA2qYXjMDycOmhkwXsbSuRCh9ky0eixlSTMXYH2cKGQjg3QTSbWX
         4WXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Wq/f9M4f;
       dkim=pass header.i=@chromium.org header.s=google header.b=jnoPvtM9;
       spf=pass (google.com: domain of kernel-hardening-return-12743-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12743-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Wq/f9M4f;
       dkim=pass header.i=@chromium.org header.s=google header.b=jnoPvtM9;
       spf=pass (google.com: domain of kernel-hardening-return-12743-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12743-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAGXu5jLAqki8oE7AF9BEwLxKzpTOOPsT1imjdSAG_U44uGXJdQ@mail.gmail.com>
References: <20180315225919.GA43806@beast> <20180316155950.35fda7c63ec59277ba504201@linux-foundation.org>
 <CAGXu5jLAqki8oE7AF9BEwLxKzpTOOPsT1imjdSAG_U44uGXJdQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 26 Mar 2018 16:17:57 -0700
X-Google-Sender-Auth: sUQPgQUwBndWSMVseaJzJuew7SU
Message-ID: <CAGXu5j+utmcN_ot-3NJ-8C0onnu8O-DOdbAxVoatzE9UcJ-O4A@mail.gmail.com>
Subject: Re: [PATCH v2] rslib: Remove VLAs by setting upper bound on nroots
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Segher Boessenkool <segher@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595046396754035881?=
X-GMAIL-MSGID: =?utf-8?q?1596044132215360443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 11:25 PM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Mar 16, 2018 at 3:59 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Thu, 15 Mar 2018 15:59:19 -0700 Kees Cook <keescook@chromium.org> wrote:
>>
>>> Avoid stack VLAs[1] by always allocating the upper bound of stack space
>>> needed. The existing users of rslib appear to max out at 24 roots[2],
>>> so use that as the upper bound until we have a reason to change it.
>>>
>>> Alternative considered: make init_rs() a true caller-instance and
>>> pre-allocate the workspaces. This would possibly need locking and
>>> a refactoring of the returned structure.
>>>
>>> Using kmalloc in this path doesn't look great, especially since at
>>> least one caller (pstore) is sensitive to allocations during rslib
>>> usage (it expects to run it during an Oops, for example).
>>
>> Oh.
>>
>> Could we allocate the storage during init_rs(), attach it to `struct
>> rs_control'?
>
> No, because they're modified during decode, and struct rs_control is
> shared between users. :(
>
> Doing those changes is possible, but it requires a rather extensive
> analysis of callers, etc.
>
> Hence, the 24 ultimately.

Can this land in -mm, or does this need further discussion?

-Kees

-- 
Kees Cook
Pixel Security
