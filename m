Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1024697-1525697512-2-14314446486451217745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525697512; b=fFh+tUtvXP0hIwim1z9mZmCSesUQSwNFpDKf0jaK77VMAFaZ4T
    8curzG13CAeppnn6T1bxJEwEKIAMeHkerV95FAKzIwTesvjjAXopiKjIZLjIOp5a
    i+2Un4a+LzfniyL+URFM7a321gunupeJ41uVZNJjlGjCmsicIRuZvICm8rb8vk3T
    pBudiXWrHByPLXO7Sf2TT+GZKrsYycNRsV7+i+PV+Pirop0iDJq/zeg4lNwymHb4
    IScwcq8XyXhFhpl2jlQdd2OANey4RWHWnKu4CzeDXqmUCezLm+FXLOxAyfQnWNBK
    dNCL7Q4X/cvLrCTWgE/L1Cf0wY42suLAaHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525697512; bh=MgDwh/FcHXMySViOH/4XaTECmlNMB2
    MQCcDtAPqKZ7E=; b=NkOVr51+YSknFonyFjwiflcExHr8Z7TrcGWqOexEOFeUrl
    PwsZJTFv+wUT7sgqBxeItwVsICmP+cUcEM4hf6Sdbog143/LbzKHm3riS+mppKd7
    UmgleAVBS2O8hNWltiE5ForzJkTn7mDuF0k0l8OKml/qyWtzfwIL3Cjtuz1RQOfN
    qZpDOWJJcudAsXrPUwNOK/Lh7+d0deeadOEgYzVqnnk/WkTVad+jKDVTXCjDqYuN
    CPsELRPbS2pBRIXxDtXcePo0Kr7LbAmFEvDloM5hSOOmmM0nyOEoKWdckMz4kSpn
    m3jSr5bCWAV2fU/wD4xvJG4td++ToMeSyYdoCRUQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfActmbClsOVBiLxW7aLb/YFDX1T/cx5yctWnCCOUjqXu2UwAoN1Pi9a2S5421C0gfxPMlRX3nqBnh66C7/Zy6eoHRDaCtlY99Drzs8nqbvCpnJCpuZ7W
    oDc79qA57OPqb/0zPyN5wA/ZVTylxL6u867I3fhThxUCIcNfVEgsKufZ7C5OvXLVkK12hFElv2ETIDIsOWfx1fa9VZ3b+Sx4TtiNxtj1Ms6NfhtwnxeY1BzA
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=EmEKVuC82Ht8DtaaFvUA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeEGMvt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 08:51:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50896 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeEGMvt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 May 2018 08:51:49 -0400
Date: Mon, 7 May 2018 14:51:46 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-rt-users@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-sh@vger.kernel.org, gregkh@linuxfoundation.org,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: Re: [PATCH v2] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
Message-ID: <20180507125146.75crpaj2scav7mql@linutronix.de>
References: <20180504163041.28726-1-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180504163041.28726-1-wagi@monom.org>
User-Agent: NeoMutt/20180323
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-04 18:30:41 [+0200], Daniel Wagner wrote:
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2890,16 +2890,16 @@ static void serial_console_write(struct console *co, const char *s,
>  	unsigned long flags;
>  	int locked = 1;
>  
> -	local_irq_save(flags);
>  #if defined(SUPPORT_SYSRQ)
> -	if (port->sysrq)
> +	if (port->sysrq) {
>  		locked = 0;
> -	else
> +		local_irq_save(flags);

how is this helping? You should see a splat after a sysrq request.

> +	} else
>  #endif
>  	if (oops_in_progress)
> -		locked = spin_trylock(&port->lock);
> +		locked = spin_trylock_irqsave(&port->lock, flags);
>  	else
> -		spin_lock(&port->lock);
> +		spin_lock_irqsave(&port->lock, flags);
>  
>  	/* first save SCSCR then disable interrupts, keep clock source */
>  	ctrl = serial_port_in(port, SCSCR);

Sebastian
