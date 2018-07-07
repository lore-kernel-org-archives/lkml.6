Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363ADC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43CD2174C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43CD2174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeGGITy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:19:54 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:44435 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbeGGITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:19:52 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 21729100FC0CC;
        Sat,  7 Jul 2018 10:19:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AE73836A1D; Sat,  7 Jul 2018 10:19:50 +0200 (CEST)
Date:   Sat, 7 Jul 2018 10:19:50 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     nathan.d.ciobanu@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        michael.jamet@intel.com, andreas.noever@gmail.com
Subject: Re: [PATCH] thunderbolt: fix small typo in variable name
Message-ID: <20180707081950.GA6660@wunner.de>
References: <1530056060-3612-1-git-send-email-nathan.d.ciobanu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530056060-3612-1-git-send-email-nathan.d.ciobanu@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 04:34:20PM -0700, nathan.d.ciobanu@linux.intel.com wrot> Fixes small variable name typo and the associated
> checkpatch spelling warning
> 
> Signed-off-by: Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>
> ---
>  drivers/thunderbolt/tb_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index 5d94142afda6..693b0353c3fe 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -202,7 +202,7 @@ struct tb_regs_port_header {
>  	/* DWORD 5 */
>  	u32 max_in_hop_id:11;
>  	u32 max_out_hop_id:11;
> -	u32 __unkown4:10;
> +	u32 __unknown4:10;
>  	/* DWORD 6 */
>  	u32 __unknown5;
>  	/* DWORD 7 */

This is not an improvement.  The bitfield is marked unknown because
its meaning hasn't been reverse-engineered yet.  But you work for
Intel, presumably you don't have to reverse-engineer the bitfield's
meaning because you know it or can find out about it.

So please submit a patch that changes the name to the bitfield's
actual meaning.

Thanks,

Lukas
