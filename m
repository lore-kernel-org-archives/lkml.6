Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F4BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A77521924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="V/s3MDl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBHVx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:53:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49056 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBHVx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:53:29 -0500
Received: from zn.tnic (p200300EC2BC9F900B830E0BCFC6FF2AB.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:f900:b830:e0bc:fc6f:f2ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1C7D1EC0A4F;
        Fri,  8 Feb 2019 22:53:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549662807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+bkeTsRJ3DNtbvZ47f5dXFlITQ8viIxge0L4fkv7618=;
        b=V/s3MDl+UqhjG6tUVA4W4BMjA5dzECqzinVtNJGF5351SzOstiojOCcr3psr9VP60b4YCb
        d1SbbUkkpFL64h0XFLOh/wFs8xlhcc+nxVC2PZghTX1A+S8jhzaJmiLUruv4YnngWDq2Y/
        2gCX2BBPJ/MYbVDLf3CVAmBMhElJB1M=
Date:   Fri, 8 Feb 2019 22:53:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     fanc.fnst@cn.fujitsu.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mingo@redhat.com, thomas.lendacky@amd.com,
        yamada.masahiro@socionext.com, caoj.fnst@cn.fujitsu.com,
        jgross@suse.com, mingo@kernel.org, keescook@chromium.org,
        x86@kernel.org, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190208215322.GO674@zn.tnic>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net>
 <20190208191024.GL674@zn.tnic>
 <20190208204451.GA14024@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208204451.GA14024@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 12:44:51PM -0800, Guenter Roeck wrote:
> Yes, the kernel boots if I comment out that function and have it return 0.

Thanks, this localizes the issue significantly.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
