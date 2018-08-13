Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F5C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F288221730
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaeVpror"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F288221730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbeHMTWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:22:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36649 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbeHMTWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:22:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so14847352wro.3;
        Mon, 13 Aug 2018 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tOR25S/KdaplFdfBegsBk3nfA7DK7sEOd0coNwIZGZM=;
        b=gaeVprorMLjDUgppwG74BIez/sMe35LBOoxGvZb/6D0c8qFmp1b9mxRSDJ9NdRpNqb
         JzfJ6l1K3BoizyU2s+zAweJAlpG/IPaLmTjbxxNkK8m8J9rG9avznUMbHz+7ktKoB7i3
         /MO1xqLubVGOADCLV0GG1Pg90U4oijQWws2uaVbAZRtkkl6TzlMtsKv8c2rv6uZe1p4L
         kfGYQlJ4GfBhwlpn06ozwjzFXDNMmDCnFYu+V3YJVa7QTC33Bee+68UXKcHpii+qiHFs
         2Ighj/iyld4Q5lwojN6Z7cNqNhiBLbCrKdoSkSIh13vj9zqeS2vWSIv3LPrfNU+5+ImF
         1H8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tOR25S/KdaplFdfBegsBk3nfA7DK7sEOd0coNwIZGZM=;
        b=tepyVPkzFVuOLiWK3UegWGneSp5dJ1roolyoTgLsCrBGd/GV5dI0/l132aSfKphwMF
         h40iBnwymgOp1XJymr4yv2evHwG3TkC7/1VinS+M2BdZ7PogOOCx2qZatC+stwMHxHSa
         /mvW6EKUvX/tt2qf8SHBPZRlRdT44uAgJTpjgouEfWGw1FxCgwxye+Pv/Ngtu0nHFqU6
         832u+5THcUBDdwmew+6QgLMDmbDfqJoV/xp+CeNmQwEikhf86cECQUudj8/hybnXXOBb
         HWovO3SEW6wVj49A5QZkEl/MVVzqjH9B05ccjosB3+Iypee/rzRFbfDqOHM1zX5PvZ48
         aj4g==
X-Gm-Message-State: AOUpUlE2KMFzq0GWSOUBEShhs1zwUdmq1G9zWyKdFDSc+tb3wXCH3glk
        BUcg0hFDKQFJgXwuofgALC7Dalt3U/s=
X-Google-Smtp-Source: AA+uWPzI+jQDs+dWzJe0V2ct9MUAqfc6MgqIn/rM/Xjg3c2U00fmwv+TS764kCi/MAkrcqyuTHg7RA==
X-Received: by 2002:adf:8405:: with SMTP id 5-v6mr10885755wrf.41.1534178390601;
        Mon, 13 Aug 2018 09:39:50 -0700 (PDT)
Received: from ?IPv6:2001:a61:25e2:700:4f0c:c4f8:e531:4a0d? ([2001:a61:25e2:700:4f0c:c4f8:e531:4a0d])
        by smtp.gmail.com with ESMTPSA id s2-v6sm16998603wrn.83.2018.08.13.09.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:39:49 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, pi3orama@163.com,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v3][manpages 1/2] perf_event_open.2: Document
 PERF_EVENT_IOC_PAUSE_OUTPUT
To:     Wang Nan <wangnan0@huawei.com>, vincent.weaver@maine.edu
References: <20161024065256.160703-1-wangnan0@huawei.com>
 <20161024065256.160703-2-wangnan0@huawei.com>
From:   "Michael Kerrisk (man-opages)" <mtk.manpages@gmail.com>
Message-ID: <7bb03d5d-fbfb-f4e4-d505-de012535f844@gmail.com>
Date:   Mon, 13 Aug 2018 18:39:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20161024065256.160703-2-wangnan0@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wangnan,

On 10/24/2016 08:52 AM, Wang Nan wrote:
> Linux 4.7 (86e7972f690c1017fd086cdfe53d8524e68c661c) introduces
> PERF_EVENT_IOC_PAUSE_OUTPUT feature. Document it.

Just to confirm, I presume this patch has been superseded by the one
from Vince that I just applied.

Cheers,

Michael

> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Reviewed-by: Vince Weaver <vincent.weaver@maine.edu>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> ---
>   man2/perf_event_open.2 | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/man2/perf_event_open.2 b/man2/perf_event_open.2
> index fade28c..561331c 100644
> --- a/man2/perf_event_open.2
> +++ b/man2/perf_event_open.2
> @@ -1687,6 +1687,15 @@ the
>   .I data_tail
>   value should be written by user space to reflect the last read data.
>   In this case, the kernel will not overwrite unread data.
> +
> +When the mapping is read only (without
> +.BR PROT_WRITE ),
> +setting .I data_tail is not allowed.
> +In this case, the kernel will overwrite data when sample coming, unless
> +the ring buffer is paused by a
> +.BR PERF_EVENT_IOC_PAUSE_OUTPUT
> +.BR ioctl (2)
> +system call before reading.
>   .TP
>   .IR data_offset " (since Linux 4.1)"
>   .\" commit e8c6deac69629c0cb97c3d3272f8631ef17f8f0f
> @@ -2865,6 +2874,21 @@ The argument is a BPF program file descriptor that was created by
>   a previous
>   .BR bpf (2)
>   system call.
> +.TP
> +.BR PERF_EVENT_IOC_PAUSE_OUTPUT " (since Linux 4.7)"
> +.\" commit 86e7972f690c1017fd086cdfe53d8524e68c661c
> +This allows pausing and resuming the event's ring-buffer. A
> +paused ring-buffer does not prevent generation of samples, but simply
> +discards the samples. The discarded samples are considered lost,
> +causing
> +.BR PERF_RECORD_LOST
> +to be generated when possible.
> +
> +The argument is an integer. A nonzero value pauses the ring-buffer,
> +zero resumes the ring-buffer.
> +
> +Pausing a read only ring buffer before reading from it without having
> +to worry about data being overwritten.
>   .SS Using prctl(2)
>   A process can enable or disable all the event groups that are
>   attached to it using the
> 
