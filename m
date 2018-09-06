Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EA02083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6zAdgS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EA02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeIFFJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 01:09:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35414 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeIFFJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 01:09:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2-v6so3131342plo.2;
        Wed, 05 Sep 2018 17:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WxTlHDpYHwt6YE5E1TGbUx+GgMzuLqQkLvXoNP2JPEg=;
        b=u6zAdgS1aViqhB+ndyYP2hvHNjt0P4Yhh1g5rdjFEqqrU9sxSAzUXeSH1oLpCXsgBC
         9gXNsxbAX37LUEhJmjmACmZGLl+HoX70iaMBbBw/a8nFMLU5nUCaMWapCGGsI3PD55F/
         7IWto9CEd+Mdh1+kmpXATAzUyx0ZFzXYzFTaHQ8easIESxiZEOFp3MTYh4ilFvtfEZO7
         ElH2lmpEEZpnKfqrRE4qBvYmQXGgZ6slKv77guS4gtPJ940X/dovTGoOWS7yhNFNimfH
         v4iEnadD6uF7uGHd4djBPFzqBRdFQUlxq1xXlVtky9MjVTZy7swTfE031Koxbq1uF5Pp
         MNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WxTlHDpYHwt6YE5E1TGbUx+GgMzuLqQkLvXoNP2JPEg=;
        b=qOttWhLY5YHLiDBAq5SC7NGoBfjne4oXeZWjtgCkk//zfKr5TgaOK+mCIXfog9HrzV
         TLJSIxRZF/maQoXNjrNDPgnIYWlRjwIEify0JmJDJ7kVfBdCCU2q57+0Sz4/erUSvbcq
         E+RZ8yorP4g+2LYowL98vz/KsFrm0flCThjq/CK3/0llQtweotQ+aY2lQ8NMjQ4mowyg
         sUQ3qlXybt0eIijscUWEMMWymKQITaKYr9xnuXkCwxredHCfc9CQAISHvUrXsbNVgURc
         9vQu8ZzQyFQrMGXxKOCQXs0vNyWITZwwYVPwVDFta69eXWNGMyp791sgulffuwGGbxzm
         ivnA==
X-Gm-Message-State: APzg51AD1vzIyHhUO6fxSwXGYacStYtioSOXwBEOTwRugN7143Lg6VUw
        /HrP4QPm6rNagpQGFY41Be8=
X-Google-Smtp-Source: ANB0Vda8mxNslc/4iSspsp1Pwo59Q9Wqhwk79VHcyjE+lIp5T75TuG3FrcdSmjO866TnffMt+1YM1g==
X-Received: by 2002:a17:902:a58c:: with SMTP id az12-v6mr222012plb.339.1536194181619;
        Wed, 05 Sep 2018 17:36:21 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q80-v6sm4538454pfd.15.2018.09.05.17.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 17:36:20 -0700 (PDT)
Subject: Re: [PATCH 3/3] mm: optimise pte dirty/accessed bit setting by demand
 based pte insertion
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
References: <20180828112034.30875-1-npiggin@gmail.com>
 <20180828112034.30875-4-npiggin@gmail.com>
 <20180905142951.GA15680@roeck-us.net>
 <20180906081802.210984d7@roar.ozlabs.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c4ca50a2-5f85-84bb-65e7-79621f5b4c0a@roeck-us.net>
Date:   Wed, 5 Sep 2018 17:36:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906081802.210984d7@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 03:18 PM, Nicholas Piggin wrote:
> On Wed, 5 Sep 2018 07:29:51 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Hi,
>>
>> On Tue, Aug 28, 2018 at 09:20:34PM +1000, Nicholas Piggin wrote:
>>> Similarly to the previous patch, this tries to optimise dirty/accessed
>>> bits in ptes to avoid access costs of hardware setting them.
>>>    
>>
>> This patch results in silent nios2 boot failures, silent meaning that
>> the boot stalls.
>>
>> ...
>> Unpacking initramfs...
>> Freeing initrd memory: 2168K
>> workingset: timestamp_bits=30 max_order=15 bucket_order=0
>> jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
>> random: fast init done
>> random: crng init done
>>
>> [no further activity until the qemu session is aborted]
>>
>> Reverting the patch fixes the problem. Bisect log is attached.
> 
> Thanks for bisecting it, I'll try to reproduce. Just qemu with no
> obscure options? Interesting that it's hit nios2 but apparently not
> other archs (yet).
> 

Nothing special. See https://github.com/groeck/linux-build-test/tree/master/rootfs/nios2/.

Guenter
