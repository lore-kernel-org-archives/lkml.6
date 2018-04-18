Return-Path: <jroedel@suse.de>
X-Google-Smtp-Source: AIpwx4/USQ+m1JwkVSv//vnABNr3OOxfw5AHFc0ZZ52V/B1QvwzJL827s5MFy0ulwneFi59YNxFb
ARC-Seal: i=1; a=rsa-sha256; t=1524036964; cv=none;
        d=google.com; s=arc-20160816;
        b=Fu3k8995DpFMldyTlpH7hqT/dFnD34oCv2F14jEY/OOgU9KX0rPFTF/NReHJzB8kHl
         rSCePfFzbuYTflAqqi2fbwyreJJOnbHNCtlxCFzhlzMVuhXCIhqZ6eZoins1YopgAmI3
         +Ozu5GPtKX4apVMftoV8kAtgojz9FFtzdNjcxbbutzEh8ToVlZjEeZt/aZ1zgHKOQi2G
         4m3iYHyntHaKpLxM6ZynpS5Bhrtsr8ej3TKoLX3ZuPUB6bTH5FGrabn/Yy6e1HgpJlP0
         k8Z+16er6QQHpelKzSJueF0HEMBECjW5MiCpEUoGtPMq+7etXvEszhri7C85NntPwzHp
         uN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=UQZZH1svp6rhZf0mhmGDfiD/yPiqCw+AxLV8Qgp3aBk=;
        b=tPQioYcOGB/GnpRbDB+GrGsEldvqLqVmgyiNU4yC55sqFCWSDJSprJ2HuX6k2f0fMe
         royp/NZ2begobLikkuMZT9XtmdnnOu58savngULLb5N+QVhM7KDKU/4fmXLCupBUrTt/
         XZc5TjMm3ofkf10GSOLXvbl+VSR22bGHc9cmNgcH1U0lWLPBA7Wg0OVDkytesuJ34f7h
         4P+wLo3JqBsbKbb3qvcQJZ/gs1WDehKMflRrPXBkXEM/tPlYVHP/o6CwTIMxhm777Ytl
         LryWWdnV45CWiK/arCibb8zwzK202MkoOaTxJuOfZPmy1LdbL9iRPIJUaexSa/gqV4JK
         c8rg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Date: Wed, 18 Apr 2018 09:35:58 +0200
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
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>
Subject: Re: [PATCH 00/35 v5] PTI support for x32
Message-ID: <20180418073558.mebtl457ss2rzhrm@suse.de>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
 <CA+55aFwGTOgSonVquab63PZG5z_NfgVF2A08iHaNeeqY5pdfnA@mail.gmail.com>
 <20180416160154.GE15462@8bytes.org>
 <CA+55aFzrYbTMXyZBVqRV875HwQJNxD+822RGeeDb7BLDLU8aWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzrYbTMXyZBVqRV875HwQJNxD+822RGeeDb7BLDLU8aWA@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916931664810234?=
X-GMAIL-MSGID: =?utf-8?q?1598068583678225784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 09:13:22AM -0700, Linus Torvalds wrote:
> See for example commit 8c06c7740d19 ("x86/pti: Leave kernel text
> global for !PCID") and in particular the performance numbers (that's
> an Atom microserver, but it was chosen due to lack of PCID).

Okay, I checked this on 32 bit and after some small changes I got
identical mappings with GLB set in all page-tables. The changes were:

	* Don't change permission bits in pti_clone_kernel_text().
	  Changing them does not make a difference on 64 bit as
	  everything cloned in this function is RO anyway. On 32 bit
	  some areas are mapped RW, so it does make a difference there.
	  
	  Having different permissions between kernel and user
	  page-table does also not make sense, because a permission
	  mismatch in the TLB will cause a re-walk, which is as fast as
	  not mapping it at all.

	* Mapping kernel-text to user-space on 32 bit too. Since there
	  is no PCID this should improve performance. I have not
	  measured that yet, but will do so before posting the next
	  version.

I do some more testing and performance measurements and will send
version 6 of my patches beginning of next week when v4.17-rc2 is out.


Regards,

	Joerg
