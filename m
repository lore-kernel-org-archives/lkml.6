Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192B4C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE7125CAC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HeGPDMDi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LGZaB3zZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE7125CAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965666AbeF0QGb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:06:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48984 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934909AbeF0QG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:06:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1ECF660AFF; Wed, 27 Jun 2018 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115588;
        bh=ge4KRERqOO7fd9DTjcUBuC4vfrkmDWSmQzAwKd9cYsw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HeGPDMDijBXMrxnc5bG1Ee1aM2r12g/Vm0aSSH95nZqTvJSKFOzn66glXw6uJlhQv
         ctNWngDnslTfjfs09LowT5CaG1wiF2yuT91oHTK/YA9cnzoSdlMi6ap9bU06fqq97i
         xuz6swLpr8PeHIiNHFQdphkHuHlBQAKCJngAlxoI=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B941601EA;
        Wed, 27 Jun 2018 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115586;
        bh=ge4KRERqOO7fd9DTjcUBuC4vfrkmDWSmQzAwKd9cYsw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=LGZaB3zZ345y1vZkVywCFDVNGTlKEJp5Ozy3i8mVjl0ifEoFIYKGcs5td8lo08ExV
         y1zMWlHhb3MI0VwuDVhnOTmAMTpvnU05/+3mseBvY638qkRSt5mKrzU89WAgViJ+kg
         JuLVV82CIMAKXVmwFjtQM6YRkT1K0K1Q+6kybkvQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B941601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: atmel: use memdup_user to simplify the code
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180604103210.23984-1-yuehaibing@huawei.com>
References: <20180604103210.23984-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180627160628.1ECF660AFF@smtp.codeaurora.org>
Date:   Wed, 27 Jun 2018 16:06:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> use existing memdup_user() helper function instead of open-coding
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

8668f9a57c8c atmel: use memdup_user to simplify the code

-- 
https://patchwork.kernel.org/patch/10446299/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

