Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93127C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2AF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="grM8VzcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfANJIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:08:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41198 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfANJIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:08:04 -0500
Received: from zn.tnic (p200300EC2BC4CA00116FEC2D9C4463FB.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:116f:ec2d:9c44:63fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67AD51EC058B;
        Mon, 14 Jan 2019 10:08:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547456882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=F3O9IqkNzwz/8Etq42lTyFj7inkLRyVqs29On1dc020=;
        b=grM8VzcDZx8VtVXsoLC5uDLMd267OC7Gn3SBVPV4I3m45NfbxRc8mxCZnym6ISyFE+Tpsz
        ffZjobKB8rHNd0RjcASLkJCY83PKGIBkeQ1HeRcL+UyXWAEizfPh0lYWd/OZzb6iMn0+7h
        2p+uzmi4G24UKTop15rMqfb4rPB6/Qw=
Date:   Mon, 14 Jan 2019 10:07:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20190114090756.GA2773@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-4-fanc.fnst@cn.fujitsu.com>
 <20190110211523.GG17621@zn.tnic>
 <20190111012353.GD2216@localhost.localdomain>
 <20190111103225.GA4729@zn.tnic>
 <20190113094704.GC13263@localhost.localdomain>
 <20190113110544.GA7398@zn.tnic>
 <20190114012641.GA30900@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190114012641.GA30900@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 09:26:42AM +0800, Chao Fan wrote:
> According to the code, I saw:
> #ifdef ACPI_ASL_COMPILER
> #define ACPI_32BIT_PHYSICAL_ADDRESS
> #endif
> 
> and then
> #ifdef ACPI_32BIT_PHYSICAL_ADDRESS
> typedef u32 acpi_physical_address;
> 
> As for ACPI_ASL_COMPILER, I saw iASL in documention, but can't find more
> information in the code. If I miss something, please let me know.

And, as a result, can acpi_physical_address ever be u32 in a kernel
build?

git annotate is also very helpful when doing git archeology like, for
example, finding the patch which added the ifdeffery and looking at its
commit message for more hints.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
