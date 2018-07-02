Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012ADC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73562554C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fb/4Xfo3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fb/4Xfo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73562554C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeGBOkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:40:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbeGBOkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:40:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FBD660B3C; Mon,  2 Jul 2018 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530542419;
        bh=NaSfPyJHRwEiGwP9EGWA8xI4Q9h8i78VpGnumBKiwSw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Fb/4Xfo33QyymNaXMwEphThU6iAPRTtYb2uOIe08AFITyH7xjahQJ5dwLbZjzs/1M
         LRPoW3tA/FGk+qTlpd5O2BQmTTz66DN0qRTcQuiVmNSt6lfAvzEFuTTWX3plJXvfxx
         wZjfE4LjjjyBZOPab/PUU0eaRUQNgJ2qm06sBs6E=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 487FA6031A;
        Mon,  2 Jul 2018 14:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530542419;
        bh=NaSfPyJHRwEiGwP9EGWA8xI4Q9h8i78VpGnumBKiwSw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Fb/4Xfo33QyymNaXMwEphThU6iAPRTtYb2uOIe08AFITyH7xjahQJ5dwLbZjzs/1M
         LRPoW3tA/FGk+qTlpd5O2BQmTTz66DN0qRTcQuiVmNSt6lfAvzEFuTTWX3plJXvfxx
         wZjfE4LjjjyBZOPab/PUU0eaRUQNgJ2qm06sBs6E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 487FA6031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <simon@thekelleys.org.uk>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <davem@davemloft.net>, <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] atmel: using strlcpy() to avoid possible buffer overflows
References: <20180630063341.9900-1-yuehaibing@huawei.com>
Date:   Mon, 02 Jul 2018 17:40:14 +0300
In-Reply-To: <20180630063341.9900-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Sat, 30 Jun 2018 14:33:41 +0800")
Message-ID: <8736x1snu9.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:

> 'firmware' is a module param which may been longer than firmware_id,
> so using strlcpy() to guard against overflows. Also priv is allocated
> with zeroed memory,no need to set firmware_id[0] to '\0'.
>
> v1 -> v2: remove priv->firmware_id[0] = '\0';
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/wireless/atmel/atmel.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

The changelog should be after "---" line. I can fix it this time, but in
the future please use the correct location.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing

-- 
Kalle Valo
