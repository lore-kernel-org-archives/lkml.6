Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-466278-1525874235-2-3761426508973196981
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525874234; b=iEc81dLOfJ9mX/2Yj2s7jLpPylziPp4AOE9EEpBfa0UKs9U7QX
    Rpq6CQ8hg0cnMZU0ktmeoBoikuewvFRI58LliRK66uv4+edC3UASS71gzkE67p05
    9Udn9PSqUyb7usbgSN6iSvxO1yV+AwNTNXZJ6x93EmXqhZ6az3hYtPRsodR7NyDx
    ZXQGjB7bSPbMM2K3b99eV7QgIDjW5nXRve1qgVKz+SXvIAGFW5rLyDrwl99AUV+U
    W4PhKvHDs5J+csemucYVUbAbx586asg3h/BNt5tFkwfpR/YurmyRUSiPqeD9Te1K
    /apiBwPKCv1g6i/gf6TbEBorryrmCNbvoQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525874234; bh=z/E0hb5SzDtZ28aFkOUjZuawSUpV60
    37kW12q5RWGho=; b=fk7zfh2qM1yAirifu6/4mtxqDWWohLqExgLZ8sVelObVgR
    hnHaLgBNEGEO9GB+p6L0HeMnxZ7wtnqny1553/jQOTFccJgsTus1Ve9iWkS/u5ek
    rnz8o5VA3Thcaf3r38BAWrffLVKQ4fNfAugHje5QaHZuMxHfJrv5y70FKR9S+ByU
    u7UooNOYMnEh0CANFjuXNTgzuQlyY0ZxU70gtJF1gIscGeT9LLST3GyJyl6c0ANp
    ryLrkY9cBL03HBGOMEMFWW1TALxJ5OHnGWOjSL4kq29wA2JFBlZMQB84ZojYrMrJ
    6pPNCufckvHE8Vt7K3WsB2fjryPgTU586Jc7zR6g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfArKYJxQL6ngQ1Mn2b0pGT5JDigMKpU/rWk/rOr2PZfN7DJ0lmbaKoO2dS35xDOiZmltGZUrREiFjpvRE0BVEhfh3zSTmli4gmW35RoqN8ICBVbaqYmO
    cjmG/3HX/VQsYQoVXfuryc2wocmqwA3FSl8viYPcQ3oWdMr82VVgJ52fjLNPbnEIlWV4ppUkX+xIjTt98GY1HlmnA6vYRhzvSC9wiezQq2DRsS+2mHBMjJm9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=iwNJb3IMfoYcIu7tAcoA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756252AbeEIN5N (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 09:57:13 -0400
Received: from muru.com ([72.249.23.125]:41398 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756221AbeEIN5K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 May 2018 09:57:10 -0400
Date: Wed, 9 May 2018 06:57:06 -0700
From: Tony Lindgren <tony@atomide.com>
To: Johan Hovold <johan@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: OMAP serial runtime PM and autosuspend (was: Re: [PATCH 4/7]
 dt-bindings: gnss: add u-blox binding))
Message-ID: <20180509135706.GB98604@atomide.com>
References: <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180507175032.GR98604@atomide.com>
 <20180508065852.GW2285@localhost>
 <20180508152228.GV98604@atomide.com>
 <20180508154756.GW98604@atomide.com>
 <20180508155405.GX98604@atomide.com>
 <20180508164904.GZ98604@atomide.com>
 <20180509131003.GC2285@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509131003.GC2285@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Johan Hovold <johan@kernel.org> [180509 13:12]:
> While this seems to fix the idling of closed ports here too, I'm not
> sure we can move use_autosuspend to startup() like this.
> 
> First, this flag should be set before registering the tty so that udev
> can be used to update the attributes.
> 
> Second, this prevents setting the autosuspend delay through sysfs when
> the port is closed (when autosuspend is disabled).

Yeah I noticed that too yesterday.

> It seems we really should not be using the negative autosuspend to
> configure the RPM behaviour the way these drivers do. Perhaps a new
> mechanism is needed.

Hmm well simply defaulting to "on" instead of "auto" and setting the
autosuspend_ms to 3000 by default might be doable. I think that way
we can keep use_autosuspend() in probe. Let's hope there are no
existing use cases that would break with that.

> But I'm afraid I don't have time to look at this today.

Sure np thanks,

Tony
