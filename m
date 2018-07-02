Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3854DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E748525E5B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g3xXwPsL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XSInLh1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E748525E5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeGBOXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:23:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbeGBOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:23:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E93FC6037C; Mon,  2 Jul 2018 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530541399;
        bh=eExqIY1/5k6YlwJ5MxyK/eZqF0OzJVlyTiTpHEgI1gw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=g3xXwPsLeZU7Y33Lo5mdLJBaZHo0EHQOhAfx50W/2CvDNEzgtR+bVFp5qKxxqAtsV
         XtibHMeViSWDYB6nbLzZXEfumClK43CJH/UvJdDEPli97rkBRl3DbLx5jOHYG5sQtu
         tAXeKcL66tNvH2/ZHov4uO/891ubRJM3t3E1O+PY=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF9526037C;
        Mon,  2 Jul 2018 14:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530541398;
        bh=eExqIY1/5k6YlwJ5MxyK/eZqF0OzJVlyTiTpHEgI1gw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=XSInLh1pkTSKnXmqXXAPsctwnrb5pTxLMLYBmxKXkVzH8+VLaP3yEo03AyPeUHPQb
         Xp2g+DXoJ8kAwV5jZlSU2fW9SYJ4FTubiU3MCTzylyX3lEEQ4r/tlk/x2NfX9EZhad
         CQMGN1Z3w69NAfVrCzIpJ24cZmLYHavkMWgyfQ8Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF9526037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/3] ath10k: sdio: use same endpoint id for all packets in a
 bundle
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180620084222.3521-2-niklas.cassel@linaro.org>
References: <20180620084222.3521-2-niklas.cassel@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        alagusankar@silex-india.com,
        Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180702142319.E93FC6037C@smtp.codeaurora.org>
Date:   Mon,  2 Jul 2018 14:23:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas Cassel <niklas.cassel@linaro.org> wrote:

> All packets in a bundle should use the same endpoint id as the
> first lookahead.
> 
> This matches how things are done is ath6kl, however,
> this patch can theoretically handle several bundles
> in ath10k_sdio_mbox_rx_process_packets().
> 
> Without this patch we get lots of errors about invalid endpoint id:
> 
> ath10k_sdio mmc2:0001:1: invalid endpoint in look-ahead: 224
> ath10k_sdio mmc2:0001:1: failed to get pending recv messages: -12
> ath10k_sdio mmc2:0001:1: failed to process pending SDIO interrupts: -12
> 
> Co-Developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

679e1f07c862 ath10k: sdio: use same endpoint id for all packets in a bundle
d1d061b1395a ath10k: sdio: allocate correct size for RECV_1MORE_BLOCK rx packets
8530b4e7b22b ath10k: sdio: set skb len for all rx packets

-- 
https://patchwork.kernel.org/patch/10476637/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

