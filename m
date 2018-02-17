Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3035676-1518881103-2-7786967241566007393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518881102; b=AdyFqja3mL+p7Fgul7uEz6dDtmn8ucSRaK9j5yMX5LAVcyO
    uaw7xHODR6YyuSiszEDBVPcw55s0bATe4zUjYU+aVmcU2QrwsND4VqkpLbB9QBHo
    mf2LACvNckXVSNBEcILDmBCR4ZZAd9MVsGee+x7khqT0vN8+yHX+Nksfm/u2F9WX
    s6oPg/k61P9vaeaoIJfwZHgB5nuaHY/PCEfZGzYoULPxtW9LWk36X79KQx9rMCwe
    r7JHWGN2nVW+L7SmLXgt4RcIqXbURQln3qC2Eih70tkmt8JPQ7nUuIBFZqhvb+g7
    4W0S2wrEa1g5MrDXxSCNsnl5HYZENnVWe5R77Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518881102; bh=gn1+GiEqvhv6si1E2yHx3XZiAC
    BwoDgO8lLWxuVejCk=; b=Nno/8AToBl/wnLIqBB4Al/YlfjWJMWBvocwNoaYm0P
    1YlB6j266T7c3YlsiBdLu4x6B0jv120Psc3RUKhuV27g6AvZeUKYZ/VzED76V41D
    3hwCEhY2Yuzv24kBAYCPkF1AGaP8Q5QGFgcvlf27jHpOP8IgZNxTeZFxWl5AN8Q4
    ro10oVkehEaJFafAuea4mcn8MLyxOzyIbbLfaHqmH/gWaS0/VwABPqIrlZJq3et0
    Xv9smY0Obeb4kCYUSreEuKNozchE8mu/Q/hLnYj95I9FEv2jEaDyqR/1PZv1BAIW
    AyYM/IVew/QYaJDiv0sBHa/ouBoBfbrxcOtqjd0AWQXg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbeBQPY7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 10:24:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbeBQPY7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Feb 2018 10:24:59 -0500
Date: Sat, 17 Feb 2018 16:24:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4.4 095/108] Bluetooth: btusb: Restore QCA Rome
 suspend/resume fix with a "rewritten" version
Message-ID: <20180217152459.GA22308@kroah.com>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180215151235.620152736@linuxfoundation.org>
 <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
 <20180216064850.GA26224@kroah.com>
 <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
 <20180216185220.GA29352@roeck-us.net>
 <20180217134351.GB28145@kroah.com>
 <befd1dc3-32ee-bd00-876e-a59397cffd37@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befd1dc3-32ee-bd00-876e-a59397cffd37@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 17, 2018 at 07:12:17AM -0800, Guenter Roeck wrote:
> On 02/17/2018 05:43 AM, Greg Kroah-Hartman wrote:
> > On Fri, Feb 16, 2018 at 10:52:20AM -0800, Guenter Roeck wrote:
> > > On Fri, Feb 16, 2018 at 10:10:44AM -0800, Brian Norris wrote:
> > > > On Fri, Feb 16, 2018 at 07:48:50AM +0100, Greg Kroah-Hartman wrote:
> > > > > On Thu, Feb 15, 2018 at 06:31:48PM -0800, Brian Norris wrote:
> > > > > > On Thu, Feb 15, 2018 at 04:17:32PM +0100, Greg Kroah-Hartman wrote:
> > > > > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > > > > 
> > > > > > Consider this an objection:
> > > > > > 
> > > > > > I'm currently arguing that this is unnecessarily regressing power
> > > > > > consumption here:
> > > > > > 
> > > > > > https://patchwork.kernel.org/patch/10149195/
> > > > > > 
> > > > > > I'll leave it up to you what to do with this, but if this ends up in
> > > > > > Chromium OS kernels, I'm likely to revert it there...
> > > > > 
> > > > > Is that patch in Linus's tree yet?  If so, I'll be glad to also apply it
> > > > > here.
> > > > 
> > > > The link is the original patch, where I'm (too late?) complaining about
> > > > its side effects. Hans and Marcel are discussing potential alternatives.
> > > > This stuff happens in -rc kernels. But you're already ready to push it
> > > > out to -stable users? I can try to push another few reverts into Linus's
> > > > tree if that really helps, or else you can wait on pushing these to
> > > > -stable until 4.16 settles down.
> > > 
> > > FWIW, here are the various commit SHAs.
> > > 
> > > Upstream:			61f5acea8737
> > > v4.15 (queued for v4.15.4):	e766a2d7f7c2
> > > v4.14 (queued for v4.14.20):	736385472dfa
> > > v4.9 (queued for v4.9.82):	1c6fc2167678
> > > v4.4 (queued for v4.4.116):	575538a5371d
> > > 
> > > I didn't check older stable kernels.
> > 
> > Thanks, but I've now released all of these with this patch committed, so
> > we are now "bug compatible" :)
> > 
> 
> FWIW, seems to me that trying to be "bug compatible" with -rc1 upstream
> kernels may not really be a good idea for stable releases.

It's a tough trade-off.  If I dropped this patch, the normal mode of
operation would be for it to get merged into device kernels and then
forgotten about.  Only if/when the user with the problem moves to a
newer release a long time later would the regression normally appear
again, and everyone would have to remember what happened and try to
piece it all together again as to what commit caused the issue.

By you adding the revert to your device kernel now, you have a record of
this being a problem, how upstream isn't fixing the issue, and when/if
you do move to a newer kernel, that bugfix will still be there in your
patch stack to forward port.

Yeah, you all are normally better than that, and I trust that you will
push to get this resolved, hopefully soon.  But for the most part, this
method works best overall for the majority of the cases like this as not
all bug reporters are persistent, and if not, the maintainer usually
forgets about it as no one is saying anything and they have other things
to work on.

Well, bluetooth is known to not have responsive maintainers, so who am I
kidding here, odds are it's only going to get fixed as Hans is
involved, despite the bluetooth maintainers :)

thanks,

greg k-h
