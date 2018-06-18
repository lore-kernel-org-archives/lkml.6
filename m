Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0FCC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8609F208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oT7sUNmy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C7zn+ohZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8609F208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967886AbeFRIzk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:55:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54660 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967755AbeFRIzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:55:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A8F160B13; Mon, 18 Jun 2018 08:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529312135;
        bh=UM91ZcWhOytsdAMYSOLN4FTPbMxmPt7Xtm72oH1GhGk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oT7sUNmyodyGYwJUPtHXtaTqS7C1fKuBQDsRtRSKC3obw8dB15TCbEcCkhlk20P68
         LSL5gGMrvlbHvQxji8EO0z7ks1aC9ly4vKcwxjHgARJTj/lYftnbzFXOdA6hAmcZUO
         2HhpIdK5GdTu8pV06wMzek/4O1rE9+ETH78PWfS8=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EFED360227;
        Mon, 18 Jun 2018 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529312135;
        bh=UM91ZcWhOytsdAMYSOLN4FTPbMxmPt7Xtm72oH1GhGk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=C7zn+ohZbBfXK9klne7XUMAp9E89ZCOGMMOtvB9rUU8zCED4ngrktZlyrAqJHk+SU
         4cm2Xx7rCkkF3diDgwuI2TeQnlDGjdzqGUufWKG/b4Bf5ZuriBdxG4eYwUZei6TQi7
         oXcZyFCV0VENqoDHIZFBmgEHXN+hzMl8JQ/RXRFs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFED360227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: qtnfmac: fix NULL pointer dereference
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180601132408.GA2572@embeddedor.com>
References: <20180601132408.GA2572@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180618085535.6A8F160B13@smtp.codeaurora.org>
Date:   Mon, 18 Jun 2018 08:55:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In case *vif* is NULL at 655: if (!vif), the execution path jumps to
> label out, where *vif* is dereferenced at 679:
> 
> if (vif->sta_state == QTNF_STA_CONNECTING)
> 
> Fix this by immediately returning when *vif* is NULL instead of
> jumping to label out.
> 
> Addresses-Coverity-ID: 1469567 ("Dereference after null check")
> Fixes: 480daa9cb62c ("qtnfmac: fix invalid STA state on EAPOL failure")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quanenna.com>

Patch applied to wireless-drivers.git, thanks.

c1e3f64f8738 qtnfmac: fix NULL pointer dereference

-- 
https://patchwork.kernel.org/patch/10443507/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

