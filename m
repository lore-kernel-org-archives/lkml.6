Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B23C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 16:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FD920883
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 16:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FD920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbeIVWbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 18:31:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39026 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbeIVWbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 18:31:47 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AGkXn2oK-8b4; Sat, 22 Sep 2018 18:37:36 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD84600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd8:4600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A40B1EC0104;
        Sat, 22 Sep 2018 18:37:36 +0200 (CEST)
Date:   Sat, 22 Sep 2018 18:37:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fan Wu <wufan@codeaurora.org>
Cc:     mchehab@kernel.org, james.morse@arm.com, baicar.tyler@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, john.garry@huawei.com,
        toshi.kani@hpe.com, tanxiaofei@huawei.com, wanghuiqiang@huawei.com,
        shiju.jose@huawei.com
Subject: Re: [PATCH v5] EDAC, ghes: use CPER module handles to locate DIMMs
Message-ID: <20180922163744.GC26797@zn.tnic>
References: <1537322340-1860-1-git-send-email-wufan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1537322340-1860-1-git-send-email-wufan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 01:59:00AM +0000, Fan Wu wrote:
> For platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records, this patch uses the module
> handles to locate corresponding DIMMs and enables per-DIMM
> error counter update.
> 
> Signed-off-by: Fan Wu <wufan@codeaurora.org>
> Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> Tested-by: Toshi Kani <toshi.kani@hpe.com>
> ---
> 
> Changes from v4:
> Changes from v3:
> * Updated Reviewed-by list
> 
> Changes from v2:
> * Fixed coding style glitch
> * Added Tested-by/Reviewed-by
> 
> Changes from v1:
> *  Changed the new function name to get_dimm_smbios_index
> *  Removed unnecessary checks inside get_dimm_smbios_index
> *  Reverted the change of the DMI handle print
> *  Updated commit message
> 
> ---
>  drivers/edac/ghes_edac.c | 23 +++++++++++++++++++++++
>  include/linux/edac.h     |  2 ++
>  2 files changed, 25 insertions(+)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
