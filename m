Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6150DC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A23F21990
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MEGzvEU0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X51+KHVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A23F21990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbeHIRed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:34:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732570AbeHIReb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:34:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7D1F660AD8; Thu,  9 Aug 2018 15:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827351;
        bh=Iu8B+9lnM7600FfaQTVqxALrhXPsShpQsx8DumCHGcM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MEGzvEU0PQXOsnfO/uQE/7tAzCSA+4dalz6NAto5ZW8Kv1PzV60T/lB+o/Hf3b3CW
         vHG26bXWmozae+I/pRpSaxX9jPqrFfAcnfdhInBBQHKE1MXWLG+k/FUgzBJJC5/4zT
         f0ys5H6rSKA24X/fCwvQWEd6qijR8gCl8vDd41NM=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C768960807;
        Thu,  9 Aug 2018 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827351;
        bh=Iu8B+9lnM7600FfaQTVqxALrhXPsShpQsx8DumCHGcM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=X51+KHVCIU438ggPeBbpLaQK3emR6KvQu94Fzft2yYCNc49cbUhjP7j80kvFKQJup
         WrQNMgnwoRvYgYgqeM3FQ1bp74tCl+TfqRwPo/EX3t6xyAPCTmD3awuHUUhgnWrAoA
         rvyD0hXfFwyAxfttUxH5+rIKWKQDdrwyRYZ2mEYQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C768960807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers] mt76x0: Remove VLA usage
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180807225040.GA2164@beast>
References: <20180807225040.GA2164@beast>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180809150911.7D1F660AD8@smtp.codeaurora.org>
Date:   Thu,  9 Aug 2018 15:09:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> Even with "const" variables, the compiler will generate warnings about
> VLA usage. In the quest to remove all VLAs from the kernel[1], this uses
> a #define instead of a const to do the array sizing.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Fixes: e87b5039511a ("mt76x0: eeprom files")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Stanislaw Gruszka <sgruszka@redhat.com>

Patch applied to wireless-drivers-next.git, thanks.

17ad18fd12a3 mt76x0: Remove VLA usage

-- 
https://patchwork.kernel.org/patch/10559297/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

