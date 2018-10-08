Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD622C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741B920C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741B920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJIDOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:14:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbeJIDOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:14:47 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9DbXTs4w8x02; Mon,  8 Oct 2018 22:01:21 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2F391EC00EA;
        Mon,  8 Oct 2018 22:01:20 +0200 (CEST)
Date:   Mon, 8 Oct 2018 22:01:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <joro@8bytes.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] x86/mm: Do not warn about PCI BIOS W+X mappings
Message-ID: <20181008200115.GC5919@zn.tnic>
References: <alpine.DEB.2.21.1810082151160.2455@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810082151160.2455@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:53:48PM +0200, Thomas Gleixner wrote:
> PCI BIOS requires the BIOS area 0x0A0000-0x0FFFFFF to be mapped W+X for
> various legacy reasons. When CONFIG_DEBUG_WX is enabled, this triggers the
> WX warning, but this is misleading because the mapping is required and is
> not a result of an accidental oversight.
> 
> Prevent the full warning when PCI BIOS is enabled and the detected WX
> mapping is in the BIOS area. Just emit a pr_warn() which denotes the
> fact. This is partially duplicating the info which the PCI BIOS code emits
> when it maps the area as executable, but that info is not in the context of
> the WX checking output.
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Tested-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
