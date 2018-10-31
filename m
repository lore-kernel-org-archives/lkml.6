Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65394ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A96420838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwE1FG2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A96420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJaSdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeJaSdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:33:43 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5017720821;
        Wed, 31 Oct 2018 09:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540978582;
        bh=PYler+rAWyH0W0qkyr5hZotNA98+xj4xT61RZhdqpuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwE1FG2L3/0Q9yD6LZXX+uCRmUNhJdYO0Gd+tNuDAxYp+TBrLP2IzYHoS8Q5WMH3F
         PcCNa57kyWga/kQtASAHdLukToEykCBIbv/W3wWelAkcxXOvWH8fsF8ZQJ3+8TJ+R3
         JF1Dl2T+a72ohcTe5Qe1LBuJDOogAgSqmRxe8QC4=
Date:   Wed, 31 Oct 2018 10:36:19 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Ke Wu <mikewu@google.com>
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modsign: use all trusted keys to verify module signature
Message-ID: <20181031093619.24n53lfeink3qsk6@linux-8ccs>
References: <20181022222614.41016-1-mikewu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181022222614.41016-1-mikewu@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.16-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Ke Wu [22/10/18 15:26 -0700]:
>Make mod_verify_sig to use all trusted keys. This allows keys in
>secondary_trusted_keys to be used to verify PKCS#7 signature on a
>kernel module.
>
>Signed-off-by: Ke Wu <mikewu@google.com>

Thanks for the ping, I had missed this patch.

David, could I get an ACK please?

Thanks!

Jessica

>---
> kernel/module_signing.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/module_signing.c b/kernel/module_signing.c
>index f2075ce8e4b3..a8b923ba1a39 100644
>--- a/kernel/module_signing.c
>+++ b/kernel/module_signing.c
>@@ -83,6 +83,6 @@ int mod_verify_sig(const void *mod, struct load_info *info)
> 	}
>
> 	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
>-				      NULL, VERIFYING_MODULE_SIGNATURE,
>+				      (void *)1UL, VERIFYING_MODULE_SIGNATURE,
> 				      NULL, NULL);
> }
>-- 
>2.19.1.568.g152ad8e336-goog
>
