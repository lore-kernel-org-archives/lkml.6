Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56332C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F3920893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LW6/k9Ay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F3920893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeH1UBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:01:38 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39084 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1UBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:01:38 -0400
Received: by mail-it0-f67.google.com with SMTP id h1-v6so1257488itj.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MOD4MooAAgBdlMNHxIRpkxm+GUbz8nH1096W3q30vFE=;
        b=LW6/k9Ayn8K3H7hju3ZkJ/uoHBKMJWcZv8OMyeUukDupUvUVu+OKklIqbi0nCrzjmf
         v9A8wsI9MvaB9T05cevEXyb5UoPTbJEnaJ6NeODzrF283DxWVMMRk9DL2M4qtWU3lv+1
         ZYKeU7rnypOX8qoDplD3ld8/MD73d6hKBAndHgM7Y7Br09X2ZjPoy7FwzQt14fBQ6pJc
         tDdoqXWnY/aUlMuCIIGJjLur7bqqcb2hYushSmEKkEFvrfCxqh7C5Zsz8FDVPFaAthQP
         LyPqHSOVhda3s/Y31TpMXBsl30d/gK/NB2dkGSVfCir4t3JqLPUCsLoj4cGcOnrbCqBG
         iBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MOD4MooAAgBdlMNHxIRpkxm+GUbz8nH1096W3q30vFE=;
        b=kH1zzCPnUam9F/rX1RjWHiZikxBLswY2xJqTZEAWXROYQHExfh0HFLA71v7ieVo+QG
         ppwSc7Hg+s/Y+4Te7KmBo2GOLfHmxSWZQ4e34kKKBslv3Pm74cUHoGMaQ3rJbsfSUL4w
         h/U9+hcZDl7HPzH+wOKxSuAnSSWWsa7AxHhSqOMMV0ybkISJ5ULumLzyx2WFdmVlMm0c
         bdq4RU7L+xeQNWAzd5u21w2wRQsyI+uCVY3UbFq07KASl9Kv28BYyH/gumGePZhy+udO
         tqj/PinyDAxhHsb4znMPCj1Vj/8gDk2E/i+9dvefM949UG4gOdyH8ytx1FEnOV3L1u9P
         PFWQ==
X-Gm-Message-State: APzg51BR4otbF2pdiPC/koL9PgxqueIUklmdM/p8q4LSlZ8ztus5J7L+
        eApS5UE5hb2N/0/sNuPczoEsNA==
X-Google-Smtp-Source: ANB0Vdarrf0jDlHP2Sej/S8WoyCNyxeFgblf9JTl5MO20Jf6Cx9EH2Edafdj5doWPUoQSrBbCxtmpQ==
X-Received: by 2002:a24:dd88:: with SMTP id t130-v6mr2121764itf.129.1535472555910;
        Tue, 28 Aug 2018 09:09:15 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r126-v6sm774757iod.7.2018.08.28.09.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 09:09:14 -0700 (PDT)
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To:     Ian W MORRISON <ianwmorrison@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kashyap.desai@broadcom.com, loberman@redhat.com, osandov@fb.com,
        hch@lst.de, bart.vanassche@wdc.com, hare@suse.de,
        ming.lei@redhat.com
References: <20180828154727.3589-1-ianwmorrison@gmail.com>
 <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
 <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1cbdba28-3ff5-2bbe-a2cf-b533249c6970@kernel.dk>
Date:   Tue, 28 Aug 2018 10:09:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/18 10:07 AM, Ian W MORRISON wrote:
> On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
>>> Kernel oops when booting on Bay and Cherry Trail devices
>>> such as Intel Compute Stick. Bisected as:
>>>
>>> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
>>>
>>> This patch reverts the above commit.
>>
>> Did I miss the posting of that oops? Just curious where this is
>> going wrong. Not adverse to reverting, but I'd like to try to
>> understand the issue first.
>>
>> --
>> Jens Axboe
>>
> 
> I've not been able to capture it however manually transcribing what is
> on the screen:
> 
> mmc0: Got data interrupt 0x00000002 even though no data operation
> 
> followed by:
> 
> mmc0: sdhci: ============= SDHCI REGISTER DUMP ==============
> 
> Do you want any specific register value or should I transcribe each
> (as I am working from an image taken at boot)?

Just take a picture of the screen, that should be good enough.

-- 
Jens Axboe

