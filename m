Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZpCV002aalSm+Irz+gzOe6dBd0kU4Ruq75vbRMkhx1V8SL+Mx67XGPI7SDOS+5BGL7E13uB
ARC-Seal: i=1; a=rsa-sha256; t=1525388949; cv=none;
        d=google.com; s=arc-20160816;
        b=t9J/kRnK61onSj70NHaSmm1KTJM+VGTW0RUzRjZL1B5tkGTanBLjVs+mBDY+btGIgY
         s13wIbG+v5BE99b5JEdDrKeaziFgGf7py79dKJREiqk64UbZIgm+7XzS/DKUVxsYr+j5
         YOi90zDCZC1ZsRUKWIP+ZiJt2FTGOoDHs1TqZds1WSKjJ56pT5Fz3Z/ORsTgoB20rQVF
         Ymcw5TifDQxz4oQHiZKn8NC+8f6PDTOq6ttAEiNLY5lDcAYBddwWOjVojwtlZVy9PuiU
         Kq2bkyeK5E958RK8zOU0C8txVnbaS85HHBNHQnIXxoMzrriqOhS4i2PWm7O9Ey3LrXEs
         ubbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+tH3CasT2nDYAfw11O8PwLK+czTTGVdwsKEmIjbXUzc=;
        b=rqVfg+iKWWi7AZ0aViWwzW49BZ2FgcOnlTuRR6136Ye2RVFkbn1ZucaKJitabQF3zS
         mQL5+Oy2Tx4TDTTkSW9wgqb8IITd4V6ZbA4MbM+08zelFQFl1YtxejqwScONIbuLydV5
         3V4wSnBGU/3xV2izdnLR79ps0+hHCT6/pu2zOabWQxr/u7nhMjmHmX2x3b2EYbvZkB3A
         VGUKF/qeeRFl9xVAqTIEoY/olWlc9ZOQmprjx4WnNDyc0iNi/GjMzZ1j98jid5Aj/Fsf
         /uuJ9yUYFXyjiOzNu4OeIEwR62lnHsWU3IdXBLhuGpexQeUvxVNLYdYurb1Yg27OdyrM
         ZKBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Thu, 3 May 2018 16:09:05 -0700
From: Tony Lindgren <tony@atomide.com>
To: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503230905.GA98604@atomide.com>
References: <20180501194450.GD10479@thunk.org>
 <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org>
 <20180501211551.GI2714@sirena.org.uk>
 <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm>
 <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503224217.GR2714@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599486242330354116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Mark Brown <broonie@kernel.org> [180503 22:44]:
> On Wed, May 02, 2018 at 08:52:29PM -0700, Guenter Roeck wrote:
> 
> > As for -next, me and others stopped reporting bugs in it, because when we do
> > we tend to get flamed for the "noise". Is anyone aware (or cares) that mips
> > and nds32 images don't build ? Soaking clothes in an empty bathtub won't make
> > them wet, and bugs in code which no one builds, much less tests or uses, won't
> > be found.
> 
> You've been flamed for testing -next?  That's not been my experience and
> frankly it's pretty horrifying that it's happening.  Testing is pretty
> much the whole point of -next existing in the first place so you have to
> wonder why people are putting their trees there if they don't want
> testing.  I have seen a few issues with people reporting bugs on old
> versions of -next but otherwise...

Yes I agree testing Linux next is very important. That's the best way for
maintainers to ensure a usable -rc1 after a merge window. And then for
the -rc cycle, there not much of need for chasing bugs to get things working.

Bugs reported for Linux next often seem to get fixed or reverted faster
compared to the -rc cycle too. I think that's because people realize that
their code will not get merged until it's been fixed.

So some daily testing of Linux next can save a lot scrambling after the
merge window :)

Users don't usually upgrade kernels until after later -rc releases or only
after major releases so that probably explains some of the -rc cycle fixes.

Regards,

Tony
