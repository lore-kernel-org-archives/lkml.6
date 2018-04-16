Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3406967-1523890037-2-4191463899156804212
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
    1523890037; b=JfD3oRP/MYthmXjp29KRFCPshWhKKzzzJkF3FeQ8nWDBycOiq0
    owPjMLkr88vPrBoIoVMERKwqq1edTUjvLAsIe7mGg5i26Or5m+PdFQQIw5V3GN41
    EQ8UpReVbYSuuy2GcDzW1h3i2DkIDBedWZkzhb9xEWfzZpwt5cNsrd9ZbhtM4u2H
    amJk6BUMGJMyf4muvtuFmpg2rRXcs4G1vLOxZhwDVhtWJ04mUncTccBwjQQO9Qm1
    yldEPsLr3UN16bR1g/xVjhn9shrK8Vv5xkhOC8LbyYaGF4BH26w8Bojvnh6qggNQ
    fw6pAgWtO7xH27Xzc1HDoYJ4qe2ZP51uoGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523890037; bh=yEJdI2VqVTi9xXiADIydivFpatYKPW
    fhZG/oNT2tkN4=; b=Yown5bQdx234uHi839+i5U19wpVbzgPe4r1wnjkLGWzyE1
    qcyjJdqIvdB/85meUAnPcDxrDtYoY7juKu0M9Oh80nX9qot6624Z3W4E3VOHmdp1
    Zo9f1kcvYE6RKrKEmEdEaV+aBdloGiYTce9rmSeD1UYUmKFktxMN1TMmGhZ7SrQs
    ++1CDRuONW9HKInxLDZqXSVNFw7/RpsDKHDGQ2NPcAZAW3RML2bcmK/vok/YqZqN
    VbF55VAMmeILStb2Mi3bv02Ff4AP9SqtwGXSLqTSUaBEhloz7zVIwgdkQc6Uh1Gf
    YWwlskZ0Kwfc/uk7RKb6uT8IdsIiThu5YjFQGukQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKuPPcp1tIeWBHJp+2y3iKCZf+L9f1K552SADXbroghu1mF5bZzpN08tex292PPKqigqWkZjux4ecD8HgUokB5CCY3xzZLp2LCBawN4FgbpVf0B7nXVH
    2GdapStGwuIbbS4xeFAd98oniqpy3J+QSursKtdvrQ1CSTnD1kJCL0yP59MRs7PG9/n+3zVswudtIiXEfHN3zVMZNm7R/m8kys18fyYFXqki3+CtCekY3hsd
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=rFk19BI-4jeXDvfW6xAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbeDPOrO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 10:47:14 -0400
Received: from muru.com ([72.249.23.125]:36884 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbeDPOrN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Apr 2018 10:47:13 -0400
Date: Mon, 16 Apr 2018 07:47:09 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Alan Cox <alan@llwyncelyn.cymru>,
        Dan Williams <dcbw@redhat.com>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Michael Scott <michael.scott@linaro.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Russ Gorby <russ.gorby@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Message-ID: <20180416144709.GC5669@atomide.com>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
 <20180409105407.GA15315@amd>
 <20180409134259.GO5700@atomide.com>
 <20180412212412.GA29243@amd>
 <20180413002415.GC5700@atomide.com>
 <20180416084439.GA5489@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416084439.GA5489@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Pavel Machek <pavel@ucw.cz> [180416 08:46]:
> Ahha, so first I missed two of the patches, and second, I was not
> patient enough. I was stopping my test after first or second
> error. Now I get... so I guess it works for me.

OK good to hear.

> For the series:
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>

Thanks for testing.

> Testing ngsm..
> 1> U0000AT+CFUN?
> 1<

Hmm droid4-ngsm should show the response or error out as you
already probably figured out :)

Regards,

Tony
