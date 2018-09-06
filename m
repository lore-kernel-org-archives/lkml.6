Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1426EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C246320844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Lq+Djxfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C246320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbeIFWJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:09:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34579 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbeIFWJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:09:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so5597735pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Y/cBsV7uvDHCRF8oBe18V41iUMD8nBXqVOS1snPmeiU=;
        b=Lq+DjxfvVnx2h5jRV+/h2t2JRkRBKysyhec16/sncRtmk8XwFaf6iuLHsio5FkxCEg
         aWc0i27nNTjLobylquWPVbqby3sW1UvlTa5t3+ZvSFWNMm1DAS2MQavN+oxi4JOYYLq7
         CFs8NQfGzud7POoUK8vOKoVxGljMjWcKU6g2EQWi4r9ze7Z8h+Al8JBDZG0+3KpY2njw
         GNX88lmDhS6XVjdv/5ijSGiwDOcZQ0HzShlESIxeg1IVFKRIJmxCtHIijKyf7tPJE+/B
         NjAunkXlLY6N8BGNO4ck2JWvJpqQ/fD5G1dbMQZIO+4ugcVufgVDKOJ5/VhPfyy0blwe
         gAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/cBsV7uvDHCRF8oBe18V41iUMD8nBXqVOS1snPmeiU=;
        b=N6Pu9ec6tBNrhIzCreumYWxXj+S52eyMFGeX3o2nrLjrvoXfX3nyJQv4smh2z3Mh+L
         Fbdgdby/pP6jZbyAeZPS3iUHTWqJ0BTLoYjQdgOwy4CBVpEm8J/2rYBQh56IcVsGj6dS
         eKFjCDeWDBp/xRM0jyyJkNOrkSJfi+q270g41rhC/FNCBV0C/BQIK0Pc1loE9XT4fo5B
         bzNptnPGYocBPh8UPeHr96+rpNFQ+akqPxeO4axVDvEUyxxJD7dsrNuriKglz4/NsQw0
         QIA+4DqojFwE8VuTJkELLVQrDXn/lnQGX3bOkuZkQR30KCiI84LbTu0blqBku813f0f3
         dGMQ==
X-Gm-Message-State: APzg51DhA3kMMf3QbIJj3G8JKG83gg4J8zPwSKRstl2A591bgKam/1g3
        qYJalG6Aj2iW52gvYkJbd65SXajkIo8=
X-Google-Smtp-Source: ANB0VdalF5jzUwzURkfj7QNnUFohgiKwaqpH+ClImv/29Ffo1M3YKUKbLt2w9mbO9NIOPK/DIG033Q==
X-Received: by 2002:a63:7a0f:: with SMTP id v15-v6mr3963641pgc.127.1536255203586;
        Thu, 06 Sep 2018 10:33:23 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1132::11cb? ([2620:10d:c090:180::1:53cf])
        by smtp.gmail.com with ESMTPSA id j22-v6sm7578709pfh.45.2018.09.06.10.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 10:33:22 -0700 (PDT)
Subject: Re: [PATCH] block: bfq: swap puts in bfqg_and_blkg_put
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
References: <153622114435.533797.15694137158197822778.stgit@buzz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7bf130e2-1aef-3ef6-caef-a80d0eb1bb96@kernel.dk>
Date:   Thu, 6 Sep 2018 11:33:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153622114435.533797.15694137158197822778.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/18 2:05 AM, Konstantin Khlebnikov wrote:
> Fix trivial use-after-free. This could be last reference to bfqg.

Applied, thanks.

-- 
Jens Axboe

