Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDA5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101F52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="N7waiX2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101F52084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeH2STq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:19:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40702 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH2STq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:19:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id z25-v6so2396585pgu.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jmkuVy/pUnsjAPmEN0xGiTcuD4L8tgEVxb0PDt7cJik=;
        b=N7waiX2ZeYU3f5IYwVsVCTIGVYepdp1xLASml/ajENY7rTcnwtPc/kHIw5tCXn6RMr
         5qg4va4MklU0h04UL2hn5i31kFUuw0bFVkNNJu2sJxB+TBN5hPpuMOzh/oVS2eSby6eG
         l5eFaT3a2jZk0QJKJXOI76twecTso9n4T05x8ED39SJDYnot6gVHcV5cVyVli4H4cAYO
         477oDCU3n4UdffPI87+qdxsMuGFRSgYp522hAa3pbOwptmXN14SNjhHUK8VafEycxzgo
         5SVecwSyzH63IGmvwvkx15l9yYQ3kQH6WgyiRq39MK9lA/D4drF7ckA4kpQ14q31LTSw
         YTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jmkuVy/pUnsjAPmEN0xGiTcuD4L8tgEVxb0PDt7cJik=;
        b=Frm7ovU5Y3rclYcqhlpGgQYN81rSQxRWs81TR0aHzPzP9+qnvq0J/pwtEI1rOloGwi
         32w0ZvgQGD4FpGek+5Crsgba5IZTxEA+0h77hyQJJrOtvfkeywgbKIhi4IOgI2/2Ag0R
         SAkjK8TZhcpEsdAafyIo+DlGPd9i31ym5oPSuZBLWT7ORMZQdAX/tmc/cPcHsMD3Pamt
         9wt+zPDTI3SlcES/Ih5YXIiMe/1Pgq1P/zLZlLEx4zZxKkv6IcT3mwMMXqZZWaSsk7UI
         88U6SsObnmHxqodtlAUydmUhVfs+uQ1vIuzhIomAQkyll8tPcHaJXSN0oRgLzuSzEXmG
         cT4w==
X-Gm-Message-State: APzg51AOTl5n3c7/dvrsRo0Wt/o32kqNIUYkWYSQJNFkVAtwLsdh9ugo
        wWi3oJR9yT0Y4qv/7VmOMLP12w==
X-Google-Smtp-Source: ANB0Vdb7O2m8RiaA5nizK4OvNxN08gnrj93Ta6zOwFXyhXuYgvzcVzMog6ILpCo3QVjbbmB2tlrQIw==
X-Received: by 2002:a65:50c9:: with SMTP id s9-v6mr3835265pgp.417.1535552555305;
        Wed, 29 Aug 2018 07:22:35 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id u83-v6sm21155657pfj.37.2018.08.29.07.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 07:22:34 -0700 (PDT)
Subject: Re: [PATCH 0/4] Introduce trace events for pblk
To:     hans.ml.holmberg@owltronix.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <6ceb3e39-16bc-af1e-ed8f-f24b7fba2bb5@lightnvm.io>
Date:   Wed, 29 Aug 2018 16:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 02:31 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> This patchset adds trace events for tracking the internal state of
> pblk. I've used the events extensively the last few months, and
> they have proven very useful.
> 
> The patches depend on some of Javier's for-4.20 patches.
> For ordering, see:
> 
> Branch: for-4.20/pblk
> Remote: ssh://github.com/OpenChannelSSD/linux
> 
> Hans Holmberg (4):
>    lightnvm: pblk: add trace events for chunk states
>    lightnvm: pblk: add trace events for line state changes
>    lightnvm: pblk: add trace events for pblk state changes
>    lightnvm: pblk: add tracing for chunk resets
> 
>   drivers/lightnvm/pblk-core.c     |  69 ++++++++++++++++++-
>   drivers/lightnvm/pblk-gc.c       |   8 +++
>   drivers/lightnvm/pblk-init.c     |   8 +++
>   drivers/lightnvm/pblk-recovery.c |   6 ++
>   drivers/lightnvm/pblk-trace.h    | 145 +++++++++++++++++++++++++++++++++++++++
>   drivers/lightnvm/pblk-write.c    |  10 ++-
>   drivers/lightnvm/pblk.h          |  14 ++++
>   7 files changed, 256 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/lightnvm/pblk-trace.h
> 

Thanks. Applied for 4.20.
