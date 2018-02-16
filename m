Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AH8x226qEhF3HWPShFPlS/wcsPpIfQ5dQ0yNrjJaluV9lUaS9kKyAzq2Pjlo/24egrULZicR9YxK
ARC-Seal: i=1; a=rsa-sha256; t=1518771481; cv=none;
        d=google.com; s=arc-20160816;
        b=OzbUmyKJ/RGf21FB+hbkQSQiZGFV/rZE5McHgHJYErR/FcrhAAZR3I5d1z4NvdQycJ
         mLX3KrlPUVH1B5zVELWyfj6o+NAwcT6Xrwb6juf91v0K3d3nJLtKB+2LSWUA2HKy1lIv
         BP5+XJ6HA+7mFqETyBt/sO/Xoon84zze2Uc03S0eNdABfNKNTJRsacDey/wp6GefMdah
         7OxEHUdr+QDmvxDD8lMP+b9Xh/apWTL3HgwgmemrazhaNdKqK3Xe0vSrEeF3ywSJ+COz
         cOyrHD7S+6MNjWAxGc/lE2tiTdP2XV6HNkP3y5OND/W9XJj0jCNMb4+J+H3UwS4j6FuH
         OTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=Q5LVtdY4y82x/VYKYZGdizsWaAXSplJRerx7YEUT6iE=;
        b=hjpJG6TCyAkEP+KSm6Me7KHBHCex/ZpbZLCHrNy1o+iPqhG76SriIsnOsYvnfueMs+
         i3Z7NoXgruFIMIeEWI9S3AgFzWBbppDHTLwqGAYrIRS/ysH7qYW8EHpjTu1A6guu5tr2
         XHxF/RXXBvvJFt4h8xzHkW7ovSw2qJdpk1jt7w1hvHag4yFWVm8utGL5rkBjrKULifRg
         cnxkf0Xonm243JtnggT5wp0d8ZbJr3/7wjkBDkqEOh5KgJr4bS1+HX88FW/wfQ/TcSP4
         Ey81SBo+eMoaejPj0zA4RFYOFFliUrcI6jyxPpL7s7fXWTGc8+jL5AmlzJipMotW0vlv
         Wryg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Fri, 16 Feb 2018 09:58:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"riel@redhat.com" <riel@redhat.com>,
	"keescook@google.com" <keescook@google.com>,
	"gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>,
	"pjt@google.com" <pjt@google.com>,
	"dave.hansen@intel.com" <dave.hansen@intel.com>,
	"jikos@kernel.org" <jikos@kernel.org>,
	"gregkh@linux-foundation.org" <gregkh@linux-foundation.org>
Subject: Re: [PATCH v6 11/10] x86/retpoline: Avoid return buffer underflows
 on context switch
Message-ID: <20180216085800.GA7616@amd>
References: <1515363085-4219-1-git-send-email-dwmw@amazon.co.uk>
 <1515455051.15588.7.camel@infradead.org>
 <CA+55aFwJLjNTDXBo-OkBhJ7ddrY+30MZY_HiY6TAc_tJNaL9-A@mail.gmail.com>
 <1515455902.4423.59.camel@amazon.co.uk>
 <CA+55aFztN+nGBnb1Wjvygvgkg2MfN9m88egsostaNJ5LoSQx7A@mail.gmail.com>
 <20180109004415.GG6718@tassilo.jf.intel.com>
 <CA+55aFy3sCY5xUwZtOYL1MLhRwYe1sU=5d8sWPZqAnEZ71u8-w@mail.gmail.com>
 <3aadb8a0-08c8-bdf9-7b91-0fa774a9e1ab@citrix.com>
 <FC895787-D674-4BC5-B660-DD946EA9825A@amacapital.net>
 <1515503060.22302.19.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1515503060.22302.19.camel@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589069808671539027?=
X-GMAIL-MSGID: =?utf-8?q?1592547324782689501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 2018-01-09 13:04:20, David Woodhouse wrote:
> On Mon, 2018-01-08 at 19:27 -0800, Andy Lutomirski wrote:
> > > 
> > > If SMEP is not active, speculation can go anywhere, including to a user
> > > controlled gadget which can reload any registers it needs, including
> > > with immediate constants.
> > 
> > I thought that, even on pre-SMEP hardware, the CPU wouldn't
> > speculatively execute from NX pages.  And PTI marks user memory NX
> > in kernel mode.
> 
> Hm, now that could be useful. 
> 
> Do *all* the KPTI backports (some of which are reimplementations rather
> than strictly backports) mark user memory NX?

Hmm. We'd still want to do something on 32-bit, and those might not
even have NX support in hardware.

Pentium 4 (and such) is probably advanced enough to be vulnerable to
spectre, but not new enough to support NX...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
