Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8CCECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201272086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GzeFaaAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201272086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeKHWxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:53:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37597 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKHWxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:53:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id u13-v6so9298048pfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jUH1UJPG2LmCOHBMwz2uz3TvtjkaIvhOvncXdHTrb0A=;
        b=GzeFaaAKu3lqLAf6/x5mzs5wW9potKUX4e1PqhRi77mAXor7m1zPke5AVFWVfIZ2aE
         uD6br0n0KDNSslMDzsIL4lzQWGIjgPbq+vFDbCQNMfD8rBeaT7v1bUO20wJzDd/LGjNb
         9VC1DwojiUbj3JGqKunYbnqYkiyNYkAh6lEud4jlvF4390lwQv7xikX8xUV/4kJmTrHS
         +ZXJPV/dvVTzadZru49K0qAVtoOplfjPV63cR2LVTIZ0nh9TtL+jZhecUyJk3dr5ngxw
         iz5BSllqJs4tjHgfQRgMX0ERddFv9rPjZD5ju+JRYa9jmoz9/L91oJF5ZGrnmMaz18ug
         nX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUH1UJPG2LmCOHBMwz2uz3TvtjkaIvhOvncXdHTrb0A=;
        b=KAE5nu74kewb/q+/lgURzR0oXMy5ARyNQzcydzZ/+9O38YZkXYoTL6VfH9bS3owhqh
         BEEeA2FxBBoHDhkmpA4DIFEUBHzuml8N6btujQ3rFYvQxf90Eemki/aIxfp9l7JD1JHx
         phY+qZJh+iYHDNgPHwCxq0d3/t2k+YFpAi8HaS1ypJBCbVKj2kfcEXLwiRm3qxS/LtqZ
         ZJ/TZY+o4BS8buFgRAR9qHPGVwezdPUGe5AfgXLrKX0vN8SuzR8a2rlmJfOQRqwi8Kd9
         xtQVy/gUA9/aWSbbTtAx0P/hJ4f7UKEQN52h1NJe61hIsVdf8ZMrtDVdGLnSmBvoJsAv
         +MSw==
X-Gm-Message-State: AGRZ1gKbG80sDdRt/X2h6jrCKkx6NOUzdhNebG7k6zV5kqKaO5pyULbd
        dz3ascmzGAx6oS2j0BmvqnI0GQhlx2U=
X-Google-Smtp-Source: AJdET5ePAi2Xhacx8u3rCN40Icuf11NA0dOM9XgMXjcf/dk8Eo1LvyQHOYwywIZgY14gEPLcaZULAg==
X-Received: by 2002:a63:dc0c:: with SMTP id s12mr3796595pgg.398.1541683070429;
        Thu, 08 Nov 2018 05:17:50 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 73-v6sm1510121pfl.142.2018.11.08.05.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 05:17:49 -0800 (PST)
Subject: Re: [PATCH][next] ms_block: remove unused pointer 'set'
To:     Colin King <colin.king@canonical.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181108110809.2145-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <04ac11c4-9cbb-3d85-c26f-0fcd42fb4bb4@kernel.dk>
Date:   Thu, 8 Nov 2018 06:17:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108110809.2145-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 4:08 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'set' is declared but not used, remove it. Cleans up warning:
> 
> warning: unused variable ‘set’ [-Wunused-variable]

Thanks, applied.

-- 
Jens Axboe

