Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2626299-1525357909-2-11453924439221503200
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
    1525357908; b=MDYfeIMoNFpwmozs3g1JVTWSjQRI3LHwXMiOjwoLYrpg2MnyE2
    vyK1UgtXIzkmeI8l3kcGTFap9N3kHq8bZS6Mm0FjKo258jvNd8EryCvihIHdgf8Y
    ZJ5dq+x2L9qwxM3TF/71/MfOqDPycqATaYtvOXpDFqKVJn7zLJ79Uxhn2ICpgr1l
    ZUn1bXtfM2xwzFc3hRyV84kB3jf+xiRH5Rek+fccs+5jTJlKtW0J1dSdArAZUesw
    gPb/AGeCWcnkVzLhmVKIWZr+NfA5fWWmtnToESiFdUANQOx6eCsxXnQpY4maxso7
    TElWJ8je7yTPYdfWE0KuReBmF5PSxchzUSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525357908; bh=g9B01AdFzTp2T32QtklXoV4Zbeyir7
    gnLKoL4HeYrlg=; b=Y65rJ+bndWhUUrAUfynJ4b1tJSfDZD+BGHYntR2z8JKQgc
    02SWZZJ3a3cJGmTvCvfSMw3mMDjLuS6q/QXDrqnvBC/h+sFN+B8DVDOu5wnpWxEi
    xAqP2n3LRFBU4bWIiQhBdciHJb5NjH8zChI/vaKzQ6t/aXnxkYTJxM4bUczIDFpv
    0Su3PWu8iRymOLTotcRYbAkxL88cHnDwQg6pWvp2HcR0CHC75vuOTvSvnb3l7CjA
    FbgxE3B08QzQDOtj9KMk+zTbuBfuZOHdlEzR7Cjwl/5AntmZlAhHV3RL1375JuIY
    NIKqU3ETgtCGsbEp9Bnd9wvEhmFdQbfIN2X/CIvA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDHKpkmsB7nP7Hlvrpo9i+T5UYKWSXQ17IEwiEr8S500eT0KGH7cPHb0pzfi/dmeGu7X79RMIwWc/17+bnSUvMqtYKTJZ6A+UPNh3v4QdmYkAcFCq9xx
    dy9enX5tVK9Lz5WdapEvnuol7mXNBwy9lWQr7wDuSfiFUmOwwsrpFTRBRoRFn5Anm4C9YMvCcLgjwyYGeT6tn5/a69t2g7pNgRKNTjWEFPrSK2kJZmqQXec6
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=8DUhEglErKGnpGYDuPAA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeECObq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 10:31:46 -0400
Received: from muru.com ([72.249.23.125]:39946 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbeECObp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 10:31:45 -0400
Date: Thu, 3 May 2018 07:31:41 -0700
From: Tony Lindgren <tony@atomide.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Peter Hurley <peter@hurleysoftware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] serial: 8250: omap: Fix idling of clocks for unused uarts
Message-ID: <20180503143141.GR98604@atomide.com>
References: <20180502171500.60462-1-tony@atomide.com>
 <58bcba76-d63b-212e-4baf-d40a28c549d3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58bcba76-d63b-212e-4baf-d40a28c549d3@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Vignesh R <vigneshr@ti.com> [180503 10:20]:
> 
> 
> On Wednesday 02 May 2018 10:45 PM, Tony Lindgren wrote:
> > I noticed that unused UARTs won't necessarily idle properly always
> > unless at least one byte tx transfer is done first.
> > 
> > After some debugging I narrowed down the problem to the scr register
> > dma configuration bits that need to be set before softreset for the
> > clocks to idle. Unless we do this, the module clkctrl idlest bits
> > may be set to 1 instead of 3 meaning the clock will never idle and
> > is blocking deeper idle states for the whole domain.
> > 
> > This might be related to the configuration done by the bootloader
> > or kexec booting where certain configurations cause the 8250 or
> > the clkctrl clock to jam in a way where setting of the scr bits
> > and reset is needed to clear it. I've tried diffing the 8250
> > registers for the various modes, but did not see anything specific.
> > So far I've only seen this on omap4 but I'm suspecting this might
> > also happen on the other clkctrl using SoCs considering they
> > already have a quirk enabled for UART_ERRATA_CLOCK_DISABLE.
> > 
> 
> That's interesting! We do have AM437x suspend/resume working without
> this workaround (UARTs on AM437x does not use DMA) and UART IPs clkctrl
> do go to idle state. Seems like a OMAP4 specific issue.

Yeah seems to be omap4 specific. I did not see this yesterday
on my am437x-idk or beagle-x15 after clearing status = "disabled"
for all ports and idling them.

> Comment in omap8250_update_scr() warns not to set these two bits in a
> single register write because this may lead to malfunction. I would
> recommend to split this into two writes.

OK I'll split the write into two parts.

Regards,

Tony
