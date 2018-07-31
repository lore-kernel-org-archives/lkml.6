Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0762BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FB9208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eL9ldmNB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jH3bl07/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FB9208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbeGaI4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:56:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56504 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeGaI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:56:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A3D8606AC; Tue, 31 Jul 2018 07:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021459;
        bh=0sc/mNlBeIxyd9ZlLDAlRjud6UoVOsFrKplyfPC+bxg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eL9ldmNBsLAkKlqWYK1uXnzprPZdfp//yhaE6AVmdqjTLF2HbmG5jyfhGFOYD7WoR
         i/z0fpI6mTt+H3kjyhzNM9cUm+dio0w/cOo8O1ATiq2VIAw4cYxCACp/NrUaPWxvR1
         W1JVIdEMuvcF3SJvY1/6HFxjzPAtkMpCQWYR+kjg=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9171060376;
        Tue, 31 Jul 2018 07:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021459;
        bh=0sc/mNlBeIxyd9ZlLDAlRjud6UoVOsFrKplyfPC+bxg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=jH3bl07/+mBwso2Es3PJhKA7alJf4ox8UBI5cH0ZIHfeQ1gatq+mZDe5oLtuYUyC8
         LfYEsT9GTx+3+OTVh91PCQGfjXPyvzcbVhCk3dBFPiBzPZbgPSiMsnOfcsQP4daca/
         eNvz4ZesZG8L374VJovfGnHhsDHYFW9NBqeVAiJU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9171060376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] airo: remove unused variables len and dev and clean
 upformatting
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180709133843.15615-1-colin.king@canonical.com>
References: <20180709133843.15615-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180731071739.6A3D8606AC@smtp.codeaurora.org>
Date:   Tue, 31 Jul 2018 07:17:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables len and dev assigned values but are never used hence they
> are redundant and can be removed.  Also add in white space in for-loop
> and remove some { } braces on if statement.
> 
> Cleans up clang warnings:
> warning: variable 'len' set but not used [-Wunused-but-set-variable]
> warning: variable 'dev' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

d01a4e04dab7 airo: remove unused variables len and dev and clean up formatting

-- 
https://patchwork.kernel.org/patch/10514607/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

