Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AB3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF432075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RRVZU1rJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gEp/RoaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF432075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbeIFUhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:37:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbeIFUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:37:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C81F76044E; Thu,  6 Sep 2018 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536249650;
        bh=GOFmPO9eaa5FGNMeXEzEO8NA2+3K8Ylses+hiOxaeNg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RRVZU1rJbtHBO/pSEHtzXqCG0mOLpFTNogjMgw1YjpUb3asP5oDB3QRXRFRIT3jir
         utofqXGITCmO3K/tJtAVr4gqR8rL0+KxX+oEkE7dvB/eZgjlKjPICxPYoJ38a6AOzd
         laNgN7+cFW5MziAsu9G1Ei7hf3E9o0rgJmGrV27w=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 539CB601D9;
        Thu,  6 Sep 2018 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536249650;
        bh=GOFmPO9eaa5FGNMeXEzEO8NA2+3K8Ylses+hiOxaeNg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=gEp/RoaMF5A/EbnHsbzJORqzhYzTUEwF6sMc8fNQuTSNPjCqPXB7Qhvh9C+gFYYs3
         FYvlRmlc0Z/VHdJX0qzTHj/F+LtFK3zgrer8uvJh/X6LvvmLlnht1Fw0d64UsSurBW
         6Cj6bZP3RSdJg84nQtot9vDezTu6uSkT4H6ix/CQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 539CB601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wil6210: fix unsigned cid comparison with >= 0
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180829175018.GA3776@embeddedor.com>
References: <20180829175018.GA3776@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Maya Erez <merez@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180906160050.C81F76044E@smtp.codeaurora.org>
Date:   Thu,  6 Sep 2018 16:00:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> The comparison of cid >= 0 is always true because cid is of type u8
> (8 bits, unsigned).
> 
> Fix this by removing such comparison and updating the type of
> variable cid to u8 in the caller function.
> 
> Addresses-Coverity-ID: 1473079 ("Unsigned compared against 0")
> Fixes: b9010f105f21 ("wil6210: add FT roam support for AP and station")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

49925f247016 wil6210: fix unsigned cid comparison with >= 0

-- 
https://patchwork.kernel.org/patch/10580739/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

