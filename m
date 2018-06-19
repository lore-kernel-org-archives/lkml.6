Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EB0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B550E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMb4V7bZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B550E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965878AbeFSKk5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:40:57 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33368 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937554AbeFSKkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:40:55 -0400
Received: by mail-oi0-f68.google.com with SMTP id c6-v6so17697510oiy.0;
        Tue, 19 Jun 2018 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BKkoSAI1DVN6hn+s8tCrHDcs7TeyCkhCSnlk1JILdyA=;
        b=DMb4V7bZVVwq/7zk8Ypz5zC8CIKzpqYr25r7HbxAFstloACJB0PT+Krosrwh99Jh3r
         nviVMc9e+6javmItGY+SMMStMytNxD1Tzx+r7VQiy07vj8oWU49UYDO+sqAgib5EzINP
         GrgkaHSRHL8shHTGwVKMERlkP1sKHCTlR4FcVxKqtlFzp+6XkSZxUu1qCBcrSsKjyzi+
         TlczZ/U7FQWWuV7qiXPDKGyTLJIgFaKSHd2dACSAxj5YJkm+enpP1MgEFd1pkO8o3+g9
         LNVAvMnuqOdOYhUwLamjusSKmE5zRRSTaJs1+koV6lgjLNxPGUmnGZxBAUgfmWpCl+9j
         Usdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BKkoSAI1DVN6hn+s8tCrHDcs7TeyCkhCSnlk1JILdyA=;
        b=Ki7HTmLJQv96/QX1/7iZEjprovO+UMkqzIxNDT1Y938R0XtOTKegvDUMyePMjxoGED
         MBke2pYv7A4eZgASRZvERq9SM3DgcumzGmyJ5VHQqCTadNvS4UCi4LepUoe4+O26H7uZ
         avu0lrVnQkrVnJYeTz5BX8JLBSvt3BHJwbPVfN6cUQb82VJx7EUwMlhOPo7Y/w4gq7Av
         EFQac2dR8wREiZWMxisULJFfMMcvSinwN/qOaH+QLJcRLqj21IbiQ4xk5WDU5EmF4Joz
         WS6KTNfho1QmboUqRxCNbGy8U6bgDJ/zUlNJczmDTlGqs8ujvCsehN3W18NYq9sEZzlj
         hgvA==
X-Gm-Message-State: APt69E3SIJNY4mkXnkll4LK2fUlb3rBmy5LnCLNrpwtB+/SQ/c7+lt9E
        k3fAoiH9DksS2IoPjiX8hGnsAzu2yREemqgVa04=
X-Google-Smtp-Source: ADUXVKJ8h05ysZDI6P9RUYjzk+Rm0+6bTvNTXCfEoStBuwdetrCF94UPObGNGIBVdsBzPg4yFdaZL+wvIxjKoCaxkmQ=
X-Received: by 2002:aca:2808:: with SMTP id 8-v6mr9493229oix.235.1529404854186;
 Tue, 19 Jun 2018 03:40:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1915:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 03:40:53
 -0700 (PDT)
In-Reply-To: <20180618151142.1214422-3-arnd@arndb.de>
References: <20180618151142.1214422-1-arnd@arndb.de> <20180618151142.1214422-3-arnd@arndb.de>
From:   Stanislav Yakovlev <stas.yakovlev@gmail.com>
Date:   Tue, 19 Jun 2018 14:40:53 +0400
Message-ID: <CA++WF2NRGtCKr=Q=+zmA7otu64J6JBfrnK9vB-Nyqk6oYivWDA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ipw2x00: track time using boottime
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>, y2038@lists.linaro.org,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2018, Arnd Bergmann <arnd@arndb.de> wrote:
> The ipw2x00 driver family uses get_seconds() to read the current time
> for various purposes. This function is deprecated because of the 32-bit
> time_t overflow, and it can cause unexpected behavior when the time
> changes due to settimeofday() calls or leap second updates.
>
> In many cases, we want to use monotonic time instead, however ipw2x00
> explicitly tracks the time spent in suspend, so this changes the
> driver over to use ktime_get_boottime_seconds(), which is slightly
> slower, but not used in a fastpath here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c | 18 +++++++++---------
>  drivers/net/wireless/intel/ipw2x00/ipw2100.h | 12 ++++++------
>  drivers/net/wireless/intel/ipw2x00/ipw2200.c |  4 ++--
>  drivers/net/wireless/intel/ipw2x00/ipw2200.h |  6 +++---
>  4 files changed, 20 insertions(+), 20 deletions(-)
>

Acked-by: Stanislav Yakovlev <stas.yakovlev@gmail.com>

Looks fine, thanks!

Stanislav.
