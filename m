Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8D426C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40538208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f3mU8ARY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R46kswUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40538208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964970AbeFNPQt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:16:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49674 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755158AbeFNPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:16:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 26CB36022C; Thu, 14 Jun 2018 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989407;
        bh=os/qBnD4tlo3RYFj0UOSzTAwvPbJZtrzIRumPWIhzHI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=f3mU8ARYvgu0SCR4gQcDH+/6uC+LdHjQd6TGLpSnw2cAo0M9/0lBpBQs+XsUsE/qN
         +lpuQ0/TaO6x5+bKfreP/KnDDZp+BN60PkwA0sfLj8Znf/WgcnylsqI+HN/K28UL02
         PXYzGywaubf2T3DGgXsuprI+UAQPWj8OhtBdDQv0=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E35576022C;
        Thu, 14 Jun 2018 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989406;
        bh=os/qBnD4tlo3RYFj0UOSzTAwvPbJZtrzIRumPWIhzHI=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=R46kswUDMawINXBI7+5mItxV8ezXANqwR6c4dSo/TMdge3sCnB5JOSbNXnVvYFeFe
         SFbG2Hi2tdglUIvauajwlfWIpcrcAorxbSpttAZN74chJuTEtVQCN3Xl0VTD98VCTL
         mF0PCHUAoGxdncYsxW9oI/d89dBwVSxCdKJajXIM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E35576022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/4] ath10k: snoc: use correct bus-specific pointer in RX retry
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180611210946.241341-1-briannorris@chromium.org>
References: <20180611210946.241341-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180614151647.26CB36022C@smtp.codeaurora.org>
Date:   Thu, 14 Jun 2018 15:16:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> We're 'ath10k_snoc', not 'ath10k_pci'. This probably means we're
> accessing junk data in ath10k_snoc_rx_replenish_retry(), unless
> 'ath10k_snoc' and 'ath10k_pci' happen to have very similar struct
> layouts.
> 
> Noticed by inspection.
> 
> Fixes: d915105231ca ("ath10k: add hif rx methods for wcn3990")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

4 patches applied to ath-next branch of ath.git, thanks.

426a0f0b5a2f ath10k: snoc: use correct bus-specific pointer in RX retry
8ac5fe8e3d11 ath10k: snoc: stop including pci.h
13e6cc0bd4ef ath10k: snoc: drop unused WCN3990_CE_ATTR_FLAGS
c9f3e7fa8bcb ath10k: snoc: sort include files

-- 
https://patchwork.kernel.org/patch/10458863/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

