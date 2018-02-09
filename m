Return-Path: <jroedel@suse.de>
X-Google-Smtp-Source: AH8x225glL8ck4qXeiQCVHbcv/9oVtK+CFryBYz1BTbTE6haMnwIzMw0z3B5P4/p4zxmLroN5yW2
ARC-Seal: i=1; a=rsa-sha256; t=1518203474; cv=none;
        d=google.com; s=arc-20160816;
        b=g8g2HjZak8VVdiqjFExuj/AtCWdUT1mHddtUlqqpsmcTmTB/cYzVnz2BSBiDAJ9QId
         5GSiuIWN9V6C4fL/das/uCooSC7m+e7H8YhKwnpcNEQf8/iLBvbseAnPPFoi4EzPduZB
         KE/GIEIWP2WnXx07t2I6MFkS483Q99PRV9WA84yKB5Ltxh11bTKnnqww2MmyTAhvod0x
         myQe2CsVbKuzvKOZm1klr/XlU4IDAufMJqNKy+nQDdfdIvpdIexgJcP5pLi/j1cXUx59
         oR98DHr9/ewTjkg8pSZFj1A9r4InSgkzrKaMGzvm4K7hkSd5get14+CwMIRp351mfk6s
         KLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=azXwY9RyUaYbmWKfznHnQqfQN1l/6t1fxID1wxI4DpM=;
        b=pSwKE7z9RN0lbuE9A513Rr3IkUdKNZYBnuKE2fAAMaSNX2famI9QU4YWMrV451+CuH
         TkCuqwlXmQhFE/PTSYOET/oCJyRaVT6qoN8em6kvwF6Bvp7PddXZjjjxcbChwmcRSvDU
         raDu7JbFUaW8wi8iViFZ/ooaJ38FQ+tsSTZkDPKCW3f9uksvME1ar1k9UQo29i/0HhAv
         23e+Lt2bz/zbGl9x/GZoUPbxJI+T4Ol1WkDxVzixeZvY0f0vup7Blb/4GfNTQIrH3wRp
         56qYAGnypYhmkD4mRxvyhHGnIfRS/hLX8Hdh0+D0z4n3Do0tNI/y9Rj6GvcxXrQRpeTR
         fc8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Date: Fri, 9 Feb 2018 20:11:12 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Message-ID: <20180209191112.55zyjf4njum75brd@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1591951726818174621?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andy,

On Fri, Feb 09, 2018 at 05:47:43PM +0000, Andy Lutomirski wrote:
> One thing worth noting is that performance of this whole series is
> going to be abysmal due to the complete lack of 32-bit PCID.  Maybe
> any kernel built with this option set that runs on a CPU that has the
> PCID bit set in CPUID should print a big fat warning like "WARNING:
> you are using 32-bit PTI on a 64-bit PCID-capable CPU.  Your
> performance will increase dramatically if you switch to a 64-bit
> kernel."

Thanks for your review. I can add this warning, but I just hope that not
a lot of people will actually see it :)


	Joerg
