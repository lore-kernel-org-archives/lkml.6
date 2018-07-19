Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D313C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9E22084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKZ/P0uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9E22084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeGSOQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:16:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44667 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731780AbeGSOQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:16:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so3778517pgp.11;
        Thu, 19 Jul 2018 06:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hzm3tTtEyG950qHxGDtVD1907MYzH2eh6zPjGlfusMU=;
        b=fKZ/P0ujYZx5Xodt1/0mQWhU51PYCk/DDoxaJs7lqQNTvO4WtyDN7KqvSA5ennZ6jk
         SoFvCd8qGQ/QIWw2W/8/ps/KFEcWeBBBzfYT94ePAUdueqfdX7brTjJZLQrvDgf4A2q3
         YN8PgiYlihw0LbkCv3GqiT1uCDKY+vcbbX+H/QuiDSSOJaG7THkaXMDX0/pfX11MATHa
         hb1nFeK6ZUtlceYXpXelb2b+xhqTW3XGUGWBdTSqzXN2D8y8fkx9BKRh+mZeN2o2IxaV
         d91NDmjeVuyRVb7LYucdro+iZgUAhhUJFrCzSC+O6gBxguJWxjlk6Y0NnDkjhzAAA7lt
         0nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hzm3tTtEyG950qHxGDtVD1907MYzH2eh6zPjGlfusMU=;
        b=uLoii+ht3Mx9lMDLcivLA9Y5cJqyBsNjJfev47jU3ZPgdYVEAHsHAppd8IngJVSfTD
         bvQTjUdzVbnuCA7OvPecsDDKRrJAH8Ysw+iyTXUzBP8sjMEE3ANeX6Hh5jlY99o5dtKH
         Xb2+XrdBl9MxKr/1bltyGUOdLXt3nXS6awmqd5m104khK2gkTGfALzVk14vXjDDfKiuY
         KwiGYzUcU7iG8JDzlZkuWOBOmvGVCB34l9FpGpFbo0Z10YAy5VedmwTXdwpLbAe33afO
         7eRh/lGbyvV6FHvK7Y/ifncMpnSSU6uH49t1kJlkNmSy6H65w+KnRRTPaa8RcLIF83TS
         Ca+w==
X-Gm-Message-State: AOUpUlF3BsF4bvwQu6VRk84sfPd8CJRpv1SZshk4+jBlubN0TbT0uonl
        8KDwCJuXgLlwBk1/J7nM2sQ=
X-Google-Smtp-Source: AAOMgpc0hqchnXTthj0N3sheIJAYtzRXtqcIOIh3uoF620FUYIT1SN3JWDnVgkiwGAUjhK7MTzto/Q==
X-Received: by 2002:aa7:82c3:: with SMTP id f3-v6mr9581917pfn.136.1532007204662;
        Thu, 19 Jul 2018 06:33:24 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id u8-v6sm9955717pfl.105.2018.07.19.06.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:33:23 -0700 (PDT)
Subject: Re: [PATCH V4 net-next 1/3] tcp: convert icsk_user_timeout from
 jiffies to msecs
To:     Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
References: <20180719011444.4694-2-jmaxwell37@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <8a9af363-9bb2-7193-f647-a73c28949ded@gmail.com>
Date:   Thu, 19 Jul 2018 06:33:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180719011444.4694-2-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/18/2018 06:14 PM, Jon Maxwell wrote:
> This is a preparatory commit. Part of this series that improves the
> socket TCP_USER_TIMEOUT option accuracy. Implement Eric Dumazets idea
> to convert icsk->icsk_user_timeout from jiffies to msecs. To eliminate
> the msecs_to_jiffies() and jiffies_to_msecs() dance in future.
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>

Signed-off-by: Eric Dumazet <edumazet@google.com>

