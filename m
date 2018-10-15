Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D10C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F002064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="yEUUgIOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F002064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeJOTik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:38:40 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:32993 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOTik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:38:40 -0400
Received: by mail-wr1-f52.google.com with SMTP id e4-v6so20987043wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PS5BRA56e8+AjLCnv1NRlZKOksTtO1baoz0kebiyIGU=;
        b=yEUUgIOKhOLDG+UQAYsLMQ/+iSy3BvL7Y+O5jYYJa+9xTlm7UUJfEYoVI1ipQQo/Mq
         D7YKQ+oJ0rROuJJDDDS3uoqdjxM7Gq12r523a1+yAynI+iMeWGQD92CGFw4S6E1oZ1rH
         fK/AYYOl+EGKhp0bV9+ukxAzpWl+72XoSs/+fx4NIktI9ok2ObZ1FQzYsqNcFj4xw9oF
         DLG44wBb9W8ZRshBxg6FIiYqxbjS6IQu21Q6w4Z0CoFRfv1hQZje1wVivvEK8sI2zxHP
         uXVcgbHumny2ABu15pV565040wxKV0LpGpFFrLbpf4sYNcy8zeWY+er3nXI0m0DzY00F
         oZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PS5BRA56e8+AjLCnv1NRlZKOksTtO1baoz0kebiyIGU=;
        b=HIG/uep3ZutAcUagKKcgEAiOlZI1f08TINM/t7uefSBfcRJ+p6VblZUei+4BiGeSRv
         +rQFmqZpJuEd+bl8dKJPspcUveRbQ1DoA2HCWy0nGxlgXZ5JXPRqifwS1OBOlKkt7NXa
         7JuaHc+hdNxTEWE8WVkOriaflpugJEUSXGnIpg9pRYelYpxt9EatDVSBhxMvzuO7FAIW
         7kWLxgTIuY8SPp9ioZZ5xXj8TBaHFHPpjQXIxw+7jtIkf5kfMEgkZAGre9Wiwqjy0AHi
         E1noJ1eEtutbo0qBBAScXeRK5Nwz+ShxKewu0obTxQmmB+czB+plA6mI2N9xxCyjhgKV
         IbtA==
X-Gm-Message-State: ABuFfogo27FzEl0OsMWi+8hpBBdSBOF9/427/wApGqcQD0CuXuutqe8W
        iVIwA5tzo2Rzgb+lh4ETCLPAEUSQG8WS9x4hM66HtA==
X-Google-Smtp-Source: ACcGV61JNdMF5OaB1C7Oznw/Wqndp5MAngcQKIchgrkMJX2S1CiEx/FAoMad+/ZERNkFcGR6D2aPppux5VqT69MnZjg=
X-Received: by 2002:a5d:5501:: with SMTP id b1-v6mr13670871wrv.228.1539604422595;
 Mon, 15 Oct 2018 04:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <1539012243-7489-1-git-send-email-jinpuwang@gmail.com>
In-Reply-To: <1539012243-7489-1-git-send-email-jinpuwang@gmail.com>
From:   Jinpu Wang <jinpu.wang@profitbricks.com>
Date:   Mon, 15 Oct 2018 13:53:31 +0200
Message-ID: <CAMGffEkBzPEUPveXbJRVT8YsfBNgq1LJwj4Tc1RTqok23bUHjQ@mail.gmail.com>
Subject: Re: [PATCH] md/bitmap: use mddev_suspend/resume instead of ->quiesce()
To:     Wang Jinpu <xjtuwjp@gmail.com>
Cc:     Shaohua Li <shli@kernel.org>, NeilBrown <neilb@suse.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 5:24 PM Jack Wang <xjtuwjp@gmail.com> wrote:
>
> From: Jack Wang <jinpu.wang@profitbricks.com>
>
> After 9e1cc0a54556 ("md: use mddev_suspend/resume instead of ->quiesce()"=
)
> We still have similar left in bitmap functions.
>
> Replace quiesce() with mddev_suspend/resume.
>
> Also move md_bitmap_create out of mddev_suspend. and move mddev_resume
> after md_bitmap_destroy. as we did in set_bitmap_file.
>
> Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
> Reviewed-by: Gioh Kim <gi-oh.kim@profitbricks.com>
>
> ---
> v3->v2: Drop the change in md_bitmap_resize, as Shaohua noticed
> mddev_suspend/resume is supposed to be called with reconfig_mutex hold, i=
t's not
> the case here.
> v2->v1: add reviewed-by.

ping?


--=20
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
