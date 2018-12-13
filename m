Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A3EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A6220879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lLxC01Nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A6220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeLMTaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:30:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55490 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbeLMT37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:29:59 -0500
Received: from zn.tnic (p200300EC2BCC6800892794B346FCED17.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:6800:8927:94b3:46fc:ed17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BEE71EC0C0E;
        Thu, 13 Dec 2018 20:29:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544729398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BJ2lmRb8JY9jtIsd5MV38FwCZep2cTPZda5vtV+lQJg=;
        b=lLxC01NqQSW/3yKy4g/lXk3DEYeYpVWte0MPZxPcKCm598LW8DWemuTTDlb5MBGJW8gr8J
        IWK4KpipJVik7DPrROe1xSQQC740gfcueie4IdDrk8T77RtltsKydhI+a/TuB/jtpryVoi
        MFkRsRLn3dEFiBbElT3fuZxRfTNvmSw=
Date:   Thu, 13 Dec 2018 20:29:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, keescook@chromium.org, bhe@redhat.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 2/6] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20181213192950.GE25287@zn.tnic>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-3-fanc.fnst@cn.fujitsu.com>
 <20181213192529.yjklliaxy4tk4kck@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213192529.yjklliaxy4tk4kck@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 02:25:30PM -0500, Masayoshi Mizuma wrote:
> > +	len = cmdline_find_option("acpi_rsdp", val, MAX_ADDRESS_LENGTH+1);
> 
> sizeof() is better here.
> 
> 	len = cmdline_find_option("acpi_rsdp", val, sizeof(var));

Why is it better?

That makes you go look for the "val" variable and see what it's size is.
MAX_ADDRESS_LENGTH+1 is OTOH explicit.

> 
> > +	if (len > 0) {
> > +		val[len] = 0;
> 
> '\0' should be fine here not 0.
> 
> 		val[len] = '\0';

Yes.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
