Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FC3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C840020862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nn2xEDvz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P01o8Kue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C840020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeICVUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:20:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59312 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbeICVUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:20:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DAABA607F4; Mon,  3 Sep 2018 16:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535993961;
        bh=l9nMAL9KlxARK78hLaqiNN9HI2zQO2stsLE/TU+7SHM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nn2xEDvza5UTM3HnJSKMBM3TYlQGbAkoLZjDY+3LrMhX+vSL/I76d02vS5UDDdfSf
         CzO1a9yqaQlYWEHD7jEWyhlt8+nBZthtQiV8vpceQMqtX3lGpiz2h2NhojsMU3H/mV
         hzjcpOraAhQNq017Q1r8M/BegIkI6zqrB8JI0VkY=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E17BB605BD;
        Mon,  3 Sep 2018 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535993961;
        bh=l9nMAL9KlxARK78hLaqiNN9HI2zQO2stsLE/TU+7SHM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=P01o8KueUVAW+BmXtXna4Nm64ytZTIoh8boMMnmgElzvzF7/n0wnOO4PAFVh9tgxL
         kbkqV+9DhGPVXWA2f9QpImUIE7Al6VNDfQX+Ug9xHOSFb/Yt6RarOFXAmmxolxD/7A
         a+PuTF1CBD1pnB5bRJlvXjgLNcf3BHuglinW7ssw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E17BB605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180612113907.15043-2-niklas.cassel@linaro.org>
References: <20180612113907.15043-2-niklas.cassel@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180903165921.DAABA607F4@smtp.codeaurora.org>
Date:   Mon,  3 Sep 2018 16:59:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas Cassel <niklas.cassel@linaro.org> wrote:

> ATH10K_SNOC builds just fine with COMPILE_TEST, so make that possible.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

f1908735f141 ath10k: allow ATH10K_SNOC with COMPILE_TEST

-- 
https://patchwork.kernel.org/patch/10460103/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

