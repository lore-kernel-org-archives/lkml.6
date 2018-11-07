Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA667C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A4F20818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZAoR9H76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A4F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeKHFhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:37:03 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40464 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeKHFhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:37:03 -0500
Received: by mail-it1-f196.google.com with SMTP id e11so21344992itl.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 12:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RGlRR0IxOueRFL5tHOTubBMGk8c1XHhzE/wNkZpJwuA=;
        b=ZAoR9H76XpG2j6xbZ1WtUpXAockKhAgT4Qq3uqTcIJemwQofmGEuh2QICafEsC5KCc
         ka8dA5kvhV/W0U8XZTZMroMnTQSSa4d3jXlaUDoqr7QbY/ttLM64LFOVpVesnK+uki8g
         CXQDnsLlMUo89nMR1VCDhNcuTJEFAFB85nvx49RaDxjlKnmKNg4R7EnnatI1bnCnlV0l
         Ecj3sKBhnwwmjaLHkXOFreo0I/257etLiSM4RgQw96v3LgbUmKEXfwR3JylXDGZiyV7t
         9P/04uDbF159+eILjAg7qqkajIyq1VGmZ9q9UkghkSzLNICfdshBME83nCQRu8LNk0a0
         1zDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RGlRR0IxOueRFL5tHOTubBMGk8c1XHhzE/wNkZpJwuA=;
        b=K+9D0emxHoAxTQt2M/POa8sMm4hDs39n+dmoX44V1d1EtkiUxTTH5GGOPNHEY9rNTc
         Qt9ah+7UrDXoybVTMDBFGt6P5N8A3wpxoTQYv5rS+Ywyy+tdUlRd0D9No59oGVxaiXzx
         hOT6fRsSzQCF8fwn/NvDSTop3f+JHnHSoFNWzz9n1muiMomFJim9qU9dgn3MFzMkZrhW
         EQLGuyoJF9a0L/mmjxYr2OHC2zOTUl/i4S17IRTM9ndF7HL6Zx/QnIB060Wj5GGv4lvb
         ljIRd8YssO69OCwMD+mZIAK6FCSG3GzsUbQV1jfCe/h00ALAnClwe5CFH6X2UxmpBjt0
         2qGw==
X-Gm-Message-State: AGRZ1gJi3+4MI5OjT0PlRDxYkQZX5em4hGxN6xCmziq45eCjpBwehw9c
        lWhSV0yk8bRI8ZK9Nmo+P9MJ7Q==
X-Google-Smtp-Source: AJdET5ctEVNxpLcy4zsAd9munOkyvPTHRrt0fWyNzqkJbVNaSV1D2tMQlCuoi7l7D3aYyAShf6CDQg==
X-Received: by 2002:a24:508a:: with SMTP id m132-v6mr1413313itb.19.1541621109022;
        Wed, 07 Nov 2018 12:05:09 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1134::136a? ([2620:10d:c090:180::1:ed44])
        by smtp.gmail.com with ESMTPSA id u127-v6sm785866ita.10.2018.11.07.12.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 12:05:07 -0800 (PST)
Subject: Re: [PATCH v2] block: respect virtual boundary mask in bvecs
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20181107135814.15727-1-jthumshirn@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <756f1630-f875-4a7c-26cf-9cce7b850ca1@kernel.dk>
Date:   Wed, 7 Nov 2018 13:05:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107135814.15727-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 6:58 AM, Johannes Thumshirn wrote:
> With drivers that are settting a virtual boundary constrain, we are
> seeing a lot of bio splitting and smaller I/Os being submitted to the
> driver.
> 
> This happens because the bio gap detection code does not account cases
> where PAGE_SIZE - 1 is bigger than queue_virt_boundary() and thus will
> split the bio unnecessarily.

Thanks, applied.

-- 
Jens Axboe

