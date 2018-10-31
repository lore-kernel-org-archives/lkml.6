Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A31C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F62520664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F62520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbeJaJ7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:59:30 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:39212 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeJaJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:59:30 -0400
Received: by mail-pl1-f182.google.com with SMTP id b5-v6so5787847pla.6;
        Tue, 30 Oct 2018 18:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=iwdXbv8X0kxeWpuP+qjeNKI2Z2zWIR+OGrWB0no+flDnQFx/4wnJW7e4SNPPDEz/ZY
         MeI3j+sKusnkaCNgY7hAzGaXFOd1YDtiOxdG3k7ZtGf2/i9vGCSzpM/FOhCc67fTpU76
         31iEUGJWojINzKFy2WASAd51ZL6u2MJujam3e8M9Tvs4Me6mCN44br2UiC/wSIbr4RSy
         edW+jECWBlly5AsZTY+WytxvNDE4i2J/+gOnF9k2boy1nmU8Xy+uYi/iqbOR3zsLAd4h
         oO2UGNSibGQXf/ecIcI4ET/Y7PaVT8y1bWZHNrzXDYZJBhzMSg9oqRd3qZWGu5TiPY7F
         nZnA==
X-Gm-Message-State: AGRZ1gLZwpc8K0QTyIkPEUegD3ccOklEFYhGE+Hzb4Vi15jKY458QSSr
        WaEVaC+gD/1l5xYDnA99MB6e2uUM
X-Google-Smtp-Source: AJdET5ejHA4Pc4yldNJDcB4htnITRaqfK22g2mc59EHOeGnsgb5ukOjiPFvfpVDA1mne77OyOoHKpg==
X-Received: by 2002:a17:902:380c:: with SMTP id l12-v6mr1048012plc.37.1540947822746;
        Tue, 30 Oct 2018 18:03:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id f68-v6sm58804081pfe.143.2018.10.30.18.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 18:03:41 -0700 (PDT)
Subject: Re: [PATCH 10/16] blk-mq: cleanup and improve list insertion
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-11-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1e92bf67-a8ac-b812-d3a0-adc56ed27203@grimberg.me>
Date:   Tue, 30 Oct 2018 18:03:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-11-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
