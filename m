Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4232EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1191E21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fwMgjLRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbeLUNEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:04:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55728 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388218AbeLUNEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:04:09 -0500
Received: from zn.tnic (p200300EC2BD18000183B79CE2301FC6B.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8000:183b:79ce:2301:fc6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17D8F1EC0B86;
        Fri, 21 Dec 2018 14:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545397448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1O5XXWm3rA90JAEGE8F8oBHLF68/5lBe4VI+XYmT3mA=;
        b=fwMgjLRIH947aR0d2Atcch8nUtyYcFwqwUm4a2mWoG+YuHYp4dqO8RlymKynG5Zy6PA/0K
        VSiqBozZNhgOJqdlijrfXWfz6gUe1YDsWhV/BLyMQhvIXeiWdOz4L30LCEj5Kagguh5lP1
        E4M1Vz1j30iqe3qzD5pWlIhhCKGFZEU=
Date:   Fri, 21 Dec 2018 14:04:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] x86/cpu: sort cpuinfo flags
Message-ID: <20181221130403.GD1325@zn.tnic>
References: <20181219195014.A0962820@viggo.jf.intel.com>
 <20181220120240.ermrc3hnixkin2yg@black.fi.intel.com>
 <20181220160411.GC31403@zn.tnic>
 <20181221124037.s57lt567pgzbz7z3@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181221124037.s57lt567pgzbz7z3@black.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 03:40:37PM +0300, Kirill A. Shutemov wrote:
> But I don't see an improvement in readability of data presented to user as
> a silly idea.

Improving readability is not a silly idea and I never said that. Rather,
the cost of what you're trying to accomplish, needs to be weighed.

The final goal of this is, AFAIU, finding whether a feature flag is
there or not and you can use grep for that now, on *any* kernel.

And if you need the feature flags sorted, you can do that too:

$ grep -m 1 flags /proc/cpuinfo | tr " " "\n" | sort | xargs

and there probably is even a simpler way to do that.

Or add a shell alias for that or a small script or ...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
