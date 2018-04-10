Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3892947-1523367857-2-4671975273407511879
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
    1523367856; b=KO+e1CZQCN0bJsztTd2CJeGlBTf27/0AKIXcDywGi57JpU/aa5
    I0K3XxebETOG0cwWFE7L5bBndvQoPdKbpOS4G4DGypg2eRErQ5jkcghBeMAwx6wE
    5MeqilvPKzg9pNnwvDjrr2qMfon4WgzF2tJj40wkVJ1eSMOCJCn0WPLiTRTVJTwD
    sEO6YqooehaGU6njav02e41UC86H8bx4ITbH4LmYB6GP+JU3SoSCFSvF8tbb0PaJ
    p9VmWWjZSZpCQs2ZSeRgbg+VAlLMh/YopveM26DlyXO4OBmpWAhrO7I5Zp4H6EcJ
    dnApz3PmXvSq28uRhjtFs9zu8Cq/ZX2xrIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523367856; bh=C95cTCq4wcXtTp1UI4OPjZcQs0PIcs
    a3qjfjnKjlu5A=; b=qNBTR99dEWVEOnKK/jpXVztnpKSGV0X9M37qZ4RwJlfvQR
    383JLioIKTMECgtjAAs9Gbd/CM15AocZX661DosR05oLikaHHEijUXRc+a8vSSAD
    jGfGdlYn98QqpNwzm/C8AGsbWkkCBvzcgCit0OjgDV/gJ2+feEZaXBV95WNrsLze
    uZwCASB8hLJfY+0KUkZ72MUG/gc7U0vfLNguEG1H+NwTXRb/1nXcbj2QzKMEG5R8
    TqPEYlU2qWnVO4Z0+ZDsTbYeHVaiGmpdVgXu2SPUxvFJ7LrtUEuyYraE7YDrUYdI
    Dn/wQ/BSUSARittwDSYsKTkgrzEF40RYg8aI/LOA==
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
X-CM-Envelope: MS4wfK/8QaYDvDYMANAdD1HLWiCYV8etXMFimN6pzeN0FdOEpLy3cwgwJXiA2kklKE6TfUkSHIJTesAJbL8j38ky2n3sWqgKoWW/99abKnZwNHZyN3g4d130
    H48snw3U7mOOWxOdPAnSfzOSgBfG3B/M5ehXBseNnLWaHCm6DrpWilKXyow9iXoKtkUS1FlABM79jpVJi0LqZHgrpYekn4M3kUaqN1HE1jKcZxzViFEsY/kX
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1m5ADOQ481-_TzztFuEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeDJNoA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:44:00 -0400
Received: from muru.com ([72.249.23.125]:36034 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752912AbeDJNn7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Apr 2018 09:43:59 -0400
Date: Tue, 10 Apr 2018 06:43:54 -0700
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
Message-ID: <20180410134354.GR5700@atomide.com>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
 <20180409105407.GA15315@amd>
 <20180409134259.GO5700@atomide.com>
 <20180410110944.GB13697@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410110944.GB13697@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Pavel Machek <pavel@ucw.cz> [180410 11:11]:
> Should the modem respond to AT commands on ttyS0? I launched minicom
> (115200 8N1) and I'm not getting any responses.

Not that I know. At least I never got anything out of it. But who knows,
maybe it is in normal mode initially during boot or when mdm6600 is
being flashed.

Regards,

Tony

