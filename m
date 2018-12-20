Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D111C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2845D218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eGduir/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbeLTQET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:04:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43826 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731179AbeLTQES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:04:18 -0500
Received: from zn.tnic (p200300EC2BCCE300FD3378BF67DA2321.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:e300:fd33:78bf:67da:2321])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 369631EC0913;
        Thu, 20 Dec 2018 17:04:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545321857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HmdlXuQC/vrQhvrmhnLecUKi3ndI9dEtKDSoLIK1jfE=;
        b=eGduir/Dt4n9/Q1ye32bOrd+D+BUQV2trRP90Bwljpoet5+GXrb19Oz0+P7xfXXx2WGwBh
        HwADUf89gtKGgTMeIESA96czqn8pQ/nqD/PxnrqF/NiskAcgRQL24a0Ml1q22SR+I8pIyr
        BTYSxg7/wDa2tBRUv/qtsE0WF/bmkjg=
Date:   Thu, 20 Dec 2018 17:04:11 +0100
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
Message-ID: <20181220160411.GC31403@zn.tnic>
References: <20181219195014.A0962820@viggo.jf.intel.com>
 <20181220120240.ermrc3hnixkin2yg@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181220120240.ermrc3hnixkin2yg@black.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 03:02:41PM +0300, Kirill A. Shutemov wrote:
> Below is my attempt on doing the same. The key difference is that the
> sorted array is generated at compile-time by mkcapflags.sh.

Let's just drop this silliness and use good old grep, ok?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
