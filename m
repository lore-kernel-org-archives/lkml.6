Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518205740; cv=none;
        d=google.com; s=arc-20160816;
        b=LAPcao1Bqf1bjLeG3nbiWs4rHUu95qhvBtJvdXiy8n2WXMvFGNbKh7c4wCl2zXzgJI
         AMHZlwdJRYfGNvMQu+ipkqM/yb1IqVdHI6Db6OJkuzYzK6tttqkCCXIKJxmiVs7CWFSt
         vWJ3vJqJd3fAxqVrfA/HkBEYsQfjGOXjq2uzEdnzvRqqnnPwsh0RmvDhPK+/mkhLwbFD
         lEQ6chpzvYWlpbBaiQrknZ7zDwtRcBEbugwnkOGDenoMDevvpBWFrva7fDeuJZ/XJlr+
         tq/TzlI068UluRAiq2ITe3EQrxQsFw98yHDWrI5lC9rXjTMZRzMRL/LTo5dQC30xRwgv
         vIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=EFlLQ2p3OSXgAgYao0PBlpZ/kGPxVDFi6tK8egPI5eg=;
        b=hsWaKdJrO+kEwQI9FeHz8wN5RX9sniNQOPQ+9AFToOZcV7IVXLyBJGomsxLnXLR8PP
         T6n37aRaibGXXjHVoUEe926pwnlBuY4LEH1kIuWHjL5U73L/16hM9Ub7tAKgqS2HUBR+
         fDzvVrwnh0fO6xDEWHcI57zG/NpxZ6MmL5iMucDY9S7WUWLD8rJ9uWxWO/AFGkpWQ/oe
         5WZxgkOReWxu80JeeQf5IVyBHotJMWt3+L4lTAZ2fph1Y2Q05mDyWtwJ5E98E7SeQm20
         lq2PfWWQKSe+Ib4+SoL4s12FyIA+styBFwJ4z/0BBjmeBqKdebXwCabwbJS86JcaBJ84
         ECIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T450Ypou;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T450Ypou;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x224VYJXOtmAJjlZ7KL5A/F/d4eJama6ToiS6+6m67+2V0qYMitb1gIe0L+0ypilGCg8W0+u6h9b7PamU7K4FaOk=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180209192515.qvvixkn5rz77oz6l@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-10-git-send-email-joro@8bytes.org> <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
 <20180209190226.lqh6twf7thfg52cq@suse.de> <CA+55aFzy6ZJDUpgHY0J2_z4kODaiYPgyHuOsMGiXmrhgR3kyPQ@mail.gmail.com>
 <20180209192515.qvvixkn5rz77oz6l@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2018 11:48:59 -0800
X-Google-Sender-Auth: bACYifX2rINesSfjpji2yhbwHxk
Message-ID: <CA+55aFw643jQxVDrm05ZJ6YkVdqBBJ8WH-+=QCx3SDXrVN-TxA@mail.gmail.com>
Subject: Re: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
To: Joerg Roedel <jroedel@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, "the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1591954102160267548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 11:25 AM, Joerg Roedel <jroedel@suse.de> wrote:
>
> Ugh, okay. So I switch to movsl, that should at least perform on-par
> with the chain of 'pushl' instructions I had before.

It should generally be roughly in the same ballpark.

I think the instruction scheduling ends up basically breaking around
microcoded instructions, which is why you'll get something like 12+n
cycles for "rep movs" on some uarchs, but at that point it's probably
mostly in the noise compared to all the other nasty PTI things.

You won't see any of the _real_ advantages (which are about moving
cachelines at a time), so with smallish copies you really only see the
downsides of "rep movs", which is mainly that instruction scheduling
hickup with any miocrocode.

But with the iret and the cr3 movement, you aren't going to have a
nice well-behaved pipeline anyway.

                Linus
