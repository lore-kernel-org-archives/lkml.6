Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7885FECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FCD214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EtPW62WR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FCD214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeIRUwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:52:12 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40321 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeIRUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:52:12 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so3483223ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5qIoN0hYeaglc05BP/qdQbwQQKHfCj5ZpaJkz8LE2/4=;
        b=EtPW62WRxQN6dQyB2Xt96G180BwVS3Rvy26aNe2lBI8LeLYAb+Z2KKDPTSXaHUNSkD
         2ZzOWiCgR2zwxluBGMr6+YOvmX5H9wFvU4zAHODQ6/29tao5Zm3IRoLyxO/FRKU8z+Wh
         ETacrOv/nTy6XKWnn6O0Sgitbkup82P5Wiap0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5qIoN0hYeaglc05BP/qdQbwQQKHfCj5ZpaJkz8LE2/4=;
        b=Wfwu4QLnfMqgTFsByYIHeOL+wKE3xi+9oMf+hV+jSWRmVI9kK5xlUSjNvTc0WBfCYy
         uq1ec4harSqs6dfqhxSNPYAYnDcBoDikv2PZ89CN0ORFpdgNHHYzIwUZroppl7iem2/4
         pLK3s/ObtpOQGtnOmUtH0GAL/fkLJxiKS5pC9NwO3GN5AQkI8YWGafdYWQOopyHxrjoL
         BlDnmRnfSfY0Q9PAE4/kM3gn7S3/XRNIT0NXJDJc6fqsayl7CiILYzUFb2Q8MKs2R/wq
         EqBvBPP6TpWOoNT88qsoADOgnOTEF1fJU1dZx7+FpKqTkr8AwHnmLUKMNJ86DUfqSRiv
         6tag==
X-Gm-Message-State: APzg51Ae7qtBmbzMcgQMZnQ+LVvA92RZ1IvuQHQwtUi7oNCwyxENJf5o
        fXnWbS8vxfWkQ8M1pPO9ckg9euZbnfFm4+hHSeexsjMoE+U=
X-Google-Smtp-Source: ANB0VdZAt5XOXxELa6f6y8N8kZtoLq/CMJEp9xM3QTE1DqP1hGLzWAFIXQJRnzTNZeCXI+dh99kKU9lOPB/HBmcH4nw=
X-Received: by 2002:a02:b38c:: with SMTP id p12-v6mr26558141jan.79.1537283949508;
 Tue, 18 Sep 2018 08:19:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6cc5:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 08:19:09
 -0700 (PDT)
X-Originating-IP: [2a02:168:569e:0:3106:d637:d723:e855]
In-Reply-To: <20180827071824.GG3850@dragon>
References: <1534472646-10368-1-git-send-email-zhongjiang@huawei.com> <20180827071824.GG3850@dragon>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 18 Sep 2018 17:19:09 +0200
X-Google-Sender-Auth: KrqEDgVS1HulppUMudA-xSag9Dg
Message-ID: <CAKMK7uFVVKgZy3tVsG4f-TFbaYZYxBHrcS0FgCVZOU7M9mq_pg@mail.gmail.com>
Subject: Re: [PATCH] gpu: do not double put device node in zx_drm_probe
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:18 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Fri, Aug 17, 2018 at 10:24:06AM +0800, zhong jiang wrote:
>> for_each_available_child_of_node will get and put the node properly,
>> the following of_node_put will lead to the double put. So just
>> remove it.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>
> Acked-by: Shawn Guo <shawnguo@kernel.org>

Shawn, I'm assuming you'll push this to drm-misc-next? You're the
maintainer with commit rights after all.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
