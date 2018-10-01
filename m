Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14782C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F6D206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dzofgBPL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b7qAahde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F6D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeJAKvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:51:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52506 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbeJAKvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:51:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8365660C4F; Mon,  1 Oct 2018 04:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538367349;
        bh=1ZWBWrnBocvQRuB1od+lHNHXtwNrVXFVQg2p/Jh2ka0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dzofgBPL+soS5+Gh97zzlVD6qwlhi2M9HS8aSpeUfOikHOf8nXCqRSBAk7OlJKWcT
         iLZhS/Jilb4Xk37zBoqVSnHevVw3Gsgh65h6nDXQgCmG2zvYJ3mFVua13eB7RgRBZS
         KfHctk7zYz+hSN2Om4TmqIlsf3zwW94z7zvYYe0E=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F09E600C1;
        Mon,  1 Oct 2018 04:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538367348;
        bh=1ZWBWrnBocvQRuB1od+lHNHXtwNrVXFVQg2p/Jh2ka0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=b7qAahdeKKOD+ue0FSKhskd1kTIdJZt2NNSWI73Fl5UYoTw7LJcUbaRHciIsIKT6k
         eS0OETdmz6r7TSXjypALtjlpelGAIgO6t0u0YvG3CNJxATl3SI7YiEn27Dud/BTDKV
         paoeBk7Z9LHhGv0ZOYmgmb/CdfQOqrTTgPJ9gwyY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F09E600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Joe Perches <joe@perches.com>
Cc:     Rick Veens <rickveens92@gmail.com>, gregkh@linuxfoundation.org,
        Ping-Ke Shih <pkshih@realtek.com>, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtlwifi: Removed unused define and code efuse_re_pg* from wifi.h
References: <20180930182919.GA19383@localhost.localdomain>
        <7c4f645219bb69f31777367d5edc0830c32467db.camel@perches.com>
Date:   Mon, 01 Oct 2018 07:15:43 +0300
In-Reply-To: <7c4f645219bb69f31777367d5edc0830c32467db.camel@perches.com> (Joe
        Perches's message of "Sun, 30 Sep 2018 11:35:01 -0700")
Message-ID: <87in2ml2ts.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Sun, 2018-09-30 at 20:29 +0200, Rick Veens wrote:
>> The following:
>>  bool efuse_re_pg_sec1flag;
>>  u8 efuse_re_pg_data[8];
>> are not referenced anywhere in the rtlwifi code.
>> 
>> Signed-off-by: Rick Veens <rickveens92@gmail.com>
>> ---
>>  drivers/staging/rtlwifi/wifi.h | 4 ----
>
> Presumably the equivalent uses in
> 	drivers/net/wireless/realtek/rtlwifi/wifi.h
> should be removed as well.

But if it's needed, just do it in separate patch as the patches go via
different trees.

-- 
Kalle Valo
