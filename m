Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7448BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C4C208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RyUO8GoD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KvhdR9Ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C4C208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935452AbeFMLuI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:50:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60536 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935106AbeFMLuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:50:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9F3AD607E7; Wed, 13 Jun 2018 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528890606;
        bh=9RebfdmTN/vEIoGCX4emfKImrxxC8aGcZxYcFc1wmcI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RyUO8GoDlJYs2RTvyJMFa3XhSbCZZm1934+d/yscOGD0fsR7l60vIqbubLF0VrKGD
         sLpiMS3Ol1ZCNdi06KKaujZTMynCuj4B2dMyjDJyi50oMOkDggAZgikWCqmJToHrnS
         8VRJV3yGXjJAb5oHicmumjlDFlZwhgX2ANCvWhvk=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FF69601D2;
        Wed, 13 Jun 2018 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528890605;
        bh=9RebfdmTN/vEIoGCX4emfKImrxxC8aGcZxYcFc1wmcI=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=KvhdR9Ac9UnpUOIVDd8U5+x5xTU8DUBvulO0Y+VmeT7fXtMFmE/NpDJL6nIsY4kdT
         EPJZ0gMUbMrYEgI4ZgCppsuif2IigDzW6GVuPpEVVcpBooPN6L6A2sWGjwt8pvP0US
         JgUMNHNVRq2zrn88wYSq1S2jj1JGTE4g7jygCaMA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FF69601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath9k: mark expected switch fall-throughs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180525212207.GA10681@embeddedor.com>
References: <20180525212207.GA10681@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180613115006.9F3AD607E7@smtp.codeaurora.org>
Date:   Wed, 13 Jun 2018 11:50:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

12b67b0d6bcb ath9k: mark expected switch fall-throughs

-- 
https://patchwork.kernel.org/patch/10428521/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

