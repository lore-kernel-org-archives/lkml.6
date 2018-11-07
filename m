Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99107C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6465B20818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6465B20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeKHEzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:55:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51644 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeKHEzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:55:32 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v_UkOSw5-qj7; Wed,  7 Nov 2018 20:23:47 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 807B01EC01A8;
        Wed,  7 Nov 2018 20:23:47 +0100 (CET)
Date:   Wed, 7 Nov 2018 20:23:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-edac@vger.kernel.org, ravi@jetztechnologies.com,
        arvino55@gmail.com, mchehab@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] edac: i82975x: remove set but not used variable
 'dtype'
Message-ID: <20181107192340.GE14169@zn.tnic>
References: <20181107022237.14048-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181107022237.14048-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 10:22:37AM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/edac/i82975x_edac.c:378:16: warning:
>  variable 'dtype' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in commit
> 084a4fccef39 ("edac: move dimm properties to struct dimm_info")
> 
> Also remove function i82975x_dram_type and move the comment and the
> assignment to the single called place.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: remove unnecessary function i82975x_dram_type
> ---
>  drivers/edac/i82975x_edac.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
