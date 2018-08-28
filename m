Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD293C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583982089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VAcvxp6j";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VAcvxp6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583982089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeH1PKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:10:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbeH1PKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:10:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D85946055B; Tue, 28 Aug 2018 11:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535455171;
        bh=9Js+4nH/m2fHKW6tm5fOO9CCNjhjHyaIlc+2U8JJaBI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VAcvxp6jsIGf/b4hEpvou27J12UPi9jyi/Tn+K8wP3BZOibt2K2PV7plba25hjxtt
         7pdCJLKeCdcnl+WK8gabwATWf6oYf0QPR0EtPzMzZEn3x9rlSqR49KT8LRdhMxsG7h
         JM4NA6wiHWBZYquz9pkEUScVp2+i6EV/RZ+k7RcU=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D02AA601A0;
        Tue, 28 Aug 2018 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535455171;
        bh=9Js+4nH/m2fHKW6tm5fOO9CCNjhjHyaIlc+2U8JJaBI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VAcvxp6jsIGf/b4hEpvou27J12UPi9jyi/Tn+K8wP3BZOibt2K2PV7plba25hjxtt
         7pdCJLKeCdcnl+WK8gabwATWf6oYf0QPR0EtPzMzZEn3x9rlSqR49KT8LRdhMxsG7h
         JM4NA6wiHWBZYquz9pkEUScVp2+i6EV/RZ+k7RcU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D02AA601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: wireless: ath: Convert to using %pOFn instead of device_node.name
References: <20180828015252.28511-1-robh@kernel.org>
        <20180828015252.28511-36-robh@kernel.org>
Date:   Tue, 28 Aug 2018 14:19:27 +0300
In-Reply-To: <20180828015252.28511-36-robh@kernel.org> (Rob Herring's message
        of "Mon, 27 Aug 2018 20:52:37 -0500")
Message-ID: <87h8jeg2m8.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/net/wireless/ath/ath6kl/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The correct prefix is "ath6kl:" but I can fix that.

-- 
Kalle Valo
