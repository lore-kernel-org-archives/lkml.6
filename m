Return-Path: <briannorris@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519328152; cv=none;
        d=google.com; s=arc-20160816;
        b=TWWklJSWsR8/RdR0kowZUzGTa5/rigs2Vx1uNEVKTtzopnhLphSc+XCEyyR2Y8wu2p
         4naZfCRtn7EMNIG+tCEhYPV1COczXqsJik3btacHefWcju2G+0s9s95vZeNHCTLVOtyc
         L+LNyGWfH8h2mFEsAgNmdCPKnFzSJvKH/e6fBo6NDie0Y67T1f/UEe0kazS8N4nAtxzY
         SHdjnG52dtmvV56BHBNluJNVIpvNu79LslPK6Bm+dSad1Yw1kXElojqiZu06F3hHrCQc
         hNM/0XcXhkAj4gn6q66aw6Dh7kbltLUukgeacMd0JVaNax9RSOhIpZB5sVqcebA6gUcw
         zE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=TQNlkDg1N+ZM64dEGmQOkSTC+5SDaD6TX976vkVuurs=;
        b=N2+JjtRr3mHJJF/QvLlhLz6+HHDxNz5vt3iFrc8YcuN/RUHPCg7ZRsRmjF201/jC+3
         KVm1peh9Q+t0/clsH2bhP3B6Z0SSsijr41H3Bv6Fk6UvQNtZNZ77GmcMqMT9RszWuY3H
         CxZ2Y+kotoQlPilADOhKJ/Hj9nfJZQDCSNaSudVb4bG0g9aizSV3xPed73uRHhDpH3EK
         apXFWpGkJdpDL0prttdWpOnoFXArB7RueMIrcak4P89/ks8jXukRn6WZov1Q15EZLeQJ
         Cy2lSqmMcONFwE5H2xz3wieuyM/7ltaGauG85GKBmBvWeeLqwWKcoA4GSxKLm0SwJfbO
         BDKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=LyiM1BWZ;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=LyiM1BWZ;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x226InfqvBPCk6CSsd4nj6Hy+xtmE2SWzV/NRH5sYn418i6DtF+Bnb0K0M08Sz0NZihYuoNP3Vg==
Date: Thu, 22 Feb 2018 11:35:49 -0800
From: Brian Norris <briannorris@chromium.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@codeaurora.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] mwifiex: support sysfs initiated device coredump
Message-ID: <20180222193547.GA78462@rodete-desktop-imager.corp.google.com>
References: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
 <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
 <20180221225903.GA42395@rodete-desktop-imager.corp.google.com>
 <5A8EB4F4.2030103@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A8EB4F4.2030103@broadcom.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398864870404?=
X-GMAIL-MSGID: =?utf-8?q?1593131036471468885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arend,

On Thu, Feb 22, 2018 at 01:17:56PM +0100, Arend van Spriel wrote:
> On 2/21/2018 11:59 PM, Brian Norris wrote:
> > On Wed, Feb 21, 2018 at 11:50:19AM +0100, Arend van Spriel wrote:
> > > Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
> > > it is possible to initiate a device coredump from user-space. This
> > > patch adds support for it adding the .coredump() driver callback.
> > > As there is no longer a need to initiate it through debugfs remove
> > > that code.
> > > 
> > > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > > ---
> > >   drivers/net/wireless/marvell/mwifiex/debugfs.c | 31 +-------------------------
> > >   drivers/net/wireless/marvell/mwifiex/pcie.c    | 19 ++++++++++++++--
> > >   drivers/net/wireless/marvell/mwifiex/sdio.c    | 13 +++++++++++
> > >   drivers/net/wireless/marvell/mwifiex/usb.c     | 14 ++++++++++++
> > >   4 files changed, 45 insertions(+), 32 deletions(-)
> > 
> > The documentation doesn't really say [1], but is the coredump supposed
> > to happen synchronously? Because the mwifiex implementation is
> > asynchronous, whereas it looks like the brcmfmac one is synchronous.
> 
> Well, that depends on the eye of the beholder I guess. From user-space
> perspective it is asynchronous regardless. A write access to the coredump
> sysfs file eventually results in a uevent when the devcoredump entry is
> created, ie. after driver has made a dev_coredump API call. Whether the
> driver does that synchronously or asynchronously is irrelevant as far as
> user-space is concerned.

Is it really? The driver infrastructure seems to guarantee that the
entirety of a driver's ->coredump() will complete before returning from
the write. So it might be reasonable for some user to assume (based on
implementation details, e.g., of brcmfmac) that the devcoredump will be
ready by the time the write() syscall returns, absent documentation that
says otherwise. But then, that's not how mwifiex works right now, so
they might be surprised if they switch drivers.

Anyway, *I'm* already personally used to these dumps being asynchronous,
and writing tooling to listen for the uevent instead. But that doesn't
mean everyone will be.

Also, due to the differences in async/sync, mwifiex doesn't really
provide you much chance for error handling, because most errors would be
asynchronous. So brcmfmac's "coredump" has more chance for user programs
to error-check than mwifiex's (due to the asynchronous nature) [1].

BTW, I push on this mostly because this is migrating from a debugfs
feature (that is easy to hand-wave off as not really providing a
consistent/stable API, etc., etc.) to a documented sysfs feature. If it
were left to rot in debugfs, I probably wouldn't be as bothered ;)

> > Brian
> > 
> > [1] In fact, the ABI documentation really just describes kernel
> > internals, rather than documenting any user-facing details, from what I
> > can tell.
> 
> You are right. Clearly I did not reach the end my learning curve here. I
> assumed referring to the existing dev_coredump facility was sufficient, but
> maybe it is worth a patch to be more explicit and mention the uevent
> behavior. Also dev_coredump facility may be disabled upon which the trigger
> will have no effect in sysfs. In the kernel the data passed by the driver is
> simply freed by dev_coredump facility.

Is there any other documentation for the coredump feature? I don't
really see much.

Brian

[1] Oh wait, but I see that while ->coredump() has an integer return
code...the caller ignores it:

static ssize_t coredump_store(struct device *dev, struct device_attribute *attr,
			    const char *buf, size_t count)
{
	device_lock(dev);
	if (dev->driver->coredump)
		dev->driver->coredump(dev);
	device_unlock(dev);

	return count;
}
static DEVICE_ATTR_WO(coredump);

Is that a bug or a feature?
