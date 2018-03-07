Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2592411-1520410678-2-1251630873043922075
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='at',
  MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520410677; b=Gqw/YlEOhQnF3hZPtEW7NIVwvPEzoC2ByRkIjb8YZVWB9hV
    k/7/TuPe7hFDtcGVuZKGZJOS4CMLrzUVyIV4nsog4Faaevnmk5vZe0eo2wBtkyMY
    VG0qCNELg3IKhxLfjul6n2d+yOBzPP+P4soPtQb1eno6IYEajGlKZ+1mxpgrRJpD
    MgZ8voZO4x3LurkrpvV9HpiLh5nliTUHJXbdR+CnDd5RA8cxVOlbCHGEXxpHFrjk
    Pr+X2rcnDiv21QK1dVlvYgAUUVrI7HltGYoJuO+WJJVLVlrjzQSAJywJqEEeG5dF
    vi3R72IUSrV/u9KzT71JJtM5fopMSQZJWgYDFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1520410677; bh=S4jnM0
    nI0aIp55BcNfQUEMimL5Bdq/sHO0ashOSDHsg=; b=oHNn00V91H/ri50HgMxKwx
    dgCV4CXZjeMuD1g9cDSPvDXCsQIE2K7A2B4lAMXMbxwsHYuwqHDyqAwHiK+mYfqn
    q6iZHM5qPZxbj1QeCQ4JUeMXSFVLTluyeOFueroG5ygR1w2Qdlli5w1vConNV/77
    0Mg0Rw+RCeKz2CbU1G9y/hmwHBNUXdSXDww1HajznQqdk8KrcvuTWbYKxNqqQ7U9
    PUxZ7ehjinSriyrUSPnRWYImcw9/IuZLEpuUs0jf2CbgCjRnkU9m379BgaQJyj2/
    jKzLMLiOvMJ1TuQ1DApQDcQo+nUBL850dlgU/UoOW9sA7v+NlJBwtVZltL8635JQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbeCGIRy convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 7 Mar 2018 03:17:54 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:35602 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeCGIRy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 03:17:54 -0500
From: Richard Weinberger <richard@nod.at>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 03/34] mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM
Date: Wed, 07 Mar 2018 09:19:15 +0100
Message-ID: <3306133.ouE1UNrexX@blindfold>
In-Reply-To: <20180307091236.741b7fd2@bbrezillon>
References: <20180302084435.842679610@linuxfoundation.org> <1520371350.23626.23.camel@codethink.co.uk> <20180307091236.741b7fd2@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Boris,

Am Mittwoch, 7. März 2018, 09:12:36 CET schrieb Boris Brezillon:
> On Tue, 06 Mar 2018 21:22:30 +0000
> 
> Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> > On Fri, 2018-03-02 at 09:50 +0100, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me
> > > know.
> > > 
> > > ------------------
> > > 
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > 
> > > [ Upstream commit fdf2e821052958a114618a95ab18a300d0b080cb ]
> > > 
> > > When erased subpages are read then the BCH decoder returns STATUS_ERASED
> > > if they are all empty, or STATUS_UNCORRECTABLE if there are bitflips.
> > > When there are bitflips, we have to set these bits again to show the
> > > upper layers a completely erased page. When a bitflip happens in the
> > > exact byte where the bad block marker is, then this byte is swapped
> > > with another byte in block_mark_swapping(). The correction code then
> > > detects a bitflip in another subpage and no longer corrects the bitflip
> > > where it really happens.
> > 
> > [...]
> > 
> > This seesm to be a bug fix for commit bd2e778c9ee3 "gpmi-nand: Handle
> > ECC Errors in erased pages".  That's not in 4.4 so the bug fix is not
> > needed, though it doesn't appear to do any harm.
> 
> I wonder why the fix was backported to stable releases in the first
> place. AFAICS, there's no Cc-stable or Fixes tag in the original
> commit. It's probably something in the backport-to-stable process I'm
> not aware of.

It was auto selected by a stable script.

Thanks,
//richard
