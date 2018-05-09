Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-619745-1525882448-2-11235443748920480113
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525882447; b=E+0pFACm6iOwrOWUAxTOz81TdjaNbo3Euujchxqj3malzOIIes
    CuGISBSJ7OC07M5jDizMd60xrwyfFz6ksFA1ThCc3OWKbHlhPMDNtQxpDrIMbskw
    j+cx1BFZByCjGuTYiWTE/bwyT1wpAUH2f8i0aSM+soe6inJlG8vQXk9cT1Tmbuwq
    RYadsfSGETQ6xvcFp16tdb6um2DrCrwZW3x7QfzngOMxp+d3PcG3Y2yXaT4TZ4ad
    ECuvN8MplJGxPL+afnNCsp0SLzCGkJTewlyP51FZ1RWAsaviE21dhye7mKheUW4p
    6bOmw9Jy5sAFdRvI344yBH16maKVSQSbmfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525882447; bh=89k1xzuMuTYM7q6hUfp3yrJIGup96e
    M5Fhoc3JRjhuY=; b=a3E8OnM54z8A/Bh167Ki1777YqfJmqIQsFyZp0u9vxPynb
    /BMRLtesEfB0LF5tKecbhU2tBQcsTsV1ycaqZYPlK4WHGSgdQmtsDj64/UcVEO6L
    zUK0B4q3FVIPEQMOHy86zMqVKmzRmBkdImYBZZ6bGOGyEDG1uWcnP5MOvsXpWOEI
    xh1VduCQ50Wf0oQDIhsN43Y7wcY8dViVMC25/PqV0qUz6gay6C/ojK9xg9Zl8fC1
    mcl02mq499OudND0EIq/zGby8KRepIA/t7d8vP8T17NN1zrs9DnuRR3L9uWaGtrX
    ywHceDMiM7L3h/ZLpJXxcty/punm53Uk45RsJHkw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ravnborg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ravnborg.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ravnborg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ravnborg.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAtAV2K/ae0Bd0Efn4aCBn4Wm3FVLJTLIk9dQVOjSXUCvQAUB/lVS8WECUHk5JeNfhPG9oQdI7hE4fh96N7KJgXtzLV1DJlu2wYJ8ml6ibmQKZnBUrsH
    fRkFG0xFjCqtOzOOufRa7rSqU5SyJGrMW20Y5x+EI1P3YwLepQWV5pNT1oTn+Goe+oe+h+2iojTj3CE9MXkY9GSMigGgNuIxuJFZI3A3dZV97UYDHgL0YtVO
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=D19gQVrFAAAA:8 a=7gkXJVJtAAAA:8 a=MEarO2aCjOhwG9nifTAA:9 a=CjuIK1q_8ugA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=E9Po1WZjFZOl8hwRPBS3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965440AbeEIQOF (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 12:14:05 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:56081 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965358AbeEIQOE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 12:14:04 -0400
Date: Wed, 9 May 2018 18:13:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH 0/8] kbuild: remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
 and clean-up code
Message-ID: <20180509161359.GB7459@ravnborg.org>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=D19gQVrFAAAA:8 a=7gkXJVJtAAAA:8
        a=MEarO2aCjOhwG9nifTAA:9 a=CjuIK1q_8ugA:10 a=W4TVW4IDbPiebHqcZpNg:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masahiro.

On Wed, May 09, 2018 at 04:23:44PM +0900, Masahiro Yamada wrote:
> 
> I got acknowledge to remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX entirely.
> (https://lkml.org/lkml/2018/5/5/148)
> 
> Several tools can be cleaned-up.
> 
> Removing the CONFIG option makes VMLINUX_SYMBOL() no-op,
> so this macro can be removed too.
Looks good. You can add my:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

for all patches.
One minor comment to one patch that I let you decide what to do about.
The code readability increases everywhere.

> 
> VMLINUX_SYMBOL() and VMLINUX_SYMBOL_STR() are widely used,
> so it will take some time to kill them entirely.
> (I will send other patches later, splitting per-arch)

There are a few files outside arch/ like
certs/system_certificates.S
drivers/mtd/chips/gen_probe.c
kernel/module.c

They could belong in this none-arch series.

	Sam
