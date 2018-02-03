Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3809097-1517623063-5-2548887448673951027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517623063; b=PjSJbfF7dqP9m6j0xnJ0wX7ll0S10d3sm5mvgAggVcC6wL9
    ZeIt2b8gb/sMu80aVLzYojnLLKIJfVSxF2xoiFbG9m8SkTFPsLPxo2GRSJ29IeDt
    +cvH+nB5s4FsW6xbJKb1UEhY1dsIoQtvmTCu2I+46eJ8bvkNiH3bcRumTK08NSlP
    ZPQTyDoKIcucaHn+5PvKcYt3zGwRGZvRT4f1oUGXOHzwefYhME3C2+UjRvLaFhUX
    lw5/VmYRA95gLg+iBasxHw5ogxXPnY3h8csgImMGB3lJSluwGPpvu9u8KU9Fo7GQ
    1HhSnRVfwDxz+PTuFzIjGIov8dvvUniGvg+Libw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517623063; bh=eCD41MyhRa3umfpMoSpBRLHi7W
    jIveArL1faqsF3Dw8=; b=v9eceRI2tLNrmNK/Gb6f0RgISorinyQLllknUoXMOi
    0zsetxmHpB0sbl6sfxcpzX5/mSpkEIogZ6ZO/EF0eNUM6p4LOQxURLcK0lL7yQfM
    /bKG1kzir6IVPnoFGyRcJKCHaSxAErYfqE6ZckjXuv+T6B/lbixOayUWD8ilfmmf
    7amFsUjeXy1ibxI2g6y/Fk30DKS/ZEQsjXu1sRrxS+7fieTTwCPHd45fH20vPPxm
    zJ2cnUZtnNKozE0x6athc7Ov2uvwpGYDO57VreJ2AU7W9kRoXwMSq1SBOwdOl8hI
    f0tBExzaw82j5ljjrvAx8EP4t3MvVTHGqUL55SwAg14Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hallyn.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hallyn.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeBCB5Y (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 20:57:24 -0500
Received: from h2.hallyn.com ([78.46.35.8]:36452 "EHLO h2.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeBCB5X (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 2 Feb 2018 20:57:23 -0500
Date: Fri, 2 Feb 2018 19:57:21 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Guy Briggs <rgb@redhat.com>, cgroups@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Audit <linux-audit@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Network Development <netdev@vger.kernel.org>,
        mszeredi@redhat.com, Andy Lutomirski <luto@kernel.org>,
        jlayton@redhat.com, Carlos O'Donell <carlos@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Simo Sorce <simo@redhat.com>, trondmy@primarydata.com,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: RFC(V3): Audit Kernel Container IDs
Message-ID: <20180203015721.GB27295@mail.hallyn.com>
References: <20180109121620.wi7dq2423ugsraqv@madcap2.tricolour.ca>
 <CAHC9VhQ5ciUZDhrsb6S4YxwuzQEY-ra2RTDceWXOdjHEBoZ0BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ5ciUZDhrsb6S4YxwuzQEY-ra2RTDceWXOdjHEBoZ0BQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 05:05:22PM -0500, Paul Moore wrote:
> On Tue, Jan 9, 2018 at 7:16 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Containers are a userspace concept.  The kernel knows nothing of them.
> >
> > The Linux audit system needs a way to be able to track the container
> > provenance of events and actions.  Audit needs the kernel's help to do
> > this.
> 
> Two small comments below, but I tend to think we are at a point where
> you can start cobbling together some prototype/RFC patches.  Surely

Agreed.

LGTM.

> there are going to be a few changes, and new comments, that come out
> once we see an initial implementation so let's see what those are.

thanks,
-serge
