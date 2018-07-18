Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFB7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB5B20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB5B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opteya.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbeGRQI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:08:26 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:33622 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbeGRQI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:08:26 -0400
Received: from [2a01:e35:2e9f:6cb0:857c:11e6:3194:d53d] (helo=test.quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1ffoOt-000AHL-Gq; Wed, 18 Jul 2018 17:29:59 +0200
Message-ID: <822ef031e3589a5cda5972eeeb457bbad69ecde6.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Date:   Wed, 18 Jul 2018 17:29:58 +0200
In-Reply-To: <20180718142625.GA5942@thunk.org>
References: <20180718014344.1309-1-tytso@mit.edu>
         <37046662f2b38f98854abfa1b5868a27c3fa0888.camel@opteya.com>
         <20180718142625.GA5942@thunk.org>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:2e9f:6cb0:857c:11e6:3194:d53d
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 18 juillet 2018 à 10:26 -0400, Theodore Y. Ts'o a écrit :
> On Wed, Jul 18, 2018 at 09:22:13AM +0200, Yann Droneaud wrote:
> > 
> > The text message should explain this is only relevant during
> > initialization / early boot.
> > 
> > The config option name should state this.
> 
> There are other workarounds for hangs that happen after
> initialization / early boot, yes.  They are of varying levels of
> quality / safely, but that's neither here nor there.
> 
> However, enabling config option means that the CRNG will be
> initialized with potentially information available to the CPU
> manufacturer and/or Nation States, and this persists *after*
> initialization / early boot.  So to say, "we're perfectly safe after
> we leave initialization / early boot" is not true.
> 

Sure, but, AFAICT, RDRAND is already in use through arch_get_random_*()
functions when CONFIG_ARCH_RANDOM is enabled.

From an outside PoV, there's a conflict: why one would want its kernel
to use CPU hwrng if one has purposely disabled CONFIG_RANDOM_TRUST_CPU
?

> So I'd much rather make it clear that we are trusting the CPU
> manufacturer far more than just during early boot.
> 

Then, should CONFIG_ARCH_RANDOM depends on CONFIG_RANDOM_TRUST_CPU  (on
x86 at least) ?

Regards.

-- 
Yann Droneaud
OPTEYA

