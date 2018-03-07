Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2663489-1520410362-2-7874241679574151128
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520410361; b=nnBj1TrZphE6uFX3DrQj4serZNJVwmy7CSefWppB9oooq2O
    U6o6Z/jHqzvzRFF2nJqr7bgQi6b+W6WII1Jhi8AGSAeowCXhEUnJ//GblaO+oFVW
    3+/vbws7r5749OOBntl3I8CUCn5bS4GBVw4IxlOmP3oSB0fJlXJqIf0A2LRv/Bhj
    nuf/Q74rPH8w3XsGH5TZlSMy41Soq41MoYjDDic6HaJ2z05b0eid16QAShVXoOc6
    ZFO62bTLGex8ZgMsheEcgybE0UykL6NsM79ed/98J5OBU7gRRiQJO2w0PN110SWD
    bCNQ2JtJOAePrScVRo5rHmJiG5ivpUMQHprdkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520410361; bh=/djtCjwOBadZGIMktBS0wXNUPkiztTBZ+T4bpd9fApM=; b=d
    8Zr8f6sqSNb2a/y/mwFt4LlYRIMy2xw8yrk2vKmOhBQxjHOa4tRe2nxUXTx1q9GV
    tDRvo7UsPBZkdfEY8SGu0zLV+CVt3ML6KgfhYbr3gmo79gKeO2h4gJ1rBoGYgHnR
    tLTHkP263gVlLBovmPYgwtKXprazmy8HLfVwc8TExqnI/7bMczWen175QN9isdiC
    pbeT7pQ0vlE7Y0UDXrR3FCXvUHKE2DF4S6IsyQyNz+RbUSL5vaUQ+1oiAjkA9rHe
    OPvPJUjX0kaxNdrZIUiChBxj0BTIRE6en+VJuZeqAq27zbAGGuo9zKOS+6j+sGLu
    SXkEHmiVy1mqavyN6Iq/g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbeCGIMj convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 7 Mar 2018 03:12:39 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57378 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeCGIMi (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 03:12:38 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Wed, 7 Mar 2018 09:12:36 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 03/34] mtd: nand: gpmi: Fix failure when a erased
 page has a bitflip at BBM
Message-ID: <20180307091236.741b7fd2@bbrezillon>
In-Reply-To: <1520371350.23626.23.camel@codethink.co.uk>
References: <20180302084435.842679610@linuxfoundation.org>
        <20180302084436.171257760@linuxfoundation.org>
        <1520371350.23626.23.camel@codethink.co.uk>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 06 Mar 2018 21:22:30 +0000
Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:

> On Fri, 2018-03-02 at 09:50 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > 
> > [ Upstream commit fdf2e821052958a114618a95ab18a300d0b080cb ]
> > 
> > When erased subpages are read then the BCH decoder returns STATUS_ERASED
> > if they are all empty, or STATUS_UNCORRECTABLE if there are bitflips.
> > When there are bitflips, we have to set these bits again to show the
> > upper layers a completely erased page. When a bitflip happens in the
> > exact byte where the bad block marker is, then this byte is swapped
> > with another byte in block_mark_swapping(). The correction code then
> > detects a bitflip in another subpage and no longer corrects the bitflip
> > where it really happens.  
> [...]
> 
> This seesm to be a bug fix for commit bd2e778c9ee3 "gpmi-nand: Handle
> ECC Errors in erased pages".  That's not in 4.4 so the bug fix is not
> needed, though it doesn't appear to do any harm.

I wonder why the fix was backported to stable releases in the first
place. AFAICS, there's no Cc-stable or Fixes tag in the original
commit. It's probably something in the backport-to-stable process I'm
not aware of.

Anyway, not an issues since the changes seems to be harmless.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
