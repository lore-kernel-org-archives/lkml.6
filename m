Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D935ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C50208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdekgNrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C50208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeGQF1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:27:03 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40501 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbeGQF1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:27:02 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so6885176plp.7;
        Mon, 16 Jul 2018 21:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P9dzCvtvkIK2UEEA+utpCb4pHzbuuFT8ApXfbGJ0kNA=;
        b=DdekgNrEGnzh9Y6yeOGQIldDdGSe7A/wNcc15vYwKdvF4rBAfomtlZuWSgUBZMCvij
         U/miCk5IjfZvArg5Z03koa2MNAwexzz6plUySNWNpTExe+wEo4CEPY8MV3SXidrPzao/
         FDJb9XkAPLav+oFohry62KQqF9058EsYHVIRpx/wflzL3ngHY6zH7u7vfja01j3W47Tu
         2U/15vP3y7eE47/2gmFs9lkd6UzMK2+XlerVEh2NFZlJT1ZdAzugaFvLvBb6HNJl6HqJ
         lmWLJDJCNBQ9DaMO4KPGRJqPAaaIboBBBrFDCytlHe98cUdoPQGVcFNEygUMQIEW3Zsc
         Pgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P9dzCvtvkIK2UEEA+utpCb4pHzbuuFT8ApXfbGJ0kNA=;
        b=pLJxZyr+2zDC+tQRkKjybP106ls4k0EDV1Li/fyB5BX6+/Ahny549guHkgEPUnLF+U
         4dWEc4hmxfsa8rE84UE89aRwLV5uSAWnIuNGDQOSuwZbIUlA4vKh+6HsU27wLd6AgwPF
         A57adiqIU61cjswPjQdTQ7hg8XhTCCCkcrLRHfVAXyaYtTkUzYqg99juSnpSMCQsic3S
         OubNn84+vrOk4OgmpHofhaqMFRS46akG//lJe5RFmKp/G2Cf4mY7sPKT98CTyQVPinM8
         eBsR9fYcjOPmKxKuYrNgDotUSPT46l7SRSd6VWEgaStDaBjqnkulYFY+IRAdglzXl/jF
         2aEQ==
X-Gm-Message-State: AOUpUlEEh1dbq897wvQXRG6ZT6qYRqATEcRU6pwX5OxmKIhmgKH0QDrX
        OJ+S4UPRd2m8duAs1Gj91vI=
X-Google-Smtp-Source: AAOMgpcFglO6K9DIB8XgoqrsDcWTdq0fXtb4hH2ERGLp7Iq8JLvrPhiIHV0lZaCYRsZ1oDne3f9d0w==
X-Received: by 2002:a17:902:a702:: with SMTP id w2-v6mr94185plq.41.1531803381302;
        Mon, 16 Jul 2018 21:56:21 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id t88-v6sm150706pfg.10.2018.07.16.21.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 21:56:20 -0700 (PDT)
Subject: Re: [PATCH net-next 0/3] Series to improve setsockopt()
 TCP_USER_TIMEOUT accuracy
To:     Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
References: <20180717041602.31100-1-jmaxwell37@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <0cdd742b-ad2e-aeac-c85f-21c59333d54d@gmail.com>
Date:   Mon, 16 Jul 2018 21:56:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180717041602.31100-1-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/16/2018 09:15 PM, Jon Maxwell wrote:
> This is a patch series based on:
>
> Jon Maxwell (3):
>   [PATCH net-next 1/3] tcp: convert icsk_user_timeout from jiffies to msecs
>   [PATCH net-next v1 2/3] tcp: convert icsk_user_timeout from jiffies to msecs
>   [PATCH net-next v1 3/3] tcp: convert icsk_user_timeout from jiffies to msecs

This would have been nice to use meaningful titles for each patch,
instead of copy/pasting the first one ?

Thanks !



