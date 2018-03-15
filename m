Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-779193-1521134052-2-14950387762266515804
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521134051; b=dIq0IDvzwGSLGaP7oJNSYQ92e1BrtStkU0Uae86kjj6ru9e
    EVX2OqIE4wR6nlxQNMnixX5dZWrUnY02AN19HOr81+K4XL83wXRGD8TdjLEY+eAL
    KfVaglpqJ0uACKh2jA4LxzAnDo4B+OAriUSW5Ssg7Okzt0hxuAdquaGVPtW8I4Cq
    0IKL/pupuAbIxC89OZIIz0aRueEH8R9+7kOu9mKeG3cAA7OL5u+Hx3DQUljcW4m9
    2tzGoxwlPaX+QJtEkmRnybJdDjQxmzTmBvLzpeCdptRguvbxYBk82XZHXNtNBPcd
    e1PO4fczioUcfSmrBiJ0OS9grIp5TSTd6/pyn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521134051; bh=17CEB9lKMb2wyE1+WdNQIsGOqq4yjSXU25PiHtQ1Tx0=; b=s
    ym6igXhZhvFo8qq2H1yfsSvH076dozKbkc7nGv4ZPdlrgsjipu/LIF6ARznH1B3P
    0vj257LCZ4dn4OGMjEw5YBFnYaNtKXrKU9embC5qnXrefTR155FiB/kcC4He2tki
    iGqqMLc4tHBEA+qyjKb3s3rAW2aaVZsAFZdrl/LDIMpiNScrGUhBqHquit5/dLdO
    2dRwua+HE2HixqVlq7V5NxsLlPKLt9sUIsMgxuJ+++/PASYIs2V2pUHNz2ZBpQ2H
    Nb2+rNDFOyHwzU8vdNOEmXCH72CZapbiNBL9f8RzwpHCci1nq/WeScGnost0YlTd
    S3uyhhYpqPxnVuL20t1MQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=perches.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=perches.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeCORNz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 13:13:55 -0400
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:57754 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750987AbeCORNt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 13:13:49 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Remote-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:569:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6742:7903:8603:9389:10004:10400:10481:10848:11026:11232:11658:11914:12740:12760:12895:13069:13095:13255:13311:13357:13439:14659:14721:19900:21080:21433:21627:30054:30060:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: flag05_3802cfc9660d
X-Filterd-Recvd-Size: 2691
Message-ID: <1521134022.22221.38.camel@perches.com>
Subject: Re: rfc: remove print_vma_addr ? (was Re: [PATCH 00/16] remove
 eight obsolete architectures)
From: Joe Perches <joe@perches.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-rtc@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Date: Thu, 15 Mar 2018 10:13:42 -0700
In-Reply-To: <20180315170830.GA17574@bombadil.infradead.org>
References: <20180314143529.1456168-1-arnd@arndb.de>
         <2929.1521106970@warthog.procyon.org.uk>
         <CAMuHMdXcxuzCOnFCNm4NXDv-wfYJDO5GQpB_ECu7j=2BjMhNpA@mail.gmail.com>
         <1521133006.22221.35.camel@perches.com>
         <20180315170830.GA17574@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-15 at 10:08 -0700, Matthew Wilcox wrote:
> On Thu, Mar 15, 2018 at 09:56:46AM -0700, Joe Perches wrote:
> > I have a patchset that creates a vsprintf extension for
> > print_vma_addr and removes all the uses similar to the
> > print_symbol() removal.
> > 
> > This now avoids any possible printk interleaving.
> > 
> > Unfortunately, without some #ifdef in vsprintf, which
> > I would like to avoid, it increases the nommu kernel
> > size by ~500 bytes.
> > 
> > Anyone think this is acceptable?
[]
> This doesn't feel like a huge win since it's only called ~once per
> architecture.  I'd be more excited if it made the printing of the whole
> thing standardised; eg we have a print_fault() function in mm/memory.c
> which takes a suitable set of arguments.

Sure but perhaps that's not feasible as the surrounding output
is per-arch specific.

What could be a standardized fault message here?

