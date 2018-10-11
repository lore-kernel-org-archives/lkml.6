Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED44C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303302077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hmh.eng.br header.i=@hmh.eng.br header.b="m67xsYwS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Em6kDkTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303302077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hmh.eng.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeJKTK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:10:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34915 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbeJKTK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:10:28 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BD4D121E32;
        Thu, 11 Oct 2018 07:43:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 11 Oct 2018 07:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmh.eng.br; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=T70wiWg2mYWbvU+CAeYThzMbO59
        iNJ3wEEYkJi44Q4Y=; b=m67xsYwSwotO/hxV+DedAlWz7hhLqREbmIyj1v01qmo
        s2toeVCek9/1SNKXhvQpQqVjzIOsoowPmELqHBQTxNFWad42WTdgqYWGOTwTjYJi
        4JqJ+olwAgyYkmzV/ANhOLe/3hKWtXd4PmNJGB8sFONK2RIrBVytF/zt5dIhUxsP
        CHpbk7bpAVIKweVChVVHi/3S3sMoZRVCrLO5jHLWFnWVsHaGvdSH+j0TtWAAaY1p
        WFBrdrYTVDyu2nmpboT8XojbzoV8B1nSFfOlzseqi6QsY/ojxMYf3627ByUUyWtz
        +X6ISG2aG8cwzQEh8o5NyBKJ0NC13Ej6ZzOzZiuhluw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=T70wiW
        g2mYWbvU+CAeYThzMbO59iNJ3wEEYkJi44Q4Y=; b=Em6kDkTrflFqHpfNMJPQWy
        +h3LB7R7aYA9U0+7ISincHvUS1w67CyjP/5XgCL+IE48vlhde4NsM6TsIvjQfDew
        elhb9K/WNkgkEMq4LfuoJegqroMpfgl3mO1Fg/Tx/xNhmiNeFvozuqtdaGxHycb/
        m5WqcWwf7OH6IyH4iLoQY/iFctXKK594N9LRwjs7v3o9FQtUbNfc2Fv3R+D3IeIj
        q68XymepfOmjsavr4d8gRlIrO2t6B5Deazl0EG41ezRoYu3+tJjB90RmuOyBWdax
        vCEDZyXAiHNaHSLiOFP5DOQ9Eak++yuu3yR5cFmjJvVatFgFaI+NPr4ldbjJvahw
        ==
X-ME-Sender: <xms:ZDe_W2pSq0MI3uWNbxARCKl2wywkHcPmw_lBMy400YsYOoTn_pqZag>
X-ME-Proxy: <xmx:ZDe_W7_7RwOCy92z5q2jEMIZwEJdhkRjT0acQ0CSjrjeAHRU_K0m2A>
    <xmx:ZDe_W07_l5u3VS1qKtn8MwS9GYe2fFeyazTmUbojhOHtztBdoSfBMw>
    <xmx:ZDe_WxkWA2TUAOLaniP-8uen2e7iYnlYt-5PdmjfgQapM2G4tJOG9w>
    <xmx:ZDe_W3F8ciL9mSCdXutN-zZsDd-Rfb4uRLmHMx_tCbBNZVnzjUDnIw>
    <xmx:ZDe_W5ZQuikAZOaV1uUU_kRLuPl2X-PRSYTEJqfMLvUoOW6rrRAvFw>
    <xmx:Zze_W7zE188BQmN1tND194btgIFKfsBycHZcCpISs9HAwjSUPyVgvg>
Received: from khazad-dum.debian.net (unknown [201.53.245.99])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9206A102EA;
        Thu, 11 Oct 2018 07:43:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by localhost.khazad-dum.debian.net (Postfix) with ESMTP id 5F20D3403991;
        Thu, 11 Oct 2018 08:43:29 -0300 (-03)
X-Virus-Scanned: Debian amavisd-new at khazad-dum.debian.net
Received: from khazad-dum.debian.net ([127.0.0.1])
        by localhost (khazad-dum2.khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 2ni_b-KRft9Y; Thu, 11 Oct 2018 08:43:28 -0300 (-03)
Received: by khazad-dum.debian.net (Postfix, from userid 1000)
        id EA81E3403990; Thu, 11 Oct 2018 08:43:27 -0300 (-03)
Date:   Thu, 11 Oct 2018 08:43:27 -0300
From:   Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     peterz@infradead.org, x86@kernel.org, eranian@google.com,
        kan.liang@intel.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 1/2] x86/cpufeature: Add facility to match microcode
 revisions
Message-ID: <20181011114327.oo3at77hxucpfaon@khazad-dum.debian.net>
References: <20181010162608.23899-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010162608.23899-1-andi@firstfloor.org>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018, Andi Kleen wrote:
> v2:
> Remove all CPU match, only check boot cpu

IMHO, since it looks like a v3 will be necessary anyway, it could
benefit from a comment reminding people about how to use it on older
systems where "mixed CPU stepping" configurations were common.

This is *not* a relevant limitation, and it is easy enough to handle.
But people writing quirks for very old Intel Xeon CPUs *today* (unlikely
as that might be) might well forget the mixed-stepping gotcha...

Note that while mixed-stepping SMP configurations are *not* current
practice, they *were* reasonably common practice more than a decade ago,
officially supported both by Intel (there are Intel documents detailing
the valid stepping combinations) and the server vendors.

Suggestion below.

> +/*
> + * Match specific microcodes
> + *
> + * vendor/family/model/stepping must be all set.
> + * min_ucode is optional and can be 0.

* only checks against the boot cpu.  When mixed-stepping configs are
  valid for a CPU model, add a quirk for every valid stepping and
  do the fine-tuning in the quirk handler.

-- 
  Henrique Holschuh
