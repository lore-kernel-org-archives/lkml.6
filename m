Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36975ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B2420693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThZndDOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B2420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbeGRDQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:16:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44976 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbeGRDQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:16:09 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so1313425pls.11;
        Tue, 17 Jul 2018 19:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mom/S7pWa2/eo095z/GlDVABBdD0pt4T2EhXaDvWjG4=;
        b=ThZndDOQK0rI3jZBnJ/i/NU9KI5KRB7sDNVBcTqycF1maHWI7l408lu5DMhOUArFwe
         Q3a0NMO9E6wql/OaLh8d2CulEXxLdikBAYPMmrBNNOXtWB5EG1IshMQf3rbCNtLwa8w1
         LZlDdapejE6AaNCf6HUabbPsB/asDj0hbVI7nJ+uloy0zgpxGYjwq2nWftx5ap5aCr5V
         NDM5sgXV8N33PCdnglCMyxivdYTUTKeeyr+dtpwzY/QSjrkZ6nspvatT7R82FGaGWCv/
         +g7ux3AUZGKzhk3Yf6QAnsYm0E7kpOUPi7QvTbiRXwOyjD3QlCeBMJ8oGTukIBVR0eUy
         iV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mom/S7pWa2/eo095z/GlDVABBdD0pt4T2EhXaDvWjG4=;
        b=pXm7gccnejDrt5Epz+Zv2W9xe8VdTrThbGs8Sacu5X9AdsCKiiWrpJxvwzQsBoWXEY
         V8icEonFiO5msB7+vR+R+2Fxy9PmPTEXIWvkdIDUk2F2OLR43NnI3f1mYFPhyK33C4dK
         KiDeeIcvzVTLWRNLlaA+TdyrvKpQr9GVu8x0iDmxZAPgP9rZpf/3a6Y5jQm/ZcvRVcxb
         gHBx2bEtAHT5pFhGFeF+HYsDxMmidBdMErvtha2x773lpQQWqXGTeohUV/46qWXZMLYi
         Ls6zWLLKm/pC2P/xIl+DmgJomDMzcvjlKV97Z8kHrwBgp5IvMBXAvhh0NYfrzN/gfB9v
         /qtA==
X-Gm-Message-State: AOUpUlEYU9eh+JTtnLgkQd4e8FSaC1Sys3651WaSPYbSL8L2i1S84wpj
        4aK9pSAc0HAq+RxO571kv2Y=
X-Google-Smtp-Source: AAOMgpebFLHMWalvyYysOac0YpzaE3a1YAec2EQKKVzLz8tH6IbTrrlEaSaqgvS4Zy32z6E3fpQSXA==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21-v6mr3960448plr.264.1531881635893;
        Tue, 17 Jul 2018 19:40:35 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id p8-v6sm3356036pfk.186.2018.07.17.19.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 19:40:35 -0700 (PDT)
Subject: Re: [PATCH net-next 0/3] tcp: improve setsockopt() TCP_USER_TIMEOUT
 accuracy
To:     Jonathan Maxwell <jmaxwell37@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        David Laight <David.Laight@aculab.com>,
        kuznet <kuznet@ms2.inr.ac.ru>,
        yoshfuji <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jon Maxwell <jmaxwell@redhat.com>
References: <20180718004639.30154-1-jmaxwell37@gmail.com>
 <5aafc511-15a1-da3c-19f8-cc8b658f9c3d@gmail.com>
 <CAGHK07D_XCpU6V6oJ2rhR1=rX5P6t8ZhTMT7GEAyrBXoc=hbcQ@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <4cd4429d-bca6-8b3d-1dd2-ef7f4cd102b7@gmail.com>
Date:   Tue, 17 Jul 2018 19:40:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGHK07D_XCpU6V6oJ2rhR1=rX5P6t8ZhTMT7GEAyrBXoc=hbcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/17/2018 06:55 PM, Jonathan Maxwell wrote:
> After committing the patches in my net-next git branch I used git send-mail:
> 
> git send-email --identity=XXX --cover-letter --annotate origin
> --compose --signoff
> 
> and manually updated it based on an example of yours:
> 
> https://lwn.net/Articles/706491/
> 
> I can see the 3 patches that I just submitted on:
> 
> https://patchwork.ozlabs.org/project/netdev/list/
> 
> Flagged as under review by DaveM.
> 

I dunno, each patch belongs to a separate patch series, this is not expected.

Compare to what happens on https://patchwork.ozlabs.org/project/netdev/list/  for a proper submission.

If you click on https://patchwork.ozlabs.org/project/netdev/list/?series=56100  for example,
you can see 5 patch in a series.

Standard workflow : 

git-format-patch ...

<edit cover letter>

git send-email --to "David S. Miller <davem@davemloft.net>" \
	--cc "netdev <netdev@vger.kernel.org>" \
	--cc "Eric Dumazet <edumazet@google.com>" \
	00*
