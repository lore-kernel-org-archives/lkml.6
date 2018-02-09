Return-Path: <jroedel@suse.de>
X-Google-Smtp-Source: AH8x224LN2DXGASAdBkMNkf45lUubZwtV/7AjRYACS6bJbbS/uQ87kmG7MEPAI8e3YVi6pbZa3dY
ARC-Seal: i=1; a=rsa-sha256; t=1518204319; cv=none;
        d=google.com; s=arc-20160816;
        b=tnApWXKCQ1qDBu19uj3PMU2JE+KkAAq4+nV6/5Rne2+VvxHqKVuWMmES+6psyZVRMm
         3faoG8/CqOzH2vWIJGHCLzkXDddl3xOJyinRG50s9RAwrbLuT01UMh5DTmAoW/AJgatK
         ioImvUVggSKhGPLY0jYwO8HTQaVWuYNYLoHY6NaPY7aQa25FEijtpBWREz5FWNHkW8wa
         VduLubIhrVmpd5yAA+ChDgWRB1zx9D37wXm8UsFlmGQ3CsAJ4eQVCWDaBKvftUaRli0i
         w2nKLqBEUdf4FJT28F1dpSKo7E0N72ARo2Safb0nl4Ttd8Q0bnYGj9pD5HUbWmxBYkRa
         g7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=tcyBh9iBJggDEHga432MJTEoI3rhExNNbf5gmkfUZeA=;
        b=hNytsRAwaY9aSm6Q7vBjTRq+9Wqisgt5wqd0oHYQ45cva41EX4vIqyqLw2CPlRzu67
         FHg7AqSXdMP4II+4h+djjgCounvx4NpaDVa9gA11uPPDPxtMkQIqUCLDGGg+e0r0RD4A
         l5olFhoTk0QlzoZ7HQ33g/TBW9bW2W7iTIVFXSgvG8D6wlzItDo3MSxiNsPKPQmhx7gL
         tqEW0MPZ3Ww7NVT334bZ9v+Pz0udTuXQRMFDOuvnIwXiKFznsaTDDQA2okafkhkzQmF9
         1T7wgygfbdTPBKBfcys8F/Qr4Z8jUDhH8e6EhPfu2F1aYSBPw34Do49zFSOq8U9sByeM
         oo+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Date: Fri, 9 Feb 2018 20:25:15 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
Message-ID: <20180209192515.qvvixkn5rz77oz6l@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-10-git-send-email-joro@8bytes.org>
 <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
 <20180209190226.lqh6twf7thfg52cq@suse.de>
 <CA+55aFzy6ZJDUpgHY0J2_z4kODaiYPgyHuOsMGiXmrhgR3kyPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzy6ZJDUpgHY0J2_z4kODaiYPgyHuOsMGiXmrhgR3kyPQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1591952612837561293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 11:17:35AM -0800, Linus Torvalds wrote:
> Yeah, it's only true on the very latest uarchs, and even there it's
> not perfect for small copies.
> 
> On the older machines that are relevant for 32-bit code, it's often
> tens of cycles just for the ucode overhead, I think, and "rep movsb"
> actually does things literally a byte at a time.

Ugh, okay. So I switch to movsl, that should at least perform on-par
with the chain of 'pushl' instructions I had before.


Thanks,

	Joerg
