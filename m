Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A34AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C16217C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Hp0EPOCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C16217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeHUSXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:23:07 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40148 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeHUSXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:23:07 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so4448888ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iCb6Y6TN1xpIhjwroigIkckUXWcue0LgmdZH+p0svis=;
        b=Hp0EPOCr5C/LNRa1H+Owpf9oYoq13dW2zKO3rChWGvrmKbrhniIIJFegiFGL6wDcR4
         zYofeP7+t6y1IjWQ7x8e7OTkT8WCTjWVe3D9vZ92qRgErhXouIt51v++R/MobsN6mppO
         BiPC7mY24VzNYm+Ps8tWHqE46MDlSayO5Z+R4EdfKOxdgEbBximKs5RxrHUc/JPuSNxb
         mzOMeZpqN8SBo8ZI4SHpkVHH3rNE0/Lp6Mv63RpbjDeUxKj2bxf211cgH6/pqFwOIRD0
         usZ+lCurwM8DeDy/TcL4a7S1pu+s+tz1lO8VdeImOm6bMLbGhUHEhPJocNIBV+P7ETv2
         qA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iCb6Y6TN1xpIhjwroigIkckUXWcue0LgmdZH+p0svis=;
        b=nKipRwXGaMXOjmFHx4CPs2WdQMPEb2RlYp/LHSTiKSi2X72GicR/unQqmdjDx98Fms
         n/nNl9JkZa8okF9AdThdx1mXtjtfgkjkzDr6oJg/dZFF7tBMVK7sfGOJeXv/19oZ7FBs
         q25g2RpscbqEkBXClJOeocTUN8Pu2AflVTdUJQXZWPXDDyAL4ATp0qXbbx/dfxba2k5s
         JCT8teYZsnkeoIRTdfNHsVwfh6jbjdL+24qKl88pa1Fy1kDHS7seYvj01F8GJXHuXmIk
         mnxrQn+W2nlxTVYg3gwkIXTk5eOWXtejUj3NWBu+Xxs4yoyiAzAXDBr9MdXyqQH3qdym
         M2kw==
X-Gm-Message-State: AOUpUlH9WrvFZgBENbg2osAAZb+BvujOYgV1HaMeRe68BXTAo3Uoe9rK
        cwHgMMKuGJhmxHxxMZVjtes1BhAk35c=
X-Google-Smtp-Source: AA+uWPwpKPDLFEfGqNW8uQ3r/l8nJkDUVPZEwgaxoANdXg6k8D6FX9BIV3XAXuzJ82MV+dhvhc5RxA==
X-Received: by 2002:a24:e47:: with SMTP id 68-v6mr17769202ite.23.1534863755309;
        Tue, 21 Aug 2018 08:02:35 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k9-v6sm649182iop.1.2018.08.21.08.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 08:02:34 -0700 (PDT)
Subject: Re: [PATCH V4 0/2] fixes for the updating nr_hw_queues
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1534835704-3607-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <94238d71-9f39-1378-5f86-9093d0d2cf32@kernel.dk>
Date:   Tue, 21 Aug 2018 09:02:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1534835704-3607-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/18 1:15 AM, Jianchao Wang wrote:
> Hi Jens
> 
> Two fixes for updating nr_hw_queues.
> 
> The first patch fixes the following scenario:
> io scheduler (kyber) depends on the mapping between ctx and hctx.
> When update nr_hw_queues, io scheduler's init_hctx will be
> invoked before the mapping is adapted correctly, this would cause
> panic in kyber.
> 
> The second patch fixes the following scenario:
> part_in_flight/rw will invoke blk_mq_in_flight/rw to account the
> inflight requests. It will access the queue_hw_ctx and nr_hw_queues
> w/o any protection. When updating nr_hw_queues and blk_mq_in_flight
> /rw occur concurrently, panic comes up.

This looks good to me know, I'll queue it up for some testing.

-- 
Jens Axboe

