Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4154219-1517504696-2-9769856824416001259
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
    t=1517504695; b=o9VUOwYv1VpxVEwy3VlVmUKBS2xk6rcky5ForI0KWbfw9g3
    i2P/PLHbqZLde4dTzgEUA7Y0ZnNC97NrFsgJGPNyra1rTWybrMvBb46cCsyBdmR8
    E5kB9Hvw08EbsbjPUjmYZ3x9yYVLjt4XtrvFaDUyrgW/71Q0EUcCGaS5KtML6hcW
    gdjaEbYh9W3hIJKn85WZHlUKj7B+umMu/DRV3ItDaK92hohj/CQr32en1lKZKJ2I
    ZnfJhUjlaKUjIqgAi2NykoViYi3prgmIxLYSdyctifPm3yWNvYfdYv5rm/6n2pgD
    drz0hlSJ3/gbNk2M0qtcEuX93UcgMzXDsT60kpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517504695; bh=j8pjetKoEEdPIp8L0d1SMRXyis
    yrJ66x0zyTkpd0f8I=; b=u2KT8gdSzxNMtCfX/6hv/50SdNrW3l5u2wDnW8utaT
    p4xY5EkLRjGnA/Smwk3yydVwilv/8PVPKTBumZ18cIBylVaL77Ty4K/uC7ObHAqY
    3wgg3Sv/f5Ls/UB+g3iJvacGeRN/p1eUCgtvE3DEFg9pfFQz+aq2NrLE7Zx+dCtj
    JF5S+Lxz9QlXtphA3wWUlu1sxDOhUK+EWAPjXiQyPYXes0jPP9XedxAQGcIxAd5Q
    CA7aLei+QGsTZ+lKcuqCKx36z6FF1f8FeiBw+2ZOv+vTg7ozPOAntAQd1J7rBn/A
    rUko06BGe5SJhcpE+803EQpo/dowszjUjon6P0Eq+VeQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeBAREy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 12:04:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeBAREx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 12:04:53 -0500
Date: Thu, 1 Feb 2018 18:04:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Salyzyn <salyzyn@android.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        Paul Moore <paul@linuxfoundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        stable <stable@vger.kernel.org>, James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2] general protection fault in sock_has_perm
Message-ID: <20180201170447.GE12838@kroah.com>
References: <20180201153708.63506-1-salyzyn@android.com>
 <CAHC9VhSdR9UGpYhod5xhA76EbSKHzTW5rEiYWMovC0t6gfowig@mail.gmail.com>
 <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 08:20:13AM -0800, Mark Salyzyn wrote:
> On 02/01/2018 08:00 AM, Paul Moore wrote:
> > On Thu, Feb 1, 2018 at 10:37 AM, Mark Salyzyn <salyzyn@android.com> wrote:
> > > In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE socket
> > > flag") and all the associated infrastructure changes to take advantage
> > > of a RCU grace period before freeing, there is a heightened
> > > possibility that a security check is performed while an ill-timed
> > > setsockopt call races in from user space.  It then is prudent to null
> > > check sk_security, and if the case, reject the permissions.
> > > 
> > > . . .
> > > ---[ end trace 7b5aaf788fef6174 ]---
> > > 
> > > Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> > > Signed-off-by: Paul Moore <paul@linuxfoundation.org>
> > No, in the previous thread I gave my ack, not my sign-off; please be
> > more careful in the future.  It may seem silly, especially in this
> > particular case, but it is an important distinction when things like
> > the DCO are concerned.
> > 
> > Anyway, here is my ack again.
> > 
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > 
> Ok, both Greg KH and yours should be considered Acked-By. Been overstepping
> this boundary for _years_. AFAIK Signed-off-by is still pending from Stephen
> Smalley <sds@tycho.nsa.gov> before this can roll in.

An ack is all I need here, or I can just rely on Paul's :)
I'll edit up Paul's when I apply this.

thanks,

greg k-h
