Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+AyUJXQ7jUxyYZAeBOeJutOywWlRA2egPh8UvbUNQRh9GNzoW4T86cTcxgOOtlpLlvP3kz
ARC-Seal: i=1; a=rsa-sha256; t=1523005915; cv=none;
        d=google.com; s=arc-20160816;
        b=caDnm8meoEgWu7y50/btR/w+xjbeKfPQLiDrqomhnzfED4yLqvoFdYkPiQlwXuAwoj
         DE+hOcQLiPfcC8qxD5xhqgM/oYInkg9VHkrtOiqmDcGMbJyS5BSMLSOIyulrYfSU8gDO
         QWBKnpLZXYqS6IdgprnTS4qIOS+g/6WRKOINlSAsIpNKSuKOSWTk4bk/7yq7aVUQiR3e
         hp408PAxrzT8Y9Ziokq/HNcAjneHN5blozjkkArk3D5iGJ9bgySz9Rj9KOkKWDfEHNFU
         slt/PWkfPFP920Cwqgp7r9jn8CEkkr0NswnRhP/Vi+9sZv2SWzVYVA5JHgDRR+o9mQKZ
         OKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=JRhPfCbxgKBmsJ1pEF9+UseMQp6Q4SsEPctpTViIBIU=;
        b=IYH2dcjQBJ6NaX8jAgxUsZhg1izbnOUN9vhA62SCjvEmyRfdiqMaY8YV6TXBbShJeq
         updhn02nkf5ZqUTLypfi7nVZItrPZ/Zyz8XfUYzB9fYunN1zTQOQBSO0FZyRBGTf3O4l
         OXxijA9CkaU9NwUvyp/5lQktXZJIrsLiZhNtFprB+9waYGImVZ50+ystDcmpP7fF1f/h
         lyBVMfsqsEBTeHBvTzLGHdPN/WS8P9a0DjtdiRar+thY7g6Cm28m4f/HQ7zMiUCJxIB2
         fY05XaJGzrhudpJoSs9g6XqDJd8S8i1wyOLz2mmGcMsjDdAKh0gMiIj6uisOt483Cdf6
         pz7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,414,1517904000";
   d="scan'208";a="44592560"
Date: Fri, 6 Apr 2018 12:11:26 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Masanari Iida <standby24x7@gmail.com>, linux-kernel@vger.kernel.org,
	linux-doc <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org
Subject: Re: make xmldocs failed with error after 4.17 merge period
Message-ID: <20180406091126.GC21589@kuha.fi.intel.com>
References: <CALLJCT0MFg6b+dG50cqe_hv6hxmQDj-ZM066BOtQt_wOiC8ENA@mail.gmail.com>
 <20180406075109.GA21589@kuha.fi.intel.com>
 <20180406075734.GA16728@kroah.com>
 <20180406081555.GB21589@kuha.fi.intel.com>
 <20180406083010.GA20174@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406083010.GA20174@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596966487828993292?=
X-GMAIL-MSGID: =?utf-8?q?1596987450523006122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 10:30:10AM +0200, Greg KH wrote:
> On Fri, Apr 06, 2018 at 11:15:55AM +0300, Heikki Krogerus wrote:
> > On Fri, Apr 06, 2018 at 09:57:34AM +0200, Greg KH wrote:
> > > On Fri, Apr 06, 2018 at 10:51:09AM +0300, Heikki Krogerus wrote:
> > > > On Fri, Apr 06, 2018 at 12:38:42PM +0900, Masanari Iida wrote:
> > > > > After merge following patch during 4.17 merger period,
> > > > > make xmldocs start to fail with error.
> > > > > 
> > > > >  [bdecb33af34f79cbfbb656661210f77c8b8b5b5f]
> > > > > usb: typec: API for controlling USB Type-C Multiplexers
> > > > > 
> > > > > Error messages.
> > > > > reST markup error:
> > > > > /home/iida/Repo/linux-2.6/Documentation/driver-api/usb/typec.rst:215:
> > > > > (SEVERE/4) Unexpected section title or transition.
> > > > > 
> > > > > ------------------------
> > > > > Documentation/Makefile:93: recipe for target 'xmldocs' failed
> > > > > make[1]: *** [xmldocs] Error 1
> > > > > Makefile:1527: recipe for target 'xmldocs' failed
> > > > > make: *** [xmldocs] Error 2
> > > > > 
> > > > > $
> > > > > 
> > > > > An ascii graphic in typec.rst cause the error.
> > > > 
> > > > Thanks for the report. I'm going to propose that we fix this by
> > > > marking the ascii art as comment:
> > > > 
> > > > diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
> > > > index feb31946490b..972c11bf4141 100644
> > > > --- a/Documentation/driver-api/usb/typec.rst
> > > > +++ b/Documentation/driver-api/usb/typec.rst
> > > > @@ -212,7 +212,7 @@ port drivers can use USB Role Class API with those.
> > > > 
> > > >  Illustration of the muxes behind a connector that supports an alternate mode:
> > > > 
> > > > -                     ------------------------
> > > > +..                   ------------------------
> > > >                       |       Connector      |
> > > >                       ------------------------
> > > >                              |         |
> > > > 
> > > > I hope that works.
> > > 
> > > Try it and see!  :)
> > 
> > It will fix this issue. I was just wondering if use of ascii art is
> > acceptable in general with the .rst files? But then again, why
> > wouldn't it be.
> 
> There are ways to do this, look at how the v4l2 and I think the drm
> subsystems handle ascii art such that "real" drawings end up being
> produced.

Thanks. I did not actually find anything else except use of tables and
code-blocks in v4l documentation. Is that what you were referring?

I was propsed to use something called "Literal Block" with ascii art.
http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#literal-blocks

Unless you object, that's what I will use.


Thanks,

-- 
heikki
