Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B9C16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C45B20857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qh3mINms";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GVmMxnZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C45B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbeG3Tdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:33:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbeG3Tdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:33:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B6B8B60B15; Mon, 30 Jul 2018 17:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532973453;
        bh=Fggqfkbm0mF7zsWtHR2BWjhybGWqZ0miUXSjPHK7fzQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Qh3mINmsDlGgtZ8LYxzeC+iCAV9XsNnxmQ0RDM/ldKX1KRdEtnbm1C+ROE58OJy/f
         VrjY7vYHc7/IYx89zD2FFYUq8Lu8yQrfGMFK9DEh7zRiWYDcP0KF9glffJBXzZxCKX
         n1k74qDhti000zRYX3w81yxf7uUBHXo+jRfC8qLg=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 049DA60376;
        Mon, 30 Jul 2018 17:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532973453;
        bh=Fggqfkbm0mF7zsWtHR2BWjhybGWqZ0miUXSjPHK7fzQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=GVmMxnZc4PFOsESeDqE3L1NUawrG0zYN7tPEhXSGYMJw0eFHSm+qE6dKT1tk8T481
         WVRtcS+3JlzyN1aU/9bi1pwvTRPY19gWTfimPSiQ583LGp0o4l23/hG7FeDxrhwamf
         hTRJLE0/E0KXotf33fcLcgbAOgf/tdlB8Svt9k3U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 049DA60376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath6kl: remove redundant variables netlen, orig_buf,
 orig_len, dropped and stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180709131720.6668-1-colin.king@canonical.com>
References: <20180709131720.6668-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180730175733.B6B8B60B15@smtp.codeaurora.org>
Date:   Mon, 30 Jul 2018 17:57:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> Variables netlen, orig_buf, orig_len, dropped and stats are assigned values
> but are never used hence they are redundant and can be removed.
> 
> Cleans up clang warnings:
> warning: variable 'netlen' set but not used [-Wunused-but-set-variable]
> warning: variable 'orig_buf' set but not used [-Wunused-but-set-variable]
> warning: variable 'orig_len' set but not used [-Wunused-but-set-variable]
> warning: variable 'dropped' set but not used [-Wunused-but-set-variable]
> warning: variable 'stats' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

619c9700a8fe ath6kl: remove redundant variables netlen, orig_buf, orig_len, dropped and stats

-- 
https://patchwork.kernel.org/patch/10514565/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

