Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF348C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4ADA20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q9VsNEYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfBDQgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:36:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57512 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbfBDQgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:36:31 -0500
Received: from zn.tnic (p200300EC2BC6E200ECEE10EFADD37342.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:e200:ecee:10ef:add3:7342])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 898E61EC0345;
        Mon,  4 Feb 2019 17:36:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549298190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gYd/cvBC3Fbn/Tsd9Yd1PLD73gDkI1D68RGpDNvh0Kk=;
        b=Q9VsNEYnuWUU7FyD1HLRY4EvPVcWJrC/WkuxjBufMCGiAlfda2JsGZ1h1hR9lejC4CzJ6u
        9QIeDe9Dcn6rFIMdRZQBvU4qQZAAvEF6HPO7GT5GSNY+RKRXxdT8v3tzInurSoyZprbfWZ
        JzHu7Ebv3R50Qe4uU6sQRtclRjTjdFo=
Date:   Mon, 4 Feb 2019 17:36:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/5] EDAC, mce_amd: Print ExtErrorCode and description on
 a single line
Message-ID: <20190204163618.GF29639@zn.tnic>
References: <20190201225534.8177-1-Yazen.Ghannam@amd.com>
 <20190201225534.8177-6-Yazen.Ghannam@amd.com>
 <20190203122158.GA21750@zn.tnic>
 <BN7PR12MB2593CF4ABBC4ECFCDE87FC7AF86D0@BN7PR12MB2593.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN7PR12MB2593CF4ABBC4ECFCDE87FC7AF86D0@BN7PR12MB2593.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 03:14:27PM +0000, Ghannam, Yazen wrote:
> Yes, you're right. But it seems that the next pr_* that's not a pr_cont will be on
> a newline automatically.

Ah, that must be that printk continuation fun around

  4bcc595ccd80 ("printk: reinstate KERN_CONT for printing continuation lines")

> Should I add an explicit newline just to be sure we get one?

Nah, no need. If anything, we should strive to get rid of KERN_CONT, if
possible.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
