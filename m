Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512B8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0612720836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="HF6rufrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0612720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935787AbeFRUby (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:31:54 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33565 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755346AbeFRUbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:31:52 -0400
Received: by mail-qt0-f193.google.com with SMTP id l10-v6so16432723qtj.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=2lXC4WJBfVFA+FhJbwWLHdluijXhyi1PZxJro0/JS4M=;
        b=HF6rufrF/KAoncSZD4jcRCh+/PURUsVd3HBBM4R5SUFc5ApoZ7OEKxZ3hM9RoFgwHa
         rKiqW/cte+L/6i1R97Ps15yIpzatbzrZSzY5UIiYel5sMgUJa9yx2lSWohUW4lKCPcwQ
         Ik8DSZyJ0rIuDVJw67PCFmGxezFkeojZH+2YKhQrH2FK6G0HYz7VRCArPdZUpDlzaQLR
         j/NOm8yfHLm/VS+XaqbJgMft9ht3BhfSAVzJqXaNuUOHFIN2gFYQWrCArCTqDa3crzaf
         kHrowi97MGQbV2CqAIidR/snzYZvoCEVy45RWk9bbn8mD0YTL7cSeJD1Io/TK9H/OEo6
         nYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=2lXC4WJBfVFA+FhJbwWLHdluijXhyi1PZxJro0/JS4M=;
        b=ekg0SIV4LlVqDeSyZIdKc2nWld1LJPWMRbDpFgMIZ8ervhhelwUkVArzPi08zAGBif
         TFGnUB3M7o/eGInk98uSZDeH/aaoTe64x4vH6H28qijmxavcUe8+GfNH4y8siPIk+HSm
         Bv0ICo9k5r3EwTV456nq1ITfYG+S/uuSQo124r797oebdWAxlO2lOKh9uRJg+1o0LmSU
         e5W4mDjDw8A7CAOckv0ywTAWP7NMrDcjkimDkboEnycmw6QggmM6nfz+IFejLDtuHxBi
         iPlh0/W0wTSPZrTCL78dTQobpOW1oJdTzvlHq7Dh7i5O3cQtXXDlFdnZtvfB6SPj2GeS
         S4vw==
X-Gm-Message-State: APt69E0D8zN7xZ0ZbWlHRqzMs9NwTqdjKfPlVilwD4p9qRJwBKZClSDZ
        dHqQH5z6wAA+LLTT7aYeP2VYbA==
X-Google-Smtp-Source: ADUXVKKdz9OeSabrLZ5QJmbElSl1281K1jgUXn+4SIVVhm/1ozv7zWVi4f18XOcqa314I8FZFiR1Iw==
X-Received: by 2002:aed:230e:: with SMTP id h14-v6mr12455947qtc.69.1529353911833;
        Mon, 18 Jun 2018 13:31:51 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id r25-v6sm12179295qtc.39.2018.06.18.13.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 13:31:51 -0700 (PDT)
Date:   Mon, 18 Jun 2018 13:31:47 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>, y2038@lists.linaro.org,
        Simon Horman <simon.horman@netronome.com>,
        John Hurley <john.hurley@netronome.com>,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] nfp: avoid using getnstimeofday64()
Message-ID: <20180618133147.30a9896f@cakuba.netronome.com>
In-Reply-To: <20180618152051.1510142-1-arnd@arndb.de>
References: <20180618152051.1510142-1-arnd@arndb.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 17:20:17 +0200, Arnd Bergmann wrote:
> getnstimeofday64 is deprecated in favor of the ktime_get() family of
> functions. The direct replacement would be ktime_get_real_ts64(),
> but I'm picking the basic ktime_get() instead:
> 
> - using a ktime_t simplifies the code compared to timespec64
> - using monotonic time instead of real time avoids issues caused
>   by a concurrent settimeofday() or during a leap second adjustment.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thank you!
