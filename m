Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FCAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A962077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QOz8YYmW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kjn3v8lK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A962077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeHaTt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:49:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56436 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbeHaTt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:49:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 81C176053D; Fri, 31 Aug 2018 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535730113;
        bh=XPOMbybJ9Dm558lFmSGT9SkaJh49yPuNzY5Q6ITSmFg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QOz8YYmWJy2QOLbLH/p107jLBuXiYtXONBGidne0T7JjtVBb6njQ0aAuqSyndZHII
         SEUdtwTSWW+LpGSQtJsPfmPxDoVu2bikvrZ8QyPZOPGtOoVtz+A+SaQ2tPlSwlSeOu
         hZB5Jf3eGoXun/Gz3B5jVn8VifbMzZ6gMBi5kWuI=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EF026032C;
        Fri, 31 Aug 2018 15:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535730113;
        bh=XPOMbybJ9Dm558lFmSGT9SkaJh49yPuNzY5Q6ITSmFg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Kjn3v8lKj4UKOVbWMY+9+9ogVaMVVAA4C/rScO6ZavQYEpwpn1qcna9JiCFr3hk/b
         pUxvYx/sskx2/eqVqcsUiXVP/cLd6yNho82pPW4qp36tI6BTVFIjMwF3+hOh1jAVvc
         oECxJT35IzkYPU1lKIa8iyJHgkqwCifiKceUVd0A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EF026032C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmsmac: Remove extra parentheses
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180725185625.4220-1-rvarsha016@gmail.com>
References: <20180725185625.4220-1-rvarsha016@gmail.com>
To:     Varsha Rao <rvarsha016@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Varsha Rao <rvarsha016@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180831154153.81C176053D@smtp.codeaurora.org>
Date:   Fri, 31 Aug 2018 15:41:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Varsha Rao <rvarsha016@gmail.com> wrote:

> Remove the unnecessary parentheses to fix the clang warning of
> extraneous parentheses.
> 
> Signed-off-by: Varsha Rao <rvarsha016@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

9e9e11d83238 brcmsmac: Remove extra parentheses

-- 
https://patchwork.kernel.org/patch/10544573/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

