Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AIpwx4++j/tV9TW89uPFoGzPwryw4CqQAmR/km3Ng18u4ZMs2SEtT00BDJY00b+SYBVs8i7By6Sl
ARC-Seal: i=1; a=rsa-sha256; t=1522941831; cv=none;
        d=google.com; s=arc-20160816;
        b=Bf7rCp/+ezNteH84PJ9lMAwR/KHg0+T0EHVStww7xE58XDtg7WeehyFmuzbizGbchJ
         UmrQsQtDeH+nxCHAqweqt9PO3JD5R3iej7gAASlGeqszeDIYyZm2PV3YYtnBy21QAdVR
         RvYAwf1NJRsn/iYEGxN3yIq4SEyYH2TsNLzh0F8c2UyT5ZX7+TDaIO4JnRmz0ypctq66
         XfbjO2I1bY7gsROSD5L/z/cg7g7VbYADjqMiPDwj0IIbU4a7XmOmqoxzYLOiq+mfQl+K
         3E2xMqjzxamUQGbsAlLlgxrLxnb05Lic2PyYv5NSTvL+XuyjFSOeTtuvUcncBmJapWcq
         e28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=8VK2WUV6OgmtZvtep7k9AFtHbG+Z9p0RgQN+5QUYmz8=;
        b=wQIa89VUC/ljVyWjGdXUv0kb+ijSInOyiztjFZA5oCz5ZbbnvVn7feuAZhKVZ/s6yz
         J87h1BZO32RFGTyrLfh9BoWRwDB9i/SLSJkzBPpujovpuFk0WhzhFZovRvxGzNAbq8sb
         4XwladypL3NQ80adyl+NitVDQ3KSn7ih8Lid7n1DtyDsOn1gnw4O18gAyOCeodBkqLSz
         Uuw7XcoqtJGon9xsXoVgeNsHS/Diz0dI4wIQwVm94gsYeLi7M88YcnF3SgkfeIyGqp46
         jwte6bTLUJuapQVLs2aSlDHz97gw5hHro5fxt7Q6lTfjTsoxqJrJ8AHLketkg9Z3wOfY
         Ildw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=QHtjVQ1B;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=QHtjVQ1B;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Thu, 5 Apr 2018 17:23:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	gregkh <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180405152348.GC32663@lunn.ch>
References: <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch>
 <5AC5FAA8.80409@nxp.com>
 <20180405114736.GA12178@lunn.ch>
 <5AC61393.7090509@nxp.com>
 <20180405124810.GE12178@lunn.ch>
 <5AC63610.4000504@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AC63610.4000504@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596920254514937403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 02:43:29PM +0000, Laurentiu Tudor wrote:
> Hi Andrew,
> 
> On 04/05/2018 03:48 PM, Andrew Lunn wrote:
> >>> Hi Laurentiu
> >>>
> >>> So i can use switchdev without it? I can modprobe the switchdev
> >>> driver, all the physical interfaces will appear, and i can use ip addr
> >>> add etc. I do not need to use a user space tool at all in order to use
> >>> the network functionality?
> >>
> >> Absolutely!
> >
> > Great.
> >
> > Then the easiest way forwards is to simply drop the IOCTL code for the
> > moment. Get the basic support for the hardware into the kernel
> > first. Then come back later to look at dynamic behaviour which needs
> > some form of configuration.
> 
> Hmm, not sure I understand. We already have a fully functional ethernet 
> driver [1] and a switch driver [2] ...

In staging, the tree of crap. You want to get it out of there and into
the main tree. But that effort is being side lined by the discussion
around this IOCTL call.  The best way forward is to to accept Greg is
not going to take this patchset at the moment, and move on. As you
said, it is not needed for the Ethernet and switchdev driver.

What needs to happen before the Ethernet driver can be reviewed for
moving out of staging?

       Andrew
