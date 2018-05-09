Return-Path: <linux@roeck-us.net>
X-Google-Smtp-Source: AB8JxZpkTb2H6w1mL0xa2nqZ9/F+3M60b9r9ZpXRw9CUTTjnKrV0lsRr0e9Pk+CqjEBetf0v6ZG2
ARC-Seal: i=1; a=rsa-sha256; t=1525881457; cv=none;
        d=google.com; s=arc-20160816;
        b=fvULJcNZ5Y6JVwZjMHuxIvArPFhuTuoCG8hbjObRIVYxEHXdtXsXGQQX7EJbpr5Lkg
         CJhSzIW5omkgF9V1JQ2XfF3hbhsSV1VZpiCHWgfqiXqYFYTIleubOtaz4DDqVQufnQO3
         82oaXOwVB+2/uEReh/mF1av3Y+ASWPJcFqTtEuIuS7s7WT+OBOtKhsBEbdc85q21vn9P
         L71WXkolESqFFE7/vVPVwzdl7NC7gdlwVj/iQXpJJIGXwzrN3+Kc6Wve8PZNUoiuQ7cn
         OEY4+SPgGmsMENFifCxm/L5+d/3Dxj5SUH1Es47i5iGQtRK+R/Ef7rCdElIj/G3iqRQ5
         8plQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=dM5g8rVmAQu9fEMrUzG3wXQFzuyZlM/csQDi26tvgYg=;
        b=n/7+dS1DM1TXPMu5UX2mqr1/HMPvC1EDEnlXuKLNjbi0S9ZNrtJjwoJC2EnxUj4tuj
         XF/7CvT66dijEcY0crqKHLi/ZPqPq7zeYRqYxIVB8Mtr/tqU0uEaSTwuSMkvGZtVtjrX
         bn/W5jCcMAw6Yby7AeckGUiazFcG+F6nn6lFK4BxuJIILjKG72izHlv9YUb6uKdKcy+F
         ++bhoaf5hglG1NCxwzva7rLmNFdsdxbHwlmELiq35qQ/7EqIxRNOriHK5wYejMEPKh+o
         YvOolp3QafAdG2acbhe7AfWggKfKi5BB7t9Pf7Xd3/y21URNOd7GRtrmmlbmrX0L8xn/
         lkqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=DJfCuKlY;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=DJfCuKlY;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Date: Wed, 9 May 2018 08:57:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180509155733.GA13575@roeck-us.net>
References: <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk>
 <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <20180509090346.GY13402@sirena.org.uk>
 <20180509204727.7ff38021@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509204727.7ff38021@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1600002674622327663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 08:47:27PM +1000, Stephen Rothwell wrote:
> On Wed, 9 May 2018 18:03:46 +0900 Mark Brown <broonie@kernel.org> wrote:
> >
> > On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote:
> > > On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrote:  
> > 
> > > > I think this is an excellent idea, copying in Stephen for his input.
> > > > I'm currently on holiday but unless someone convinces me it's a terrible
> > > > idea I'm willing to at least give it a go on a trial basis once I'm back
> > > > home.  
> > 
> > > Since Stephen merges all -fixes branches first, before merging all the
> > > -next branches, he already generates that as part of linux-next. All
> > > he'd need to do is push that intermediate state out to some
> > > linux-fixes branch for consumption by test bots.
> 
> Good idea ... I will see what I can do.
>   
> > True.  It's currently only those -fixes branches that people have asked
> > him to merge separately which isn't as big a proportion of trees as have
> > them (perhaps fortunately given people's enthusiasm for fixes branches
> > that don't merge cleanly with their development branches) so we'd also
> > need to encourage people to add them separately.
> 
> I currently have 44 such fixes branches.  More welcome!
> 
Please add

git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon

as fixes branch.

Thanks,
Guenter

> -- 
> Cheers,
> Stephen Rothwell



> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
