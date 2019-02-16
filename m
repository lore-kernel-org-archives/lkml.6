Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16A6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BBA222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="CHF3UxUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfBPHqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 02:46:10 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40837 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfBPHqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 02:46:10 -0500
Received: by mail-lf1-f65.google.com with SMTP id t14so8850799lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 23:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=l1KthLKvmV+4GnwFICNbd9lELKHahFKa+BSGIWuEC40=;
        b=CHF3UxUFNon1FsjgR2i9sYRZMWsa4dyhPDtv124mER4tLFYkPBbEbrWGfc3+dmFQ+3
         NctHS37AdOFlwxq0HeMGZ9f60kagGdPiMdMpcqLfYEex+u4nQkUDOWC1jtYFzgo930Zr
         aIRdNwTxc0Kbli7fiVrXACvR5lOJiw9GwZdDFi65HmwbYXUijK0lYjJhXQ/xL3b6U8BZ
         ztxtz+lvACvsk7LogUUmZ862GoVYk2sOg4r+lJB7jycRxQn2exZKi8ZdqNtJ2gPOegVM
         Qzdz7ZThBHTXSKtYmWPjviXtvgA1NpKpVbQMqMEnd+ZR6sYot/nWXO2Aewt2AmA6F8kj
         S9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l1KthLKvmV+4GnwFICNbd9lELKHahFKa+BSGIWuEC40=;
        b=nE3JASsY0WhxR+OAGQzMRFnvk9tsttoFkwUSfqN2nwguEtWubsAXwh5eUrCNm/fVx3
         tDAozOpJbKGwsaCZ0YBPEf+4pBOYXfP9X70lIUAB8bndS9bz4eIX/FscuA3N9S+KtFt3
         tazJll0pNooGIvIZWIGMBlAuDiThA1uNOp+UsSDQAMnWxffnypaAhcZ6F9cl6xWYEhdx
         OdEcp/Rm+gH5oz/nmfn0aWYg2qjm5N/yDfaG9D6+3gVX0jPxkOMvwi6mz2onjya0fdJ6
         4lCeGJpmUEp+lHRfM+0455zpsUbOQWX3Ym9bWTdzcGWg7QNpLHnLuqSdhPOUsJjbWxK+
         WvCw==
X-Gm-Message-State: AHQUAubG3UkbpbPDwf1/uFWt0ME6ER7pEHrGsDqDTLwWoS29GotPsYcn
        v5/MMtJ4ris4FOqQxFt9Y6l+/DyBoAI=
X-Google-Smtp-Source: AHgI3IbFvwbzhT/qEGJNjs8faeG4WFS78VOXlghkCGdtmgkUHXfgrj0UI/xsG/7eV8ItQG7DbgkiPA==
X-Received: by 2002:ac2:4343:: with SMTP id o3mr7084762lfl.129.1550303167639;
        Fri, 15 Feb 2019 23:46:07 -0800 (PST)
Received: from [192.168.0.199] ([31.173.80.82])
        by smtp.gmail.com with ESMTPSA id v11-v6sm1782232ljc.57.2019.02.15.23.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 23:46:06 -0800 (PST)
Subject: Re: [PATCH] ata: fix a race condition when internal cmd time out
To:     Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org,
        tj@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org
References: <20190216034257.30226-1-yanaijie@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <63bc665b-4f5f-0845-9767-825925ead80a@cogentembedded.com>
Date:   Sat, 16 Feb 2019 10:45:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190216034257.30226-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 16.02.2019 6:42, Jason Yan wrote:

> For internal cmds, we will unmap DMA memory associated with the cmd
> before we abort the cmd. If DMA transfering data before the aborting,

    Transferring.

> bus error will occured.

    Occur.

> ata_exec_internal_sg
>    ->ata_port_freeze if timeout
>      ->ata_qc_complete
>        ->ata_sg_clean
>                                        dma transfering data = bus error
>    ->ap->ops->post_internal_cmd
>      ->sas_ata_post_internal
>        ->sas_ata_internal_abort
>          ->abort the cmd
> 
> Fix this by move post_internal_cmd() before unmapping the DMA memory

    Moving.

> when time out. Notice that we have to set ATA_QCFLAG_FAILED flag before
> calling post_internal_cmd() so that the aborting will work.
> 
> Reported-by: luojian <luojian5@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
[...]

MBR, Sergei
