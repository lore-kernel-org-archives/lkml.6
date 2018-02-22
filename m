Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-175092-1519306271-2-5074280086372005859
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519306271; b=JytHK//He5tYuqNswN88PZ8ejW4GR8zXnIu5l43tiTa7sum
    E05b7aCAGqO91/dKPENGkOleBtCZWiSzxK38eZB4SvuMcqRDbUmRCm6BoxvgFbQJ
    +iNXejORIXWj7ZIzCE+1W2OkBzZgSYOX/JbNHXMsY1Sn9IRkXSPkrJpK3jPUm1/D
    ODM10QDn11VZ8WnV+rLlp8SfBlz/dOifVcLk2FEEvv0x2xuZZ6KWavQlaYESuaSO
    4JerXYA7BMgLb9XlgDSTAvENajxbAd7vGkmoo6EiqiwEU24JkHWJTE89OHecpcNa
    X2J9RngJS5t3Pf6+KTARSXTu0H5UtE+44J2N8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519306271; bh=pt5pX99IuLwWdkmrlKtLfwyIMh
    wJEs6uBm4s9N2HaJc=; b=J44GY6mqfW12GI9DRoyXoVSO4wxDP3LA0JB2Od9nGc
    FBmk2NTIboWe+fpNy4KNn0kBiH03hQ/W8AUImkuf+3YxlvcxlDcTsQ2pKGSUu4pr
    L0DTiI6iLvrNKoLXY8C7HLD13Mkj2Mk16bdrIFZ0gPXvy4cRVCktWJpDrw6+MRpD
    taDCSphG8HDgnC8PRG2LboTPB45x+SXGvxpqw8gy3Q095iSLjDuAN81bMDBfEMFb
    /Id1Q5jKOuMcCPoLEAKM4eVumdHphswZbu08kLYBPhiyvjsHCiuvIiKNm4i2wtRs
    OZpvZeckR3DcdHH6aVj6ooIwgCl4IDdhecnEFw1ajyCQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=BMBIUE1i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=BMBIUE1i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932373AbeBVNay (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 08:30:54 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:34076 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753844AbeBVNaw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 08:30:52 -0500
Date: Thu, 22 Feb 2018 14:30:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: orion: fix orion_ge00_switch_board_info
 initialization
Message-ID: <20180222133043.GC23008@lunn.ch>
References: <20180221121856.3241260-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221121856.3241260-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 01:18:49PM +0100, Arnd Bergmann wrote:
> A section type mismatch warning shows up when building with LTO,
> since orion_ge00_mvmdio_bus_name was put in __initconst but not marked
> const itself:
> 
> include/linux/of.h: In function 'spear_setup_of_timer':
> arch/arm/mach-spear/time.c:207:34: error: 'timer_of_match' causes a section type conflict with 'orion_ge00_mvmdio_bus_name'
>  static const struct of_device_id timer_of_match[] __initconst = {
>                                   ^
> arch/arm/plat-orion/common.c:475:32: note: 'orion_ge00_mvmdio_bus_name' was declared here
>  static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
>                                 ^
> 
> As pointed out by Andrew Lunn, it should in fact be 'const' but not
> '__initconst' because the string is never copied but may be accessed
> after the init sections are freed. To fix that, I get rid of the
> extra symbol and rewrite the initialization in a simpler way that
> assigns both the bus_id and modalias statically.
> 
> I spotted another theoretical bug in the same place, where d->netdev[i]
> may be an out of bounds access, this can be fixed by moving the device
> assignment into the loop.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
