Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B5CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B8E21D62
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="D44ifDBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B8E21D62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbeHIOu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:50:28 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:42190 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:50:28 -0400
Received: by mail-oi0-f53.google.com with SMTP id b16-v6so9416972oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d7Lc/CnNbHRin4yBAktv/eaMBtP6IosIuYbZxW6Z+/A=;
        b=D44ifDByu6pICpuouNYKg0jurGPS0pn0J3TTcbGucrBr3b3RAfutiSYcD1CwKvuK+I
         26OBKa5T6YJdgjMll/2DnGmywuNt7yWzFqRS4vuh8jxAAZqa/iqdUZ7A2e7bNlMxgNGq
         xzCmGpCLuCbuKfWTj2UHtfOv9HCF0n5/Vxh1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d7Lc/CnNbHRin4yBAktv/eaMBtP6IosIuYbZxW6Z+/A=;
        b=S6Z2kLwrEUKSnjdNQRrukGMiPvZNjYfq9RaA/nfARyvz/XLPO+fW8GNzQ9Q0BSPFTb
         dfQpxPGbMQvb4Bnmoyoy6D/1nDrV/sVT1rXHed8t1O3i2AKB6CLR48qdKT2hbgasqc+N
         Vw/LJN5lzkcr6L4IGK+/sUrWuVwvEVfE+aMMZqGXFCbb/+OBnhfytyT6oUa6pRspuF4M
         PyZcX+F3hOmfoj4JOxIq5Ysy1NeSMLkP4b+oSISK9XjjkKlEl0sUh2AF6flbf0Cyn8rs
         NAGi8nbPVwhBtV17xFIzXigT5tlrI1sbchCwzFQXZvrPmjD0gzM+YkXuYUDnw2JECBm6
         vJ3Q==
X-Gm-Message-State: AOUpUlHT1gY2Pj9NOiiU5Z+WEUU0yigmvwlVoGqbMJYHJYikepqjakxG
        NYedr8HzUBhnmqMfihcVUeg7MjZOlqFuhNRwdkdYbw==
X-Google-Smtp-Source: AA+uWPzTkeMwkD0FlpsIJeYEdXrGJishJIUqSUCG4Ig2NtvXJ66baJk6vxWqK72D6lDUwLqDezuZVMNrRpyYBNNmsvA=
X-Received: by 2002:aca:3c45:: with SMTP id j66-v6mr1739560oia.118.1533817548552;
 Thu, 09 Aug 2018 05:25:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 05:25:47 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <EA52CBCF76D5E04D95BED55B83577BE7A677C0@MBX50.360buyAD.local>
References: <EA52CBCF76D5E04D95BED55B83577BE7A677C0@MBX50.360buyAD.local>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 9 Aug 2018 14:25:47 +0200
Message-ID: <CAJfpegt4ymM8Zuto8vDX4djP5S-t3DMaaKn0ntwCsG1JaBpExg@mail.gmail.com>
Subject: Re: FUSE: write operations trigger balance_dirty_pages when using
 writeback cache
To:     =?UTF-8?B?5YiY56GV54S2?= <liushuoran@jd.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?UTF-8?B?5YiY5rW36ZSL?= <bjliuhaifeng@jd.com>,
        =?UTF-8?B?6YOt5Y2r6b6Z?= <guoweilong@jd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 2:08 PM, =E5=88=98=E7=A1=95=E7=84=B6 <liushuoran@jd.=
com> wrote:
> Thanks for the advice. I tried removing BDI_CAP_STRICTLIMIT, and it works=
. There is no balance_dirty_pages() triggered, and the performance improves=
 a lot.
>
> Tested by libfuse passthrough_ll example and fio:
> ./passthrough_ll -o writeback /mnt/fuse/
> fio --name=3Dtest --ioengine=3Dpsync --directory=3D/mnt/fuse/home/test --=
bs=3D4k --direct=3D0 --size=3D64M --rw=3Dwrite --fallocate=3D0 --numjobs=3D=
1
>
> performance with BDI_CAP_STRICTLIMIT:
> WRITE: bw=3D158MiB/s (165MB/s), 158MiB/s-158MiB/s (165MB/s-165MB/s), io=
=3D64.0MiB (67.1MB), run=3D406-406msec
>
> Performance without BDI_CAP_STRICTLIMIT:
> WRITE: bw=3D1561MiB/s (1637MB/s), 1561MiB/s-1561MiB/s (1637MB/s-1637MB/s)=
, io=3D64.0MiB (67.1MB), run=3D41-41msec
>
> However, I wonder if there are some side-effects to remove it? Since it s=
eems that the original purpose of this feature is to prevent FUSE from cons=
uming too much memory.

Yes.  So if BDI_CAP_STRICTLIMIT is causing a serious performance
bottleneck, then we need to think about solving this without losing
the benefits.  Simply removing it is definitely not a proper solution.

Thanks,
Miklos
