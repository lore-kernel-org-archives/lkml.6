Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC35F2550D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bqaRd6eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC35F2550D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeGBO1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:27:16 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:43022 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752379AbeGBO1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:27:12 -0400
Received: by mail-io0-f177.google.com with SMTP id i23-v6so14878185iog.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oftp/yPYsRlcrHYbzLb64HqjRl/rJz9w0qJyfodxUUA=;
        b=bqaRd6eqIJReg9P4F6FObIfJcz7ovE4RFLDR4fY97M+ZP1pgxKopgYBDvUSxCmjkFT
         zz5tVKzX7yrcF4GL/rMPfZ1Wn1NMaKa35ueSMpeWI0jX10lWQr5bG9II1CsspeCkOjCm
         K3vkMkL2SxhvpsHFzf4g1kEvnNO5iEv8Asv35y0bJX5j7Jv6Yz3SgiQqrCiPJ8ZzOsjL
         2QBC5yM4J3lDhux+y2GzAg6z+bCUs+v3Zzwph66X6LJDg5QE8dT4Ng74WoujGNtA0KaM
         /Lhkjn1Wxk4WgdqBryx5iSnWyRkpZcNWlyGyxpkF7XyaBUW8XnpLdsqG7vOxKn0zrhDz
         T8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oftp/yPYsRlcrHYbzLb64HqjRl/rJz9w0qJyfodxUUA=;
        b=lvboINXIWRiHc8stai9oIjao0BTpeKk+RZiGM2AXZ+lVqKGWmkkzVwt9l8fq9A9PCI
         YL9qfhpvM2dYvpQdqx6ylm92vRa8tIeMJ/RSlov5YEjibVkXhmBmsl1A5+DrMhChzVom
         pksxKpAl8QkA0Yel8lCaMB/C6g9h+adsqBz8U1tPDK/aJIU6VHgM/opwGoHRZ2GNdona
         GCmTHxuYIyGIEXXrwpz93HfaUa8Xonh1CK6xALkrX7+8lPFxjhEcVEACVhAyjQjH96Qa
         uQQFOPKuTjYSl1zYLvVu+mGJpCG4WOUx3f1Y32Oq4Mtpage4z/BGbwh0yW05qyMnG9gf
         zCdw==
X-Gm-Message-State: APt69E39+GU8ZGnQNxOWKZau3BPMMy/55sjbNvNqhSxK0We/Z44hpLyB
        SXDyyziGx4jVw6vtLXJYGefpOlGbqfg=
X-Google-Smtp-Source: AAOMgpcK3C547r/c39RQ4qYcmtTw7mVbXEhbwYUzYnPe+r0l0GIioOJruxwyhXep74ZrmD5KC9YLBA==
X-Received: by 2002:a6b:5112:: with SMTP id f18-v6mr21125562iob.245.1530541631546;
        Mon, 02 Jul 2018 07:27:11 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l19-v6sm7125537ioh.27.2018.07.02.07.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:27:10 -0700 (PDT)
Subject: Re: [PATCH] loop: remove redundant pointer inode
To:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702074706.10586-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1ab10ca5-4d2e-d95c-d1aa-3b510b874d2e@kernel.dk>
Date:   Mon, 2 Jul 2018 08:27:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180702074706.10586-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/18 1:47 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer inode is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'inode' set but not used [-Wunused-but-set-variable]

Applied for 4.19, thanks.

-- 
Jens Axboe

