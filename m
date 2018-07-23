Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9872AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB9E20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM3kzBOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB9E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbeGWITe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:19:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40928 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387840AbeGWITe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:19:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id x5-v6so11603498pgp.7;
        Mon, 23 Jul 2018 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=piyeUeuKVZqYH6l60dXwgx5SH0c13S1Bs4DKux0Nm2Y=;
        b=HM3kzBOGSeik18/6xVvXdJ/YmRpZTnnXbD1neZsvAJtYya4kYsdzOQbakZqGLfHQzN
         IsIpPBfgz7XYzaOSX9VcJmfBLZ3V+UpYGQ7OCo9LxnrD4Y2EDjalI7QY2/MALkvgH/F/
         nAELygO1T0fIl0EglmEO2UXNh0gHOqgCX4VBTd19qFQ8U210BlVL/gweP/oznG8saX91
         j6TwavDaYey7hiSYfafldMttTEHQmARiSUTc9csRHesZB5Il3Ms9Z4woil3R15zSQ76I
         8haZMv1PdlcubVvTi5Hj1qN9A/VAb69e+Z4oqGcVFOl8U5bobpggHdjJ2n4oItGUwpm3
         OxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=piyeUeuKVZqYH6l60dXwgx5SH0c13S1Bs4DKux0Nm2Y=;
        b=r072mRkeIO+CXIi74+57SFH2QrAUPnnX8p+SeEkjVycMvUFcdUNRty+RqPDqM3QcyK
         q7HnJnUNpZL75yytcwWQ6m7rpsCIXujNqpja1TlSwW/lO/gk2G3ycyLzyzdV2gV8dbwU
         QTL+WpTVpVO2fCiOEFjnqMm1XQb3CvTTe+ZZdSesnQY7JnGj68C73/k+h/5RBBbyUzmk
         DncSMyvyorJNPKCDR7WoNQEAlwxXiaptsX+2MbQ67QFLzPGNHGREYP8sUWNhiGVlTarH
         GrpfAtOkDjuGJ+Ae55kxqhE3/MaLvJHUOR+XT6GJ2y+CgComdoEfgjMa6U8zdVcwqswV
         nAdg==
X-Gm-Message-State: AOUpUlG6/VHIqNCckIo/o2+xcsGveUX5d/oWLXvir5fx4DXDHKJII9eL
        pYqKrOqlSPJNJmLSLowykBo2nc/t
X-Google-Smtp-Source: AAOMgpePuHQ8yMzrrzRz+r0KAcymBESZhcCxG8mW0JfU3n1LToYvHX3SJnpaedKvaEyfwt+J+45zPA==
X-Received: by 2002:a62:20d8:: with SMTP id m85-v6mr12228742pfj.74.1532330386136;
        Mon, 23 Jul 2018 00:19:46 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:101.5.211.5? ([2402:f000:1:1501:200:5efe:6505:d305])
        by smtp.gmail.com with ESMTPSA id 5-v6sm13539755pgc.86.2018.07.23.00.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 00:19:45 -0700 (PDT)
Subject: Re: [REPORT] Possible unnecessary usages of GFP_ATOMIC in
 crypto/ablkcipher.c
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <78a7d726-f2fa-3afb-3451-bbd51a41a48a@gmail.com>
 <20180723062101.zzm5royyjfda6jma@gondor.apana.org.au>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <f0ec23d2-4766-6677-d95c-ea8d193d4083@gmail.com>
Date:   Mon, 23 Jul 2018 15:19:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180723062101.zzm5royyjfda6jma@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/23 14:21, Herbert Xu wrote:
> On Mon, Jul 23, 2018 at 10:39:40AM +0800, Jia-Ju Bai wrote:
>> My tool DCNS reports three unnecessary usages of GFP_ATOMIC in
>> crypto/ablkcipher.c:
>> crypto/ablkcipher.c, 162: kmalloc(GFP_ATOMIC) in ablkcipher_next_slow
>> crypto/ablkcipher.c, 199: kmalloc(GFP_ATOMIC) in ablkcipher_copy_iv
>> crypto/ablkcipher.c, 315: kmalloc(GFP_ATOMIC) in setkey_unaligned
>>
>> I meant to manually check the code, but I find that there are many functions
>> calling ablkcipher_next_slow(),
>> ablkcipher_copy_iv() and setkey_unaligned(), so I am not sure whether the
>> above three reports are true.
>>
>> Could someone help me to validate these reports?
>> Thanks a lot in advance :)
> They must use GFP_ATOMIC because they can be called from softirq
> context, e.g., IPsec.

Okay, thanks for the reply.


Best wishes,
Jia-Ju Bai
