Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AIpwx48YnT7vLzFdz2/TDwOSnOVprrKfTXEejGZUCKddNc82Zoe7Mp8EJhuEBqG5n+vogENpBfVO
ARC-Seal: i=1; a=rsa-sha256; t=1523002560; cv=none;
        d=google.com; s=arc-20160816;
        b=d12Rj2MYZzl9qflxO2teH5+8pj4Q/5Qm35olUTOCVwct6kw7Lc49rL4Ubqv9PXNw/0
         k/qRijCJm86YkhlL8lrTvKRQiz8K2K+a2QUb3oMtsIxX4NuAFS5Xr4v8TlVCfs8Am11E
         p/ixy5dgIp0lsc1xFfajzI6rYkwr9n1pBv51I/7ha2FqTENdDCoZbxZa7uoJHU9V99o3
         wthXBkdfQ5etcKSY95FFgclmpYl/lPyv/Yki0qW3R8ZstWAhIea9TIrv4nY+ZblSw4sf
         HQSk8EqF692ExnVHUMUE7KBYpldH+h+RGva+TIB3PB7iuNXXan3nKF1ifizjNAVQokV0
         a3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=8a3lAK/ysqQCBbiKROqnllQcZ/7pFNQwwyeWHCS6coQ=;
        b=hyPH4O7aIwiVMvD5DTu1fJfOoOqOtMPok+VIC4xdW4a04klWHNVa0O1JDWfSDp5dLS
         AqpM8L7RkWVKiXtR4VLNi29iM5EnzNI39KSI1m438SMCuBx/MJohC4WM+tG3tDGjkSQB
         5xg1/VJvH3oIATz6Ez2o7rOWpqhQxUeVxCdSyIEP1Weyy+MUEp5G/ngRjAUEK/vD781T
         RWr14koCJkQprY7EQVmpQslvZ7Q8f4D+eC3aKygd1XTNP5Zk8MnWHegIhjK4a7tiY+EF
         6d7ti/hQHoAT4DB75KoaTazSTibmpqOW9p9Vw8WplJQE6WLIloVvcE2idMxh8eowvoP7
         Y13Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,414,1517904000";
   d="scan'208";a="44583388"
Date: Fri, 6 Apr 2018 11:15:55 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Masanari Iida <standby24x7@gmail.com>, linux-kernel@vger.kernel.org,
	linux-doc <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org
Subject: Re: make xmldocs failed with error after 4.17 merge period
Message-ID: <20180406081555.GB21589@kuha.fi.intel.com>
References: <CALLJCT0MFg6b+dG50cqe_hv6hxmQDj-ZM066BOtQt_wOiC8ENA@mail.gmail.com>
 <20180406075109.GA21589@kuha.fi.intel.com>
 <20180406075734.GA16728@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406075734.GA16728@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596966487828993292?=
X-GMAIL-MSGID: =?utf-8?q?1596983932731395617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 09:57:34AM +0200, Greg KH wrote:
> On Fri, Apr 06, 2018 at 10:51:09AM +0300, Heikki Krogerus wrote:
> > On Fri, Apr 06, 2018 at 12:38:42PM +0900, Masanari Iida wrote:
> > > After merge following patch during 4.17 merger period,
> > > make xmldocs start to fail with error.
> > > 
> > >  [bdecb33af34f79cbfbb656661210f77c8b8b5b5f]
> > > usb: typec: API for controlling USB Type-C Multiplexers
> > > 
> > > Error messages.
> > > reST markup error:
> > > /home/iida/Repo/linux-2.6/Documentation/driver-api/usb/typec.rst:215:
> > > (SEVERE/4) Unexpected section title or transition.
> > > 
> > > ------------------------
> > > Documentation/Makefile:93: recipe for target 'xmldocs' failed
> > > make[1]: *** [xmldocs] Error 1
> > > Makefile:1527: recipe for target 'xmldocs' failed
> > > make: *** [xmldocs] Error 2
> > > 
> > > $
> > > 
> > > An ascii graphic in typec.rst cause the error.
> > 
> > Thanks for the report. I'm going to propose that we fix this by
> > marking the ascii art as comment:
> > 
> > diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
> > index feb31946490b..972c11bf4141 100644
> > --- a/Documentation/driver-api/usb/typec.rst
> > +++ b/Documentation/driver-api/usb/typec.rst
> > @@ -212,7 +212,7 @@ port drivers can use USB Role Class API with those.
> > 
> >  Illustration of the muxes behind a connector that supports an alternate mode:
> > 
> > -                     ------------------------
> > +..                   ------------------------
> >                       |       Connector      |
> >                       ------------------------
> >                              |         |
> > 
> > I hope that works.
> 
> Try it and see!  :)

It will fix this issue. I was just wondering if use of ascii art is
acceptable in general with the .rst files? But then again, why
wouldn't it be.

Sorry for the noise. I'll just send that patch.


Thanks,

-- 
heikki
