Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12546C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB0020685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HnrMT4uL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB0020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeKUFFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:05:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51296 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbeKUFFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 00:05:23 -0500
Received: from zn.tnic (p200300EC2BD1FF00883B4D3E2A7F8FA4.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:ff00:883b:4d3e:2a7f:8fa4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57C161EC06A7;
        Tue, 20 Nov 2018 19:34:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542738890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UmXJjQyLmDw3alnqWFoAIWrmvcaE7IWG2AITDEdansk=;
        b=HnrMT4uLSxe2czC8X85RWygYxX5UPKcse8DXVFWKJBT1Mnzk1cNnGDwTekUoGqCgmbE6Y3
        sCaiihm8udgIk9r5vpWtIcRpA6XYoq+V+3n/LXYF852RppwDkcpRBavGDnmpwVqJWsXYQ3
        TZYYX5c6UtNoFRwE3uo8tkgJ0klhgaI=
Date:   Tue, 20 Nov 2018 19:34:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sasha Levin <sashal@kernel.org>,
        Victoria Anosova <v.s.anosova@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/fpu: Disable BH while while loading FPU registers
 in __fpu__restore_sig()
Message-ID: <20181120183443.GJ2527@zn.tnic>
References: <20181119160410.ne7oiq2gkwt6jiqg@linutronix.de>
 <20181120132531.6E80C206BB@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181120132531.6E80C206BB@mail.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 01:25:30PM +0000, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v4.19.2, v4.18.19, v4.14.81, v4.9.137, v4.4.163, v3.18.125.
> 
> v4.19.2: Build OK!
> v4.18.19: Build OK!
> v4.14.81: Build OK!
> v4.9.137: Failed to apply! Possible dependencies:
>     Unable to calculate

AFAIR, Victoria asked about this fix a while ago. CCed.

Victoria, do you still need this patch in your 4.9? If so, you might
wanna give it a try:

https://git.kernel.org/tip/68239654acafe6aad5a3c1dc7237e60accfebc03

Let us know if you need help backporting - it should be easy though.

HTH.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
