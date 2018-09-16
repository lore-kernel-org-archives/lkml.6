Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F1ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4F32098A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=bluebirdmountain.de header.i=@bluebirdmountain.de header.b="sd+LcIMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4F32098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bluebirdmountain.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeIQFYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:24:02 -0400
Received: from mail.bluebirdmountain.de ([85.214.86.158]:35518 "EHLO
        mail.bluebirdmountain.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeIQFYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:24:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.bluebirdmountain.de (Postfix) with ESMTP id 53D0815D80708
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 01:59:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluebirdmountain.de;
        s=default; t=1537142356;
        bh=wiph6WCaZS8m57qzRwCM3W6iPyoOK2XqcctsyQXEWL0=;
        h=References:Subject:To:From:Date:In-Reply-To;
        b=sd+LcIMKoZysW5tsKw/U8pbNNnpfPkBCXqTYxcm9Qe4lhC3xFxZnxRL4HodGdg17I
         PGsrd5Qb69+yz8NSlWILCv8DAJdAeifRz3zSm2SSJzt7pJ/l6F1qLDN4lgD4i6xyt7
         qhGoPNuD1DBtH0cuOOxVwspyInX0+xOeDYAGPacY=
X-Fuglu-Suspect: 6e08c886d34a4ef49fa6d13cd19b9673
X-Fuglu-Spamstatus: NO
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: moritz.obermeier@bluebirdmountain.de)
        by mail.bluebirdmountain.de (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 01:59:16 +0200 (CEST)
References: <20180916214226.nmjqk55cxobsjayd@angband.pl>
Subject: Re: [...] an apology, and a maintainership note
To:     linux-kernel@vger.kernel.org
From:   Moritz Obermeier <moritz.obermeier@bluebirdmountain.de>
Openpgp: preference=signencrypt
Autocrypt: addr=moritz.obermeier@bluebirdmountain.de; prefer-encrypt=mutual;
 keydata=
 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
 /JeLjehyrIWxDqbZewU5hJMoSf5DzBgLuoLz
Message-ID: <15434a7a-d411-435e-5f3a-3006c0522c88@bluebirdmountain.de>
Date:   Mon, 17 Sep 2018 01:59:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180916214226.nmjqk55cxobsjayd@angband.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When you look yourself in the mirror, I want you to see that guy who codes
> in a bathrobe instead of a sweet-talking lying politician.  

This is why we need more empathy. There is no need for you to decide what 
Linus sees once he looks into the mirror. You are projecting your own
thoughts and emotions onto him.

> Being honest means sometimes saying non-nice things.

Also I don't think being honest and being nice are mutually exclusive. 
If someone does something in a bad way, it is actually nice to point that 
out. But cursing is not really needed for this. In my experience cursing is
an indication that the mind is not calm, and therefore one is not making 
the best possible decisions - which of course results in an not optimal
outcome.

@Linus: I think it is a very wise decision to take some time off for empathy
training. If your subconscious told you to avoid the summit, it is smart to
figure out where this comes from.  I personally have found mindfulness 
meditation to be a very helpful tool in becoming more empathetic, but I am
sure you are able to achieve your goal without my humble input. I admire
your work.

Kind Regards,
Moritz
