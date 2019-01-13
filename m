Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB6CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2AD20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RXPdm33/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfAMLFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 06:05:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfAMLFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 06:05:52 -0500
Received: from zn.tnic (p200300EC2BE0800095916A4033B04A37.dip0.t-ipconnect.de [IPv6:2003:ec:2be0:8000:9591:6a40:33b0:4a37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 346201EC0432;
        Sun, 13 Jan 2019 12:05:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547377551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tql07rLHgnOWyn82gmEMn6j7EF9cKvRN3YgsvX0EJA0=;
        b=RXPdm33/N6o64PJg5ebadwwGaW1wgc0BB4OetwSvW6TKpmbAz80j+b6/e3f0Mq5v5haAHu
        FPuIKZ4/e12/kuFuMJyxEc4UDVjD9ZoOw6yqYInFH4sTqNba/fa6wvZ5wamHVvTMSoMMO0
        d9yQpyR8hc7GDmmfk2WANxXEOneGES0=
Date:   Sun, 13 Jan 2019 12:05:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20190113110544.GA7398@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-4-fanc.fnst@cn.fujitsu.com>
 <20190110211523.GG17621@zn.tnic>
 <20190111012353.GD2216@localhost.localdomain>
 <20190111103225.GA4729@zn.tnic>
 <20190113094704.GC13263@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190113094704.GC13263@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 05:47:04PM +0800, Chao Fan wrote:
> 'acpi_physical_address' could be define as u64 or u32.

And when can acpi_physical_address be a u32?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
