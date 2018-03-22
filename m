Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2465629-1521716298-2-2437173368013394719
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
    t=1521716298; b=uxf+nWlqeiUSIJDKm6uhUgMZReSi6+ynuDntWQes3Pkml3o
    V9AD7t3BV8w23J7Rk0jH7YzU8FLhXIekOpqwXpJaLZNmXjEvX1kQKLwvNmL/lwQ1
    mP3rTLuVCV9eKWbgPWXA3NuY3P9Y8vogMXNumifymhN8ZeZpcBD2PqnE3yTBy0wk
    usvtAQ9OCBUzdrhOxiX21XJYx48OVa46BBXd6DiuSxnObMZp0SFqwhomZ3znNqVE
    lDy8/NgRd7MNJkJGU6i9p0nxJn+Re+oGAiecMYgMmpxSz2vwB305G6+rHQ4GoqSd
    i8GpoGjc6bEI6s8IfVJq2CrhUwKIYY2pVHdZv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521716298; bh=NapLw+5SQkZOrt8PrXADAILebV
    nPPF9VKOHAhjpjoT0=; b=wcAlPvY1oj4K0OxUwLCx2JuQ62pZSuv8Ucx7wGCwCn
    /mfVRMVU3oim8CQb1dz07oJ6In9Bu6Jj7zrkSJ5CftilZqFRV8ybZZv3tBT7kB8b
    3YLWgKysx5n7M0xuwbWmUXJeZ/2woZb/oSiNm9paM0aZe5BSy+pw2zEzAdKVPXhx
    njibxWylJ+g9zmi8R+QNuJimSqJlHy4H+1Cae7oTlqOUqpxze7wUimqh1NAI2BTU
    CpO3G4C3CYp0h8Jbx9019KEvOtWYogMV8L+SAi18EW9WlxHUVo+KPZiMEoBMes8/
    lsFrpQ2bO7NQdYETC7ozvUOMo+0diFlbXw1oMuRBycVg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeCVK6P (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 06:58:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754047AbeCVK6O (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 06:58:14 -0400
Date: Thu, 22 Mar 2018 11:58:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH 4.9 v2 0/2] Clear LED_BLINK_SW flag in led_blink_set()
Message-ID: <20180322105811.GA24775@kroah.com>
References: <1521487399-10447-1-git-send-email-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521487399-10447-1-git-send-email-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 08:23:17PM +0100, Jacek Anaszewski wrote:
> The fix for brightness setting when setting delay_off=0 introduces
> a regression and has truncated commit message. Revert that patch
> and apply the one-line change required to fix the original issue
> in the way appropriate for the 4.9 code base.

Thanks, now queued up.

greg k-h
