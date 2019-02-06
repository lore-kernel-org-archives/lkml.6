Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC24C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171F8218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XR+jEie+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfBFVWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:22:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52932 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfBFVWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:22:32 -0500
Received: from zn.tnic (p200300EC2BCEF100DD8CA670FB4D187A.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:f100:dd8c:a670:fb4d:187a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 816BA1EC0586;
        Wed,  6 Feb 2019 22:22:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549488150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=C+YkTlw+vDGbmKozFBkEC9gkJ2lauWYajkpGTfJXtPc=;
        b=XR+jEie+q+bVO4mW+6hmr73tnIBCDATW0uYIQLcK7hz1Xe+Rb4iSGV9Jtpm/wGuHdy++Mn
        J8tNd9ZwC0y6cGqXwzjTPlmE5F7C3/RH/f6Plib9CS45RvaqKRM741i0wAmTo2GJHpQFL0
        TCOZEvg+Y5immA+kmO6YqqGApU5ShzQ=
Date:   Wed, 6 Feb 2019 22:22:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>
Subject: Re: linux-next: Tree for Feb 6 (drivers/edac/skx* and i10nm)
Message-ID: <20190206212218.GJ7314@zn.tnic>
References: <20190206170000.286b1f53@canb.auug.org.au>
 <3f095f3e-ace0-aadb-ead1-01908da5c08c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f095f3e-ace0-aadb-ead1-01908da5c08c@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 01:11:23PM -0800, Randy Dunlap wrote:
> CONFIG_EDAC_I10NM=y
> but CONFIG_EDAC_SKX is not set.
> since # CONFIG_ACPI is not set
> 
> Should EDAC_I10NM depend on ACPI also?

This should do it:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?h=for-next&id=d6a9f7336d925364daca00557afa59a68e78b422

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
