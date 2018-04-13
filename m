Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-97873-1523645129-2-17930086294479721539
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523645128; b=Q1E7IUD1KxaqLL1v23+cUo0VULLtXI0xl/VV8hsBcyZ4P98A33
    GnnbfDw7kJ6eAJuoGaY74ilSSRYrtIpwvzjCuboR410xzFcRsA3BJ6qdjhqE6iya
    Fu1iutz7T5lZr0htuzTcuepm2jkUV3+3hSjEhp4M6y9MQqrWCcSZTOQYabg9hESF
    q6rz7GoOk1uoycSSYwijTsHRbHxLFnxpD/YRBhWz5svSsZACfn2UsfG10whMOPBu
    Ser9Q5Kd8isgO428lZSHZ1x8F7Ritr8QpgG9X10UVm0+CoD4VE0Yuirh6z9IDTWe
    zQNfzb9Ax3B9fWqTKuY2SbUPB5airITxdj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523645128; bh=fLdkBcLdygn
    1Ai2zOAFa+VCpoZk3MaIYbksw5cfiDk0=; b=cGvynYi6xQgzDAAmA36o1DIBF+U
    ysxcG8NR4jZpBVvPV1iew/CdIc0yTXN9Os3DwnY3PIQm1S/6xSZsZdQisANSxv9Q
    uUrWBr40C2ApZLP/7B+mLrYSPyDFyJ5KA0QIn5X90LWUUzQDdWT1oXoQEMouad2k
    yrgZURSJYgIQ7uScMDgmsLq4cwkHdrQFfUutMWPOxrDm6Ftt23kN/Ea6VkEuDZeV
    AWP/SUafKegEZTTsHx1AjY8/9Cn3J8kOLHbI7ejB2d7MnUWlTla5BZ6VEvcdmzHo
    6AtGyNqcKRj8YG/SUAKRcoQ68meeqEWwrMjnEYJV00ZQQ1Z5uoizSNPFv/w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLeybxpw7NG65UhiLofrcemAhP+IWGKpsZvBOHBh4Y1MLdbLgZR7juV4KAQkRvvTf6cI2317d0uxuMxYHrIRlM6Ab9HRk2NTLDUsMSO+7JHCPpigPRL7
    uhBoKecLW3QiXHRvAjf5lD0nZnJaq+3+b4xtoWKwu1n7iBtl6dIjZA4cbHjmEFRAZZkQ/J6kq5sbFt3Gw7itGLj75dODJ3klWIQcgHdIvzXTSgVzoq7rx02X
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=bGNZPXyTAAAA:8 a=VwQbUJbxAAAA:8 a=V-b0Uds5DrUhaeWk_4YA:9
    a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=yL4RfsBhuEsimFDS2qtJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbeDMSp0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 14:45:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37387 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbeDMSpZ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 13 Apr 2018 14:45:25 -0400
Date: Fri, 13 Apr 2018 20:45:15 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/3] USB: musb: dsps: drop duplicate phy initialisation
Message-ID: <20180413184515.4qg24ksghap7s5hd@pengutronix.de>
References: <20180413151505.32663-1-johan@kernel.org>
 <20180413151505.32663-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180413151505.32663-2-johan@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-usb@vger.kernel.org
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 05:15:03PM +0200, Johan Hovold wrote:
> Since commit 39cee200c23e ("usb: musb: core: call init and shutdown for
> the usb phy") the musb USB phy is initialised by musb_core, but the
> original initialisation in the dsps-glue init callback was left in
> place resulting in two calls to phy init during probe (and similarly,
> two shutdowns on remove).
> 
> Drop the duplicate phy init and shutdown calls from the dsps glue in
> favour of the ones in musb core, which other glue drivers rely on.

Hmm, I don't remember the details of my debug session that led to
39cee200c23e, and I don't have access to the hardware in question any
more.

But your commit logs makes sense, so

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Given that it took 2+ years to find this, backporting to stable and a
Fixes: line are probably not necessary.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
