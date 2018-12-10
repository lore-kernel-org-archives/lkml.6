Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A793DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A7220851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="eVN1X4N8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A7220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeLJOwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:52:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35808 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbeLJOwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:52:40 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so8188438lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 06:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IdP5vSYGRxOvKWpLRYCIqT64X2K3j4BQgTZmrMeh1Wo=;
        b=eVN1X4N8sPeu3w8RgtyCe/pesrimy5v9mlsRhtMxhldsQ6Ep9pjuuijMM4dEXcrwiy
         l4p+YW0/qzHWY6xxmnIYTIYy3w9EXr5qb9JYf7t58HWTsUYs1xgAyro08SNInPttk+6Y
         VP8NmJYEpXTD+XMi4Ba/ND/4kd3rkPjrVCvvTefL0KoSnVcCp1PUH/E1r9tMj+jRjFld
         z42AVrN/QheVzu0OYhm1WExbYcKTVCUPKALOWJbOgTkizFvyNHql1u5s+/5JETLTgcqp
         +/rzx8Dxvl4aYCl5I2TOvKelgrgDX2wUrnVwpT2HWtmUCBiMWMZ8CItEZOeoXgGmv8Ix
         X5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IdP5vSYGRxOvKWpLRYCIqT64X2K3j4BQgTZmrMeh1Wo=;
        b=YxYTZPNALnIgvibkdAylpBDKemeJCTkhWs7pALR2N0dGqQwaCyYvEQKZ1FL1MkgTRt
         CcpkoJeOqcg6hIKWpBAcj/Vny6GfES5QQNk/rz0mknov91PkIRLaRSl3rgxkHi1Vjhus
         GTXmvohLXZdvtmiYeNKhRkAFOmYc8QbQoRHaFcl0MXeZJ9UstPNuZj9c9Bq0CuP0iudo
         0hbGNbdS34WMtzxSVmcdfgbRvKE8/4jGcnxl1CM3I6QcOsFTBZUTwQ7crTC2u5ojo/ms
         +Upb9P4UFFbdDzxCGN64Mw7yN/7BpQJq/617amZtWqBFj9lY+qL54sI5JcMKePOVkEZ3
         o3cA==
X-Gm-Message-State: AA+aEWbN+Xe/NbVLZ2uk1Ej8IUNEyhQ1ybMbgimrlG/t3sT4zvKmX4o0
        qhQ7aKEoBZpyDMUF2gbMiZBlMr9xQRw=
X-Google-Smtp-Source: AFSGD/V2zQ6B6lSXXW2t5iqFgsXTmgxCr4BmB9o5TvCfhu0WWCNRwmMphsp+8IkbgTcvXXztwkJHQg==
X-Received: by 2002:a19:5154:: with SMTP id f81mr7424246lfb.96.1544453558113;
        Mon, 10 Dec 2018 06:52:38 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.98])
        by smtp.gmail.com with ESMTPSA id m4-v6sm2171292ljb.58.2018.12.10.06.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 06:52:37 -0800 (PST)
Subject: Re: [PATCH] ata: pata_oldpiix: Add missing device ID for
 INTEL_82371AB
To:     Corentin Labbe <clabbe@baylibre.com>, axboe@kernel.dk,
        b.zolnierkie@samsung.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
Date:   Mon, 10 Dec 2018 17:52:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/10/2018 04:46 PM, Corentin Labbe wrote:

> When playing with a virtual SPARC machine with qemu, I found that the
> IDE emulated device was not probing with the ata/pata_oldpiix driver.

   Correctly, it should probe with ata_piix,

> But with the old ide/piix, it was probed.> 
> This is due to this PCI devid was not migrated from the old ide/piix.

   It wasn't on purpose -- the IDE driver supports the original PIIX
incorrectly.

> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

   NAK.

MBR, Sergei
