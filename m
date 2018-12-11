Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3275EC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93102084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Bic+ikT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93102084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeLKXnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:43:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57764 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeLKXnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:43:12 -0500
Received: from zn.tnic (p200300EC2BCD2B002DC08A63FFF8C6E5.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:2dc0:8a63:fff8:c6e5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 622A71EC0BC5;
        Wed, 12 Dec 2018 00:43:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544571791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PR/Md25RLnTT4bLkhhiILFw8rmOunN7xkq8ufk5OuZM=;
        b=Bic+ikT9LehJuiNBYYIYajywoa0TnJBLDoHBakkXsfN/WdTMNvqTpJZjGJaKTPiMSelmaG
        jAsawqKIKqVW61/LYNmcVE99fG1BmFALTZVmR8c55UMlAoibAStphYZGmXSNj+CvPTK55h
        ArxTbslHrXHeBsYmYe9PsXv2I8yNr0Y=
Date:   Wed, 12 Dec 2018 00:43:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     luto@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        thomas.lendacky@amd.com, hpa@zytor.com, john.stultz@linaro.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Message-ID: <20181211234308.GW27375@zn.tnic>
References: <20181211233753.GA26593@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211233753.GA26593@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 02:37:53AM +0300, Alexey Dobriyan wrote:
> I have a question: does alternatives ordering matter?

Yes.

> CPU can have both features.

The last present feature wins.

> And other code in this file uses "c" for clobber.

Ok.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
