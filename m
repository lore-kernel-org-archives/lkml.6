Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4508EC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF7A2240A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOUX2qTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF7A2240A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeHJN3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:29:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37143 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeHJN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:29:20 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so2086670itf.2;
        Fri, 10 Aug 2018 03:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdWEbC5MNlUAWSOuaTtiyTEsb0MFuFSQzeIXMyo6x78=;
        b=lOUX2qTzrsFi2ok/QJyhK1pssq5ZWff9srOoSWO2YsyFhr69B/NrJrTcpo/jS3jhOm
         3JEJyFXHUW5+midYEXX7B6bmeQT5mLh5qKaKYxs9WVYOOPIYby/6nUhGr3awAsNXRzoB
         QEa8QACTuuQ1cXB1+ElqFJdg4u5bSZQ15udSaEz4LvFlTIpZMvvOTCtmw2/d9RRJg96J
         td+2Yjpgx3ZXk2l9+QMFkNNI2qbYsjaxhPiKfDZVjZ5eWOOgj48ZqPrSsGrEGbiJSPBr
         8yCKIlmBOoC9emAl2fDDu6/evS7cleSOLNyFsk0URjubJP5NoL100Av2VCVxKAZrpHEr
         KhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdWEbC5MNlUAWSOuaTtiyTEsb0MFuFSQzeIXMyo6x78=;
        b=Bc3XndMKZfG1nQuxjfsPPPa20AgjC/4TaHHtnUpYlxOqSNkbrd9NA/yP9feqFgHQ+O
         tUKD4TdYTQOHccXwFehpuUipRYBL47Bw3sfOKGgew2PyI0uroEhPEOSlRXZXPZ3ojMe/
         Bsd0r0GRC8FrWLAHL+FNEvsTi+s3JdoJ55/2WFWQ/6SopFbv0yOhlNlH34QJM6VQsp0u
         cdhUiKQrEtT9ybmpYNnzMmEA3wDCIHUa37Pe1l68eXiZFOmsle343zcgoxoedKVr/eif
         qgTUSPb/1S7yHtOURsq4i5Ugx7EerIGXgnIHfI/ViL4s8scopEF+KnzFBbdvexOQAd4G
         zVIA==
X-Gm-Message-State: AOUpUlFnR7iDe/odNXE5Yq0vHjYFRTeiHiDHL8iYhFjLbb9WEtumGCi1
        hS17Dtm0NVFqQtwyTkrkyYuKeEn7evCNKdOtAJM=
X-Google-Smtp-Source: AA+uWPyDYFsaILXJdQ+1ijqvmK5ugcvnb4VZL7vIwfpao4Pk0Mun1Omd0IDtZAk0c8e3kR6fJKpoAAiV4tpmNh2MXqQ=
X-Received: by 2002:a24:5d4a:: with SMTP id w71-v6mr1803061ita.118.1533898794740;
 Fri, 10 Aug 2018 03:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180808115257.6088-1-yuehaibing@huawei.com>
In-Reply-To: <20180808115257.6088-1-yuehaibing@huawei.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 10 Aug 2018 12:59:43 +0200
Message-ID: <CAOi1vP-Vg8qoMe12OzTOwVaGgzU4GP2wBdhGyEV67Rd4edKVFw@mail.gmail.com>
Subject: Re: [PATCH net-next] crush: fix using plain integer as NULL warning
To:     yuehaibing@huawei.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 1:53 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes the following sparse warning:
> net/ceph/crush/mapper.c:517:76: warning: Using plain integer as NULL pointer
> net/ceph/crush/mapper.c:728:68: warning: Using plain integer as NULL pointer
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/ceph/crush/mapper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
> index 417df67..3f323ed 100644
> --- a/net/ceph/crush/mapper.c
> +++ b/net/ceph/crush/mapper.c
> @@ -514,7 +514,7 @@ static int crush_choose_firstn(const struct crush_map *map,
>                                                 in, work->work[-1-in->id],
>                                                 x, r,
>                                                 (choose_args ?
> -                                                &choose_args[-1-in->id] : 0),
> +                                                &choose_args[-1-in->id] : NULL),
>                                                 outpos);
>                                 if (item >= map->max_devices) {
>                                         dprintk("   bad item %d\n", item);
> @@ -725,7 +725,7 @@ static void crush_choose_indep(const struct crush_map *map,
>                                         in, work->work[-1-in->id],
>                                         x, r,
>                                         (choose_args ?
> -                                        &choose_args[-1-in->id] : 0),
> +                                        &choose_args[-1-in->id] : NULL),
>                                         outpos);
>                                 if (item >= map->max_devices) {
>                                         dprintk("   bad item %d\n", item);

Applied.

Thanks,

                Ilya
