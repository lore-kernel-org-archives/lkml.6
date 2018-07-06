Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234A6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2648223EE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5Hd654s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2648223EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933801AbeGFQjq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:39:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33764 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933561AbeGFQjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:39:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so3120869plb.0;
        Fri, 06 Jul 2018 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jiF7G6YbnfsU5ysRGbDhSUlyR4Olael6O4pTr3DcSN8=;
        b=N5Hd654sELi0r3jA91d73EDICcpYuxCgVEOVgv2cjZkSMSch0hhBwzIR3ZSha+XbW6
         leqhzcjfPGXi6rLkWlUrwu72TtxeLdCtSWZTGcsQA2URKUT6GNCiCNEwMIHwVtI1rb8K
         9oxqd8RxNkfmVfCcWxa+7vzUPhiavu27HdSJ5RdLIJWgrC1z0507Nx+yYTVJZYeWO6wG
         QhsNIrGmrxC2DAp09NTi26BM5EoF8ouu5Zw8CVwp1dqsMLjadLh+y5cPmuM57AYgQavL
         K10NoUccFRHdJ07TX+fw4/L1b1MKHPj7nyD+QF3wnqRXdu7ZrgT0zFd5tu2Na29RyZ47
         V6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jiF7G6YbnfsU5ysRGbDhSUlyR4Olael6O4pTr3DcSN8=;
        b=ivYxtcyLbvHVO6hkLSp+/OxjrN9lP4Wzw6h1rnO36EE3D0DXMgEDwZAQuHzeVnFvhq
         eVfIJKwwfEi3qjalhoMeHyyDTyeEpI5SDtLfK6nkebE0ScqWPlp6/J0VKp3FtDwLsboG
         JjIfmEIisbG1ltg7EkPsUeJWgJI/pW2meuQlftBtMRTJgVj7bOrMGcouZzD/GfshJOem
         FxWoIEhFlzXusUKqh157XUR5+epsku4b5/WOsy00FhJbHV8dnMeaZ6UaW1KjTtq28wRL
         h03EFgbSoZg3R0Ygq7ra+FCUOJ3WlXk0ZpW7g45tYnMY6kHcWQBb+lBiF3Dw6dOPqZDj
         0wDQ==
X-Gm-Message-State: APt69E06KL3e1C03UV99muxE0A79Aps+vif/FbxybvxrH0n55y+5KgA9
        R0LK0I9kfUhRC+RmJ0vvRlo=
X-Google-Smtp-Source: AAOMgpdZWDKd3RsTQy47YNCWK+2BC1Fn/NMUoc24qqZ8f5RMX01CvCOVsWaQAWQ4moIFylN9vqWiXA==
X-Received: by 2002:a17:902:d692:: with SMTP id v18-v6mr11093147ply.59.1530895183622;
        Fri, 06 Jul 2018 09:39:43 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id e10-v6sm13530740pgv.48.2018.07.06.09.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:39:42 -0700 (PDT)
Subject: Re: [PATCH] ipv4: fib: avoid NULL dereference
To:     Mark Rutland <mark.rutland@arm.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, arnd@arndb.de
References: <20180706142836.1822-1-mark.rutland@arm.com>
 <3ad39534-400a-8d4e-ac50-94eb5655e565@gmail.com>
 <20180706145728.57utqqrjzq7iupnh@lakrids.cambridge.arm.com>
 <deb5ea83-120f-9181-089d-8ae64e23dc0d@gmail.com>
 <20180706155436.k5phclyyheh3zjms@lakrids.cambridge.arm.com>
 <0783dbd6-36b0-f726-7dd4-39e51d6835be@gmail.com>
 <20180706163339.uksaz7jadilcflwu@lakrids.cambridge.arm.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <92e6c0de-cec6-0647-acce-e0d22aed5a55@gmail.com>
Date:   Fri, 6 Jul 2018 09:39:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180706163339.uksaz7jadilcflwu@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/2018 09:33 AM, Mark Rutland wrote:

> Sure thing. Are you happy with the "deriving a pointer from NULL"
> wording in the explanation? That wasn't intended to mean a dereference.
> 
> I'll change the title to:
> 
>   ipv4: fib: avoid undefined behaviour

This would be fine for me, thanks.

