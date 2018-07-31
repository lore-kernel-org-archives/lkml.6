Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F92C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C770D208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jWVUv968";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ictQJoce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C770D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbeGaJCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:02:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeGaJCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:02:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A3926606AC; Tue, 31 Jul 2018 07:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021820;
        bh=41M7J2ptuMenuXXJ32s0kbeS+6ai+ueryIe/x1CFCRI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jWVUv968cbGBiwuCi/sMsJYk37hBW56kPz3MWOkO0hWxJpc/UwAfzQnOTyuvZiS7K
         V+xlFfuuVLe1Ek+96kCx1fQZ85n8bBvy7hNxfaubLuF5xi8vb9rHJq5RZWVH96kSn2
         kcIALM1/GaIlUmpTtI2Vc4VkcfsmqYOFbccLWzF8=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBF4460376;
        Tue, 31 Jul 2018 07:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021820;
        bh=41M7J2ptuMenuXXJ32s0kbeS+6ai+ueryIe/x1CFCRI=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ictQJocewDTP+y3vi6zeebY2H68PmdJdmaZJgff2Sm4KkjxtCEplxjEkThyhdmufH
         vWRa/wto9/n4i65OWdXA6PH9lVlOEbyvuHOJhUTkNzLcNsj9LDtW3eUjpkljyCm/JG
         TIVNqVd6M/p+muJjdrvzkqiyw1MB8RKActVC7Y9I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBF4460376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wlcore: remove duplicate \n for some warnings
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <af660348ade58fd33396d2dca432536d2ac85cf7.1532498079.git.hns@goldelico.com>
References: <af660348ade58fd33396d2dca432536d2ac85cf7.1532498079.git.hns@goldelico.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "Reizer, Eyal" <eyalr@ti.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180731072340.A3926606AC@smtp.codeaurora.org>
Date:   Tue, 31 Jul 2018 07:23:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> wl1271_warning() already appends a \n to the format,
> so adding one to the warning string gives empty lines in the log.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Patch applied to wireless-drivers-next.git, thanks.

18dc5a4bbcc5 wlcore: remove duplicate \n for some warnings

-- 
https://patchwork.kernel.org/patch/10543473/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

