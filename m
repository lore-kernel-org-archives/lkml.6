Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AB8JxZr3mO/Wmi2GeoXTGVVrd2IguzzvsBXRIynSGg814eUBL6jT2Fs9YyXAwaTMtwez4/AhaBbC
ARC-Seal: i=1; a=rsa-sha256; t=1525817738; cv=none;
        d=google.com; s=arc-20160816;
        b=aVOObdrvdrnnj/47A0x54NH7GC/BamQzY7fbizJ96YoqgVNhTb10cZGDBB9jAS477F
         FYQ9nFssTN5LhV2xjQQ8QD6FNz+r3gEBaI7//PIZ3W+w20oGCM4XAdRfEChN6djIeOqO
         thNM0NLKnnsaKbDw+t6w/aFzgg/cQ7X+TsnCWKPRYyq8DzS02YdpRBAXZQ93allge4RU
         pDqsYHDR1nn7DMUkiDnjaUMjegZLgM4mnHpABPYbUH7MOsu4yK58K5D9QkW+T/lA+tie
         euqrt647PtuiRvFjlEPxjH/jSxE5UoxvRyH/pSh1ECPDM034CGu4fV+5R0etniUhypTi
         sz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=mpo9eyVTlaZbIxjucZ3tYCx7IvbRmyUG2e/Yk8PdRtE=;
        b=UVieP6dCSZnTR0EdMlRh+WVENgQcapPeEod2sIFgaWmWGOnIUfMtIE8jAXNPpTpSwM
         P6VNn36Xme22NL1q68og4yjWe2WDIXZR61RkqIyYHvopTEY8bQBB1ADj995r6N26Xkyr
         6E+geHX0NX8gwKOexKIgnZSSMaSqCzOxHZlHSXkoI8V2cIZonwcRGU153u+GQPRDzXSd
         mwZdtIKx3FRFlMDNkZ1c5pCkoXxtZ3oLde/ANpaWP/vDnnWepgQ+t7zqa+bNYrzS4b1M
         sZjZ882denO9z17dxc0R3LeYgV7E+zLSBrLe3BpD2x9DbE/VUlpdLlJtoGVi/nPFtRF0
         vNVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=Qixztzun;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=Qixztzun;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Tue, 8 May 2018 18:15:34 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180508221534.GC28388@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Tony Lindgren <tony@atomide.com>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm>
 <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <20180508023439.GA8514@sasha-vm>
 <20180508034820.GE999@thunk.org>
 <20180508202912.GC8514@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508202912.GC8514@sasha-vm>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599935861399833923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 08:29:14PM +0000, Sasha Levin wrote:
> 
> This is interesting. We have a group of power users who are testing out
> -rc releases, who are usually happy to test out a fast moving target and
> provide helpful reports back. We also have a group who run a -stable
> kernel (-stable build/distro/android/etc) who want to avoid having to
> report bugs to us.
> 
> What we don't have is a group of people who use Linus's actual releases
> (not the -rc stuff, but the actual point releases). Power users will
> move on to the next kernel, and -stable folks won't touch that release
> until there's a corresponding -stable.

Linus doesn't release the point releases.  Those are done by the Greg
K-H and use the same process as does the stable kernels.  The only
difference is that the life point release doesn't last very long; just
until the next kernel release from Linus.

There are probably fewer people who use the point releases compared to
the stable kernels.  But I'd hesitate to call it zero.  We once
assumed that companies were all using Distro kernels, and very few
people used the stable kernels except for distribution channels
(enterprise kernels, BSP kernels, etc.).  Then we discovered that
there are people who use the stable kernel and don't go through the
enterprise distro vendors at all.  It wouldn't surprise me if there
are also a silent (and perhaps large) set of users who take Linus's
releases, and then follow along on the dot releases until the next
release from Linus.

> What if, instead, Linus doesn't actually ever release a point
> release?  We can make the merge window open more often, and since
> there's no actual release, people won't rush to push fixes in later
> -rc cycles.

I dont' understand your proposal.  Linus doesn't actually release
point releases.  Those happen during the -rcX cycle for those people
who are too chicken to follow Linus's tree, and just want the bug
fixes.

Getting rid of the point releases isn't going to change how frequently
the merge window opens.  What would do that is being much more strict
about when we only allow regression fixes only into the tree, so
hopefully the tree stablizes itself by -rc5 or -rc6.  

> Merge window will happen more often, so there's no real reason to
> rush things in a particular window, and since -stable releases every
> week there's no rush to push a fix in since the next release is just
> a week away.

Huh?

I can see shortening the release cycle to a six weeks, instead of our
current 8-9 week cycle.  But after the each cycle where we introduce
new features, during the merge window / integration phase, we do need
to have a time when are fixing regression bugs.

						- Ted
