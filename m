Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AB8JxZpes2VRXswtb4wfCt6FiePwimx34O0HXezrwsZ2tyZWQPxh3nJAVKgq7OWTJ/+EoLpR6spp
ARC-Seal: i=1; a=rsa-sha256; t=1525468404; cv=none;
        d=google.com; s=arc-20160816;
        b=N2eFol/51geaD/AkzQmKqPY1A7CiHqJt1WWyezdlp9ZRiIIPRQPUccOujUDdUoyVza
         g3aD3e2QE9Ii5KMbb6sthnOBAEyQN9urysbDeLwxLgw3MFYDG2BFOJceXsgAsUJCZ1pC
         k25L5OleE7Sh1x0pss1xlybtdeQckVygA/OSbD2uy829TmBhWIWpPt8txsojwG7K3UxJ
         1m85ebmyKx57JhCe4WUxKXh2uB7t4jUzAopns18O1Zxz4fbftlqZSC+5EIkvww8rCfXO
         MGb7q/OqwjG6lRPmjUzXWM7ziiMm4mEOeaNTMYCXx2/hwb8mVgoyjnaJvJsPT5r6rW+B
         jmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=fqK12ppyPUuaEA6dkoGZutsdXQFvjma2CvUvMrJRVqY=;
        b=aMLHkrJNmzN8Ge6JVC4ATAjMYh+ztfyIQI5vwONN/DVnU1VjOmYsrYRo3YSZcmvp2l
         QPt01DtOiMkwBWlaX4qTP/oZakMJ6WJdC8jyFM4ZXYfkousHB8qBetk0WBRlTrideNcu
         tu3lT0nS13FLH90DzkDm1j9bSirRMOJ0+aFypRBQ6wcfoUONaZiu7K/+BdhA+cjY1xI/
         VoiVjPFekjA6UTpYKcf9+TqyHuODcQkq/0/Yh553keLmr5Q5SCE4nqom5b9PU75gnzBr
         OYjpJL0b+uoDXy55chMkqCRarErY+PqsP5+Du2enB3I8UUW2Dr6ZG3n/AnhqQ6omeLnF
         xxfA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=crEde8V/;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=crEde8V/;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Fri, 4 May 2018 17:13:17 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jani Nikula <jani.nikula@intel.com>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180504211317.GK29205@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Greg KH <gregkh@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>
References: <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
 <20180503144612.GJ18390@sasha-vm>
 <20180503165446.GB30522@ZenIV.linux.org.uk>
 <20180503173422.GR18390@sasha-vm>
 <20180503182039.GC30522@ZenIV.linux.org.uk>
 <8669.1525427874@warthog.procyon.org.uk>
 <87fu377gbu.fsf@intel.com>
 <20180504130932.GI29205@thunk.org>
 <20180504174055.GF4649@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504174055.GF4649@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599569558224089875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 10:40:55AM -0700, Greg KH wrote:
> Ugh, what?  I don't understand what you are proposing here, what we have
> today is just fine, what is broken with it?

What we have today is this:

     Cc: stable@kernel.org # 3.11
     Cc: stable@kernel.org # 4.8+
     Cc: stable@kernel.org # 4.8+

Jani was suggesting something documented which doesn't match current
practice.  See commit 8e9b9362266d, which describes something like this:

     Cc: <stable@kernel.org> # .32.x: a1f84a3: sched: Check for idle
     Cc: <stable@kernel.org> # .32.x: 1b9508f: sched: Rate-limit newidle
     Cc: <stable@kernel.org> # .32.x: fd21073: sched: Fix affinity logic

... to specify prereqisite commits needed to backport the commit in
question.  I am proposing that we delete what is in
stable_kernel_rules.rst, because it doesn't match with current
practice.

If it is necessary to explicitly specify prerequisites (as opposed to
having scripts or stable maintainers guess or figure things out
manually), then something like this might be better:

Stable-prereq: DEADBEEF1234: subsystem: bork bork bork....

If it's not necessary, fine.  But we should still delete what is
currently documented in stable_kernel_rules and was introduced in
8e9b9362266d, because it doesn't describe current practice.

						- Ted
