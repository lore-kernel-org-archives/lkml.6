Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2858053-1518875033-2-18147952765359220794
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
    t=1518875032; b=Kd5ed2qp+a5g5gNoOtT+qtDi/60RDYBY/oUeEigatMudcGA
    jzxweDLorIAqyHoq5ASIfgF2hQptrotrWP3me16uJPzU2Hm+8UouDVa5NDI/dK9p
    rI6s4dR73nKlKoxmlUvPW26VVHY7O3ZJjGfsmVNcFF9D8nqqC196TSmtqY6gIjr+
    ASapCduMhuvgHudZGD6tdZ9X13lwPTkMwUFlqXskapfYpi8OVq/V7DUPpiXXZJ8K
    5atimAzokfhEMdQN/qEl07AY/HtTK4v2NINOcTtpBFuigHc/resj1/R9bXOAmm1S
    4trkfJ1Y5aFLBX13U4/MvIsHTtrigrQSdMb04jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518875032; bh=9+mf75mXizX/N9m2eDyW6jND9j
    xdOrmfy6AuKWrnhRU=; b=TyIOFRMzNoVBiMN717V9mmTc2KV0STbjk6qUWxs5js
    h1WZsrnIDZN50mAPLX5CtgesFXSO0gO34pJvJOKPZesi3uWRl+AJ7oRMkZkeZVkv
    rl7ygXvjw7NDHZPwiXIF4TFpxKM+y8NP+ZYnH8OtjwHiqleGQIn31atGYsqyIlX8
    VlihpZoU2XMz+cHgbn5vuw9+Q8gqvMyDhS5NhfpLTXiNKnGta41i7Tja9xOv8x2G
    2lB5SCV0nC51jfQZS9M65v8EcOV+RtUUfWnmepVfjUJhFhVYxvjb0xdr0lSpktzK
    HlG66+5e26pGii0obkRO4LFFLktmASwYMTIhQn2OZrxA==
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
        id S1750994AbeBQNnv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 08:43:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbeBQNnu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Feb 2018 08:43:50 -0500
Date: Sat, 17 Feb 2018 14:43:51 +0100
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
Message-ID: <20180217134351.GB28145@kroah.com>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180215151235.620152736@linuxfoundation.org>
 <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
 <20180216064850.GA26224@kroah.com>
 <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
 <20180216185220.GA29352@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216185220.GA29352@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 10:52:20AM -0800, Guenter Roeck wrote:
> On Fri, Feb 16, 2018 at 10:10:44AM -0800, Brian Norris wrote:
> > On Fri, Feb 16, 2018 at 07:48:50AM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Feb 15, 2018 at 06:31:48PM -0800, Brian Norris wrote:
> > > > On Thu, Feb 15, 2018 at 04:17:32PM +0100, Greg Kroah-Hartman wrote:
> > > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > Consider this an objection:
> > > > 
> > > > I'm currently arguing that this is unnecessarily regressing power
> > > > consumption here:
> > > > 
> > > > https://patchwork.kernel.org/patch/10149195/
> > > > 
> > > > I'll leave it up to you what to do with this, but if this ends up in
> > > > Chromium OS kernels, I'm likely to revert it there...
> > > 
> > > Is that patch in Linus's tree yet?  If so, I'll be glad to also apply it
> > > here.
> > 
> > The link is the original patch, where I'm (too late?) complaining about
> > its side effects. Hans and Marcel are discussing potential alternatives.
> > This stuff happens in -rc kernels. But you're already ready to push it
> > out to -stable users? I can try to push another few reverts into Linus's
> > tree if that really helps, or else you can wait on pushing these to
> > -stable until 4.16 settles down.
> 
> FWIW, here are the various commit SHAs.
> 
> Upstream:			61f5acea8737
> v4.15 (queued for v4.15.4):	e766a2d7f7c2
> v4.14 (queued for v4.14.20):	736385472dfa
> v4.9 (queued for v4.9.82):	1c6fc2167678
> v4.4 (queued for v4.4.116):	575538a5371d
> 
> I didn't check older stable kernels.

Thanks, but I've now released all of these with this patch committed, so
we are now "bug compatible" :)

Please work to get this resolved in Linus's tree and I will be glad to
backport the result.

thanks,

greg k-h
