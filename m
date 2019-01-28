Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4142C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A431F2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="O0FCgJQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfA1Rvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:51:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39194 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfA1Rvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:51:40 -0500
Received: from zn.tnic (p200300EC2BC5DE008821062B415D2F41.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:de00:8821:62b:415d:2f41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E28681EC0229;
        Mon, 28 Jan 2019 18:51:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548697899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c1l5yM0oYZo9rHL0q1tmYnNvCtj0Dh2bnbi2GR+39b4=;
        b=O0FCgJQ63WC6LCvhcs3pbfoKZeea744cwK9kOh5417tKxwRxMkKUaVeoypqnxTrkphKYtj
        ygXWR4Twnd+ccWx/A4C3VTCkh9tENSKYNSwCy/bZJi0oJVnw0L744EcK+vcQxbJNAR/nu4
        QtwCqte024MRdU9EhXa10qhafSBTXyk=
Date:   Mon, 28 Jan 2019 18:51:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com, kasong@redhat.com
Subject: Re: [PATCH v16 0/7] Parse ACPI table and limit KASLR to choosing
 immovable memory
Message-ID: <20190128175132.GE20487@zn.tnic>
References: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 07:08:43PM +0800, Chao Fan wrote:
> PATCH 1/7 Copy kstrtoull() to boot/string.c to instead of using
>           old simple_strtoull()
> PATCH 2/7 Introduce get_acpi_rsdp() to parse RSDP in cmdline from KEXEC
> PATCH 3/6 Introduce efi_get_rsdp_addr() to find RSDP from EFI table when
>           booting from EFI.
> PATCH 4/7 Introduce bios_get_rsdp_addr() to search RSDP in memory when
>           booting from BIOS
> PATCH 5/7 Parse RSDP and fill in boot_params->acpi_rsdp_addr before
>           KASLR.
> PATCH 6/7 Compute SRAT from RSDP and walk SRAT to store the immovable
>           memory regions and store the immovable memory regions.
> PATCH 7/7 Calculate the intersection between memory regions from e820/efi
>           memory table and immovable memory regions. Limit KASLR to
>           choosing these regions for randomization.

Ok, I've massaged the whole pile and fixed a couple of things that
sprang at me, see each commit message for details.

Please run it and check whether I haven't broken anything:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-boot

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
