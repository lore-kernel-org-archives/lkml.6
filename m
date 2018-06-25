Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D01EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C467A25650
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu7sCYzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C467A25650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbeFYJDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752576AbeFYJDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:03:01 -0400
Received: from linux-5o07 (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86C8225650;
        Mon, 25 Jun 2018 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529917381;
        bh=HDsFfQwzFb4IOOaSKa46Mp0Oy3yOFIM8YObEl2pkTIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gu7sCYzgcwyeeWzpy1PNPpDBdreR4V04nlUCJHd9huEFsbduIGq4H9AYYM8JiCTY2
         fN/u1hzoA3XI+vdtiTddpb1Wc6+9MDapwWcjH5GCmc4NWlNkKJkKWaczxIHDcGaWmx
         P13wftA2Us8PEBGFIsZSesp3uppmqVVXKNn7R2t8=
Date:   Mon, 25 Jun 2018 11:02:58 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print sensible error code
Message-ID: <20180625090258.mkai3zmgt6bkafgx@linux-5o07>
References: <20180622153850.24240-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180622153850.24240-1-Jason@zx2c4.com>
X-OS:   Linux linux-5o07 4.18.0-rc1-lp150.11-default+ x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jason A. Donenfeld [22/06/18 17:38 +0200]:
>Printing "err 0" to the user in the warning message is not particularly
>useful, especially when this gets transformed into a -ENOENT for the
>remainder of the call chain.
>
>Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Applied, thanks.

Jessica

>---
> kernel/module.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index f475f30eed8c..c666ab4139f4 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2282,9 +2282,9 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
> 			if (!ksym && ELF_ST_BIND(sym[i].st_info) == STB_WEAK)
> 				break;
>
>-			pr_warn("%s: Unknown symbol %s (err %li)\n",
>-				mod->name, name, PTR_ERR(ksym));
> 			ret = PTR_ERR(ksym) ?: -ENOENT;
>+			pr_warn("%s: Unknown symbol %s (err %d)\n",
>+				mod->name, name, ret);
> 			break;
>
> 		default:
>-- 
>2.17.1
>
