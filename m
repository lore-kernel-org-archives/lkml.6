Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 02643C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EC2208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E/48ykIR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hj702tzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EC2208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935380AbeFMLos (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:44:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935107AbeFMLor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:44:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6FD6660791; Wed, 13 Jun 2018 11:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528890286;
        bh=Ia8WcZtTBC+gcP60MG87QfG996t+8dCmD3Y/ityY8PM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=E/48ykIRa4oj84dT4JUfcZDlIwEcq6xA9tXDWAuuyrCVPApARxMUIFXAyOlbF8oYa
         vQEFaSbzrJ7RpmAQ8vZEFlQKp3ZTT+PZiUow516xYHPZgVx9SyzsXn7IeEs6hMtbtO
         w5V9QmPPczctYcbVR+X/NXGHbJyWjNxhpLfbzdfg=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C97D5601D2;
        Wed, 13 Jun 2018 11:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528890285;
        bh=Ia8WcZtTBC+gcP60MG87QfG996t+8dCmD3Y/ityY8PM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Hj702tzjFvwaQuXYvGHcbM8MEFTOBesiceb6b+Lgf4bO8jHMhksEalY/b5+KZw67q
         3N0Z3BSc29kIO687CajR7ubI5IFyiNMDeDcVK3OOaLxuQk9A799RnZn3m+krRHgZsO
         RGNo7WeN/E3F9cGYmXtgUlC+9Zt94G3okLRcF2Hs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C97D5601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] ath6kl: mark expected switch fall-throughs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180525182311.GA3000@embeddedor.com>
References: <20180525182311.GA3000@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180613114446.6FD6660791@smtp.codeaurora.org>
Date:   Wed, 13 Jun 2018 11:44:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Steve deRosier <derosier@cal-sierra.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

4de30c906ef0 ath6kl: mark expected switch fall-throughs

-- 
https://patchwork.kernel.org/patch/10428239/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

