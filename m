Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3129DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0222086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ehl90/NR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ST0cbSDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0222086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeIKTrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:47:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34376 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeIKTrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:47:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A83A608C9; Tue, 11 Sep 2018 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536677256;
        bh=+kNXtvsawg9K8Z6Z8LiWplEOyGJdei6vUQkoW1STWnk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ehl90/NRGETtlwaNTF8XbTRfn68R4ewz5R/SPAYyrVgJDnaLNSbBokWoPfBG7na0c
         zhmtL5vYF2Gb51yWU3vDI4XPnrqRB7prFn8NkjyWELjQHer0cL8ou4vnZkqWY3D3nI
         xV0AbwTXLOiZfp4tXYqzn+ZZuhgXNaZ01kjeHodw=
Received: from x230.qca.qualcomm.com (85-76-111-141-nat.elisa-mobile.fi [85.76.111.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CE9360452;
        Tue, 11 Sep 2018 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536677255;
        bh=+kNXtvsawg9K8Z6Z8LiWplEOyGJdei6vUQkoW1STWnk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ST0cbSDd8QjydIH0O6eXRLafcnhB9F2hrlkc7njvZUJjd4LT4IwyqDKYH0xSvt/ex
         IihW8pEjRdatJCQw3yYlYUL15JqNOLnJ4rmg1MrJ6Nus/tjr09L6LCCqDzeP6tk17T
         F+F/p65ZFFTjr4fUGKd5NFCyLsNs8LsuNSuItkaQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CE9360452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, Zhi Chen <zhichen@codeaurora.org>,
        ath10k@lists.infradead.org
Subject: Re: [for -stable] commit "c82919888064 ath10k: fix scan crash due to incorrect length calculation"
References: <20180906213620.GA72542@ban.mtv.corp.google.com>
Date:   Tue, 11 Sep 2018 17:47:31 +0300
In-Reply-To: <20180906213620.GA72542@ban.mtv.corp.google.com> (Brian Norris's
        message of "Thu, 6 Sep 2018 14:36:22 -0700")
Message-ID: <87lg88t7jw.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> Hi Greg / stable maintainer(s),
>
> IIUC, this commit is a good candidate for -stable. I just hit the bug on
> 4.14, because of new vendor firmware that noticed the mismatched length
> (an internal "assert"), but it seems like this is equally problematic
> from the kernel side for as long as this code existed [1]:
>
> commit c8291988806407e02a01b4b15b4504eafbcc04e0
> Author: Zhi Chen <zhichen@codeaurora.org>
> Date:   Mon Jun 18 17:00:39 2018 +0300
>
>     ath10k: fix scan crash due to incorrect length calculation
>
> Thanks,
> Brian
>
> [1] I guess that would be:
>
> Fixes: ca996ec56608 ("ath10k: implement wmi-tlv backend")
>
> which was in v4.0.

FWIW:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

Thanks Brian!

-- 
Kalle Valo
