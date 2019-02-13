Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69522C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A63222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="p103b3JS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391772AbfBMPXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:23:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39228 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbfBMPXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:23:33 -0500
Received: from zn.tnic (p200300EC2BCDE80001C441D7371A5B73.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:e800:1c4:41d7:371a:5b73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BFE361EC02FF;
        Wed, 13 Feb 2019 16:23:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550071411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ed+qZFvUH1CbTgvyh/nwON5pLfd+2jQtEruy5zv7iqw=;
        b=p103b3JS86YS3N/G1dECBI5BoYEzDSWhBr1X82sUgR9/q5dwIqWVrdzRDnymNxoFOP37kQ
        7tsLz/rhTsWhGFafCnDsulX9LTNLW4fzCwjP4JYxp/mBTpS8Mg1Kp7bRBUhNClAjz6iFUM
        qJxIrYtPfoVkMsoptMVEBfQ2wU7jxCA=
Date:   Wed, 13 Feb 2019 16:23:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, dvhart@infradead.org,
        andy@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 06/10] x86/cpu: Add Icelake to Intel family
Message-ID: <20190213152326.GA1883@zn.tnic>
References: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
 <20190213150810.32750-7-rajneesh.bhardwaj@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190213150810.32750-7-rajneesh.bhardwaj@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 08:38:06PM +0530, Rajneesh Bhardwaj wrote:
> Add CPUID of Icelake (ICL) mobile processors to Intel family list. The
> information related to ICL CPUID is referenced from below Coreboot
> project link.
> 
> https://github.com/coreboot/coreboot/blob/5ebcea3aaaa3cd358bc5bccaa156b13a6ef25df6/src/soc/intel/common/block/include/intelblocks/mp_init.h
> 

I believe tglx was suggesting you should drop this link. If you can't
reference an official document, then you don't need any reference.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
