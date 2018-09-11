Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D33C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7C92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7C92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeIKPGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:06:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35594 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeIKPGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:06:36 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mNPYWYDrjwGm; Tue, 11 Sep 2018 12:07:59 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC6F600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:f600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20AB01EC0858;
        Tue, 11 Sep 2018 12:07:59 +0200 (CEST)
Date:   Tue, 11 Sep 2018 12:07:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
Message-ID: <20180911100757.GD12094@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <035e5d0a4f2a0edf68ca0f1019e47b878eaa5da6.1536550550.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <035e5d0a4f2a0edf68ca0f1019e47b878eaa5da6.1536550550.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 09:17:11PM +0800, Pu Wen wrote:
> As Hygon registered its PCI Vendor ID as a new one 0x1d94, and there
> are PCI Devices 0x1450/0x1463/0x1464 for Host bridge on Hygon Dhyana
> platforms, so add Hygon Dhyana support to the PCI and north bridge
> subsystem by using the code path of AMD family 17h.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/amd_nb.c | 47 +++++++++++++++++++++++++++++++++++++++++------
>  arch/x86/pci/amd_bus.c   |  6 ++++--
>  include/linux/pci_ids.h  |  2 ++
>  3 files changed, 47 insertions(+), 8 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
