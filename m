Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2641504-1523206261-3-7327022963863858194
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523206260; b=ZLjVm2rOy2NtbuH03n7txlb9w5uDUKzmQr8xk5tH5O+9ulU5Iu
    zHgxmhiQo1AZ8sG41T9Cot1OH5YPsenceqsChAdPE66ThJazaiyKA4ZcXtrzzcjx
    mvCwQY8BEPvFYUjiYuk62DYyUFWMOdyt4IAm/mpleLlZCtkuKwfcETXBxnCnxWHn
    pShb9Avd5C7e23GjyFXwoHIJTdkEBTEXoftiIaD3spnmuvZ/hUHozmOXDnLNVvN0
    I9YsQGkUaCBJJhZu5qr75vTZEncNv51H01KRTb32HQserJUAjSkGY8RSdihIydp/
    z2jgDyeraJZ8AblcGFT7+H5DJxdn76YBkC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523206260; bh=qZ46nnC+1kvmDqupPRoWqgK9LbC16h
    r3p0vVA4sszfo=; b=ANLHP6d+ksPboeGwH1VrqjSvD2fGHbm2cQmuXT/T0EY+pv
    TFCfKNTQa1i0VKVi/4fFf3nLdFvKRNqroEPvF8avyWFnAtO2kG8wMnjA8KuNt4kt
    c0b4qxu2pQFPr5boirslLB4CZjuDcHniKbGvhq2Un93L9jZhKN8kMfC2pTC4h6Bb
    dzXb4aKJFY74vaBXyrkwvca5VM8i4yH5xPLVTQ24U2jn3Nm3WrXVUkB0/eruWM67
    cZJyq0W4lL5wKkbgvEG+fGXmmzqKqPX5gUpouAgaGH75V17epnDWUqoHLuFaIhjt
    hTu6cMEDxRAuoBIpteizHvTBKff1qH5jB/dZrqoQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfNbwPpsSt+Ha3ZR5y5F39eo1YnFBHqiiabeTxopos9MNb/Kq4n2xg6WX7P+auRRz9Wy5QRgSDS0PH/rvz6o2ee2iUDqnnGwhvuLm4uNHJvxO/of949HK
    Qg8FsNx/H4LCWg92VrUrUEKKwuuCNwpZd65r/zmrO3utYEJCih4sIRjdRFGlQFhtydxyrGZis2DEryQr1e1GKoGAV+b7wB1Zf7MlUL3wmxVBIJCHPykM7x4H
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=3pabqXNUaM46ggzVSRkA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeDHQuo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 12:50:44 -0400
Received: from muru.com ([72.249.23.125]:35702 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752396AbeDHQun (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Apr 2018 12:50:43 -0400
Date: Sun, 8 Apr 2018 09:50:38 -0700
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
Message-ID: <20180408165038.GM5700@atomide.com>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408090259.GA8185@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Pavel Machek <pavel@ucw.cz> [180408 09:04]:
> I guess I'd like to test this on Droid4; there are fso-gsm0710muxd and
> gsm0710muxd packages in Debian, but I assume those do multiplexing in
> userspace and thus are not suitable?

I don't think those are needed, we now have kernel n_gsm driver do
most of the work for us :) Doing ldattach config is still needed,
but eventually we should have a serdev driver do that too for us.

So apps should only do the ldattach part if node yet already done,
and just attempt to use /dev/gsmtty* ports directly.

I did get serdev working with n_gsm several weeks ago with horrible
hacks, it needs quite a bit more work though before it's ready..

Then we need to add proxying of some /dev/gsmtty* ports to W3GLTE to
get that working (US only AFAIK for the band). It might make sense
to add the proxy features to ModemManager eventually.

> Do you have a tool to use and a script?

Yes I used the shell script I posted earlier, but forgot it also
needs the ldattach done.

Anyways, last night and today I wrote a quick test utility called
droid4-ngsm that initializes things and I can use to do some
experiments to get the ts27010 channel proxying to W3GLTE also
going:

http://github.com/tmlind/droid4-ngsm/

Sorry could not resist adding a test call feature too :)

Hmm it might be best to add the ts27010 support and proxying
eventually to ModemManager? I think ofono and others could still
use the /dev/gsmtty* ports for the modem as needed too?

Regards,

Tony



