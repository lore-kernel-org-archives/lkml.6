Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-805435-1524664857-2-17451869128806815016
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524664857; b=p9JpJtlPpGWmEkkAJBtCbCF8ZtvNET4ehUTjuNQviFQhh5MZci
    2QLjrhb+1hHbmhLY9f8dQXzru3Oh11bqlvy+L0gUcIyJ4nAwu1u6mnRKgjvsMrla
    tN5bP7eG8tV9psYUcKuQbTenBUOZuiGlre84CB1OXfRuudw9DhuESxTBq48JF1RV
    +sZhd+fJgYgIn3J4vl9TiBYFz3ZJ/Pk75d/FSGyX6gI21W56UPFkQpqcLMl2+wnY
    OO7d0/m2dDrH/C3lvApyHinTexL06mjYayRTZoknXZr5KqIjlBw7KRUcGQOBomc9
    Nzo5xr0Xnnygqiv03W26kwpWYFngRHvHExAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524664857; bh=MHLYP20uBqOSVzCoY52lKd/yNmq0Kb
    CZclMD8bNvJAk=; b=oD1EwKS8oAIWUFrLHUn3Tgd+ie0WP7m2s5dHlja/x3jIPE
    VyDXS7vCjaqqn8iLUunteMJ3ES+uXQQc6CCF10tBWY/fLnK/MTUw6QrcQZgnPBjb
    IJV3nkGPjifXx7QO9kkSx9ELP+CKRGP/gKUc5vgiWAYAjb5NUSBZbOWdDmODmJDT
    R08eE04ZtsvCCkGNGaPQzmipYf/95re84rFav7JF0gaf5+GNjWKudkEXQim2IqK9
    LzfB1Ehkg5h3Ah5qYdPMozAkRs3xUOJwcU96SXAjP6mb859kLhj7cA/aatCdZpTZ
    jfk8hMmxWLZZOonM+ooV8LQBM0JbZD7YIV31xh6Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ0Tw5Vow192a8bE4hbYCZ/4mejjaZnQxkqW19cPo7djTT7sP59trsUATfR5VuWJiub7Um5DZRtjGmS/KfO2/2gSDUqru1ws5lim2RDLZQopwrYcVdym
    Bjf8zD/kgymwRSl6HjVcm4A3mD9b70UDp1NoCMkKFQc0BHcJXYlsPmxHTbv25NvUAinW/iJ2u/wwK2qtKes8fzoR/qrgUc0iHoBI96KBddtNASkZaNtK4atJ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=i3X5FwGiAAAA:8 a=VwQbUJbxAAAA:8
    a=vISiuk_Le-mRetmbteIA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=mmqRlSCDY2ywfjPLJ4af:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbeDYOAM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 10:00:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753509AbeDYOAL (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 10:00:11 -0400
Date: Wed, 25 Apr 2018 16:00:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: typec.rst: Use literal-block element
 with ascii art
Message-ID: <20180425140003.GA23493@kroah.com>
References: <20180406124122.70676-1-heikki.krogerus@linux.intel.com>
 <87604fcsa2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87604fcsa2.fsf@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 04:47:01PM +0300, Jani Nikula wrote:
> On Fri, 06 Apr 2018, Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
> > Using reStructuredText literal-block element with ascii-art.
> > That prevents the ascii art from being processed as
> > reStructuredText.
> >
> > Reported-by: Masanari Iida <standby24x7@gmail.com>
> > Fixes: bdecb33af34f ("usb: typec: API for controlling USB Type-C Multiplexers")
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Jon, this fixes a documentation build failure in v4.17-rc1. It's not
> just a warning, it's a complete fail. Our docs builder at 01.org is
> failing, apparently the same at kernel.org. Please pick it up soon.

This is in my tree, will go to Linus in a day or so.

thanks,

greg k-h
