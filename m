Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EDB2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EDB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opteya.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeGSVBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:01:53 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:33943 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbeGSVBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:01:53 -0400
Received: from [2a01:e35:2e9f:6cb0:857c:11e6:3194:d53d] (helo=test.quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1fgFMJ-000APw-Qi; Thu, 19 Jul 2018 22:17:09 +0200
Message-ID: <437d334a02acf3eff96a4f4da6079829f1de1197.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sandy Harris <sandyinchina@gmail.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Date:   Thu, 19 Jul 2018 22:17:03 +0200
In-Reply-To: <20180718173621.GC30706@thunk.org>
References: <20180718014344.1309-1-tytso@mit.edu>
         <20180718015154.GE3489@thunk.org>
         <CACXcFmk7D5t9yg9VxhKZgMvqK-LmFF0d7Dh9A3hsoGTfzzeM8A@mail.gmail.com>
         <20180718173621.GC30706@thunk.org>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:2e9f:6cb0:857c:11e6:3194:d53d
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: Re: [PATCH] random: addu a config option to trust the CPU's hwrng
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 18 juillet 2018 à 13:36 -0400, Theodore Y. Ts'o a écrit :

> For those people who are super paranoid and want a "true random
> number generator" (and the meaning of that is hazy) because a
> CRNG is Not Enough, my recommendation these days is that they get
> something like an open hardware RNG solution, such as ChaosKey from
> Altus Metrum[1].
> 
> [1] https://altusmetrum.org/ChaosKey/
> 

I could suggest "Infinite Noise" [1] keys which are also open hardware.
They use a different design, based on "modular multiplication" which
should be immune to most RF noise, 

The original model is currently sold out[2] but a fork exists[3].

One can also have a look at OneRNG [4][5] which uses a more usual
design but adds a nice EMI shield protection.

[1] https://github.com/waywardgeek/infnoise
[2] https://www.tindie.com/products/WaywardGeek/infinite-noise-true-random-number-generator/
[3] https://www.tindie.com/products/manueldomke/infinite-noise-trng-true-random-number-generator/
[4] http://onerng.info/
[5] http://moonbaseotago.com/onerng/

Regards.

-- 
Yann Droneaud
OPTEYA

