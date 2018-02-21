Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519232375; cv=none;
        d=google.com; s=arc-20160816;
        b=LTxFecSX1Y9Jm6cRC+hQLzlHdSj8kJl2l6LIFEe8b07c2pD5F3pN7VY2CGCntPlLBB
         tolH7vu6DUcZd8vaITVs6Jn29zKe/MYn72SIYB41BjDSzz/dTknmFTkQOdlN7nCqKuvX
         QHMFZH8QI/TQFnBvxxTeOd9FyHYwBpi3zd/6FjI318vbHB6SvKa65GRV6IyElBD+qMMi
         HEXDnkKep3e0Be/i1bkxYpf/o++Jogn6fJogblYHJMQBmWx1b/5N7gxTgmRtRzrRfTyU
         yOVep5h1Ovkz1dGNVSfXb+XBL1699W4rv9LlUFrNJ4gJurAQIwudWE5iSXAarjsLmC4V
         HTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=iRDddS1NJ8/xP9c6jG9+g75D5gu9aUhAWwtbrfgiDz4=;
        b=tS0AokE674MzD9BOile/NR0Hfas+9QxUzffPgT4u+rfRXcTgLkX+dXefAwjkeodKB0
         w6E8cXIH9uVuYt6k+3z18MdQpZHns+E99j5wOcYixhm5I8XhJ1obFHvsFFA7TKe+6aNa
         hUXhfsQ2R7dDb1wf1AVVWQEhoyof7kHG3J6H0N+kj3jAbrId+zU9TdppW75njCKCb7Lz
         g6FcZ4kyo5SNT5YN/DPgnurv4XcB7x4yBuYjW1R9cEDQ3Ztx+NOCXnP63J9D0CU55ciB
         M9rulaB5UYFWy4AAaYuQWhNm4vs4jGk0ydbGxaA7wNRFmeBxzDcrScF9TiqMz+ZzWGKB
         1oKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ItQVKKpa;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ItQVKKpa;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x227VAZvvs1Sou3+PHVWB6Gbh0o6KKv/VpjvigORyvY+UURd4htPxAQ01tXb+ciKY4bYvLnu6aQGKDf1WTWONsDw=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAKD1Yr2mgYZ7uFCQsQ9M5YMGX1LuhO0CQR6tLvQM=dND4RBrbQ@mail.gmail.com>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de> <20180210091543.ynypx4y3koz44g7y@angband.pl>
 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
 <20180211105909.53bv5q363u7jgrsc@angband.pl> <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
 <20180213085429.GB10278@kroah.com> <CA+55aFzLR2DbGnAKQwg79Ob9dpkOM1Z7bxkjyPBSp3Zdxmk5eQ@mail.gmail.com>
 <20180214085425.GA12779@kroah.com> <CAKD1Yr2mgYZ7uFCQsQ9M5YMGX1LuhO0CQR6tLvQM=dND4RBrbQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 17:59:34 +0100
X-Google-Sender-Auth: 66rCXRUi6JVvvw23OonjxkbKiKc
Message-ID: <CAK8P3a2iFfrH5B8sha7GMEPN-pv995X_1b6-Bo4h=wBLGhhUPg@mail.gmail.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Mark D Rustad <mrustad@gmail.com>,
	Adam Borowski <kilobyte@angband.pl>, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1593030607966941565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 11:26 AM, Lorenzo Colitti <lorenzo@google.com> wrote:
> On Wed, Feb 14, 2018 at 5:54 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > > IPSEC doesn't work with a 64bit kernel and 32bit userspace right now.
>> > >
>> > > Back in 2015 someone started to work on that, and properly marked that
>> > > the kernel could not handle this with commit 74005991b78a ("xfrm: Do not
>> > > parse 32bits compiled xfrm netlink msg on 64bits host")
>> > >
>> > > This is starting to be hit by some Android systems that are moving
>> > > (yeah, slowly) to 4.4 :(
>> >
>> > Does anybody have test-programs/harnesses for this?
>>
>> Lorenzo (now on the To: line), is the one that I think is looking into
>> this, and should have some sort of test for it.  Lorenzo?
>
> Sorry for the late reply here. The issue is that the xfrm uapi structs
> don't specify padding at the end, so they're a different size on
> 32-bit and 64-bit archs. This by itself would be fine, as the kernel
> could just ignore the (lack of) padding. But some of these structs
> contain others (e.g., xfrm_userspi_info contains xfrm_usersa_info),
> and in that case the whole layout after the contained struct is
> different.

So this is x86 specific then and it already works correctly on all
other architectures (especially arm64 Android), right?

      Arnd
