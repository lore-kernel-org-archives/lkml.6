Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F85C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5557208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o4rmYinN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eOEAVl1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5557208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbeGaI7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:59:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57452 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeGaI7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:59:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1243B607BD; Tue, 31 Jul 2018 07:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021629;
        bh=YEFXMKmZXJ1OFyrpsSq6kLZ75QiWoZoEYNtebWHpi54=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=o4rmYinN3wq+hDY9UOH6AwTeIPEnktT6Muhov5TOd0+4oX5HPFj68V8Gky0qu+bDi
         NzUVkdEhn4zZBzUtFOtM+iOX7arNvkItCukdZyC9GsojIauzA3ZXdB2x/VpEh80/+m
         jKB/4RlQx7+qPDS8QkSIHjrxvwFRAnw5liDgg8zg=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65D73606DD;
        Tue, 31 Jul 2018 07:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021628;
        bh=YEFXMKmZXJ1OFyrpsSq6kLZ75QiWoZoEYNtebWHpi54=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=eOEAVl1AZLXDewBu0Pp7CebzQVGxrUyP9Zc5unDu+zBXla8JoBrU00pRuL0VBCrh4
         5y86+0i0MlsCFikyEtc+WSPp65quY9DuGUFB70deaUL6Z/bP2MumN4UtbHbX3dKs7+
         gLoIDKZRqMCgdlgB0KJ4L+BZJ2X/xQhp2fuf9rgg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65D73606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ray_cs: remove redundant pointer 'p'
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180720180740.21018-1-colin.king@canonical.com>
References: <20180720180740.21018-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180731072029.1243B607BD@smtp.codeaurora.org>
Date:   Tue, 31 Jul 2018 07:20:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'p' is being assigned but is never used hence it is
> redundant and can be removed. Also re-work if statement to remove
> redundant assignment of p.
> 
> Cleans up clang warning:
> warning: variable 'p' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

f21bcefcf91c ray_cs: remove redundant pointer 'p'

-- 
https://patchwork.kernel.org/patch/10538143/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

