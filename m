Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF1FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A8C2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BI6AeydN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbeLPKo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:44:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45012 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729811AbeLPKoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:44:55 -0500
Received: from zn.tnic (p200300EC2BE55900ADD97DAFC8659476.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:5900:add9:7daf:c865:9476])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F7841EC0980;
        Sun, 16 Dec 2018 11:44:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544957094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/c+Z2yQd2nc8tbx8jr+19oJhgLGYEfFitWB8e0ljVz4=;
        b=BI6AeydN+g9tksD+LoM8bet057hpau0vK41lKSfQmYDHMm6prAPBhuYpj3DBxPtDbXj51j
        yhcuWpr7otYcf6KVG0iNO7sRzv6+Z2XTFWbS4xpCZ6NnV/fQ/PXKRteUXZWPPbIVQdXWOb
        Q5HYNVyVxTHz+ehHcch+kAA27hDsf8E=
Date:   Sun, 16 Dec 2018 11:44:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with late AMD microcode reload/feedback
Message-ID: <20181216104453.GD815@zn.tnic>
References: <CACna6ryhfaOFS4qjZoLjJqcu5LQd05_jDndL5+GpADTHhu3_7Q@mail.gmail.com>
 <20181216000510.GC6693@zn.tnic>
 <bac495ca-ccfd-3551-97ca-1444a391fa40@gmail.com>
 <20181216100645.GB815@zn.tnic>
 <CACna6rynZtBC8YiGOD_YkwobvUsYxRqzsqwG0fNjs-LL+K2Oig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rynZtBC8YiGOD_YkwobvUsYxRqzsqwG0fNjs-LL+K2Oig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 11:26:29AM +0100, Rafał Miłecki wrote:
> Debugging CPU errors.

I told you that this issue is being worked on and there will be a fix
of sorts at some point. Don't try any funky business of downgrading the
microcode and maybe break your boxes in the process. Just ignore the MCE
- it is harmless! - until there's a fix.

Ok?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
