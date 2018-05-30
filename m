Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-186052-1527710117-2-15618959269904164516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527710117; b=L7zttGikImsc8QjJNuL1V40BCzBwgIXLrnd+R5qZO6QB+Y3fxc
    G6aJtZ6aYBQvw89LjIyNiR5fpHlumL84JZIuYIM+iAb5rQ1gGSH5mkJKJjWuXFxZ
    sTBmVCcvyw6JupupsZZ6e6Ch6ZF5yeOUXTXi1tnZ/tivDOpww6+VyNYaKkOf6/ec
    rxMW7gv+xnVQ1nSwZ1ZfyMDz/o6g3G3ieUnVaPwrsOzvG0WziDEPgJM8T0kPy1YG
    IvBEDS8TkxlD39qc7+cq4vUOiILC5BsVw+RkVlLabXw4tIkpphf8L3RWf4O7299t
    /CYy+84TZrmaUec7xLWRdmhqEUC9Wg8bo5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527710117; bh=xn8OHz+bkp4hbj+D5YXDeXZB+E+8Im
    fmTUt57+gMp8c=; b=FLga7oR31kduvx2cB70AttzUCc5MB24tdv4wSkKIO5lM5K
    JCWTNnliIuh6Fd7OH81YOLVqlxDyNRny5sFouzQAQOMLdugF5KOBTaUaNmhqQb+l
    +Td6iSbhL2qtLl3N7bQlld9+XGPdjW6EapHQT64TX7TIFYJvSDG7KlMGMXRZWVxA
    3ORFissqLVM3+5Dw2O2zfXoFzWlz8j1GbTilqtOYpD+nPRQ7Nf1a+lMqrYFgAvNo
    Vm3qI5b/1/aXEbvMj/RAeR/Tezk5R5GmIbeiDCfdLfKI/RqqAsq2jfaoraj4fWSB
    iINT9C5E1c0OCkAhJXOaITFoHiTc1a952zE3GwAA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKoIak68CwGINj30lNkV/khBN3z9uVO02aOnUfLSJY456WiUpqUnUc0KWu355SRN/DgMK4B1gZZXDfqMif27708wXq4jmTd2qt6fe59EA8D7XSRwCLo0
    Si/M2Syw8opQ10w77jjeartK38WdzfNrWlIJOJJV80+Su5N3X3StCnEAdNT1VVtqaM1x0Kw9wquE72wiTDAKTiB/q6nMKQ1qwqQpb3YtwyGZ8X9rCBxcOAHz
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=2oNIfkA2PPlwlrE6tZsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932208AbeE3TzD (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 15:55:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:51631 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753651AbeE3TzD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 May 2018 15:55:03 -0400
Date: Wed, 30 May 2018 21:55:00 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org, arnd@arndb.de
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, willy@infradead.org,
        geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH v3 0/2] mm: PAGE_KERNEL_* fallbacks
Message-ID: <20180530195500.GU4511@wotan.suse.de>
References: <20180510185507.2439-1-mcgrof@kernel.org>
 <20180516164403.GI27853@wotan.suse.de>
 <20180523213551.GF4511@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523213551.GF4511@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 11:35:51PM +0200, Luis R. Rodriguez wrote:
> On Wed, May 16, 2018 at 06:44:03PM +0200, Luis R. Rodriguez wrote:
> > On Thu, May 10, 2018 at 11:55:05AM -0700, Luis R. Rodriguez wrote:
> > > This is the 3rd iteration for moving PAGE_KERNEL_* fallback
> > > definitions into asm-generic headers. Greg asked for a Changelog
> > > for patch iteration changes, its below.
> > > 
> > > All these patches have been tested by 0-day.
> > > 
> > > Questions, and specially flames are greatly appreciated.
> > 
> > *Poke*
> 
> Greg, since this does touch the firmware loader as well, *poke*.

*Re-re-poke*

  Luis
