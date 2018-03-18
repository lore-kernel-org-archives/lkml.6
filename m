Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3741325-1521368060-2-11039862261517425999
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
    t=1521368059; b=u+LOuB5Kzs+kr5FLh5M+eRKZdKe85MO2CjY7GE9gahIespj
    5wmGvz6fWm87WLHgpwgQwjgmILRcsUmhPhL2kpKvaq4bp+aUq8QXgWoNI4AEM9xg
    4pTKD6OWvFpwqBivlD7K6bfs9qEKtPCGYfSSsZJ+9kH26Or5Itc3yJhGFua8P/iQ
    lRt00k7Fd84ym10ApiKInteIndHR1O04dJ1WP1XtyZr7hpRPPEgJzJ4MGmmnJR+i
    MceVc7KZG4zBb/HvzIdPGmaELv164//yWd+SxBAYvy3QUmbUTaUZ36+6fmpM8/ZI
    Tui+M3YiTyILL2V6+azqAb5Kky0ZO8qrt904rCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521368059; bh=J2/mst/brxwC+ICLId+2hTpbsQ
    86t4QD/505lSRKKRs=; b=BydjNQSKg+286aXGZb5NYnO/QihZ1J+NTOs71SsIFK
    RKqGypkTXp5Ik8NqPL7Sn9n3tyv7MfswsTQqAqk9MITDTkyihp9RjqAdTsqF31DW
    rzs13cMTLMQIfd6j7r1Jcd0voEBRpQ7ToMgZxZuojyakDIWfEmBkLUziK1nWbMOF
    FBidJxrnMXVslzhFblLf5CeayHoSYyEnBrQjR12g/KCLfLP1USza4vdfULfpwTuH
    R4ERXUcjoPjmggJjlt5A94JEXS/3J51Z9Gjl45U0XGXM7oPFKlf9FNuk+f6clD6Q
    qZwRA+svFIWe6WD0aoIfHH6DBo6TEhg54gShmRmiBeMA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753883AbeCRKOS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 06:14:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbeCRKOR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 06:14:17 -0400
Date: Sun, 18 Mar 2018 11:14:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 4.4 29/63] watchdog: hpwdt: fix unused variable warning
Message-ID: <20180318101416.GD13276@kroah.com>
References: <20180316152259.964532775@linuxfoundation.org>
 <20180316152303.262268098@linuxfoundation.org>
 <20180316225537.GA5989@anatevka.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316225537.GA5989@anatevka.americas.hpqcorp.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 04:55:37PM -0600, Jerry Hoemann wrote:
> 
> Greg,
> 
> Sorry, if I'm missing something, but I see 3 patches for
> hpwdt queued up for 4.4:
> 
> 	queue-4.4/watchdog-hpwdt-fix-unused-variable-warning.patch
> 	queue-4.4/watchdog-hpwdt-smbios-check.patch
> 	queue-4.4/watchdog-hpwdt-check-source-of-nmi.patch
> 
> 
> Shouldn't there also be a 4.4 patch for
> 
> 	commit 2b3d89b402b085b08498e896c65267a145bed486
> 	watchdog: hpwdt: Remove legacy NMI sourcing.
> 
> As there was for 4.15, 4.14, and 4.9?

It does not apply to the 4.4.y kernel branch.  If you feel it should be
there, please provide a working backport.

> commit 2b3d89b40 is the Spectre related patch.

If you look closely, not many Spectre-related patches are merged into
4.4.y as no one has taken the time to do the backporting.  I thought
someone was working on this, but odds are they just moved to 4.9.y or
4.14.y as everyone really should if they care about these issues with
their platforms.

So if you care about Spectre, I strongly recommend using 4.14.y or
newer.

thanks,

greg k-h
