Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1194497-1523281386-2-11833306472076914197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523281386; b=HIaULijf5USX4kSmlOX72UJ1Wuo3JInXNve+sac+0RaJURCsjg
    7rZBLC9ctpzqwJq7B3c1Iw9e+5zB+U6A9qHc8rTQt6RiOT4VpMERV817pMJTmV6B
    3TNnf/2VY0czel8MLRJ700gqeSmr+7kaKMai9O9QO3UQJ4+/OT87+4ZlUT79l/Z9
    eE7qx0GCISaEcYJ7BrlhiBz0xmp4C874NUYlDbGFwdv5v/AtR7VudBH58VrvTY8t
    lwn1OUrtqcm1xWVl7+C8htdDh9j/uIFmNgnJMLSBY7lX7exTxM/cWFI4PtA8IToM
    3CWUJLM/oVCN73BB3VVgP20sx4doIAZKRu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523281386; bh=bqaNwgV2PpFT165rMWnDwsikM19Zwg
    LxEsqkHyyhK6s=; b=ToaUehPt9OZff2FG1OPWGEoWDuiyxA8ytgdiDRRgMNmDgp
    5mTlELDTbvZLg0MWrkWI+qb2y+W9xnRmS171p/NXhqDIeKxnqIHJVXHcno/M1T6n
    DYKTOVyTjNt9tuFKPt1Sb7rIc2WGvZI759nXPz3ZJ0oSl4YRuue2UE2lxtHRORkg
    DbebOKGbUayLWqmueq3FXjPceMHl+vchyNriO91Kwbw+kWaCbcK6lJInzZFAz43C
    9Ywg99eGrQNhVM2QktlaHSAq7f2ODbpymL55NFg+vQrbH7CUcTme1XKXYNiXa7F8
    ITYMKRsgkQNCRDge4UjVFK8O1bivgQiKvYoax26Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfLlW6kLIkqmT3+Xda1RPjGiAFv/6mC9nMoAeCweD61jUjWs2EYaPkBIZZdKXClRYVvsJLZxBGAYQLqY9OCDpR2rqmtux5hQBgTzgS+NJrYKxM7CnyquE
    pElNJeRDJEh8vWlwwyC/9U3HTkUavRj/XGbjF0y9J5No8Ep+28CQTUFMUNlZnYTTJXBBEarZcyVIIFqtZnIhyMPbmxs+iQ2a3zQLeuahouLls1cXaEIKdO/Y
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=4B6O7k_05uCXav8sBZEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeDINnE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 09:43:04 -0400
Received: from muru.com ([72.249.23.125]:35878 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751548AbeDINnE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Apr 2018 09:43:04 -0400
Date: Mon, 9 Apr 2018 06:42:59 -0700
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
Message-ID: <20180409134259.GO5700@atomide.com>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
 <20180409105407.GA15315@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409105407.GA15315@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Pavel Machek <pavel@ucw.cz> [180409 10:56]:
> Ok, I should have all that enabled. But droid4-ngsm still fails:
> 
> user@devuan:/my/droid4-ngsm$ sudo ./droid4-ngsm
> Starting ngsm..
> Testing ngsm..
> Could not open /dev/gsmtty1: Level 2 halted
> Trying to start ngsm again: Level 2 halted
> Starting ngsm..

I guess you must have phy-mapphone-mdm6600 enabled as you a have
working modem over USB. What do you see in dmesg if you enable n_gsm
debug with modprobe n_gsm debug=0xff or on kernel cmdline?

> commit 984c7706ff180e33096c57183435d925cb644576 says:
> 
>     ARM: dts: omap4-droid4: Configure uart1 pins
> 
>     These are needed to use the n_gsm driver for TS 27.010 UART
>         multiplexing. Note that support for the OOB wake gpio is still
> 	    missing so the UART is not yet usable for n_gsm.
> 
> ...am I still missing the OOB wake gpio support?

We can get away without OOB wake gpio for a while as mdm6600 is not
yet suspended over USB. But if you have manually suspended mdm6600
USB interface via /sys, then it won't respond properly on n_gsm
either.

Regards,

Tony


