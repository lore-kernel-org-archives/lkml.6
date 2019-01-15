Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBE7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6BC20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Mtq+BBFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfAOJzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:55:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35974 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfAOJzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:55:06 -0500
Received: from zn.tnic (p200300EC2BCBB4000C4BA7EB962C71EB.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b400:c4b:a7eb:962c:71eb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B9451EC04F3;
        Tue, 15 Jan 2019 10:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547546105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zI8XPpI6AzBn+4YYVmFePdFYozbGqhBgYzGL4P+fAn4=;
        b=Mtq+BBFYl5jAVM1WctvgOuzZcnS01gPCS17jvcXwhEcCrAeDcr1gDWRxb0ufVoKLJiaPm0
        KKP3YKiSXjzPkFkZQiSrseNcsrFbrsjD1KGswKhVEycjV84BYzvnsFfY2rQZKVcVy4xLh3
        ZIAXmu3kPqMN8gceWuXEIiVYORblIVI=
Date:   Tue, 15 Jan 2019 10:55:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     lv.zheng@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20190115095502.GA6596@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-4-fanc.fnst@cn.fujitsu.com>
 <20190110211523.GG17621@zn.tnic>
 <20190111012353.GD2216@localhost.localdomain>
 <20190111103225.GA4729@zn.tnic>
 <20190113094704.GC13263@localhost.localdomain>
 <20190113110544.GA7398@zn.tnic>
 <20190114012641.GA30900@localhost.localdomain>
 <20190114090756.GA2773@zn.tnic>
 <20190115072121.GB30900@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115072121.GB30900@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 03:21:21PM +0800, Chao Fan wrote:
> In my understanding after looking into the commit message the comments.
> I thinks yes. For 32-bit OS:

And when does your "32-bit OS" define ACPI_ASL_COMPILER ?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
