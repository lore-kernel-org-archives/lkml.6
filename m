Return-Path: <kernel-hardening-return-13042-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48tyTgtf19Z59noEgMO7Ud4rRpe9sQimTEq7oh4Y5bKV2vjP57UpNXYTWtGX9J9x9g+GZEW
ARC-Seal: i=1; a=rsa-sha256; t=1524071046; cv=none;
        d=google.com; s=arc-20160816;
        b=ZDXRlzrPdtBGEgC9w1OHQwypPJn4e8i+K2Ki+enUBjfvJQuP+pmYQ2ESGDwIZLun58
         dwJ2LM8a7/1jfm3KXtNqpXENwqGB2pqmhRG+sooU8Isx7OJL8usZzd/eYIeB7p3MHSB1
         ODkBOnfiT5HLhTloQKdHrXP5mCRdx4PDTnSIEAdwaycFIy1y8N3Oiq0e38Cdw/BjCUb3
         fUgEQzE7eVtWrI/2SmCB6MMvOSmlgBv2zCXo+3PeOKvM2oDOH1MgC7WPgW807vmjvxmR
         cEgL7qA5vfs2eSaPIBezGgQ4u4Opo4kPHgs1l1bMchhdXHlovuMlnoPpEHOvyVSKL6PH
         xyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=evKKgrUUPn6Gqz6WdbnwZrKq/W3j/ocagj6JP060MWE=;
        b=IJW33raAQhTZyDlskYBeHCQ9Uj0++uhmyE60V90t/ka7SafAsUDIfV39iG/ziwfa31
         23nIyDAY3L0z+mH98FKt0FxuecZIDceJPSwkMlLBrxNb6s4e2uIF4g+E0GKszilUzfGf
         12kqJBXzLNs92qAJN6/5baIn99CDU54G0lv7ytZCFhwS6uvZL5S8pDX5jarWth200sWd
         9bQifqhqeBcbB42K8uXT8/MWfKstRMrhR2zBKcLVbDnjrKx4z8/DKL2kukMr3D8ZRYvO
         Hx2+qYvEHhnGFds6G4+VJxAFVJHmjE5w32o+q0OSqWUEbpZDAlU5WRBDDXgjU4i7S1EY
         oR4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ayiGcONY;
       dkim=pass header.i=@chromium.org header.s=google header.b=KAK3r3Ue;
       spf=pass (google.com: domain of kernel-hardening-return-13042-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13042-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ayiGcONY;
       dkim=pass header.i=@chromium.org header.s=google header.b=KAK3r3Ue;
       spf=pass (google.com: domain of kernel-hardening-return-13042-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13042-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180404214007.31a5fbc6@bbrezillon>
References: <20180328205138.301218351@linutronix.de> <20180328205554.666762229@linutronix.de>
 <20180404214007.31a5fbc6@bbrezillon>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 18 Apr 2018 10:03:44 -0700
X-Google-Sender-Auth: hKjbu5eJYfJLTgtXclFmRttKHI0
Message-ID: <CAGXu5j+rckvb94YhdqUhRhuG=RtjN+S9QArAhwVWPj8mbPom+w@mail.gmail.com>
Subject: Re: [patch 5/8] rslib: Split rs control struct
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Andrew Morton <akpm@linuxfoundation.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>,
	David Woodhouse <dwmw2@infradead.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
	Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596216529331204918?=
X-GMAIL-MSGID: =?utf-8?q?1598104320962237012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 12:40 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Hi Thomas,
>
> On Wed, 28 Mar 2018 22:51:43 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> The decoder library uses variable length arrays on stack. To get rid of
>> them it's it would be simple to allocate fixed length arrays on stack, but
>
>        ^ s/it's//
>
>> those might become rather large. The other solution is to allocate the
>> buffers in the rs control structure, but this cannot be done as long as the
>> structure can be shared by several users. Sharing is desired because the RS
>> polynom tables are large and initialization is time consuming.
>>
>> To solve this split the codec information out of the control structure and
>> have a pointer to a shared codec in it. Instantiate the control structure
>> for each user, create a new codec if no shareable is avaiable yet.  Adjust
>> all affected usage sites to the new scheme.
>>
>> This allows to add per instance decoder buffers to the control structure
>> later on.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  drivers/mtd/nand/cafe_nand.c    |    7 +
>>  drivers/mtd/nand/diskonchip.c   |    7 +
>
> Don't know how you want to get these patches merged, but the NAND
> related changes will conflict with my nand/for-4.17 changes (NAND
> code base has been moved to drivers/mtd/nand/raw).
>
> The rest looks good,
>
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

Hi, just checking in on this series. Thomas, what's your plan for
merging this? I don't see it in -next yet.

-Kees

-- 
Kees Cook
Pixel Security
