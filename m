Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3613467-1521750365-2-8577735022002249326
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521750365; b=w/cfBYXyhOsT9YBu0BPl2X5HuE0eHW+uE46gj2QoUMH1sjR
    qI30ysvNq4HlCaoh3mQTkgxoJjr5dtwbRcSfzzxt1XAE2If3ClQ8cLV7qOgIEFvI
    cZafnEJiK3qpPj218xrXaDLA4jbTZYwYXq6ZVFIfEXHa+kw1ugtteqYuBlGlHiMp
    Iuir5Ci/e5SclcYAbvPyKIsDoSERt8pvIIBZqWoF0eBaN4KODcJe4OuQsV8M735R
    HDaaQgN5m4rP6tZw7RKt6MI/GdtMzM/gpVyBXI4oLUqQy9dt6VNgh1bUKLlUVpM0
    kI/mAlZ72O7v0Zr+lw+o/1VVOOkvCkw7QkNvTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521750365; bh=vxo1NVHz2mmJg6N7jWIYhb0RDg
    bmq69kn/m6G26gUio=; b=EhYJZRa2aLhUagjU/3RKHqVWAeMAwEtL0OcqFY2y1t
    49qu65p1fmAkq80uC+T3vNsj5OXoulvM2W/qR5F3X714LYJR8UnOsK8fJvqsovXq
    fEvu0rOn2FoPZS9btWtJfRXH0+BFyXcQyHz3iEYuVpBIP+GbJW0MNpfBNzFNCYih
    sqYk+lgYjuOZWaF6p7njYhdekMXBEizaBm3ZOvlCyjamKylRyCekTzh1tjJ+54sA
    F+kX8clSH/ybeslKsGWUIbn3//jWmprBwzFmHP+xbizfNJGdmu5TfQp3u8eQsDpa
    WPA9hGzT7Bc9NSwjr39P7ABDHPfLgbRiN98WZaYY2VAQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeCVU0C (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 16:26:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeCVU0B (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 16:26:01 -0400
Date: Thu, 22 Mar 2018 21:25:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Brian Norris <briannorris@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4.4 095/108] Bluetooth: btusb: Restore QCA Rome
 suspend/resume fix with a "rewritten" version
Message-ID: <20180322202558.GA28958@kroah.com>
References: <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
 <20180216064850.GA26224@kroah.com>
 <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
 <20180216185220.GA29352@roeck-us.net>
 <20180217134351.GB28145@kroah.com>
 <befd1dc3-32ee-bd00-876e-a59397cffd37@roeck-us.net>
 <20180217152459.GA22308@kroah.com>
 <CA+ASDXMvsgOUkxyYuMNqNduNJR5k-jWHynfXvpEdTLGPZyD=TA@mail.gmail.com>
 <20180322175251.GA24850@kroah.com>
 <20180322185635.GA4411@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322185635.GA4411@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 11:56:35AM -0700, Guenter Roeck wrote:
> On Thu, Mar 22, 2018 at 06:52:51PM +0100, Greg Kroah-Hartman wrote:
> 
> [ ... ]
> > 
> > And that't the point to drive home here.  If you stay away from updating
> > to stable patches, you have a huge boatload of KNOWN SECURITY HOLES in
> > your product.  If you take them, you have the _possiblity_ of some bugs
> > added, but overall, the rate is _VERY_ small.  Guenter has numbers of
> > 2-4 patches per year cause problems.  That's lower than ANY other
> > development model I have ever seen anywhere.
> > 
> Unfortunately, people tend to be irrational. Yes, the regression rate I have
> observed is in the 0.1..0.15% range for v4.4.y and v4.14.y. Yet, there are
> still people who believe that we should not merge stable releases due to the
> regressions it causes (though they are much less vocal nowadays).
> > So, stick with known buggy/insecure devices?  Or take the updates and
> > handle the 1-2 problems a year they provide you.  I think the
> > cost-analysis is easy to make here :)
> > 
> 
> Agreed, on an objective basis. Unfortunately, one does not get credit for
> fixing bugs which have never been observed in the field because they have
> been fixed before they showed up. But one _does_ get blame for regressions.

Someone has half-way joked that they were going to turn an intern on the
stable releases and get a CVE assigned for every patch in them.  Just to
highlight just how many "real" things we are fixing before anyone
notices.

Some days I think that is going to be the only way people pay attention :(

> Even though there have been very few regressions in absolute numbers, the
> default reaction to newly observed problems is "it must be due to a stable
> release merge", even though it almost always turns out to be incorrect.
> 
> The only way to deal with that is to reduce regressions to 0, or as close
> to 0 as possible. 0.1% is good, but not good enough.

For some platforms, it is 0%.  Facebook has published numbers showing
this for a 2 year run of stable kernel releases.  When you start dealing
with crazy embedded/odd hardware platforms, the numbers does go up, just
because no one is testing those platforms before I do a release.

Hence the push to do the testing on the real hardware, which is why
kernel.ci and Linaro are now doing this.  If you note, we also have
people doing merges on their phones, and I get private emails from a
number of SoC companies showing that their merge/test cycle worked as
well.

And one note from that SoC testing, in the past 6 months since it has
started, I have _NO_ reported regressions on any stable release so far.
Not bad...

> Also, while I agree that we are much better off in respect to security,
> the verdict is still out if stable release merges actually improve release
> stability; I don't see a clear trend even with chromeos-4.4. Of course,
> it is all but impossible to say if this is due to 4.4.y or due to the
> 13,000+ patches we have on top of v4.4.y in chromeos-4.4.

Yeah, _THATS_ the major issue here.  The interaction of the 3+million
lines of out-of-tree crazyness in device trees still scares me.  But, as
the SoCs are now reporting, so far it's going well, but it's only been 6
months.  But it has been an "interesting" 6 months :)

As for "improve" stability, well, given that we are fixing
known-root-holes, yes, that does increase stability.  Again, I can crash
any phone shipping today except for 2 of them, because those 2 updated
to newer kernel versions.  Do I need to start publishing reproducers?

Actually, along those lines, I have seen people start putting tests for
reported kernel bugs into some regression tests.  When those start being
more popular (i.e. people start running them on devices that are not
updated), then you will start to see the reports of "instability".

Oh well, back to patch reviewing, I'm preaching to the choir here...

thanks,

greg k-h
