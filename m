Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519298283; cv=none;
        d=google.com; s=arc-20160816;
        b=nI1OecLzIJOzNq6gnABellZAg7qKKgkFkjFuq89zj68lZtNFv4utdSA7/Fiwo9RcAp
         CmI5HJrvGIkEVidNlcEYj/Em0sxsCkDo3sKr4psq8CVZyaLZngFU0oUxWdj5r/BnqYbu
         GbIELxm3ifDv+D27ymA+b0LMbh0KO7odtTqjMzyGvFUt0w71F/cLhHnHgAnBvEyelc4N
         mRYVzW1y4rF6XK6KUVUgLhwBkZFDZrX6dyjzjOFL/G2fPCaZZ0OROapl2UPuXzKlkWum
         rbKV99wrJPHWrJM3gqkThchYBTzvobb4zmgRIx8VDJmQ7aRDOZFcKj2vGFzovh9hbcEs
         Tahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=wAae8AJs73O+jWjWMS1OBeCNCKgWvFnqW6+Jb2/usQM=;
        b=hQim0UADysKub0Su1xFixCqDigNP+1XBej6BaKlFhDGGxrBr3gDBuw0qPsC5s56TXr
         aNvaFM0mBL8ZHPSlIVA/QtK2r9B3jv1ZW2OzZ65Ps7lcJVC+uUxbjz8lOuCLVAFc1Kbj
         PFTOJzZtuaaJ7pK/5Bhwn19EROOEO2lPPMybOztw32ttupK5FqiIevECo3Smm4lFeq0n
         /4z5nylaf5J+nysr2Mdjvi8+LWY69D80IovGR45JL/czIvM+rpXyf30NHngdrd6/2qsM
         itULhU3YWqcpoxCLPoyc0/2aCqgLjtdZ//2fqZ7T3Xy2mFFxiDgPBOiw59299fAXmi7k
         uZDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OBE34fbQ;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OBE34fbQ;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELug/e2t1Edal9cViDgk0B2dBWkfsjsIDIgB8DCJK8Mc3QE+MtOEZcSvr7JQgpK+dgAZk4HcrAga4OOT+I7Ch44=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180222111003.GB22572@kroah.com>
References: <20180209191112.55zyjf4njum75brd@suse.de> <20180210091543.ynypx4y3koz44g7y@angband.pl>
 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
 <20180211105909.53bv5q363u7jgrsc@angband.pl> <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
 <20180213085429.GB10278@kroah.com> <CA+55aFzLR2DbGnAKQwg79Ob9dpkOM1Z7bxkjyPBSp3Zdxmk5eQ@mail.gmail.com>
 <20180214085425.GA12779@kroah.com> <CAKD1Yr2mgYZ7uFCQsQ9M5YMGX1LuhO0CQR6tLvQM=dND4RBrbQ@mail.gmail.com>
 <CAK8P3a2iFfrH5B8sha7GMEPN-pv995X_1b6-Bo4h=wBLGhhUPg@mail.gmail.com> <20180222111003.GB22572@kroah.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 12:18:02 +0100
X-Google-Sender-Auth: gnjU4FpYP0kYtzfbBzM3LVxL1uo
Message-ID: <CAK8P3a3a-2FAZ0hTGwnQpREn5qov5jhWC_HrR0Vbf8X=EywBSA@mail.gmail.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lorenzo Colitti <lorenzo@google.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Mark D Rustad <mrustad@gmail.com>, Adam Borowski <kilobyte@angband.pl>, Joerg Roedel <jroedel@suse.de>,
	Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>, David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1593099716873664024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 12:10 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Feb 21, 2018 at 05:59:34PM +0100, Arnd Bergmann wrote:
>> On Wed, Feb 21, 2018 at 11:26 AM, Lorenzo Colitti <lorenzo@google.com> wrote:
>> > On Wed, Feb 14, 2018 at 5:54 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> >> > > IPSEC doesn't work with a 64bit kernel and 32bit userspace right now.
>> >> > >
>> >> > > Back in 2015 someone started to work on that, and properly marked that
>> >> > > the kernel could not handle this with commit 74005991b78a ("xfrm: Do not
>> >> > > parse 32bits compiled xfrm netlink msg on 64bits host")
>> >> > >
>> >> > > This is starting to be hit by some Android systems that are moving
>> >> > > (yeah, slowly) to 4.4 :(
>> >> >
>> >> > Does anybody have test-programs/harnesses for this?
>> >>
>> >> Lorenzo (now on the To: line), is the one that I think is looking into
>> >> this, and should have some sort of test for it.  Lorenzo?
>> >
>> > Sorry for the late reply here. The issue is that the xfrm uapi structs
>> > don't specify padding at the end, so they're a different size on
>> > 32-bit and 64-bit archs. This by itself would be fine, as the kernel
>> > could just ignore the (lack of) padding. But some of these structs
>> > contain others (e.g., xfrm_userspi_info contains xfrm_usersa_info),
>> > and in that case the whole layout after the contained struct is
>> > different.
>>
>> So this is x86 specific then and it already works correctly on all
>> other architectures (especially arm64 Android), right?
>
> Why is this an x86-specific issue?  I think people have noticed this
> with ARM systems given that the original bug report I saw was for an
> ARM Android-based system that had a 64bit kernel and 32bit userspace.

The patch Lorenzo linked to is only for x86, it addresses the fact that
the padding at the end of xfrm_usersa_info differs between 32-bit x86
and all other architectures because of the x86 specific quirk that u64
variables have 32-bit alignment.

xfrm_usersa_info should have the exact same layout on arm32, arm64
and x86_64.

      Arnd
