Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77236C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 12:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3122084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 12:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXdwW+dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbeLOM7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 07:59:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34652 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeLOM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 07:59:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so1136557wmd.1;
        Sat, 15 Dec 2018 04:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cgxfQXsOEMc8qLGQOyyltNvcjB/vGVVeo/vq8a9rOpA=;
        b=XXdwW+dYdtvZhcdEA8qLZwU5Z4+NKXTdDm4+pNyl/b8Xt1J2Y8f8ZzyGhUUGFNo0kz
         acd3R6bi3cDoKvl4SPtF4LGK/vgK0Dw7cSXKNZXD6Kq074wxtofCp4592qfX2KxlJvsF
         ikaKXpZkMxE4DfeUhyTvct7nxVm/AG8CKTsjbvzdLdqtK4HJHlUEhDaS1dFqfMXfQ8GP
         fYu/sOzC/kp2XA3EbHC9JZzA1gLhlkPXVhxtuo9RIfJh3f5CDbNhiHGgPyA/eQ3SFjrq
         Lx6VwE/cLoWZwKL7ccVmJ/LGY1rS/Gmuu+NO4WDeNXYoBIr61lrzUz3ZtM4tcps7iWdB
         Esrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgxfQXsOEMc8qLGQOyyltNvcjB/vGVVeo/vq8a9rOpA=;
        b=d9aVSx4MfXSRZfpOEpWyTk2s3d1bx/rzrS22X0kUg3TF2Pn8rKbYnG8z5yuD0BLOEs
         plVDJCGdsrEW0A7VqHpD0XBQRAUivsFMkVzvplsEDaUIEwpA6zsyMaVGrgX1XYm/gG2E
         lFCpr2BuNil6tdC7F6KiEphKB7+nmQr10KW3UV1i2kFAFKZPm8qjAJA235mTfSbEJkI4
         qMmcyLbqygAJRMUcqL5WddMz7TQwd7MsFU1ZbNc3u9O5ZVGoZWnHm6fVdJYL5845S7yq
         f2bK8k1pKwb1Aw1vyzJOSrWX+Lq8eVlmDRYhELxSW8qHzzP9yW/NtYJ17YwrWDgn62fZ
         tW2g==
X-Gm-Message-State: AA+aEWb1D+nEnPdCPfmwL4e4qk3ugq4vWCkPUZtur+flueXDvKmtsc2Y
        nFTrmgvO2Iz68N7uMzR9peCRaQZP
X-Google-Smtp-Source: AFSGD/VR68SsxQgqFd92TYQnIcATa8wo27u0u2ToX/kIUp1Z0QzrCQHtGcsSuz7bw2N1h0TaHOa7dw==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr6236924wmi.58.1544878744003;
        Sat, 15 Dec 2018 04:59:04 -0800 (PST)
Received: from [192.168.8.147] (48.42.136.77.rev.sfr.net. [77.136.42.48])
        by smtp.gmail.com with ESMTPSA id l197sm21650000wma.44.2018.12.15.04.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 04:59:02 -0800 (PST)
Subject: Re: [PATCH net-next] tcp: minor optimization for calculating
 packets_out in tcp connect
To:     Yafang Shao <laoar.shao@gmail.com>, edumazet@google.com,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1544866389-11168-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <48971720-96e1-a48f-a1f5-3a96aa3fae7a@gmail.com>
Date:   Sat, 15 Dec 2018 04:59:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1544866389-11168-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/2018 01:33 AM, Yafang Shao wrote:
> When we building a syn packet, the tcp_skb_pcount(skb) is always 1,
> which is set in tcp_init_nondata_skb().
> Regarding the syn_data, it is set through
> memcpy(syn_data->cb, syn->cb, sizeof(syn->cb)),
> which is always 1 as well.
> 
> So we don't need to use tcp_skb_pcount(skb), that could give us a
> little improvement.
>

I dunno, I find current code more self-documented.

This is not fast path, so I would suggest we keep it.

Thanks.

