Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAECECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F226A2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JW+vjphJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F226A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeIOAWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:22:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55333 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeIOAWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:22:20 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so3976089itj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mQFPS94BnKD57gUiTfyHX78cEwS1VVYuF5uvjetV0bM=;
        b=JW+vjphJxMlZ9PcGD2weKveYvm1yVcRLD+Kml21wN2Yk2Hu6cFZUpKQ32xFYK2Gzl/
         dDACLJZZGc1GHlVxHR66Oqw3PGwo4R0rwRlVWOIk9/IMkn2lXXRgRMAs3xlDMaSe3G1e
         1hW9zfbiOxyYTGo3Dv0n9HWjI6bfAzAulGhqRVFXSQ8AaNVgQrf0p4gOgIQ6A7n3IO23
         D/WWtRGJXcBnTkZ5/oZJYk8V3UIuuSCE8tBYtUfJ/NNBZSMMiKQVLBHvWwYOpzVDF9Bf
         oXNH4wfhsVeJU2lNderS/lCgfGrSIsJd41hcou7FPzL8WVg4buz/3pZEfzJaHhOg5z6w
         bq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQFPS94BnKD57gUiTfyHX78cEwS1VVYuF5uvjetV0bM=;
        b=GzsAH32J1/wAe28Nz332aL2lTxMlYUYCthRn2TISXWCcAHGt5KpPneuR2n3TJKzRhq
         o21SW3OHkP4al2ij4kxQ2USwQY6+BydvUmz7yqrKw0oF0NRc/E0X8kpaF/tilNs0DVS2
         xSHJB2UnWmaSyyRoRnRKxX70mde1lRr/LaCeRBSyY2h9FI1RJMT0UJTuJPT/pfOANSD4
         0UF1M9jPIaXAi+AI+TvWwWabhfOWooosHLrJnN/haJ03Tx79x76oPvT0l+IqCeysQN33
         CRgbd9uU8BvkjcXAuvtVtDuQvS0F6I2ip/Woo+WNxw3qt/yowGuIi6lPqKNwb+dhh2Db
         F8Dg==
X-Gm-Message-State: APzg51BxdLf3nV6rrUwiZKJSM4ZFuhfyevBnnQ1aWNJ1A9+tvRtrzzwP
        o9oY42Xo1TGD6sp+65E6ffHnsQ==
X-Google-Smtp-Source: ANB0VdZtFhUSzYs8MBGFkrJ5FSwyBdZbQZuMOBIumhq5n6Pxg0XqHDxt25CGJpdgHNgQB8BvYrDHlg==
X-Received: by 2002:a24:ecc1:: with SMTP id g184-v6mr2595791ith.79.1536951991318;
        Fri, 14 Sep 2018 12:06:31 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v14-v6sm2762047iog.42.2018.09.14.12.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 12:06:30 -0700 (PDT)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/3] bfq: one fix and two important
 improvements for throughput
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
References: <20180914142309.6789-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bb31b362-53a9-483f-381f-1fcf0dad32bd@kernel.dk>
Date:   Fri, 14 Sep 2018 13:06:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180914142309.6789-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/18 8:23 AM, Paolo Valente wrote:
> Hi Jens,
> the second and third patch in this series provide two important
> improvements in bfq's ability to boost throughput with random I/O. The
> benefits of the second patch concern I/O control, and are described in
> detail in this LWN article [1] (and briefly in the commit message
> itself). The benefits of the other patch should be
> straightforward. Finally, the first patch fixes an I/O-control bug,
> found while making the second patch.
> 
> These patches modify somehow core operations of bfq, so, before
> submitting them, I have tested them a lot, and have had them tested by
> other people too. In particular, during these months, they have been
> tested in systems ranging from PCs to development platforms.

Applied for 4.20, thanks Paolo.

-- 
Jens Axboe

