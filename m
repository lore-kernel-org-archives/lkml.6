Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431414-1520249026-2-7126229115260536132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520249024; b=JT0LpExz0Pkn4N9rAa4npEHwQI6KRWPabau3rh2bOZGFPDT
    2HBECblLDUNTRvV5uJZ+P8g6GoThYxNsOeepLwnBJEXQGN66Q740cdrqUEzz9Fd4
    6VaXFlO7DwAx2msjG/gNMMzv/gGRnQjwev01MhtWtnje/FlS6GMzsA1twCXZLVdu
    SkestDagTGmpjjHw7wOH9bosQbQVgUsptrZsGia6YJQUMlwpQBJijrq0uCVan7U2
    d3hB78ge0u/yADDVidQROp1PyzNdX96nnmBERCr6Ro/OttKR0fUoSa+d07BAmOvD
    8f/Axyspq4fzOnYXruBiCcAaH3PkNrumXpKrHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520249024; bh=SVz6mpD
    heEjx5eVHh1iOUUfngyts7yYL5p+tErobGvI=; b=A1NW/ojlunIBXWn8Nk9gvGE
    yn+xE8VZa6cfErWbaGy4ic7A0qloNQ7CnWYEg1XZeRLmCkB0SvX4uovyV767x9l5
    ftwp8lP13aZ2p98b9295uK513UMsNIl1t9fbs12zhOP//3wx2+K7GSQLD7386bfM
    74M9d4iw1bNFCGPwUI15HhNJQFveH8I0cg+B/daQDh4mkvZfu3S8NM7rj1N3rfzP
    PEPqe0w2mP3TzgeWKocHDlRDMhLa6VEHUk5/3PSZn6UBi1Ld9nqIoFudUZKI2hCv
    xGtKjA5+5PyfKTgfBhU/q/cU4Q/byUwrWf48EULFUW4AjUEHSByqbSfScwcnrpw=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934009AbeCELXl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 06:23:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:52619 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933988AbeCELXk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Mar 2018 06:23:40 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="205571328"
Date: Mon, 5 Mar 2018 13:23:34 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] tpm: Trigger only missing TPM 2.0 self tests
Message-ID: <20180305112334.GI25377@linux.intel.com>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
 <20180228195819.22231-2-jarkko.sakkinen@linux.intel.com>
 <1520107919.3105.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520107919.3105.9.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 03, 2018 at 12:11:59PM -0800, James Bottomley wrote:
> I still think removing all logging traces is a mistake for something
> that can consume a significant amount of time in the boot sequence.
>  It's going to cause lost of people doing boot timings to waste lots of
> effort.
> 
> However, removing the log messages makes the above statement a lie, so
> one of the two needs fixing.

The commit itself makes sense but the implementation was sloppy to say
the least in v3. It was like prototype/PoC version of something that
could be merged to mainline, not something that can be merged to
mainline.

For example:

* You could have implemented it more cleanly without that new
  'tpm_transmit_check' helper function as can be seen.
* Many log messages contained a redundant "TPM:" prefix.
* There duplicate logs to tpm_transmit_cmd(). Pass a NULL as
  desc tpm_transmit_cmd() if you want to take care of logging
  yourself.
* The commit has the same short summary as the commit it fixes.
  This issue still persists. Open for suggestions.

Please state if v3 contains a log message that has been removed and is
still mandatory and I can add it if it makes sense.

> > +		rc = tpm_transmit_cmd(chip, NULL, buf.data,
> > PAGE_SIZE, 0, 0,
> > +				      "attempting the self test\n");
> 
> There shouldn't be a \n in the string: the failure message already
> appends one.

Oops, my bad, will fix it.

/Jarkko
