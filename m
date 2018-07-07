Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACE5C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 22:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF97208A6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 22:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvFuKmbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF97208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754375AbeGGWen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 18:34:43 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44830 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754246AbeGGWel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 18:34:41 -0400
Received: by mail-pl0-f66.google.com with SMTP id m16-v6so4378936pls.11;
        Sat, 07 Jul 2018 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PEac0MYViHhiYZmXYJjKdxTcrw1fGd4+eTzDbln7cOw=;
        b=SvFuKmbwUROSEt4oZT41MtsX9bV8BtpQc2icBJU6DG3X2Dp+m8T1FCVqbQ34M5HczL
         nQ6gApR9w8DOPey0QE0Zoil5cxUozB/M5/e4kJ7v0tAB0PTenNkJPnQENXzMVvcXSuC9
         GQbWkcll4wUKLBqSdzhJvK4XRRBHGyHQM/5v5FQbSmeo6wXo4B96oHaT+QrGANFkmCLd
         MhIBEB8zvF72XSlnEov/zk+hc/1H7dx7XnX4kmzGh2NkEPlBSNqCq+MbG819cYa6fvkQ
         jRbcc7ybmDVifzX3nROn8Ukxs7w/tr0LzbWM7JgdQqVRCZwnaPZ67P43bBBwov7o0jYk
         Zz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PEac0MYViHhiYZmXYJjKdxTcrw1fGd4+eTzDbln7cOw=;
        b=H4h2KlTZUkiFu9LykgcWhstHsVFX84vfmKEnrN+iOYlyWbdE60d+L1kFOi4cjI5bIj
         hiBYOf8UZoTmx9lShK8UGy0D0jJ6Od2qDfyhT1UXn2rX33wUHsqtAXplXi08/zykLFtn
         QWw53bGXiLozv1SunSdqxPnhxvUxwPXgJNmXwPT+kWeY2CgU7WAP66LIeTS5/I7gTqQt
         Rq3gwNFzHgKeQ4VGQ4UYLUQaSHqq4ejdW1ouSN4UJCZ4BU9Xd+CYmlc+Y01VC5k7XyWW
         KABrT7o0NeHKJnXdmw56XRRFhRUyZ4cKlppyXJjxZwrXpTXgZ+OzSA6ILSTvizmD8U7m
         BB+A==
X-Gm-Message-State: APt69E0K/tKHiQ+QJaXTc6kO3G59Bw3d/QV7YHUTATaCD9wrMdshRlc/
        HyYz0ym7OFI90B5nNiDm2SJmpsij
X-Google-Smtp-Source: AAOMgpe/amcDx85wpEPLgzL9o2Yyo4C/DSBY58OHH+N6UHD0Ez4AvyuvZ6yUpQ1sgDZZcSnMx/JnEw==
X-Received: by 2002:a17:902:7044:: with SMTP id h4-v6mr9972019plt.179.1531002881248;
        Sat, 07 Jul 2018 15:34:41 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id n18-v6sm23808569pfa.50.2018.07.07.15.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 15:34:40 -0700 (PDT)
Subject: Re: [PATCH] move smp_rmb() after load of status
To:     humbabek <humbabek@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Maloney <maloney@google.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180707192319.24771-1-humbabek@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <5e5dfd01-bad6-55b0-cfd1-75f7ec769e89@gmail.com>
Date:   Sat, 7 Jul 2018 15:34:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180707192319.24771-1-humbabek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2018 12:23 PM, humbabek wrote:
> Signed-off-by: humbabek <humbabek@gmail.com>
> ---
>

No changelog ?

No comment added explaining why this smp_rmb() move is needed ?
(ie where is the opposite smp_wmb() )

Share with us your thoughts and reasoning, please.
