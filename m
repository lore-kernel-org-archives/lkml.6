Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1132802-1521014042-2-8159042425729051058
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
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521014042; b=jmmwm1KBYm28vdQYmD/i0VP5VcoRvR5GJFV0BF9OlNI2CPa
    gfIdCYmZhlhOYqfdTsEhFUCwdNSYy8YmH6ANszaUpdIaQyQyBtAWmTM8gwZL8klA
    mlVVuGyChBsydzKXzqmfIwM6YQWPer9bjdL9gk31PSVAorEz0ohsnGGZSvKHlVBl
    HDiogjcOlHtrSgR2K68gVgDgiaX0X14jZtIb6031ygRw51F7vMCRJ8BO7Oj+G7zH
    1onY7IMhmukP0xvpjHOz2sUZzE5K/BJkyvFE2fcF9ZtKyLCH77QkEMdyyi/hVRq6
    ChPT186Hr+cdccissrNYsS80MRcFtSzivB9EQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521014042; bh=2nQ3tG/ERyj6dUrI21Z4ZAd5VA
    Ddc3IzU8Hy4s+5OC4=; b=J2VJFi/MgY7yhiUHvit91erzu/T7870RgKEKyKCzFn
    FmtoW4Qx6osGOFhR/r4ktZYrnDLOYNSVNhvx1FlA0xtIBKW0CWTN5s0HwltAGlnj
    scVel7WmzHa2bNlgaBUHjSXiQORnyGD2pDBrH1o9i1hTdvVaMPG5o+42FFzLvKjw
    hQoDFM2zgTyvjH9JEFpJPQ7Pcg12bC87VBFQ9e0w6fQB9uWcosD/azipu1iQJOu4
    POOPWwMJHohLRKq3kEZ0leKL7/hUXh2EU2UtQ04MLOBUgghSWho7IBPEcj3S8yer
    yQbrGYmdiQFumGBTfQvV5iKrisxuVbA13T4q0xlyi3cw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeCNHxc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 03:53:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38464 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753189AbeCNHxa (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 03:53:30 -0400
Date: Wed, 14 Mar 2018 07:16:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: misc: supports Apple Carplay driver
Message-ID: <20180314061612.GA17263@kroah.com>
References: <1521007356-12306-1-git-send-email-chunfeng.yun@mediatek.com>
 <1521007356-12306-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521007356-12306-2-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 02:02:36PM +0800, Chunfeng Yun wrote:
> The driver is used to support Apple carplay feature by a debugfs
> interface which can force the driver to send a USB Vendor Request
> of "Apple Device to Host Mode Switch" to switch Apple Device
> into host mode.

While I am all for crazy debugfs interfaces, I would _strongly_ suggest
not doing that here for the main API to the device.  I know Android is
trying to prevent any new devices from even enabling debugfs, and as the
file system requires root permissions by default, you are forcing any
user of your new api to run as root, which is not a good idea either.

Given that all you are doing here is a single usb control message, why
does this even need to be a kernel driver at all?  Can't you do the same
thing from userspace with a simple libusb/usbfs program?  Or even a
simple script?

thanks,

greg k-h
