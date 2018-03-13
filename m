Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2930626-1520938242-2-13141662306298158651
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
    t=1520938241; b=ikdMJSiQNjOBd5cH/U6av3Eas34PLxBloWWwj/qlB2mww4q
    Ui2SREdl4sdOoOHzAGVGIfbGKZz8NrB4exZxnFpoyNaMjtS/dws8ew+e1V7E/Bnt
    wK/7wBSpNXDHi+VmQDM0MWZElwYrymqZcz+ef4e70elaenzc9EiJdjnlY55DcgJ8
    2dEcOhRBztYW7n0qynSEfS73EO7yM1cA/BOqp7y1qYTNqRlCL6A1XfR7YMTgFLBj
    +Ve79nH7kl2KVkQtZbAu3X8Bz0vm+LmHr+6PPqLyDZXsd1RM5m+dzLthIZA9CKv/
    X1OLgYfhs4ll6UZTE4xuyw4tREDQO/gA6+D7spQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520938241; bh=6LalbUvEd0seIH9bCa43+MZ97a
    HuNMvc6N4mdMMIKYw=; b=wzNPGvpoT6smfl7iQq/hJdX5FMXKaBY2dqrrD327lu
    CdFphA441KiMIH1IgZKGu6UpbYHegAWY8Gm7tY0V/tT5OyAmJV5E7FYyGLS7+f+C
    HsSKZDuMvuZiU4ZbBAQE1ygatgHIg71AC/p6f94kRws8JRpnrN0o1lHQx4PRgLK/
    DKRcJ3sHVB7JrcGJba1GQvF1eFbIOlM5bwrjqV+uvkCtfu6Wna7cOGJshnrrNB5I
    vxoxrjKp010g58OlrxnIdek6dO3OZADvxirCOZMXkEtdIK2mL2GOakDUipJ8gzDW
    63ltR3mBHU4QTP7O0CxNJp/KCmI4IczuxYRyKh80zRcw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S932782AbeCMKt0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 06:49:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38954 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932665AbeCMKtZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 06:49:25 -0400
Date: Tue, 13 Mar 2018 11:49:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/193] 4.4.118-stable review
Message-ID: <20180313104926.GB32263@kroah.com>
References: <20180223170325.997716448@linuxfoundation.org>
 <1520306605.2786.123.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520306605.2786.123.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 03:23:25AM +0000, Ben Hutchings wrote:
> Patch #132 (which didn't reach the mailing list) was:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > Date: Wed, 26 Oct 2016 15:55:02 -0700
> > Subject: Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning
> >
> > commit ea4348c8462a20e8b1b6455a7145d2b86f8a49b6 upstream.
> 
> This appears to introduce a regression, fixed upstream by:
> 
> commit 9dd46c02532a6bed6240101ecf4bbc407f8c6adf
> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Date:   Mon Feb 13 15:45:59 2017 -0800
> 
>     Input: tca8418_keypad - remove double read of key event register

Good catch, thanks!

greg k-h
