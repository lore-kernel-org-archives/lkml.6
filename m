Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C46C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D1924791
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D1924791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934356AbeFVTCq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:02:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32956 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934079AbeFVTCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:02:45 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MaBo47Gx4Ad8; Fri, 22 Jun 2018 21:02:43 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FCBE1EC020C;
        Fri, 22 Jun 2018 21:02:43 +0200 (CEST)
Date:   Fri, 22 Jun 2018 21:02:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86/kvm: Handle all MCA banks
Message-ID: <20180622190240.GF1882@zn.tnic>
References: <20180622095101.32587-1-bp@alien8.de>
 <20180622095101.32587-4-bp@alien8.de>
 <20180622181603.GB5549@flask>
 <20180622182419.GE1882@zn.tnic>
 <20180622184748.GB2377@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180622184748.GB2377@flask>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 08:47:48PM +0200, Radim Krčmář wrote:
> The last MSR is the original "MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1".
> 
> "MSR_IA32_MCx_MISC(KVM_MAX_MCE_BANKS) - 1" also covers
> 
>   MSR_IA32_MC32_CTL, MSR_IA32_MC32_STATUS, and MSR_IA32_MC32_ADDR
> 
> but the maximal valid MSR is MSR_IA32_MC31_MISC.

Bah, right you are, MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1 *is* the
last MSR of bank 31, yes.

Pls ignore this patch.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
