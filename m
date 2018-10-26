Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314BBECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE90720869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="dP3XyFOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE90720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeJZVqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:46:21 -0400
Received: from imap.thunk.org ([74.207.234.97]:60528 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeJZVqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DR8+Zp+/IHEKYA5ZRRF8Np+qBlW+o/7gfTPUUqb+jHI=; b=dP3XyFOkTna2qNlMmzSf/qYpxW
        kkycNT9CplzHVTwuCS7dH0Vi2giUXPcj8Q5n5iU14pzbrj5+2touf7i2MY65MG1IlOPKLoIKs3Iju
        MJOp0q+C1QXAemDuL2qrnk2+e0q/NsLj1d2SLbfDOwZKvva1+aPJKjIvxP4g5oJvzNKQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gG1rX-0008Im-Lb; Fri, 26 Oct 2018 13:09:15 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9870A7A45B4; Fri, 26 Oct 2018 09:09:14 -0400 (EDT)
Date:   Fri, 26 Oct 2018 09:09:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v8 28/28] net: WireGuard secure network tunnel
Message-ID: <20181026130914.GA8279@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Lunn <andrew@lunn.ch>, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181018145712.7538-1-Jason@zx2c4.com>
 <20181018145712.7538-29-Jason@zx2c4.com>
 <20181020224706.GC14816@lunn.ch>
 <CAHmME9qMf=n7mnE-bsx86SVFBs1LrvHoc+nWrpr12vtYAgze+g@mail.gmail.com>
 <20181025224426.GC6276@lunn.ch>
 <CAHmME9pf=tCd=RKPTCpYuHLPkYqQwwr3LXEHP+_WXJ7DNjueZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pf=tCd=RKPTCpYuHLPkYqQwwr3LXEHP+_WXJ7DNjueZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 01:47:21AM +0200, Jason A. Donenfeld wrote:
> when it goes to sleep (screen blanking, wakelocks, etc). The Android
> model of Linux revolves around this, and hence the suspend semantics
> for WireGuard respect this model and adjust accordingly, using the
> appropriate CONFIG_ANDROID to determine which model we're operating
> under. This is not a bandaid, and it doesn't have to do with forks of
> the Linux kernel.

If that's what you are trying to conditionalize, why don't use
CONFIG_PM_AUTOSLEEP?  That way if there are other systems that want to
use the Android wakelocks style of suspend management, your code will
DTRT, as opposed to depending on CONFIG_ANDROID.

						- Ted
