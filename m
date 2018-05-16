Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3468281-1526429757-2-13939220494953402590
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526429756; b=ifzgIq0T9tKYlLz9zbYK0T6Vbk3E17SN09sADNntBq0ACcGMPR
    1gOlzODv37gDFzrIgqOj8VunMofCj2oicihcl4zyI1f5PREbOkWGDLRDGcnuBgaA
    CUovA/tM3z0Gu75QiGcSHt1hHH6tplUjKPVlntRFo3Jtby4nreYaTtZuXsdE6saU
    48Clp0dMXSu9etJsT7roUz+eoqLwkHfh740ViaYGHpADtC10vw8f2WePWCXc432N
    RvO9UXBMHav4TkwXVGt50kMXsd41ancEwJCA0X8D1N0vzdwztKlKJ/faYdCOKnTp
    m/pzCXIqjRWcUTiyJOz2nj2Yp8Xq/9/hkSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526429756;
    bh=1B+h7vRY8zxvzrHzxQP+hpXAbLjvr/L0mjX5qYXRTQs=; b=AFHJBHQMCfHt
    i2DYmkIwDt8zW/VTN1xcxsYH8qwWNatEioGR/c5Pyj97w7Mdphw1zodHQUEr7nCD
    YyeQAhHEhCKA/OcSjjbi96wfoiNYXx4QerA3RAQ35UKDrG7kgiEYwtnVtcZb4nOX
    9pFETjQeIzwTLXxyBV4sAkk6+ckpcD2q/CSaPbesIxHAAQuYWYR4oHSA08QZS39s
    ZDvfk31rFU1q43BJdpi58p4YY0BJ/+XBjC3GKCyCX9onVGF1ffpA0eBHGipcw/3I
    U36GhWLRn6vufm2zmW+3woAcHN2SHYk9+uOCT48pcsnFugDn3xB4i1HLiynait+O
    X/YGc1Kg1Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codethink.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codethink.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAlZI1cp2UWU6pJt91yulFrpgYWgll+IQwb5NcqxapHx9GQLcI5159oLnqSxElwA7BBo+3tHuDtDuzdkBB3RT1b3QxHMBHrjQzq0ixv8owRXmNitzElJ
    NE3xIaZskkF17giYixrFJeqYquTW5V+gNJ45sACTIym6v4/d4urVcIcxMPpNzZilliC3nmsfzF7A77lrOGS9URlsIVZoPxAmIjNQVFzpyPVa9BE3Hh/O7ItS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=xjQjg--fAAAA:8 a=RQPXkDU5b6PTNTmh0HoA:9 a=QEXdDO2ut3YA:10
    a=L4vkcYpMSA5nFlNZ2tk3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeEPAPx (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 20:15:53 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:59234 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeEPAPx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 20:15:53 -0400
Message-ID: <1526429748.9159.95.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 115/190] Fix serial console on SNI RM400 machines
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Wed, 16 May 2018 01:15:48 +0100
In-Reply-To: <20180411183557.834541973@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
         <20180411183557.834541973@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-11 at 20:36 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> 
> [ Upstream commit e279e6d98e0cf2c2fe008b3c29042b92f0e17b1d ]
> 
> sccnxp driver doesn't get the correct uart clock rate, if CONFIG_HAVE_CLOCK
> is disabled. Correct usage of clk API to make it work with/without it.
> 
> Fixes: 90efa75f7ab0 (serial: sccnxp: Using CLK API for getting UART clock)
[...]

There's another related fix upstream:

commit c91261437985d481c472639d4397931d77f5d4e9
Author: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date:   Sat Sep 2 23:13:55 2017 +0300

    serial: sccnxp: Fix error handling in sccnxp_probe()

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
