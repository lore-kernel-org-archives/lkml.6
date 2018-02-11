Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1572815-1518449118-2-13430793520539876080
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_12_24 1.049,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518449118; b=ar6jBCso/0gXhct5qlS7PY06fhoJ41X0yhDzIgdOyC1KswN
    LIvdj2lPviIQybtoQUmph93oifVpZy3io59V6fmFKlpENS34cm6H4KOtNNJiGMGQ
    lniQqLIIEynrb7vgW3VPEACUBERLHJctwvcwD5d1RMMwhkfxk7R3BDmWrLBQym/T
    5ypVQJ+z1ACrA/MjNJX9hjQm2CahSzH6t0ub9Ci+bI0Jz9wh/jdpxVyV8slKORZv
    pKCcY22mjPY6DhEO5aI1HDdoMRNh2EumFOUwyo8pgCqlgfyswVqdWCWrmYRo/tFW
    06iQk02ldJelpTTmaZe7SJovbv3rduDp3OLWvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1518449118; bh=yaKG/Iw
    GpEllhV79jf/MkBcnuNIHePMm1FN9oEhP2gc=; b=eyLge9OYdhXsl7L9nawTvAO
    AXkv/CAOKwsatIYFB2cDb1dsdRObTEwjMSSVduxEPZ0FHWZp0LdI73mdPN+49spD
    GdGwBK23B/RysRvEMgaxwPFlSjR/uXAIZxT0CIe9uF4IWYcKHsDndRXsE7hS8wYw
    cWYH6Ro/rUW1jk8RMPkBMRxhtXJVMEA1wJJwgRtUeR6wMcwBephsiR3lFt4AJgob
    5C+xYNbMKqKmaI5KO+pH9tX5phZ/A1/5vqTY4YEoSI5eAjbwyfL6LC8IvcqETdtq
    b1senry3jN61cn++HuH2SdKoVf9wrilwL5zKgXueRRWwU6Oz4+6Uwh3m2R8vvwA=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeBLPZP convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 12 Feb 2018 10:25:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43011 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752692AbeBLPZO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Feb 2018 10:25:14 -0500
Date: Mon, 12 Feb 2018 00:43:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Oleksandr Shamray <oleksandrs@mellanox.com>
Cc: gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch,
        linux-serial@vger.kernel.org, vadimp@mellanox.com,
        system-sw-low-level@mellanox.com, robh+dt@kernel.org,
        openocd-devel-owner@lists.sourceforge.net,
        linux-api@vger.kernel.org, davem@davemloft.net, mchehab@kernel.org
Subject: Re: [patch v14 4/4] Documentation: jtag: Add ABI documentation
Message-ID: <20180211234344.GA3864@localhost>
References: <1513268971-13518-1-git-send-email-oleksandrs@mellanox.com>
 <1513268971-13518-5-git-send-email-oleksandrs@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1513268971-13518-5-git-send-email-oleksandrs@mellanox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi!

> @@ -0,0 +1,27 @@
> +What:		/dev/jtag[0-9]+
> +Date:		October 2017
> +KernelVersion:	4.15
> +Contact:	oleksandrs@mellanox.com
> +Description:
> +		The misc device files /dev/jtag* are the interface
> +		between JTAG master interface and userspace.
> +
> +		The ioctl(2)-based ABI is defined and documented in
> +		[include/uapi]<linux/jtag.h>.
> +
> +		The following file operations are supported:
> +
> +		open(2)
> +		The argument flag currently support only one access
> +		mode O_RDWR.
> +
> +		ioctl(2)
> +		Initiate various actions.
> +		See the inline documentation in [include/uapi]<linux/jtag.h>
> +		for descriptions of all ioctls.

I tried reading the jtag.h, and am still not sure how it works. Real docs
would be nice...

In particular, it seems to always specify read or write actiom. Sounds
like a job for read/write syscalls?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
