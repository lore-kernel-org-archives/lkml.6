Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59CDC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E2521479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="G0Vhiq4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E2521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbeLFKhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:37:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53762 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbeLFKhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:37:45 -0500
Received: from zn.tnic (p200300EC2BCE8F00DD72F512FF71F350.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:8f00:dd72:f512:ff71:f350])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D99E61EC03D4;
        Thu,  6 Dec 2018 11:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544092664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=u5UUzIH7VB2FoNOGeXijpzRxoUl7CMpM8T+GixeGMdI=;
        b=G0Vhiq4+DpFDKoeEfmha5vusxMQJAiurE+Rfos/Wy/pGkSbT+wy6N5ShzaNfiOeMgxzSNf
        7abb6YFFcAO99+CH1C8BhihPSMod81mlTr6VH9p0w3iWgF1xPSiI/B24cKq/1Grl0t1+07
        bigfsTd218XRwS8VB8SIOcAkJMzmLkU=
Date:   Thu, 6 Dec 2018 11:37:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND] x86/cpu: Avoid endless loop to get the number
 of cache leaves
Message-ID: <20181206103736.GA3986@zn.tnic>
References: <1544081173-25059-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1544081173-25059-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 03:26:13PM +0800, Pu Wen wrote:
> To get the number of cache leaves on AMD or Hygon platform, it should
> get the value of cpuid leaf 0x8000001d. But on certain broken platform
> such as a not fullly implemented virtual platform(for example Xen),
> the value of the cpuid leaf will nerver be CTYPE_NULL, so the kernel
> will run into an endless loop.
> 
> To fix this problem, add a new enum type CTYPE_MAX to limit the maximum
> cpuid accessing.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/cpu/cacheinfo.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Did you not see my reply to this last time?

https://lkml.kernel.org/r/20181115172155.GB25056@zn.tnic

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
