Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331AAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96C32083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C8UUzVHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96C32083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeJPWfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:35:52 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:50921 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPWfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:35:52 -0400
Received: by mail-it1-f181.google.com with SMTP id k206-v6so27356543ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EjXo5QGpKawGStlNQE4itapExiS6VjB4JIjFjFQnM7s=;
        b=C8UUzVHtr2GYiEkrdTHcO1rAGNeB3ezVeAbgxmfCPVKYlcO/uuAuUzNuS1qAxoRbmr
         VnpilIHuDY6UQ1s6BLJmhz52W4gyDmrQfy7wEx86Zx/daff1cwRsJnKF1s18xzmIQZBn
         EyKucu3FDJOHPPY73WfAxllMRxvoSNQ4aSqnb61Qge0by4+q1pWr9wDD03ce7LeuL3c+
         yE0tZCCGmN4CY1tgxsS4bRkScK2OECMZ2k7qyEqTIRLSkwMgvvB2BihFWtS/IzbQnz2f
         0F632j+QZIVXInP44AQzISUyErg6nxSHJG3zHHG0qZT1Twh3YK29dAd9odno6zGClr9q
         heHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EjXo5QGpKawGStlNQE4itapExiS6VjB4JIjFjFQnM7s=;
        b=NOGAI5oTrAHblKvYsGZm8AFIWC+tNs5+wwqwJuMdBucKx+EkHZpH/fWb5x4+FzKUMB
         MPyfm2AISHqSd7C3JkRBTx3Vo3VxU5AtC+n+hhw+G4K3LYinHm+iL0rgAoj7QOh2EvW7
         qsphwuFoQslIZLTNptKlRa0zJHZ/oVmwk9egCkiFoMRiK4xp8fs1k6NA9rz1w2pgg9RF
         SRkkYOeGGjeAyI02rjTCcAOwPqevqSUdQdH4t8/2QCw4WfnDCMR7HKs6G7R+Xeq2V3Bo
         R5NToAPAP1212Czt+To99UWgzYKZKIFClJoSIgU3nf4L52EqvEIfU+pjhvc+k8lBzN75
         p6zw==
X-Gm-Message-State: ABuFfohRKfNLpn+5N15OTnWRmNPT81XQdPPEYAp57z9CE/POKzTerfpi
        Jv6oY5CTCZ/kyy5joTXyJlaC+M+Asd0=
X-Google-Smtp-Source: ACcGV62UoZnOv5JaeGE9Q6K7zObByGyvTpqFx7S1Xm847/UAD/cq24FHACVXVwrp1I6rWJD0FBSR1A==
X-Received: by 2002:a24:1cc7:: with SMTP id c190-v6mr17624522itc.30.1539701104407;
        Tue, 16 Oct 2018 07:45:04 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6-v6sm3124766iom.45.2018.10.16.07.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 07:45:02 -0700 (PDT)
Subject: Re: [PATCH] block: fix comments about choosing request list
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org
References: <153968002141.396220.12979757828960821275.stgit@buzz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f5b7f16-b4cd-7c8f-519f-7ddbbea1ba41@kernel.dk>
Date:   Tue, 16 Oct 2018 08:45:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <153968002141.396220.12979757828960821275.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/18 2:53 AM, Konstantin Khlebnikov wrote:
> Request list is determined by blk_get_rl() and without queue_lock.

This code is going away shortly, so let's just leave the comment
alone.

-- 
Jens Axboe

