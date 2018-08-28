Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF9B20834
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CyhFfz7k";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QWjY/xEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF9B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeH1RfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:35:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeH1RfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:35:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5E6726044E; Tue, 28 Aug 2018 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535463800;
        bh=pVRUYsnuAE5Wxt8x7tdMia8H7NeEF2LLmh4i7JumbsI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CyhFfz7k0hH6ecv9+d3rnF9+y2b0i4MApHbsNnYFE4xR2uK43X1SqtLYtlUDj3tsO
         pE8fEjiJaPdHFizbb3CY6fPPJLmcA6t5jdQKO2tCZJRweGJ1fxT+JwLsFhEf5VzogB
         PLdO/gYY78BiNuH5XBaPB43UyW9idnvJFoTX1q/U=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A23160388;
        Tue, 28 Aug 2018 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535463800;
        bh=pVRUYsnuAE5Wxt8x7tdMia8H7NeEF2LLmh4i7JumbsI=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=QWjY/xEqpfDiwK5Uca+va1NG/di8dZtp8nsXl57wR8uuK1qvGy9TEns/KfDWYKEiN
         rAoa3PRy3ouCyEmnPRt6rKWP+pvfRFDVReJ2ZpOLzf4G4OMJta2ZslOWKndz7OkOjO
         PdZgm49O7oockOLEkZqeBC/UKxqmBmpSJbntWg9E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A23160388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: use struct_size() in kzalloc()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180824011247.GA25648@embeddedor.com>
References: <20180824011247.GA25648@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180828134320.5E6726044E@smtp.codeaurora.org>
Date:   Tue, 28 Aug 2018 13:43:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
> 	int stuff;
>         void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

06ae8dc00433 ath10k: use struct_size() in kzalloc()

-- 
https://patchwork.kernel.org/patch/10574741/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

