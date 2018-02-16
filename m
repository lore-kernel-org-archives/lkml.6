Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-881694-1518809242-2-10920508230681372072
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
    t=1518809241; b=JfnQMQyZf7ExTZpG3GrhYf1tFj2fiXrupFPa6sVX1KmupXY
    QwQxCNUWur0OuIS2YBQae7OfUCWUdwqPygVF5KTWdkU4IYluJvPaGkwiZjSZtvs2
    O+Md2AcpHdJrgbpu3gwONjGoveobguHWZe5QQzTWNM3AwamOxfMqt89F9RGE56RK
    FWhtweBkhqBa+/p7hEi+yZAYuY2m8cuR0Qp42a7jYsXhRlGQ77GK+0sXNOaYggtZ
    472Qcj2WQGdADX8ZUR1RWL0BOOTgYFjeWIoasu5E2Eb8FSttfx56NbSvP8+XC1oY
    9UhgrDq5UuKW+sxi7kvnFNwxTOtYyxdxl9V8DQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518809241; bh=/cSguzqQXSi6j4a1tpgfaRINou
    1smMRNINeuOPbo+ww=; b=Ous0Ob4NIGd9H9GK/TZ9kD9q6aE92NYHEuK5NP1LxX
    gAwjvpTCNJhDTP+UIuVZwqirRxTUQuvwaxy7RVn0OTFkviiShMjF5Zu4bl5b8NXq
    2bDkEFdPi69CVR982K5sgT61aQg0q176J1QruWVD6hMBIL7Utmuq1/DCuMxxcoGy
    21lUYh70Nl4oTr0d9pc9xE10ITbTsMS3/Je1JMcymn1Qx7Qe/B3ZaHFUfct5w7Gq
    v/ev646KREixh5xYcBDTIuvBS9ccB6JOwo0HAOBtc5eXnNuh3hhCKmojpAtD9/40
    8RbunnQlCMmYBopbSknCS7cSWpJKORxNQTa5fYkYxjNg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750808AbeBPTZ1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 14:25:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeBPTZZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 14:25:25 -0500
Date: Fri, 16 Feb 2018 19:54:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.4 095/108] Bluetooth: btusb: Restore QCA Rome
 suspend/resume fix with a "rewritten" version
Message-ID: <20180216185439.GE9616@kroah.com>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180215151235.620152736@linuxfoundation.org>
 <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
 <20180216064850.GA26224@kroah.com>
 <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 10:10:44AM -0800, Brian Norris wrote:
> On Fri, Feb 16, 2018 at 07:48:50AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Feb 15, 2018 at 06:31:48PM -0800, Brian Norris wrote:
> > > On Thu, Feb 15, 2018 at 04:17:32PM +0100, Greg Kroah-Hartman wrote:
> > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > Consider this an objection:
> > > 
> > > I'm currently arguing that this is unnecessarily regressing power
> > > consumption here:
> > > 
> > > https://patchwork.kernel.org/patch/10149195/
> > > 
> > > I'll leave it up to you what to do with this, but if this ends up in
> > > Chromium OS kernels, I'm likely to revert it there...
> > 
> > Is that patch in Linus's tree yet?  If so, I'll be glad to also apply it
> > here.
> 
> The link is the original patch, where I'm (too late?) complaining about
> its side effects. Hans and Marcel are discussing potential alternatives.
> This stuff happens in -rc kernels. But you're already ready to push it
> out to -stable users? I can try to push another few reverts into Linus's
> tree if that really helps, or else you can wait on pushing these to
> -stable until 4.16 settles down.

I can drop this for now, but I really like to be "bug compatible" with
Linus's tree if at all possible.  That keeps the pressure on people to
get Linus's tree fixed :)

I'll drop this if the maintainer tells me to do so...

thanks,

greg k-h
