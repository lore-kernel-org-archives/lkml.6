Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3664AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D3D208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZYm8eVOi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PCJP06Qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D3D208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935435AbeFMLlC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:41:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935188AbeFMLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:41:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2365F6074D; Wed, 13 Jun 2018 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528890060;
        bh=yT4E/GcoDT6iS2GF3X7+VAG9j/njEfQyBDS6gP7X//4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZYm8eVOi7m2j8pe89yIfK03PwMqdDgW8/LW/eXuJIagMiiwvoA/yOTH+GYtagNsoK
         Of5G8OqtHo+rQfhutlvj7AhdEqE1cGlyn/YmzJ9zm2xEiiQTCeQJwpXQgKkwyI8pf5
         u4PsPyz/QLuXI5RmH0C4BlJYL9Q5rljm90qdy/eo=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E67D7602FC;
        Wed, 13 Jun 2018 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528890059;
        bh=yT4E/GcoDT6iS2GF3X7+VAG9j/njEfQyBDS6gP7X//4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=PCJP06QnxRKhGWYVzrrVuzD1ij6aK75ApjopklOJFc6RNsz+at64di1a9hcKzK+kZ
         +b/3iIb7wEwqAdeOqmEoyRQi4LpS46NY83A492FU/7QdToctzOLgS1tENi10aC1DLI
         zK5Yi72PSsaT7F4MbbWofji38q66coNiNXqtBtxQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E67D7602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath10k: htt_tx: mark expected switch fall-throughs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180524225928.GA19570@embeddedor.com>
References: <20180524225928.GA19570@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180613114100.2365F6074D@smtp.codeaurora.org>
Date:   Wed, 13 Jun 2018 11:41:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case, I replaced "pass through" with
> a proper "fall through" comment, which is what GCC is expecting
> to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

f1d270ae10ff ath10k: htt_tx: mark expected switch fall-throughs

-- 
https://patchwork.kernel.org/patch/10425691/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

