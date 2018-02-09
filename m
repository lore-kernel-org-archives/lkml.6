Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AH8x226ZZG0mvdCPemBsxszJrzpXpuAaO7iHPAgIfGTu3f9OA7Kqa76lJTiHrptdJZmODBl08Bny
ARC-Seal: i=1; a=rsa-sha256; t=1518198172; cv=none;
        d=google.com; s=arc-20160816;
        b=WmgX1Gu2hJxRONEX1gKHRomTyLgdatt2gQ8PiSS44nqx322tnKoFdRutet8x9y7BlC
         sgaDaCYMiw988Fq3QZKQUxmGJXfWm4Q7xVzDfJG8sbBC/X1ESR3Curw8ZFhNoof4keeH
         hjysMVKO34cwwUZPMWaw0gioUE+anc8HtUnU4msqj+aZbklIxcdKhGcYnalfxh5hJyl5
         KrM3eIDbl7z7+zGz+rcI1fkq0NLwrApSUNwmJOgH975p96o1gfVJVTTEq8/fpbQYt8vX
         +eSHEMSWzRJ+vf6bZoCqLvMbsnS/NMMr2iBD481M1qmeW/ASNrCW3jyJUEO7dwWXV+qp
         uXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=LNDi65YTG2PWijQEO0avlA7rVCK7Otl7PXNEnA2IgN8=;
        b=f9bjrG/JZpdhyHFPq2lCMPdCiI3uDrvEbbz/SDNhJq8ka4TqFbHQCN6gtE+EU8mss2
         D+ncT5rE+B0QRzE+ejbYzhSb0oi3yq4YFxR/D8KYrTM7hwR/BCI4WJbkfwX1rr2aPxK3
         XXAW1g5JROIqpCDpefAXUqreK1JrrXnb9pgPHudY5d9XEgnjEpNK417Dfh0LliMDgm6o
         ZA28JmC1zTiI5teanLDQ6zjKdz9kOudmL+LL9yTGHKWD632wUC4wQlXZR7MpiRb+4TF/
         w6kPWYTkWDBypcF1BHw3b6wKCXaiHmVt9pAj+KfLQDSLqRtRmqKn92YuOhlyHkxxolbq
         l3yA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4995A217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <1518168340-9392-24-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org> <1518168340-9392-24-git-send-email-joro@8bytes.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 9 Feb 2018 17:42:18 +0000
X-Gmail-Original-Message-ID: <CALCETrV14cb4sosu8T_ZtL3cbb6cCV52uHr3ZKBqZ5+TjqZf2Q@mail.gmail.com>
Message-ID: <CALCETrV14cb4sosu8T_ZtL3cbb6cCV52uHr3ZKBqZ5+TjqZf2Q@mail.gmail.com>
Subject: Re: [PATCH 23/31] x86/mm/pti: Define X86_CR3_PTI_PCID_USER_BIT on x86_32
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914909315393823?=
X-GMAIL-MSGID: =?utf-8?q?1591946166723676796?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 9:25 AM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> Move it out of the X86_64 specific processor defines so
> that its visible for 32bit too.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
