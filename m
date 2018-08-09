Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D58C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6742221C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZnfgwV+9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vtoktq5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6742221C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbeHIRjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:39:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45984 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbeHIRjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:39:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF64160B23; Thu,  9 Aug 2018 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827643;
        bh=vbdJ0y/kR4dHOcIYET20envyzz+on5XjLwOme136ids=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZnfgwV+98gA/nniGXc3YIiQFkPkSHdqPxD0xwiyvv3mp2QL2rraVfv8WSWSYysZZt
         OgKnxf457tkIWts/mKAAts9reriwp1OZE/kfB7EYvYsSW1ILoK3REZp14C2jhlyE/i
         jauN4/L971zO7RqCLIDjrsevD/cVrultLiPFZU/w=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7E1D60807;
        Thu,  9 Aug 2018 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827643;
        bh=vbdJ0y/kR4dHOcIYET20envyzz+on5XjLwOme136ids=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Vtoktq5hNHAiTGm1VgROe6V0Ay4lFZlCSER0hpLOQVMr2CEcaMpocm9kZK26AeQA7
         YSw8oPjXjpw6iOWoFZzifSVUO6nxVRqTOL7LajFkQjVwsYE+fIVH5pTplj5KkYn8ha
         D+N/tu+xHtpswAFst42IKSBMcWYU43sAP9afRDQY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7E1D60807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rsi: remove redundant variables bss,
 wh and temp_flash_content
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180803074636.20479-1-colin.king@canonical.com>
References: <20180803074636.20479-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180809151403.BF64160B23@smtp.codeaurora.org>
Date:   Thu,  9 Aug 2018 15:14:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables bss, wh and temp_flash_content are being assigned but are
> never used hence they are redundant and can be removed.
> 
> Cleans up clang warnings:
> warning: variable 'bss' set but not used [-Wunused-but-set-variable]
> warning: variable 'wh' set but not used [-Wunused-but-set-variable]
> warning: variable 'temp_flash_content' set but not used
>  [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

35204d0aa83f rsi: remove redundant variables bss, wh and temp_flash_content

-- 
https://patchwork.kernel.org/patch/10554759/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

