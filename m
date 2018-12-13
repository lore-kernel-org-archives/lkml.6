Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9F5C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47F82080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pIH4xb0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47F82080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeLMGwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:52:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37365 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeLMGvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:51:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so793368lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 22:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l1e5G6yYmnCAnTFOusvvUz8qE4vsHqVuAYNLZZXTLcU=;
        b=pIH4xb0Q9kzGzo7L1exO7CoHj60D6Udssn0QWUrlJtUWDt//k7RHZcHXgqYERvxjGy
         JtXV3tqXU1sT0QWGY0MltL841cBaVR9ItKPMpruQpPfGNlbIORiM5ai0qJPgyqeX0Dv8
         esiJSm6df51odZcAzZOJNP1mxjZS0LH0CfFTtHneY0IkQhrzyqB+exa9WwEvnLA0Jwz8
         cyD0bqDehwzIgXLA4XhvjhziOnzyG56DFDjZS0udBpzxkXE33xyByXkMKUsCt0nvXSzT
         JvbA/nTCOLmBS0ZQwcq1ve8xIfNvljX9PqBVUososQdHpzYuTf5Zjn62QlhDZaIT3nOm
         VsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l1e5G6yYmnCAnTFOusvvUz8qE4vsHqVuAYNLZZXTLcU=;
        b=kFaE+M6ItcO/UIJKG4wTa7qvkn+mKS3UPwlIJqL1aUlJOsr11Pw+vxgIwdQkasy5BW
         y2JdvMK1vxXyTSNYj8Mz1zBdQqajokxLnAICkKSwDLfosJuniwajz8FzeXAtOwklNMOa
         9DsZh094Dm48enc90fdK37tlTPOqzWQt7rDk/YMTFxYM1ga320rQUt3Grl6WwTcBNIX5
         bl/A8aPIeZK8gAp/s/Rpq+bCukbVOZ2oKvkIeveE31jt7IcW4vtRfD4TvKb1RkLV/8eP
         HOhQNcvDvXdrL7xH2mTaGWnExswSu8/KRPdvE/cyo/KrR85+f8VM/OnYdlg7sSz0/o7e
         fYaQ==
X-Gm-Message-State: AA+aEWaqKJ8LUi7Utwj293fIDSnGL1F2FPBZvEwUmKEjm9/jI71NtAJn
        TdYSv7KsmWY0B1BzqFSy3bGXyQ==
X-Google-Smtp-Source: AFSGD/X/EscbVG2NmCqclaW72hLIhSIfBuATtNiceI1IMyKyj9W0Bxkh7UTeXnJ9IkBm3/qqBS4UXQ==
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr15250615ljj.6.1544683903534;
        Wed, 12 Dec 2018 22:51:43 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id y14-v6sm151776ljj.55.2018.12.12.22.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 22:51:42 -0800 (PST)
Date:   Wed, 12 Dec 2018 22:48:38 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 8/9] arm64: defconfig: Change SCSI_UFS_HISI=m
Message-ID: <20181213064838.f5goiwqu4tkkcmgd@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <2f3fdfc8-24ef-734b-7c4a-76da9f7556be@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f3fdfc8-24ef-734b-7c4a-76da9f7556be@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:08:07AM +0100, Marc Gonzalez wrote:
> SCSI_UFS_HISI depends on SCSI_UFSHCD_PLATFORM=m
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Another one that got covered by patch 1.


-Olof
