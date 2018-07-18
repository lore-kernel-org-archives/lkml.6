Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5D5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C3E2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRYHnT/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C3E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbeGRB4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:56:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33167 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730380AbeGRB4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:56:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so1211383pgv.0;
        Tue, 17 Jul 2018 18:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VBxhpQow1WPKNgPc2nwR4xEgmdtDWHGFweN/ds2arvY=;
        b=oRYHnT/Ek0AOeQzWr9tju72LUZSZkmQRBlZan9Gs6z0W4Wwt9GnQozUzqesbxeyjhz
         zUQLX+HVrmbRv3mYr35JqIAayY57H6sCynP1fSI4+klJlcD4Y/0Zo1dYJDTe5OpKpf6z
         4FJvokXfzPpvXQRXmRFOfW5ngDjx6zAz/OxsK/nzSg0dLXa/j9qEcZU0BxwU4EOVafwz
         30AS8yVTHbsDjaZIz0EONjUo9CNgMDFVnKD4C0L4+qD81p09hMtBu4TcbFowOPdnZthK
         f/bOLAnZelx3cIMmJB3Lbk1/l4iDHITNTjebwDKBaKkPmGxS3fS8lexW2gOLkuljkw72
         x9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VBxhpQow1WPKNgPc2nwR4xEgmdtDWHGFweN/ds2arvY=;
        b=TIsbciFJXE4ZcEFmqnQ1BFB8L7RpVPvJ4+f0CgWVoK8R8/kSm1Q3l0Q7kytgwF9umE
         DtruRUTfcPCuVrHYxBjLXFWuWK1ag6+kRBSzOnpfaSLy7ZBwQrnj/9MXJGCwFtxpq2Pw
         OKeHRUgTDl4PI3wtxvLMPms0/BaynptrzE4IzGF8U0yvnR0fGeBcZi6ezI+q06e85WXn
         2/WpKd1p8HJbMoHk/wuim5i5VBKojbJ58rnDvzywg78pwskt2sfUyySM0BP67TWp5CD9
         QVkxvG6+MOkpYyOAQ/UW7HEfV5dZURJZJIHy4QntmpXGQ7c2cOQgrl+vBlsbXkK4qGoE
         +bcg==
X-Gm-Message-State: AOUpUlEGDmJNMpmqMOkcWtinhAbbOEq/yAGLIjb7TlQ4Yk2djEo/WiUw
        LTHLIxXTzkSbYr0dU8EhBDk=
X-Google-Smtp-Source: AAOMgpcytHFm3JDHFmQX81x8StjbfyXDO61PjihKzQ340a+YP6w5ILfa5kl7OHmlZwumwY+IgCjIGw==
X-Received: by 2002:a65:41c6:: with SMTP id b6-v6mr3704977pgq.174.1531876854151;
        Tue, 17 Jul 2018 18:20:54 -0700 (PDT)
Received: from [192.168.88.47] ([107.241.92.73])
        by smtp.gmail.com with ESMTPSA id o72-v6sm3614589pfk.76.2018.07.17.18.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 18:20:53 -0700 (PDT)
Subject: Re: [PATCH net-next 0/3] tcp: improve setsockopt() TCP_USER_TIMEOUT
 accuracy
To:     Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc:     edumazet@google.com, eric.dumazet@gmail.com, ncardwell@google.com,
        David.Laight@aculab.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
References: <20180718004639.30154-1-jmaxwell37@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <5aafc511-15a1-da3c-19f8-cc8b658f9c3d@gmail.com>
Date:   Tue, 17 Jul 2018 18:20:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180718004639.30154-1-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/17/2018 05:46 PM, Jon Maxwell wrote:
> Based on:
> 
> https://patchwork.kernel.org/patch/10516195/
> 

I must confess I am lost with your submissions.

Patchwork is also lost ( https://patchwork.ozlabs.org/project/netdev/list/ )

Are you really using git format-patch ?

Normally all the patches should have a common [PATCH Vx net-next] string

git format-patch -o ../output --cover-letter --subject-prefix "PATCH V3 net-next" HEAD~3


