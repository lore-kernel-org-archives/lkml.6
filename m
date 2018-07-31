Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94DFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C84120870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jZpSdp1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C84120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbeGaQko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:40:44 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34605 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbeGaQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:40:44 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so13299204ioj.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bXMHY7hPsQi7l5lnV1u4pkA63Sp+QED5w+9R792aUZA=;
        b=jZpSdp1Bue72kw33fEf8r9HG8gjzo2qXTa7JtH3KHJ7zorBOF/ThyOyogSmIByFuQ7
         JFrIqG3O1oMR2eUeAEsjMcy66BFGHQIn2oTtvoQR6XxrHBUgZHdf28e3GB5GNwM+1tZs
         9pQeDCHQt+2u8nr+ewsxZfn/KwKKXl+cUZxCk9Hmu2+jrKaquRplbJaN54WD60Xr4Vwj
         b1V+JpSembyl8wCLwKbkG+2shm053ICE3DbGf9yUkdMdj3W7+/OU9YBtj5zmr2hfcGWt
         jUDys9IVQgth2SyXi/Hl4e0dVLi4C/WBzpya1pmo+G+LvNOo5o8i7b1pozXdX/UDSiE1
         wdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bXMHY7hPsQi7l5lnV1u4pkA63Sp+QED5w+9R792aUZA=;
        b=Tt+2OFBIuWq24WYxV9swffbKQhFJWV9QxCogrqGYvc4yklKPWWh1BBjXqx0qbNgttv
         TwhdunEf4GKTjo4kBAkdJWejwmt/TxOwrAdt1v068DwLL57Lzu8jJk4AAYUu44K+rr+8
         XgTHcr6ClAdRY6yba/+m+YBQH7dZI63fljemUrPMTUFvdyn5XZZskFGdnUBXeTwVv9Gk
         qv2QZw5HNp1QodwCPZCPPiTQF34O3xdJxCgzJwG6k9fiK9YaVZwKm86bBeBzEtPCjTgl
         XvWEBf+3qslS9ayGQtxYEyCcUv0qIqNSMHTkDXgkkdDP1BULTZO5RsZosk+MbBo7Al4J
         jwjA==
X-Gm-Message-State: AOUpUlGpfeeHPiNaMTSK8zcx6p8zpSW6GLygoSM+rw3JpmNpiQ1/faSr
        kDlz4IRAUYTfJxUqEtKztGhngAtWcns=
X-Google-Smtp-Source: AAOMgpf+WMOQhf2S5I8uzwLgYzIUttosq+neXWAJC4UoyBOxhUnDzNBAmhBx8+dfGxToDED8qJ1ywQ==
X-Received: by 2002:a5e:9706:: with SMTP id w6-v6mr27312ioj.257.1533049200798;
        Tue, 31 Jul 2018 08:00:00 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id 80-v6sm1566585itk.14.2018.07.31.07.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 07:59:58 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20180731130700.3ff50dce@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <847d1024-7e9d-65e2-356e-6fc3ffbece1e@kernel.dk>
Date:   Tue, 31 Jul 2018 08:59:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180731130700.3ff50dce@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/18 9:07 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/scsi/sd.o: In function `sd_done':
> sd.c:(.text+0x1050): undefined reference to `t10_pi_complete'
> 
> Presuably caused by commit
> 
>   10c41ddd6132 ("block: move dif_prepare/dif_complete functions to block layer")
> 
> # CONFIG_BLK_DEV_INTEGRITY is not set
> CONFIG_BLK_DEV_SD=y
> 
> I have used the block tree from next-20180730 for today.

Thanks, I fixed it up just now, next one should be fine again.

-- 
Jens Axboe

