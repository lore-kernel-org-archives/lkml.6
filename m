Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D61FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110B8208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="XuImGWWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110B8208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeGPBDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:03:51 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37198 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeGPBDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:03:51 -0400
Received: by mail-lf0-f67.google.com with SMTP id j8-v6so31002878lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 17:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nnl8PLyKOFtm1c2ugX6205P8sI3pRaDCKnNp5Wt7laY=;
        b=XuImGWWp0KQdpXjPgA55lg3fDYvXhdppjbMBueGDIJryM5odqPSnsFlGlGv2Mb6ELT
         jI2WLpsZ3ZTFW2ywsI29bgdKvGb9jKHZAyK1ZUGo0OW78s+Tf9FzE3avdS5pN8sDP5Ja
         EDF4r6+gFeROvIFtrF7V6hn5MMjBa1nGJxOVkJIvBkIMyfhb9fzo5vfoEHDmeJn6j0qd
         VmCeNLLVsoVnuKXmq40Aiw74/YP/a4KE43jDIHoqTrZt7xlFIKOkYYNTulNKlMUNbc+S
         WaGNQ+xQK4osV/cQIPZ7oxY37+uonHOe9jXOQqECFPBNDh6IYo7Ti+yMZIHC4jaYpgxj
         ZRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nnl8PLyKOFtm1c2ugX6205P8sI3pRaDCKnNp5Wt7laY=;
        b=PwTkNlrXaPK29JVjj6W8HSt+QMibj9g4i4sMwyi1+kWm2TTKQZp5PHWf5H/qGFCZL/
         um3aiwVUHFBAwReI97jKO3963P7vQsLrBt7IHsQrKr86+vr4TYsFyZOn2oBeeRUn7Frg
         h0df5UYNWkON9rileSONkAyKoJ4qcPkn35y5/rBwA+8Z3AHKK0A2D6b5Cw5mRyU8Z6Wn
         Eu+Gbf6zyI9xefDwoaiQD57B+WfZznmnZgP0WGk8348KnOdtTkHFYiks22Noq4gVpgCF
         whfeIEgP81KDqwX2zZgS1KfMcgRMgMeAJQQnP+v7eAT21YktaGK4DqDfGVkC5zYEEfUg
         WC2Q==
X-Gm-Message-State: AOUpUlFLAuWr1GW/NCuqtE+XpxSdOPOSuOvZ0kiszD6oitPxtNdHbATe
        Dx8PfE/Viz1zxN4eRSUjMtiwbfYuVCp2K8w/BGzlMA==
X-Google-Smtp-Source: AAOMgpcUkpVUascnrIJm50VBLyyokoxvp+yDTHbfDcU/5ixFz9g3ycu9H3vBSLPzBez/wGZu8yDZLqri6RKV7aW1vYA=
X-Received: by 2002:a19:4344:: with SMTP id m4-v6mr10923020lfj.111.1531701541489;
 Sun, 15 Jul 2018 17:39:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 17:38:59
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:180::1:b025]
In-Reply-To: <CAOesGMgicOOi0Nr+m_UHEGYL+ryRW65YAPwVsN+CZpo6kc2FLA@mail.gmail.com>
References: <20180716091337.6c1b2a4d@canb.auug.org.au> <CAOesGMgicOOi0Nr+m_UHEGYL+ryRW65YAPwVsN+CZpo6kc2FLA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 15 Jul 2018 17:38:59 -0700
Message-ID: <CAOesGMgWu4P+n9Bm_OJS-DjGysbtytaVVZp9W81Rb9yrLfw26g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 4:50 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sun, Jul 15, 2018 at 4:13 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> After merging the arm-soc tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> sound/arm/pxa2xx-pcm-lib.c: In function '__pxa2xx_pcm_open':
>> sound/arm/pxa2xx-pcm-lib.c:129:6: error: 'pxad_filter_fn' undeclared (first use in this function); did you mean 'dma_filter_fn'?
>>       pxad_filter_fn,
>>       ^~~~~~~~~~~~~~
>>       dma_filter_fn
>>
>> Caused by commit
>>
>>   0d0b16b8e008 ("dmaengine: pxa: make the filter function internal")
>>
>> I have used the arm-soc tree from next-20180713 for today.
>
> It's a known issue due to dependencies with a driver tree. :(
>
> Robert, this is unfortunate. What's the dependent patches? We can pick
> them up in our tree as duplicates if needed.

Ok, it was easy to drop PXA this time around, so I've done that.
Stephen; arm-soc/for-next should be building again (for tomorrow).


Thanks,

-Olof
