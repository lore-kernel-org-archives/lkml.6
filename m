Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2AFC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39B5244CF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMyAXGLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39B5244CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933789AbeFVP2k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933304AbeFVP2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:28:39 -0400
Received: from linux-5o07 (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06FB3224DA;
        Fri, 22 Jun 2018 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529681318;
        bh=K5nD2qhsgwU1tzks4n5dduMSAQ8qIHdBfrAKxkUsQzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMyAXGLZdPZ7ydhipjPQijjFFkvDkxuIHqbT1sX8rmnWmixHs4vHdAU3yany11hil
         v+Lid/AuHjNkxSpyI8RFHdLRmNFIL0D936x6rz0noG7j3YSFnoHndC4Y8tDt+zflXM
         pWgoHc2cERKJlNUgIW2K1x9nhzQlcc9Lt6xaDmZc=
Date:   Fri, 22 Jun 2018 17:28:36 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] modsign: print module name along with error message
Message-ID: <20180622152836.yxkbhlzpgzlbhgip@linux-5o07>
References: <20180530090830.20737-1-jeyu@kernel.org>
 <20180530090830.20737-4-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180530090830.20737-4-jeyu@kernel.org>
X-OS:   Linux linux-5o07 4.18.0-rc1-lp150.11-default+ x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jessica Yu [30/05/18 11:08 +0200]:
>It is useful to know which module failed signature verification, so
>print the module name along with the error message.
>
>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>---
> kernel/module.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index ae824a6f1a03..8670585eb5f7 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2807,7 +2807,7 @@ static int module_sig_check(struct load_info *info, int flags,
> 		reason = "Loading of module with unavailable key";
> 	decide:
> 		if (sig_enforce) {
>-			pr_notice("%s is rejected\n", reason);
>+			pr_notice("%s: %s is rejected\n", info->name, reason);
> 			return -EKEYREJECTED;
> 		}
>

Hi David!

I've just merged patches 1 and 2 into modules-next. Would you be
interested this patch (patch 3) if/when you push lockdown upstream
again?

Thanks!

Jessica
