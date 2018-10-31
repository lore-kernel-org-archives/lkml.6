Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12A5C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDDA20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDDA20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeJaKyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:54:11 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:39707 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbeJaKyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:54:10 -0400
Received: by mail-pg1-f182.google.com with SMTP id r9-v6so6575269pgv.6;
        Tue, 30 Oct 2018 18:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=D5TMyc7PYQFv2cSJLqi/5BvLvMXgVPC9yf+Dg1gCRhnLTm8KlTYiQOCoEAeUvDZbLz
         v2zAo88sZAn+a5XOMLidW1EBAiK46yCtJwnHxjx6hQ1YoDtb4oO3Xo3Cr2wgfjXJoqmc
         FcSSPPHVH9cYRVMIEEezMBcbTlsJQmWUHWF7xLeDVPoFZEWL3hNRk6vf68GrvrX5qlD0
         VvQlD+YLJDyONaUEzjHp6HrwlEgdU8pq5K+S5zgEMcQj/Gc/VJIMki9xAeOqKgyM7OSb
         BvAHIBiQOpC8D2F8tsghZtabduP0ceQEPN+6gy2x2fYeRIdSdFjcMI1ujU+iYOXFFnDi
         vHDQ==
X-Gm-Message-State: AGRZ1gI5gr0CZuvhLY4jFlRubPbJNuVLUR2GZsa4i0OysPAi9TLbVD71
        5N8xcg5g6LDstkpRF71vrFBD0qbP
X-Google-Smtp-Source: AJdET5cdEs29Fhvo6tXEu3Osezfpi2gu1yMdxg+fQW7iVTjkomvX5KOn5shal/JYqSjyGkoi20bGRg==
X-Received: by 2002:a62:678a:: with SMTP id t10-v6mr1226276pfj.139.1540951095931;
        Tue, 30 Oct 2018 18:58:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id g123-v6sm55178483pfc.67.2018.10.30.18.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 18:58:15 -0700 (PDT)
Subject: Re: [PATCH 15/16] block: add REQ_HIPRI and inherit it from IOCB_HIPRI
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-16-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3137fca8-249c-38de-9a87-999909e8b235@grimberg.me>
Date:   Tue, 30 Oct 2018 18:58:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-16-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
