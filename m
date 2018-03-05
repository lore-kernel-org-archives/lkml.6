Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELv/zIdrIxpj375GQnct2iPvrwNKAuCw9jxr4XLL2WMfzykDGNeTiQSpbjEQvJZW7JWM3ryf
ARC-Seal: i=1; a=rsa-sha256; t=1520255553; cv=none;
        d=google.com; s=arc-20160816;
        b=jTjxl5qHlBQCFx+4RiJP9eFszPUiMC8RuXlcw1ZweNpKrm7WWnPDWPPBJkDgp6uy0G
         lcb4ShQVhXMalgpt8qZKDZ0gihLd+NGIhg/o4hUWMow+grA5mJ/x+qTzpel4Ew34jMdW
         XQWHilKxFV0OvGOTeKL8TrYdrJRMNopEEo7jYwL4yngyQ/A64UqeJvajU8oPg7SDB8DS
         QDJ9ArywHtQVAefzRUWiT9lHL+LXlwiGzYilBJCseUUKq53tl1YJpwVcYT6N8inucd95
         diacIOtU6gTZe2TfNuP7ac9J2gVJNfpeUTWiX9edUFpKjzMWDVI4D+EdceH6COSr17nC
         1CwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=XxIulT4VrEFFKJA5L7hLUUdlDCW4p4d0a9aTtMMuCiU=;
        b=xJPdH5VGYHeFBqsU/taHsF1tl8HSMgR+4NkTLOzlbn3EMzBvatCPlPGORKgtO1xcGT
         hOTZxdNqtI071Swe7D3qBrFtdSsVzsnJI/gmbLbDbPK7poLOkRsb5umA21gUpLDlxfHn
         ohI9hzLQwikvO9+lFq4hZKa/xnkr2X/+HfEhODFctrUxF2Y5V1VGdoLTkF3hrvvH1tnn
         wNkOgmZLJOC3RzUq91T34uvjrWati3nfXmiwQ9iGmp8RgJF4Av8TtJeyqyzlz5lcpgnY
         jsYgQxRysK+cN5MArZ+eUSJQySBi+PW/LzWRawj1kjhLjbPOC4l9idaqRkGhZW1yn1uz
         5Hsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=qPS0uSgH;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=qPS0uSgH;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Mon, 5 Mar 2018 14:12:31 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Peter Anvin <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	=?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
Message-ID: <20180305131231.GR16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org>
 <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594103486018323270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 04:17:45AM -0800, Linus Torvalds wrote:
>     Restoring the segments can cause exceptions that need to be
>     handled. With PTI enabled, we still need to be on kernel cr3
>     when the exception happens. For the cr3-switch we need
>     at least one integer scratch register, so we can't switch
>     with the user integer registers already loaded.
> 
> 
> This fundamentally seems wrong.

Okay, right, with v3 it is wrong, in v2 I still thought I could get away
without remembering the entry-cr3, but didn't think about the #DB case
then.

In v3 I added code which remembers the entry-cr3 and handles the
entry-from-kernel-mode-with-user-cr3 case for all exceptions including
#DB.

> The things is, we *know* that we will restore two segment registers with the
> user cr3 already loaded: CS and SS get restored with the final iret.

Yeah, I know, but the iret-exception path is fine because it will
deliver a SIGILL and doesn't return to the faulting iret.

Anyway, I will remove these restore-reorderings, they are not needed
anymore.

> So has this been tested with
> 
>  - single-stepping through sysenter
> 
>    This takes a DB fault in the first kernel instruction. We're in kernel mode,
> but with user cr3.
> 
>  - ptracing and setting CS/SS to something bad
> 
>    That should test the "exception on iret" case - again in kernel mode, but
> with user cr3 restored for the return.

The iret-exception case is tested by the ldt_gdt selftest (the
do_multicpu_tests subtest). But I didn't actually tested single-stepping
through sysenter yet. I just re-ran the same tests I did with v2 on this
patch-set.

Regards,

	Joerg
