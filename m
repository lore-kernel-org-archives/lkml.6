Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ABFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A169F2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5DHOKH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A169F2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935873AbeFRS1D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:27:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41016 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935689AbeFRS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:27:02 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so7910643pgl.8;
        Mon, 18 Jun 2018 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4yU6fGTFpp8XBxWx560TW77s0tEC6FtRefElcU+PH/Y=;
        b=u5DHOKH2jfyMqOoQaTOVKq+SeoebzUbioX87TQQdo8csCUYmfwwwJWPZC4LmyGebcy
         lPbjwtJwVlaD80FCKfuOV6rJGDlAIin4nYYmwVLnOaYPJiBn6R7nxCsyVYjeugpNZ1TY
         DE6KbjTG0mm9SlWUNSIP2YDerFvuTlhKnHM71tgQJWiYqFxBjJHsTp7RWjzCXZrOOChG
         yRjj0Nhc5U6eDhw3VBNMEDBpslCsQ9ZnUYw4ob7LTHYK26beTMtKE7DxcMorJS0ysYuB
         phMBd5m+Q3i9rre37+nKL9Zhki54QaHS9JRNOEqjGiSHoDEEwhDQSfM+Ba7QktpwiJ4T
         gHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4yU6fGTFpp8XBxWx560TW77s0tEC6FtRefElcU+PH/Y=;
        b=ZEYZ7Xk42k1LfEuj3RJQYjrvix0ann0Nj+BJ0gLK8iixuGaL5TjLLfFOQlnOcWqsBe
         BAfbIerh3h/qF399mddBSBqqY1GZk9fw0jbgFpGKdzUdmXyijo+OUBviV7qvl+fm1Jp5
         qfHTOnH6K3w4Z/pywEFaC/ETbYk8dLah42et3laZEkRYBB+Xivsvgib6Faa/nJ10BC12
         v6OjgjvXX6lk/2IFh0QBEJapCdBZLbPRWurz4XRvkWjZP90RAXlOcQSKk4bE2FXNzn0R
         byP154C7iKIUPZ5Tr31NRRcd4sSO0Cq7eW/KJravBTzHi1jiv2GLhVDeKRxkkANmSXgZ
         nrhg==
X-Gm-Message-State: APt69E1beb/mzhhXf1GhlNTlIVFD0RWkSIRC2B5ANS/m2x5MZoFLCWul
        H/WbFF9AKo846+Mi3ZoMor4=
X-Google-Smtp-Source: ADUXVKLXeaVFQ6lc9yxoD6nk6dNfRQaKUU6YQ0A0sLVkNgJpIIk1RN6Yv4/As4yIUULWcSWBcrLN3w==
X-Received: by 2002:a62:6710:: with SMTP id b16-v6mr14793182pfc.37.1529346421623;
        Mon, 18 Jun 2018 11:27:01 -0700 (PDT)
Received: from localhost (c-24-4-232-150.hsd1.ca.comcast.net. [24.4.232.150])
        by smtp.gmail.com with ESMTPSA id x72-v6sm29110121pff.176.2018.06.18.11.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 11:27:00 -0700 (PDT)
Date:   Mon, 18 Jun 2018 11:26:58 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>, y2038@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <fabio.estevam@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: replace getnstimeofday64() with
 ktime_get_real_ts64()
Message-ID: <20180618182658.dctq7t6a2ybnerl3@localhost>
References: <20180618142109.3445025-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618142109.3445025-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:20:39PM +0200, Arnd Bergmann wrote:
> getnstimeofday64() is deprecated and getting replaced throughout
> the kernel with ktime_get_*() based helpers for a more consistent
> interface.
> 
> The two functions do the exact same thing, so this is just
> a cosmetic change.

Acked-by: Richard Cochran <richardcochran@gmail.com>
