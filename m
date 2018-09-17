Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAAFECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7B9214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="SOc15+GI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7B9214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeIQNhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:37:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46446 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeIQNhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:37:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14-v6so12080390edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 01:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TTXqQC0whNEnPTpVklfdImN9xVMqehyCgCv9EEyTYaA=;
        b=SOc15+GIirruW7Np/VoAQ7NYfYTG9LeZFbadEfFbe+IwN24QHKQV95X3Ui4z7fNW6g
         QDe4Yh3gaTAoh1/h4dI34dxonctWv9VDs6DqYVx4sPE0ZsqWsOnplhbc4ngEraN0/dJy
         NhYPfP4LrN40AA75GXGBlo9H7yrfU7DjT73Of86zv195ANpJH5e/fd0iyfwtBIQ0v9gl
         ChAJn0B6Fikv9SUbsghPDloOTEd/rm7Y0g86wQ41oyB9zFpU2NJ9+TT1fWZxO8yVlrrh
         EOndKKgxbkhzh/EShEIDyjg4wXgxBAyMRe+ye9p6ujg6d81YG0gwZQkB4ETuavXg60Ll
         f4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TTXqQC0whNEnPTpVklfdImN9xVMqehyCgCv9EEyTYaA=;
        b=KM8pVhTKD6TUi/caED1JXWCZu6jKyKzIED1gZlJtArw2qrnqNVBLNwI+ZgGW8o9KDV
         8Yd+ZRW7KqbbIcApMUHCXE7O1wv3v3B5OBhqgO8Q1H9wVbB97lBiYy2IQFSizEZuXw4z
         AZhBPItH8YUARKWzJVtWrDlU2oJg8yIy9xxnQf5njJLbrUrJkew/ENVyUEIdHzsqq2l8
         /LhRwlh0AveUl5UlVIsSxHdjUbWs43cJvxTki7T7a/lfxmjGPG+9TXE0EZtrNXOJskGa
         ucNi2Js/IR6ZnPb79qIQF+nnEjuP1ZT2Qwmjz93fTNATE8N1cwNNIwW5bpCXZKYa7AFq
         dxqw==
X-Gm-Message-State: APzg51DgqTB+dSragyyVKHh6hnajeSGWecfC3alDCX5sr4/yYFhtJgBi
        bx5AuNJAbb8vb14p3Z6RGtxlnw==
X-Google-Smtp-Source: ANB0VdbQkNG3A0eHtAtQ2fhA/m6AlpVjko1BVCNI7/5THCGeVFbsVppj0nluER23dOpK8YdbOkcm5g==
X-Received: by 2002:a50:fc03:: with SMTP id i3-v6mr40275038edr.85.1537171865093;
        Mon, 17 Sep 2018 01:11:05 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id w20-v6sm13253745edc.12.2018.09.17.01.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 01:11:04 -0700 (PDT)
Subject: Re: [V5 PATCH 0/3] lightnvm: pblk: take write semaphore on metadata
To:     javier@javigon.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5d12e1ca-546d-7909-a8ce-b16ab4596041@lightnvm.io>
Date:   Mon, 17 Sep 2018 10:11:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 01:24 PM, Javier González wrote:
> # Changes since V4:
>   - Rebase on top of Matias' core
>   - Reorder patches to avoid in-patchset changes
> 
> # Changes since V3:
>   - Encapsulate rqd dma allocations to reduce code replication (by Matias)
> 
> # Changes since V2:
>   - Split the original patch between the metadata refactoring and the
>     semaphore logic. This simplifies the write path, where the semaphore
>     is taken.
> 
> # Changes singe V1:
>      - Fix double I/O on the read path (by Matias)
>      - Improve commit message (by Jens)
> 
> This patchset refactors the metadata separate write and read paths,
> which simplifies how the semaphore is taken for writes.
> 
> Thanks,
> Javier
> 
> Javier González (3):
>    lightnvm: encapsule rqd dma allocations
>    lightnvm: pblk: refactor metadata paths
>    lightnvm: pblk: take write semaphore on metadata
> 
>   drivers/lightnvm/pblk-core.c     | 376 ++++++++++++++++++++-------------------
>   drivers/lightnvm/pblk-gc.c       |   2 +-
>   drivers/lightnvm/pblk-read.c     |  31 ++--
>   drivers/lightnvm/pblk-recovery.c |  34 ++--
>   drivers/lightnvm/pblk-write.c    |  15 +-
>   drivers/lightnvm/pblk.h          |   7 +-
>   6 files changed, 222 insertions(+), 243 deletions(-)
> 

Thanks. Applied for 4.20. I've renamed the first patch to "lightnvm: 
pblk: encapsulate rqd dma allocations".
