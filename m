Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-257651-1525243956-2-11959337490736030704
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
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525243956; b=ZwCCcO/3hdpm/Ta8d0VSOHFCij5PLvWT11+QcujgnBw2nwy1eB
    WjEJvFzk5qXfIvrZFo5jZIo9meSPelXrSCAdO7zJWaPpV2x+jQX4uX7SQLpsz1ip
    S6WCiiO0ORqPXRBNmXL3UqEYkG4lB4jp5NnoFS9QrQ9+I/dGiBLoyOhG3JyDlln6
    a9wAqzMAfIMbby8KbMSOzTYyCLKvzhmlPhkrLA1RYBIqpWnr28uQVVCTe3MkfdGV
    twkLkvTUXN7xr3uFG6lIcwajEX/4upyDWTEvsVb6SsbOw4OX60rcMjCFXYHn9v86
    rvzWW/e+aD/chpyyqMqrJwXSpkPWUrDpSK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525243956; bh=xN0aQUgAtKroXvEzgpc18hHVButw+S
    uigms6g74QtNQ=; b=bGM2Vxh8jC3PEXztWnT4HFHH7ZX7FNEVOwzEfocY/6kK27
    gBl++10N12X53YhNP23772lfqYzbT/pAIu1jNd/q2VqIzXnuUuV9jBSUY/+ocLQa
    Q9Ndy1mvimkit0rGNqYffubQbVN239BfL7iWv315c9ADDnBF4SLvK53easjOnBty
    bO0M6o16phS10TMz/r7HFT2Je1BTswhhk7D2lUaN9/G5XskQTjUuAu2dptKAce/c
    l5HV/Iv2lkn9IklmkMmrhEKBSjW+ssDhDX9L4xlCyST43PX0rD2QjZSMMCuWjd3z
    rxcKFFnbO7dhgMgezO9rAgl9OCero2TPfjflEPCQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMSPP5P4P5P2iqIcdSAFnkCDXvwnykkPj/GCgS9b26rn8ep9WWHC7s1T+PIzBkKSneIaTotBiM6Lmdrzgbwxx02RmJtwThUZStd+eP6NR42DfWIUqLRJ
    Hc/d+KGkYD8E0VN1bk/S3yS/osSkhKeUNy+ZoYPCkURipKYkW2yh04AzK8mIaYiQ8nNTibQIF6mLxqnILEjLg4+dJYuSHET3/14pNunWMTzA9h88IEj9C2aR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Q9Yb8OaVvmUjSXqEEU8A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeEBGwR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 02:52:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:52034 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbeEBGwQ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 2 May 2018 02:52:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="51658827"
Date: Wed, 2 May 2018 09:52:12 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: typec: fusb302: Fix debugfs issue
Message-ID: <20180502065212.GB12870@kuha.fi.intel.com>
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
 <20180430124158.45269-4-heikki.krogerus@linux.intel.com>
 <293cc83d-28d9-149e-9c7a-f73b6df930d7@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <293cc83d-28d9-149e-9c7a-f73b6df930d7@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 06:34:03AM -0700, Guenter Roeck wrote:
> On 04/30/2018 05:41 AM, Heikki Krogerus wrote:
> > Removing the "fusb302" debugfs directory when unloading
> > the driver. That allows the driver to be loaded more then
> > ones.
> > 
> > This fixes an issue where the driver, if unloaded, can't be
> > re-loaded, as the "fusb302" debugfs directory already
> > exists. While here, removing useless condition when creating
> > the debugfs directory.
> > 
> > Fixes: 76f0c53d08b9 ("usb: typec: fusb302: Move out of staging")
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >   drivers/usb/typec/fusb302/fusb302.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
> > index eba6bb890b17..0e5d0aa052f5 100644
> > --- a/drivers/usb/typec/fusb302/fusb302.c
> > +++ b/drivers/usb/typec/fusb302/fusb302.c
> > @@ -218,11 +218,9 @@ static struct dentry *rootdir;
> >   static int fusb302_debugfs_init(struct fusb302_chip *chip)
> >   {
> >   	mutex_init(&chip->logbuffer_lock);
> > -	if (!rootdir) {
> > -		rootdir = debugfs_create_dir("fusb302", NULL);
> > -		if (!rootdir)
> > -			return -ENOMEM;
> > -	}
> 
> I think the idea here was to permit more than one instance of the driver,
> and have all debugfs file entries under the fusb302 directory. Loading the
> second instance will fail after this patch is applied.

OK, need to come up with something else for this issue then.

> > +	rootdir = debugfs_create_dir("fusb302", NULL);
> > +	if (!rootdir)
> > +		return -ENOMEM;
> >   	chip->dentry = debugfs_create_file(dev_name(chip->dev),
> >   					   S_IFREG | 0444, rootdir,
> > @@ -234,6 +232,7 @@ static int fusb302_debugfs_init(struct fusb302_chip *chip)
> >   static void fusb302_debugfs_exit(struct fusb302_chip *chip)
> >   {
> >   	debugfs_remove(chip->dentry);
> > +	debugfs_remove(rootdir); >   }
> >   #else
> > 

Thanks,

-- 
heikki
