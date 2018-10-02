Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0ABC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D84F2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cOdvCyx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D84F2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJBVUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:20:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32881 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:20:55 -0400
Received: by mail-io1-f68.google.com with SMTP id l25-v6so2274253ioj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0pgG0kIZ7y7e8zs4QICIuaKeXOrTIbar65BN4uMYTb4=;
        b=cOdvCyx83zLvAxNhrTtslEyD+AvvV2rJnTBQMw9jJFqG7w35KB7T6HB4wXH8vN9jYV
         B2OfCasWFHC8ID9CxTReeW+3xyj5xaBvTd6x7vvmmzoO6eZdS7QdM6fB0GVQzm080f86
         qZ3BR7WKj4yty+6DZ7+oinZzClzlKb+Y9gfJiYm4OuV8lvH5jK2P0gpvCApINFdANzLu
         Lf0kHRFr3tPqu7GnVXombO1VtajhtvJSCe0z0cpRC5pe7sZVQhzl7jK+mFShmIgJTn87
         5tkE2lfOhoMimXIKzRnQ6JSOE5lJ8LIRwLnMmoWyeRYFzKcd08CDIZFGYJWvRBKdBuPH
         ZAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0pgG0kIZ7y7e8zs4QICIuaKeXOrTIbar65BN4uMYTb4=;
        b=QyC9YL4Ii0AQKoVIIvnOLW7czXGITiyPDSfiriHuVkQ4454uONK4QX8OX5+1UJ+1Fo
         eolOcxGClv+OrpQ0sNtS1ThH3xNox1s83xqp2IUNu+NdYO2d789Ed+d9FVxC6O2fHY9v
         HA1IubZmnsjxoCQ87fc07T2JX/L12SsyFDEQItiWVMv1HXaBVAGEHbKIBY7BFEjcfuFs
         6E5DVnoIrhZAgxHEkWxcgtbAGd+H0DMK5odN4RiBf8E4gmkYDdwFehlxS1TuoMeEh5aw
         jtOB/mBfzL2wLl+bFV+0nyxk3qLvTwcWhOAodN5VkUgiUPFFKCoizZLY8dcOHIhCF0fj
         JV6A==
X-Gm-Message-State: ABuFfoij8OTqQOSc12Hopz/PNnybzXFElIFU11JV3rVsw0UmpBkqc9Vt
        TYMqZf92ctnFtKSnIQI02+CPVHJsIow=
X-Google-Smtp-Source: ACcGV607/T6WjoZ6AQ1noQIQfXd+MHZnq2ajC1WahD+pO/TbHXsU4r2ER+1jB4VPnrKbUynXJb66vg==
X-Received: by 2002:a6b:c917:: with SMTP id z23-v6mr10581659iof.297.1538491031921;
        Tue, 02 Oct 2018 07:37:11 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l2-v6sm5720197ioj.59.2018.10.02.07.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:37:10 -0700 (PDT)
Subject: Re: [PATCH] pktcdvd: fix fall-through annotation
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20181002102440.GA2888@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd860546-1160-f388-670c-aee2415eafc9@kernel.dk>
Date:   Tue, 2 Oct 2018 08:37:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181002102440.GA2888@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/18 4:24 AM, Gustavo A. R. Silva wrote:
> Replace "fallthru" with a proper "fall through" annotation.
> 
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough

Applied, thanks.

-- 
Jens Axboe

