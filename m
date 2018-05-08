Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZo+3K/beWfNFKNoGJgI3H4HsC0otmcdnQ+Y8ZZgWEvUaRxvF0LLwConiH1xWWErpBdAK0o2
ARC-Seal: i=1; a=rsa-sha256; t=1525791003; cv=none;
        d=google.com; s=arc-20160816;
        b=u/4BnI7F0CVG/nyW1eMJJGsXyJjvDBUQmWBd/MGZWOCPcDuIKeexgiHxtQGxrruC20
         JwnEf+iD3DBrMoE1VP5ObipSUas7OS01rm0xBDqGdBvIATrV9asECVq4RHAamWIEesiC
         eKdhlEALZxc/P8+L+2Gk3thp41jayY+6YeuloY8aoeV4UWUewzv7BvT0DE3YQU2VU2qd
         wrmdxCnPS2hfEtjJLOhRcNI6K01idCduHkQ0F2BygUjYvETBb+Z4B+HgK2rhDqYbMjPT
         EEWHT/Xd+3IvLxZ8OBjO7Hbigxfh3wJCbCOGIZ+0lXL/W2d0dWkTD5BI/UXcBdPTvevL
         HV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:arc-authentication-results;
        bh=8FkwaYbx4ChyazF+PtIzmZ4L82rlPyPBZktHTxuTlRo=;
        b=npe6U4qANbdn3RZJdH4UH0rris/CMLEJQrerodpIM4RJ1XpxRBj6ErDFkkEWOQ1lmz
         0bdup8gyvpKQkzcHrd7MA7tNdynTHioMofSLFz7hJW3quwFPt7uQfIVsT2HwBscEGHD0
         TYOQAM+5HapPIz61+8jY6SZj+CiFVguJ2xBkaKfHtRE4bkpwbxWYEEBVNvlYo7+YEXwx
         YoKh41UTBIxxurhnWyJrqxM7YPBizPodGDZLKqpnyyXXoWWJCr0kuGfRh+31dmZ3wRXD
         IKdqTztQrpOUuyEY8GwdNL1XLiNlGT3jBjk4bs496Cn0bdop9pBcjWakrqKLixdCFJpo
         SAlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Tue, 8 May 2018 07:49:59 -0700
From: Tony Lindgren <tony@atomide.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180508144958.GU98604@atomide.com>
References: <20180501211551.GI2714@sirena.org.uk>
 <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm>
 <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <20180508023439.GA8514@sasha-vm>
 <20180508034820.GE999@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508034820.GE999@thunk.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599907827769387455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Theodore Y. Ts'o <tytso@mit.edu> [180508 03:50]:
> On Tue, May 08, 2018 at 02:34:41AM +0000, Sasha Levin via Ksummit-discuss wrote:
> > 
> > Tony, I'm curious, how many users are you aware of who actually run
> > Linus's tree? All the users I've encountered so far on Azure seem to be
> > running something based on -stable.
> 
> The people who run Linus's tree and test -rc kernels tend to be kernel
> developers and individual users who want to run bleeding edge kernels
> and who generally are technically clueful.  If you were talking about
> SLR cameras, you'd call them the "prosumers" segment of the market.

Yup that's the category. People tinkering with their devices and
using bleeding edge kernels because of some new device driver only
being in thr -rc series for example.

> > I think that a question we should be asking ourselves is whether we
> > should be basing our decisions here on the assumption that (pretty much)
> > no one runs Linus's tree anymore?
> 
> These people *do* exist, because as a maintainer, I get bug reports
> from them.  (And sometimes as a user, I send bug reports when running
> -rc kernels to other maintainers, such as the i915 drivers and the
> Intel Wireless driver folks.)

Yes.

> Such reports are incredibly valuable and precious to me, since it
> allows me to find problems that weren't picked up in my own testing.
> (In the case of Intel Wireless, a while back the IWL team didn't have
> Aruba Enterprise Access Points in their test hardware library, so I
> found a regression after the merge window because I was running -rcX
> on my laptop, and wireless access to googleguest network broke.  If I
> hadn't been running -rcX, they probably wouldn't have discovered this
> problem until after that particular kernel had been released.)

Yes. So as maintainers, we should all test Linux next on frequent
basis to aim for usable -rc1 with no regressions based on that
testing. Then the rest of the -rc cycle should be easy with more
testing and reports from the "prosumer" market :)

> So keeping those users happy is a good thing; since they tend to be
> very technically clueful, they can do bisections for you, and they are
> able to give a detailed and useful bug report.  If they report that a
> regression that was introduced in -rc2 is fixed by a particular patch,
> I want to push it into -rc3 immediately, and not let it stall in
> linux-next.  If the reason why is because you don't trust my patch
> because it "only" got tested by the technically advanced user
> reporting the regression, then don't take patches from -rc3 into your
> stable branch right away!  Let it bake in Linus's tree anfor a week or
> two, instead of demanding that patches stick around in Linux-next
> before flowing into Linus's tree.
> 
> Because I will guarantee you this --- there are more real users
> running Linus's tree than linux-next.  This is because Linus's tree
> tends to be far more stable than linux-next, since after -rc2
> linux-next starts getting the first set of experiments for what will
> be going into the next merge window.  So while I am willing to run
> something based on -rc2 or later on my laptop, there is no way in heck
> I would be willing to put linux-next on my laptop.  That's just way
> too exciting for me....

I follow Linux next on few test systems. Then when I see no regressions,
I might dare try it on my laptop. Something that's usable one week in
next may not be so any longer the next week. So testing minimum few
times a week and carrying occasional reverts are often needed to be
able to test Linux next on daily basis.

> Would I pull down linux-next, and fire up a VM running gce-xfstests?
> Sure.  But that's not a real-life use case; that's just running canned
> test cases.  And more often than not, linux-next will be broken while
> Linus's -rcX tree is just fine; which is why I do most of my ext4
> testing using patches based on top of -rcX, not based on top of
> linux-next.

Ideally we would somehow always end up with an -rc1 that people dare
to use though for the "prosumer" testing :)

Regards,

Tony
