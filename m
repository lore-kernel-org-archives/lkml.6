Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3975CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14D8208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ADVs+PTV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yp4RlQl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14D8208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936127AbeFNPOR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:14:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754927AbeFNPOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:14:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A33036022C; Thu, 14 Jun 2018 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989255;
        bh=PHSwtrzkFVwhZ97BmkiX5N6FEvwtWUn+DYbigywjVgo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ADVs+PTVC/xloDtqLt4yTWgk2d9xvPpn39BrHlLEjyciMboKbh/FONtXyikqZzNbR
         Fl/wxQOgmbut7cOupHKWcVaV64Vk+HALzO+Fm4PFB/8WuCocR+GSVw2zA5RYKOF/T/
         9nUHa5h+NlecffZ7oXE3cgFn1sUCK3k6lZDeBACg=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A31426022C;
        Thu, 14 Jun 2018 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989255;
        bh=PHSwtrzkFVwhZ97BmkiX5N6FEvwtWUn+DYbigywjVgo=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Yp4RlQl3LOnA43ujWoX0hgym42SBQTNfDZhTM7RoR1fyMb4snQXfs6lrfNZe0G0u1
         2EgsFIEFI+bb6mYjF3vMVAa/fxu7Oez7l/o0L2JI5Pos7pz+KJWyNBmByv2v+/MVFd
         wMpdnYtSAUWO2HM0ofdxFHfak/SPA6jFmkLJZp8s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A31426022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath10k: snoc: use module_platform_driver() macro
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180611193540.190255-1-briannorris@chromium.org>
References: <20180611193540.190255-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180614151415.A33036022C@smtp.codeaurora.org>
Date:   Thu, 14 Jun 2018 15:14:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> ath10k_snoc_init()/ath10k_snoc_exit() don't add much value;
> module_platform_driver() can remove the boilerplate.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

0644fef97451 ath10k: snoc: use module_platform_driver() macro

-- 
https://patchwork.kernel.org/patch/10458705/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

