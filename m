Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6374C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A5A20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="n1SLAl+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A5A20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJaF06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:26:58 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:42005 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeJaF05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:26:57 -0400
Received: by mail-io1-f54.google.com with SMTP id n18-v6so8136794ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4gqJvoF0dLC0mL7zcZOLz/LLOMGoAQuQbMPMCqTCa40=;
        b=n1SLAl+QVbywOuUZDSppX12jm2nMbgpjY2f5N+BTNsiHUqYUf5iRgf4TmtQ4326pR+
         HZLrW1mVsPoRB2JeC3sGGvudisQqIpQCf1/Qykdfqpp2eKvr+sTnop/IF6seZTk05rbj
         VDXo08XzwGg/PuHjixMffKTDNju+Kh66ouY8pHYqpYK2tY30TobTbVV9j3i4X3ClgzDp
         1dUZJxPczpiK8a4z6rbTkFmUJvZS8YiPTvqQ2wJ5TFYTlsdU8R405nJHyL38oPJXCOCw
         2lDnDvElBqI+aY3DJo3EhcwGBhZT97NO7JFNyP6qrsaisrG/Vcaq0ZeAx8rLMCQinBC0
         Gi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4gqJvoF0dLC0mL7zcZOLz/LLOMGoAQuQbMPMCqTCa40=;
        b=ctOTxx/YT35I//sZhqcMGz9aYBZ8UsictLC0IUn1l0nG7ldUrFkGSPjpvciwF/2Ihm
         3UJgJElfYjf42L3O85SH1qETVNsioW2jGU3toggU1/nfJiltOEO2B+UHNeVQwLri6zeP
         Yxa/POQ9k8k5VX0FWyPuLYhUPjf/+4HGSNQkmx5PlK67aOl24MJQnvTHwUdymmPL02Lz
         3ZmwrnJQdFTZAfgU4iBhJJa+dNNHjpGsD2IZilvaU7gVY9HQ1++2iCFHqpc7tEQz8rEg
         i0Y4EZVmuoujk95/OgDNQkxF8no3rWiowlbQ2umWfuFpU6W/eLFi3u8gEI5IyOGVr1AO
         d8gw==
X-Gm-Message-State: AGRZ1gLcF2uzriQ29b6sAtt3valPfD/8mFLHz1mVyPSAfNiERnRSlcok
        CUO7tBtY8giQnvww2g4zmFEP6v5RsO4=
X-Google-Smtp-Source: AJdET5cDKQRmv+v9J48JJymmrweEvWCEhpQKr9ptvGgrtaU0T8iwdNB9ROnfwJRK5pnbvoO5Ks7Kag==
X-Received: by 2002:a6b:bd46:: with SMTP id n67-v6mr160470iof.161.1540931516802;
        Tue, 30 Oct 2018 13:31:56 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h24-v6sm8505742iog.80.2018.10.30.13.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 13:31:55 -0700 (PDT)
Subject: Re: [PATCH] mtip32xx: clean an indentation issue, remove extraneous
 tabs
To:     Colin King <colin.king@canonical.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181030112942.10186-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd6119a8-20c8-d67b-b7f9-bb580b006759@kernel.dk>
Date:   Tue, 30 Oct 2018 14:31:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030112942.10186-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 5:29 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to clean up an indentation issue, remove tabs

Applied, thanks.

-- 
Jens Axboe

