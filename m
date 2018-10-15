Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5B7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5AE2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhWrG6Mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5AE2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeJPARc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:17:32 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53089 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeJPARc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:17:32 -0400
Received: by mail-wm1-f48.google.com with SMTP id 189-v6so19577972wmw.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KeUgfrRpWE72zBPh4Kygg+VGy+NEqZUncQZ0Fk0rFm0=;
        b=AhWrG6McY7FU1bo66+AhpG/raP+asDFfc7wxmvwtRTg+M+T1xJlKSV+Nes8Oyo2TrX
         W33nP+LjVSkElhDRun3yNSPkb4ZHizLfXJEqIyodEv4UT0iQIKjoYu8jDwOs6rCtuyzg
         UBDREibVuviIxXNoMreI/hIlr9hQY17Fc+s0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KeUgfrRpWE72zBPh4Kygg+VGy+NEqZUncQZ0Fk0rFm0=;
        b=K1QA3oOsFeuS4N6/qPCN/A/631aJbHv2vrsssQrkP4pSjivuYMrq1u1OXhOOTb8RMY
         XWSlZXkMQzaXQh2zvBbaN8txokzfu98vwlQAZv1c56Cke0dfzPwGCIEcryKvE7J9Wo75
         5hzCleGmrIc0Hf5+7Yr6gyBXsS+QbyS3wXW8CPrw3t9I71+qL5RRnmIT8UafvkEVpzBI
         n5PQUc4TagQHmwiOnisuLKlYeoFKabWRCS48lHcES7ltvSznz/3UBpmdHJv566uuAEYP
         lNM4OfrOuGckArPcCpnfax09XcgnkYZMw4UJiWWdpjdChs0STEuwbeAqo5rcEQkQu83l
         f7BA==
X-Gm-Message-State: ABuFfoitS7TgS59V/4GfzJiCqxNYgJg64IHZ826rvqF9UM8Il5J1WsuM
        +mJOpkFYhvOgiB77EVa4txRl7oLBiDn9KZSR7V3Qyw==
X-Google-Smtp-Source: ACcGV62Pgam8nWJe/+LLKu4CMEdvEXqyzs2KpmuOEDX+LiSLL/STTT+Qz7p2j2fsp8sR+LTqgdy0m0ZXVz7z0l4f/YQ=
X-Received: by 2002:a1c:1452:: with SMTP id 79-v6mr13341058wmu.31.1539621093761;
 Mon, 15 Oct 2018 09:31:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 09:31:32
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1810132256240.4908@lmark-linux.qualcomm.com>
References: <1539214413-26173-1-git-send-email-john.stultz@linaro.org>
 <7534ca1d-f874-7809-6125-d9fc72f70e39@redhat.com> <alpine.DEB.2.10.1810132256240.4908@lmark-linux.qualcomm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 15 Oct 2018 09:31:32 -0700
Message-ID: <CALAqxLWw0k7_cB2hY=2gPbYX7omKob7eV9HJizxYCVc=n=K9EA@mail.gmail.com>
Subject: Re: [PATCH] staging: ion: Rework ion_map_dma_buf() to minimize re-mapping
To:     Liam Mark <lmark@codeaurora.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Matt Szczesiak <matt.szczesiak@arm.com>,
        Anders Pedersen <Anders.Pedersen@arm.com>,
        John Reitan <John.Reitan@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 11:01 PM, Liam Mark <lmark@codeaurora.org> wrote:
> On Fri, 12 Oct 2018, Laura Abbott wrote:
>> I thought there might have been some Qualcomm
>> stuff that did that (Liam? Todd?)
>
> Yes we have a form of "lazy mapping", which clients can opt into using,
> which results in iommu page table mapping not being unmaped on dma-unamp.
> Instead they are unmapped when the buffer is destroyed.
>
> It is important to note that in our "lazy mapping" implementation cache
> maintenance is still applied on dma-map and dma-unmap.
> If you need a full description of this feature I can provide it.
>
>>
>> I suspect most of the cost of the dma_map/dma_unmap is from the
>> cache flushing and not the actual mapping operations. If this
>> is the case, another option might be to figure out how to
>> incorporate dma_attrs so drivers can use DMA_ATTR_SKIP_CPU_SYNC
>> to decide when they actually want to sync.
>
> We have support for this locally on our 4.14 branch.
>
> We have added a dma_map_attrs field to the dma_buf_attachment struct,
> clients can then specify dma-attributes here such as
> DMA_ATTR_SKIP_CPU_SYNC before dma-mapping the buffer, then we ensure that
> these dma attributes are passed to dma_map_sg_attrs when ion_map_dma_buf
> is called (same for ion_unmap_dma_buf).

Do you happen to have a pointer to the tree if its public?

thanks
-john
