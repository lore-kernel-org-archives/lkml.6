Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AIpwx4+uvTxacqEDn8+5xaxqtZCUx1ywaTIEwyc/9duy77J+7LX9qANgge4AkKcpXOXx/iw0iynz
ARC-Seal: i=1; a=rsa-sha256; t=1522243247; cv=none;
        d=google.com; s=arc-20160816;
        b=m3+FFDZ6hqFeM956ZPYXcNO240DKVzeK4aTmL7QhtsHj9NxGiZRHolu+aeQywGSUoM
         spQlAXnc1SxYkRnb7CCFJs8e8jkR5tESM5UoPC/IB6fsFCmAHK8CBBEVOhys9SLC28ma
         fOGLkWRQ8f3Ql/HOujmzGUF80TaSGiblM5/qVXlQd0WSz6ye76mCHmoyYHNfvlOPa0jq
         dfRWpDuMBimiP0Bc4ez2G9oLApgwJ+rpgw+jmrZHJn6uCs703VBf1zEgKV8Mek89rMe5
         09W5wdQ9+hyLmJmth5Or+7CSQvWUhTemEUkZlvSGU+01fV78c/daf+k/kUvGGSAqH9d6
         O0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Okic+DY9ATMIIb0bIAsCg4VFPK95ttj0plVIj3e8hN8=;
        b=RAV2wR5/9ttjJ7iIrR9m6LVxFJ4jkOJBzS3HbKh3h6I32ynd8hxHfxt0IcevroqIAE
         PRe+KipNOGCgAANnPWZ0R0Z+S4wXVlfggDDQdXyvDEatjzQEb+ipr7sCCSLTmMwAVa3O
         Y8TPHH3xRqbnheePoN8fKAbSVoALUZ/F0L36ObjLu4gDTzzJh1H+7VBBzH/ywlyNwktf
         Kb8EO7Hs625dtt1GAmEhrWUFGCeT4NI2EwWkpQ+1KCaEh1WVVSAeHdopvbsfKuvhz5nX
         Cf6uNFkj5mwZAuV0VSXrcTpkyuFaRXrq/aTsT2gwt9YLmdao1d66tVCkl9bTBR24lfE7
         EDUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Wed, 28 Mar 2018 15:20:44 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Sasha Levin <levinsasha928@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Josh Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Message-ID: <20180328132044.GM9275@dhcp22.suse.cz>
References: <20171123060137.GL2135@magnolia>
 <20180323013037.GA9190@wotan.suse.de>
 <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180327070637.GX5652@dhcp22.suse.cz>
 <20180328011152.GA7561@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328011152.GA7561@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596187735351461765?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 28-03-18 01:11:55, Sasha Levin wrote:
> On Tue, Mar 27, 2018 at 09:06:37AM +0200, Michal Hocko wrote:
> >On Mon 26-03-18 19:54:31, Sasha Levin wrote:
> >[...]
> >> About half a year ago. I'm not sure about the no visibility part -
> >> maintainers and authors would receive at least 3 mails for each patch
> >> that got in this way, and would have at least a week (usually a lot
> >> more) to object to the inclusion. Did you not receive any mails from
> >> me?
> >
> >Well, I was aware of your emails yet my free time didn't really allow me
> >to follow those patch bombs. I responded only when some email subject
> >hit my eyes as being non-stable candidate. So by no means the MM
> >backports were reviewed by me. And considering how hard it is to get any
> >review for MM patches in general I strongly suspect that others didn't
> >review either.
> 
> Being aware is different than saying it was snuck in without anyone
> knowing.

Well, you have to realize that we are receiving tons of emails and if
there are large piles appearing in my inbox I tend to delete them all if
they fall into certain pattern categories.

But just to be absolutely clear. I do not want to accuse anybody from
sneaking changes into the stable tree behind maintainers backs.

> 
> >In general I am quite skeptical about the automagic backports
> >selections, to be honest. MM patches should be reasonably good at
> >selecting stable backports and adding more patches on top just risks
> >regressions.
> 
> Okay, let's take mm/ as a subsystem that is doing a good job with
> submitting stuff to -stable.
> 
> There were 40 patches in total going into the 4.14 LTS tree that touched
> mm/. Out of those, 5 were selected via the "automagic" process:
> 
> > 647a37ec1a17 mm/frame_vector.c: release a semaphore in 'get_vaddr_frames()'
> > d91c3f2e540f mm/early_ioremap: Fix boot hang with earlyprintk=efi,keep
> > b2ba0bd34695 kmemleak: add scheduling point to kmemleak_scan()
> > 5ca94e03675a slub: fix sysfs duplicate filename creation when slub_debug=O
> > 342ee8775800 mm, x86/mm: Fix performance regression in get_user_pages_fast()
> 
> The only "questionable" one here I see is the performance regression
> one, which I decided to keep in because it's a rather severe one in a
> common code path.
> 
> Even good subsystems might sometimes miss a patch or two.

Ohh, absolutely. But if anybody is going to hit the issue, it would be
easier to spot with the upstream kernel having the fix already. Most of
above patches have good chance of never being hit or at least not that
harmful.

> But yes, I've received less response from maintainers than I expected,
> so I'll switch it to an opt-in model for new patches that go upstream.

OK, that would certainly be more conservative and to some degree safer.
I have had that feeling that stable simply has to rely on maintainers
others we are operating on the pure luck mode. Just the fact that the
patch applies doesn't mean it is correct to be backported and it is out
of reasonable to expect stable tree maintainers to evaluate that.

So as much as I appreciate the work you and others are doing (the
automagic part is actually and interesting concept for sure) the less is
sometimes more...
-- 
Michal Hocko
SUSE Labs
