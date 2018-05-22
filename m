Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2247758-1526979853-2-6781130176731059451
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526979852; b=NU0doUQ8tpcjfSfxGfytAdrvxcVIzusPu/Ynajvkt7nr6EEGgo
    LHFZ2Ow8gYvs4hE5fpzxI2BBVwAEen6ngK6nYNQczH1ubcqZLJd41yR7AYjc0Ebk
    1ZqTUoq2vr/e7Wuj0uWIP58t/2i8sv6r9MoCsbK2cIbImcCo9VJep3qWc2t1+OyL
    O1iJV5WMsP1+pkUBXTDYsHzxeMvkTFU2JURyXQx0VByNE2esZuqWiRBJDhgGmEi5
    Q3I5/FOGoZXTpcDGDR2Bpvj8aKJ5mMhaknbKmHTWkr1pqQoidU3GvoLaAApxyS+S
    5MdCWR3LB+SogP0QSfH8gg8ubqhXJ5uxdZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526979852;
    bh=8EqG2j4OYsZXLCJU49b5GDn9lOZkJkM2WjoX693E/rY=; b=IBiI3MbBY/Cp
    +lAQFRPTSAIJ+kMX2hSjEGaKov5RmHkoDI5nlUkSZz6EHORhHrwIK4sWMqCmtmkZ
    h1+FH8xp5t8aDflorGd2LcMZIQP3UweSW+p8RPfonSX8NUASuIFhvyB2sB3dLxkV
    OZQEKnxRyuCQXzfrEvGr7DdnWl5M/oV2ElqySGQv36kasdgEGcddz76dq8XxZpra
    gmTKCwXfr+bSvBi0GujcMYm3tuaKkNvAEXaBJrq9u/EsXS9dylOQuv9IE32s20rx
    DFa7C4hQdI6khQvlJTclfZ/xrVo1ylSNB11nYEzLvBa1579maYkjVVmN4BR5pxLI
    o2m8b1vnXA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPbJhyFx2+qCvh0a5j7Y9/bB2Gbuuk9o/kR8VHSVnz6LKe9lpWHidcFKZYh3v/K5agKFga/RBqqNVBpdR0Zzmb+v8IbVScDe4KWvnLiQcoU1SMVcWGPq
    3cZKCgS+XHNvM1lw0cRbJIKiMg4aVn5Bi8d8xDOvp4U7EZTrl403hTtZqpmJaSEa60iQzLD2bAwDvjX01RcgT9AuE+yO4dy/Ej48tU13O1ceftKGwmhNipt7
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=wa9yNeOZSGM4TNCpDrYA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbeEVJD7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 05:03:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:42042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751172AbeEVJD6 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 22 May 2018 05:03:58 -0400
Message-ID: <1526979432.30491.0.camel@suse.com>
Subject: Re: [usb-storage] Re: [PATCH v2 0/2] Re: usb-storage: Add quirks to
 make G-Technology "G-Drive" work
From: Oliver Neukum <oneukum@suse.com>
To: Alan Stern <stern@rowland.harvard.edu>,
        Alexander Kappner <agk@godking.net>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, gregkh@linuxfoundation.org
Date: Tue, 22 May 2018 10:57:12 +0200
In-Reply-To: <Pine.LNX.4.44L0.1805211346090.1940-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1805211346090.1940-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Montag, den 21.05.2018, 13:47 -0400 schrieb Alan Stern:
> On Fri, 18 May 2018, Alexander Kappner wrote:
> 
> > v2 of this patch implements the FL_ALWAYS_SYNC flag in the UAS driver, and then
> > adds the flag as quirks for the device at issue. This allows the G-Drive to work
> > under both UAS and usb-storage.
> > 
> > Alexander Kappner (2):
> >   [usb-storage] Add support for FL_ALWAYS_SYNC flag in the UAS driver
> >   [usb-storage] Add compatibility quirk flags for G-Technologies G-Drive
> > 
> >  drivers/usb/storage/uas.c          | 6 ++++++
> >  drivers/usb/storage/unusual_devs.h | 9 +++++++++
> >  drivers/usb/storage/unusual_uas.h  | 9 +++++++++
> >  3 files changed, 24 insertions(+)
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> This is okay with me.  Oliver, what do you think?

Perfect.

	Regards
		Oliver

