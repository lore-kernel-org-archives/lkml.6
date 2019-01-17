Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2727DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FC220855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DS8T72Gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfAQWKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:10:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40720 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfAQWKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:10:06 -0500
Received: from zn.tnic (p200300EC2BCAA9006DBFC74B7D67B54A.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:a900:6dbf:c74b:7d67:b54a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 530DF1EC078A;
        Thu, 17 Jan 2019 23:10:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547763005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CA0DXIypCIUAVNnUWSQbljm9P+xBFAZoJYYDL7F0pKA=;
        b=DS8T72GfZ5i/Ihx4Z5RT+74Fcp+GY7M5Zwv3SEgRKnZpWR9mccuV+S5UHxHlF51TlBLJSq
        tLOXxP7TYpdY65D0/+J9xmjD0dGb6bjTgYqF4GlEn5FdibjkARZz+xF/l4qaP9VwokEgIJ
        qNvfqU21tghWiEOoql1Xp7A8HYBzvj0=
Date:   Thu, 17 Jan 2019 23:09:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
Message-ID: <20190117220959.GG5023@zn.tnic>
References: <20190117161722.3945-1-okaya@kernel.org>
 <20190117163722.GE5023@zn.tnic>
 <c0fa174a-2e7b-2ef2-4913-167934c68c06@kernel.org>
 <20190117215631.GF5023@zn.tnic>
 <CAJZ5v0hHFASeJb8z8QwQkh-tCs409pnaywtWcqLP5K5ZDGhTsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hHFASeJb8z8QwQkh-tCs409pnaywtWcqLP5K5ZDGhTsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:05:43PM +0100, Rafael J. Wysocki wrote:
> I have patches for intel_ips and intel_pmc_ipc queued up (will be
> pushed for -rc3), plus some others.

Yeah, I saw the patchset and applied some of them locally so that I be
able to do randconfig builds. Do you have a branch somewhere which I can
merge locally for testing?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
