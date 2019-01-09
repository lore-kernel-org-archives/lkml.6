Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C152FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5055020859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="fLXe6uoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfAIQsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:48:16 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:10754 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfAIQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547052493;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=X55wUXMkplEw0w5U2MZONAJX8KUZrTc2wJMTYaCMoZc=;
        b=fLXe6uoBiG8RUdH4UsSVBd81GSS1E/UFE9jZGccgwK9VkxeYL8aGZLt/OH4WxkBpbt
        oM8Lm4Z4BwKW2PFEWgF4+e0+KwIPcUCVsL1tAeAHOXZOoYWDsN/KxseYO+PRDTd7cEEU
        61TQEkeSn27RsbCFCU9lV0xzVRa+sZsbLOlAbnEWhO6kjef+0jNBEZlERIB/ChE7HnHA
        YX1Qy4DTr3PEQl538yEsdwBEp9v5PaPXNaTAToB2vbiBRKibzBgh2znjaeWCnl8lnEAA
        o6yf3x56+yuSqJfNJGsBUAuE/6l9kuN5exqx3Do4UivGGxqwduZkF5kyv5DPmBdxAbsa
        YbRQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaLvSbdkg="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv09GlrS3r
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Jan 2019 17:47:53 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     joeyli <jlee@suse.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate snapshot image
Date:   Wed, 09 Jan 2019 17:47:53 +0100
Message-ID: <2049173.FbhQ43HnNr@tauon.chronox.de>
In-Reply-To: <20190109163958.GG9503@linux-l9pv.suse>
References: <20190103143227.9138-1-jlee@suse.com> <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com> <20190109163958.GG9503@linux-l9pv.suse>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. Januar 2019, 17:39:58 CET schrieb joeyli:

Hi joeyli,

> 
> I am doing encrypt-then-MAC.

Note, this is what the authenc() AEAD cipher does.

Ciao
Stephan


