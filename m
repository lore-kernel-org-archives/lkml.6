Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ECFC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA2F2089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="I/z46qNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA2F2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbeG0Qjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:39:46 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44013 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388282AbeG0Qjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:39:46 -0400
Received: by mail-io0-f196.google.com with SMTP id y10-v6so4404106ioa.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0rCkLlOJBpPhYXmkRgUpUiJbpvcgZXZFSrk38RqadVg=;
        b=I/z46qNPC5FRKBEoNxxjwFV5CFfIjOcCRMmK+s80tMTQ6awAhEc7nBEeBmtaN85kbb
         LA/4XIKVQV2N3zmz7LG6jL84bvEzjE0Fc8wLxxScldbU0a5VAxkBPbV1Ff5+08n1iPWv
         8wLQHGy+RiET+Q9McdatC5gIrNl71hPpoqn8SkE8baAqeHnXRa4GWXFL741OKuT5ECIF
         3k4qND0cZmDBI9B0ZYg4YvVGoEOP1jLjoeqFKDy+6gsf0Zekn0eRhyVteCuHuHO3efgk
         hJr6CEKx9hL8OahqEHtG2VJvVLBEuRqVnf1rC26ZAkHaYqD1LLQuxqe+cTUmNT3vJQSe
         NI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0rCkLlOJBpPhYXmkRgUpUiJbpvcgZXZFSrk38RqadVg=;
        b=Xujaa2azSvGMZtgir0jYL3IsGDw4KBoshfGlgTXtNtQ2/YI2u2e0kark4Fm/WbhNH4
         lV9OKRQF7g+IZlS8buKtvT9yQkk+1rDc4AJzu0siRg1G++ww0X/5h1a4ZvyZ4wGbY96n
         SWEjZ+xEnT/7QNrdJgOTt9H2u+c2YC9ELZNREi+59dC9bkYxG/gky90RxihSvbucfFW1
         W6K03y07evJYLkA42loswMdu/vfc4YKNuOexej8eqQgm4cG7n5DZqBoaUgva4PEzCk2b
         J+Incv9pYsvzHrwDQSN5Cjdy82FRXA4bq23Ngo9xzvVoT0QVdH8mk8LWS4Ra6I0NZUaw
         43cA==
X-Gm-Message-State: AOUpUlHXJSJHo4MsgMAKWh4SOb5iORgt60EC0I9SB6g4GtrZFC+YBB14
        Rt/eg9Puj8MQXTYB2v/LDCLPeg==
X-Google-Smtp-Source: AAOMgpfU/tMR5eSVxo5iPupKXihsOLeTzxoixHUlf7noQw/FHYI0pUQzjFfy2qG38mnsHSVa+keXkg==
X-Received: by 2002:a6b:18c4:: with SMTP id 187-v6mr5414529ioy.192.1532704643742;
        Fri, 27 Jul 2018 08:17:23 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id j5-v6sm1271816iok.10.2018.07.27.08.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 08:17:22 -0700 (PDT)
Subject: Re: [PATCH 0/2] partitions/aix: fix problems due to disk corruption
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     phdm@macqel.be, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.axtens@canonical.com
References: <20180726014629.30411-1-mfo@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ac51c6d-a7b5-9ae1-88dc-1536450d70fb@kernel.dk>
Date:   Fri, 27 Jul 2018 09:17:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180726014629.30411-1-mfo@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/18 7:46 PM, Mauricio Faria de Oliveira wrote:
> We've recently received a disk image from an AIX LUN that when
> attached on Linux displayed errors on console, then eventually
> hung the system.
> 
> Apparently the LUN was originally installed with AIX and later
> exercised with some I/O stress/overwrites which caused certain
> bits to be wrong in just the right way for Linux to get a NULL
> pointer and invalid data.
> 
> This is the test-case used ('--partscan' is the important bit).
>   $ sudo losetup --show --find --partscan aix-lun.img
> 
> Patch 1 resolves the particular problem the disk image has.
> Patch 2 improves the code a bit further (tested synthetically).
> 
> Mauricio Faria de Oliveira (2):
>   partitions/aix: fix usage of uninitialized lv_info and lvname
>     structures
>   partitions/aix: append null character to print data from disk
> 
>  block/partitions/aix.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Looks good to me, I have applied for 4.19.

-- 
Jens Axboe

