Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C02ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6771214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeNZ+zPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6771214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeIQQUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:20:50 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34533 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeIQQUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:20:50 -0400
Received: by mail-yw1-f66.google.com with SMTP id y134-v6so5236368ywg.1;
        Mon, 17 Sep 2018 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fA1nUlEz+N7M2D+tDxOVeSk+U0bT/2oDobcJWPqYKkc=;
        b=YeNZ+zPnD0T6T90U4afBQVGaCVmKknBTAuu6PLvrr/mLBYMEZAyLEW4FpJHoccLMdt
         CZnIeBp6Xz7cGVhp7CzBYD+FYTr1juw7gv/kqoqVOTqmvETtZoFW6sxMEGUCURPhlP3F
         uKFMBliPEcsrO/y9qCp+rcaVuo+xnVWKyyitdTPz7laHeVk7/LW8Nqfgcq3T5gC+y14J
         yjeo44ksjnRHuUaDYnLaXyoh+45TK5iwNbRVfJNEeFhlHt7prr/t6tWJpBfMyPvNrv/V
         BpUVP0AMC8bdLFFECKeYk8redJoPiNi61311lqdB2vvxt5sJ+x9A8V0eyxRReTJGE2ZP
         5M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fA1nUlEz+N7M2D+tDxOVeSk+U0bT/2oDobcJWPqYKkc=;
        b=JhhzcyXdctrj+zAbKvEjq1NQHTqOJdSxTrmoGHFZpTfjyzS85LFOj35obvhR89B+4u
         rrS9gmBLup8OgP5sJ436gw7eRgyGb9wkqRpOW/qXb41Wkbf84/Z7evf8vAbfQx5NadF9
         hI8mMOx1LbZjTvl0hH1jeWuXw4XMpnZUvM+D1GB9Lgnb1G1lb8cF/oV2wFU/GVdXm6cC
         E1Te6XZMQXAOW71P06/WLQ1fR67NAGFwZWRNsTWAAT9uWt9XlbwQyQAR/QEOqo1Cne1r
         jPqINg9pUq97EB1Ei1KLKVk9ccrrmfCr5UEYnyGyaFvoAgQLlPMSbDWQ8PT4p452GfJ/
         b8uw==
X-Gm-Message-State: APzg51CwlfwQExUMAG08RsjHQiUihCCpx5qZWSZ3dlmygd09HQVsm7Y/
        yjxMdRuebUrOZYwpqWNplyE5Ft45ForEYgexPQw=
X-Google-Smtp-Source: ANB0VdZ967HhBbhWpuYdE78fpsMBR6xIH2nYZfHFERp5j1Fea3PsQce5e9hI6oGuHKPoXMkjYdBSQnLtO6zmkUczl18=
X-Received: by 2002:a81:ac09:: with SMTP id k9-v6mr10119806ywh.409.1537181640112;
 Mon, 17 Sep 2018 03:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180917091602.21531-1-nixiaoming@huawei.com>
In-Reply-To: <20180917091602.21531-1-nixiaoming@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Sep 2018 13:53:48 +0300
Message-ID: <CAOQ4uxiBMD7ZRVz=iiY9bUEmvQOYSqz7wWxMQvwj7EpAd-ft1A@mail.gmail.com>
Subject: Re: [PATCH] fanotify support save thread id
To:     nixiaoming@huawei.com
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 1:02 PM nixiaoming <nixiaoming@huawei.com> wrote:
>
> Added FAN_EVENT_INFO_TID to select the thread id of the event trigger
>

Maybe "to report the thread id of the task that caused the event".
Also in commit title, I think "reporting thread id" is more to the point
than "save thread id".


> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -18,6 +18,7 @@
>
>  #define FAN_ONDIR              0x40000000      /* event occurred against dir */
>
> +#define FAN_EVENT_INFO_TID     0x02000000      /* event save thread id replace tgid */
>  #define FAN_EVENT_ON_CHILD     0x08000000      /* interested in child events */
>

nixiaoming,

You misunderstood me.

I meant that you should add support for flag FAN_EVENT_INFO_TID
for the fanotify_init() syscall, not the fanotify_mark() syscall.

See this commit from Steve Grubb for example of adding new opt-in
behavior to fanotify:
de8cd83e91bc audit: Record fanotify access control decisions

BTW, Steve, did you ever follow up with a man-pages patch?

Thanks,
Amir.
