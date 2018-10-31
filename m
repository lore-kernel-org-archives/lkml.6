Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E131C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC1620664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC1620664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeJaJ4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:56:04 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45241 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbeJaJ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:56:04 -0400
Received: by mail-pg1-f180.google.com with SMTP id s3-v6so6499363pga.12;
        Tue, 30 Oct 2018 18:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=QByp7l/8DY4zjcv5s3yIn7EqfmmO4PUT/JGjZpn6drUXf0tWTJqC37U9wfrsZ0ZF2y
         JoqYmdJ3IwnqKut8bWumMErFzuUMbmDeWndcu0Tcu75WVZNwn/2ufunJOCGEM3gWN6rK
         V6SZYQxb2GtFGu+YsE00QeuoMpDGsGHO75Rp5xV0C+hg3DeXYNkR9PhnaCfb1PujZsHi
         cyiSSlZCnSafYYRZFADwNeeQxSF5Gp63whOsXDmCgakq8eNVRn/VX+QM1Aio3sAxP7/F
         VpZRUTomxv2YuG1deMUgLVURtbAnwjAcKTgBm/PerFOgPXThOREhwEFPUEWNcNDFQXIx
         GIjQ==
X-Gm-Message-State: AGRZ1gJeTvvEvZ2/dCAZsVnFzUzMy7QLBSkbywIWWcGG5ujd8IouUxI6
        HEwx3tbob2VnT2CZK+NZPQyrnd67
X-Google-Smtp-Source: AJdET5flfvpmITeRI0CN+0jXWJicc8yfM7n9Z8oXY96bjRI88b2uRASEPrwo4feew0KOChBD/Nmm8w==
X-Received: by 2002:a63:314c:: with SMTP id x73mr969708pgx.323.1540947617299;
        Tue, 30 Oct 2018 18:00:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id f18-v6sm28077177pfh.0.2018.10.30.18.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 18:00:16 -0700 (PDT)
Subject: Re: [PATCH 08/16] blk-mq: separate number of hardware queues from
 nr_cpu_ids
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-9-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cebad07c-99eb-ebe6-07f0-d420fd467e06@grimberg.me>
Date:   Tue, 30 Oct 2018 18:00:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-9-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
