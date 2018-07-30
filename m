Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6021625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B33208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BE30hwE+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EV7Mgx7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B33208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbeG3Tcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:32:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37116 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbeG3Tcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:32:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF40362012; Mon, 30 Jul 2018 17:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532973399;
        bh=fBGpgmCdD96U64bM+uWTCecKcHKUuRYLZcKpfkQ2TYc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BE30hwE+AQKuBEds3dCgz5WOK0XYIS2ntOJDlL8n/L6y4Ssq1aUdSt5G6wszmTvFc
         nyJRJZUZZlIVk5lM6urTiIz84OCNOtELvzaBAaUGCEYE66q2+686fIf1oVkdhu6XfO
         ncB3urQIjpDV/QAcbEh03zPZ7jlLOUXw0jCyhWd0=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3767E62012;
        Mon, 30 Jul 2018 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532973399;
        bh=fBGpgmCdD96U64bM+uWTCecKcHKUuRYLZcKpfkQ2TYc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=EV7Mgx7wXx+4i8Eq5wTAL/Dhn1suX+0qN1ZVrlMhnrkklJHIaAGbaItAUzSSvgYgI
         2cU/bYyRuJUDyP8wRvUrZeu+twT5vtVsfNdMbMfel4LvDsrxtHWotHDvIMV9Vzucz3
         Jrb3urhFsS3ieFuLDWKNBmFUhzYW+3raxr8/qJ+A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3767E62012
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath5k: remove redundant pointer rf
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180709124138.14996-1-colin.king@canonical.com>
References: <20180709124138.14996-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@do-not-panic.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180730175639.BF40362012@smtp.codeaurora.org>
Date:   Mon, 30 Jul 2018 17:56:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> Pointer rf is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up two clang warnings:
> warning: variable 'rf' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

e8c38062efc6 ath5k: remove redundant pointer rf

-- 
https://patchwork.kernel.org/patch/10514529/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

