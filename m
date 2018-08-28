Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D1CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018D220894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pKGY+DEW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ooJIEBSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018D220894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeH1Rgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:36:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58936 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeH1Rgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:36:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 19787603D2; Tue, 28 Aug 2018 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535463907;
        bh=MA5Zi+8n3p/RpESKt0ixfW4k5rpvdE/kOrcF77QW4Kg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pKGY+DEWb6KNX/cMbFs8Omj7D1+N9SPATjhLNh1zJAYHiJS9vHRxCMmxV+4MIAAv8
         46YRU+v9dSzj/QWW7fjSXtNFHuc4vSghdwXRpeipuABebkmpRBNSQ+MGqU67R4+nWZ
         RPTAkNPLTowlv2eP4YHW0UVWKLJk3bfbaovU9PNc=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 087E060388;
        Tue, 28 Aug 2018 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535463906;
        bh=MA5Zi+8n3p/RpESKt0ixfW4k5rpvdE/kOrcF77QW4Kg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ooJIEBSuww8mOJJQoVw4j+AQ2KwkaXsSUplrRF4M0jjuyK2N5LmoCnMeTCJMRLlku
         DbCkXtSIIQaKssSslZQgCwh3tVkfu+79kWjddU3OQV+uIZAacx1CkF0vhMwpE6b3zC
         eqxCe4AuI0UgNJX7pQG8WSBYYhnmj3bwdpqZPuvo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 087E060388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: remove unused array firstep_table
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180816125030.4416-1-colin.king@canonical.com>
References: <20180816125030.4416-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180828134507.19787603D2@smtp.codeaurora.org>
Date:   Tue, 28 Aug 2018 13:45:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> Array firstep_table is being assigned but is never used
> hence it is redundant and can be removed.
> 
> Cleans up clang warning:
> warning: 'firstep_table' defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

a2f73a167dc1 ath9k: remove unused array firstep_table

-- 
https://patchwork.kernel.org/patch/10567385/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

