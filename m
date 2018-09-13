Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A14C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1749020866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="kw4MXALF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1749020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeIMXh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:37:28 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:45882 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeIMXh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:37:27 -0400
Received: by mail-lj1-f170.google.com with SMTP id u83-v6so5410290lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ArycV61wuv8i8vc183kpw4b57jor0XvztZzg6f+adR0=;
        b=kw4MXALF3h+CUbnqkmKKRciFsGQTBuEXvr6wenBec12aTbdObyLneufAyAU/Q7a18O
         qq7QLXU5aNCggZqADRua7oo9TQFz2MGPM1mEzLcISLxaEdslyFFjOkmVCdim0w0XQb2H
         2le8nzoFh46GRwJA+jZe54ut5KBa1x/QREg3STDcJPZXOaS+FSSKp6sdtsVntakfl4fD
         tF3oF7QirCuNxTqUv4UV0lzeoXhs2N1Aig3cTfMqc84rAxOjVdFWE+XHxsjVrXBGqSEP
         0kK7y9hzLOBYjQqW5rus+BMFz2Q6PT/endIrIuigaZH7G7/xS0u6XpdLwG6AUrTHeYFe
         W38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ArycV61wuv8i8vc183kpw4b57jor0XvztZzg6f+adR0=;
        b=sgzQvmSXqGfO+zSEHrYxOgwUdW8nq5J8rCkWbhuYUQhGe1wolNt8SXDS7yTTmoif5G
         jI71MGUCscLjn3b/QVk2R5NlWJnAL53ueB9aJ0jsAyulz08k+YzUftHh6SGlT0+WWnLX
         bmPdD99mC3AcdBQxnW5igBL98S9wqWhm2ilQK3p1BS0xkVrrLIus28ggvIW0X23pGAQp
         X3wUn0obV9bKsJZFbSuGv/Jne6FlZCLRiaJ3U7bHtIv7K1vXKwsHoR5rpKbm6fWF+Zxy
         XuqxGqEv2r6fC87hdwosPz5dl5YjC1uZA6m8N6XyqeaOB8KsLxao0Vf66bN3+cpzq0tn
         uskA==
X-Gm-Message-State: APzg51D0DmQwCLHSeGExSobA/paun9rggP2HMmPWtXmAiHNPqh8gfgAo
        ndyTTetArUcmz8yry5F6tVUiBDthjPU=
X-Google-Smtp-Source: ANB0VdadIMr8yo1XsLv3ebRd5HgrD0FmYL4HMkxND4S3UUZrw9hp5b42kEFJgtLF3JbQxR2GU14FYw==
X-Received: by 2002:a2e:947:: with SMTP id 68-v6mr5205979ljj.1.1536863205486;
        Thu, 13 Sep 2018 11:26:45 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.84.148])
        by smtp.gmail.com with ESMTPSA id n26-v6sm823487ljc.7.2018.09.13.11.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:26:44 -0700 (PDT)
Subject: Re: [PATCH v3] neighbour: confirm neigh entries when ARP packet is
 received
To:     Vasily Khoruzhick <vasilykh@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jim Westfall <jwestfall@surrealistic.net>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ihar Hrachyshka <ihrachys@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180913181203.4207-1-vasilykh@arista.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <16ad730b-ef79-62b0-4b11-9473c0b033e1@cogentembedded.com>
Date:   Thu, 13 Sep 2018 21:26:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180913181203.4207-1-vasilykh@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 09/13/2018 09:12 PM, Vasily Khoruzhick wrote:

> Update 'confirmed' timestamp when ARP packet is received. It shouldn't
> affect locktime logic and anyway entry can be confirmed by any higher-layer
> protocol. Thus it makes sense to confirm it when ARP packet is received.
> 
> Fixes: 77d7123342 ("neighbour: update neigh timestamps iff update is effective")

   Need at least 12 hex digits... Perhaps could be fixed when applying?

> Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
[...]
MBR, Sergei
