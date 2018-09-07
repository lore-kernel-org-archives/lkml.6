Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E187C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11A72083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="sPX96o6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11A72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeIGWoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:44:05 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42386 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIGWoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:44:05 -0400
Received: by mail-yb1-f195.google.com with SMTP id j8-v6so5749216ybg.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mi2ctbxXWmOUuQPHCVmVfMnMu3gq2QCj6jYt8Ttr3xU=;
        b=sPX96o6hl1DdKplFd9EtMbCZOUNAAky/W+PiHaQuJN+hS1Jnau6DlSJ9wMRD3d/ME3
         WlgRxwpLkOwccmprNwOoVh1I7J8pHAsKVBA/a/qFF/1Hk9V2Q3AY7vqn770tpy5xt+xq
         CLfvPV74TQUbvXi8E5M02odKPf8gIq67yNtDx2XBLKxAuCTIu0Kx9UQ/+SmxeUPNfPDz
         Q+ixxnDnlbxbpWklpUq1C/GSTRKEkfgAotl4+jCzNyjbrAdFJK9cV3oeTV3GlSnNp7is
         u7AMUZpb51p0mnOVhYWX574UtL5Vaed6bTRArHpYYjchPibsEOHAe5HDhi2h5fOKoH4V
         bfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mi2ctbxXWmOUuQPHCVmVfMnMu3gq2QCj6jYt8Ttr3xU=;
        b=iHbbf9BAKamVY0qMKvmUvIqoPXO72nTD3uEkh1Gc6be5c7uuN1PHHk7QjYlc8CXiAn
         XaxaNBx8AtusCwyjbGQrQHc9Fun4AxakJbPKmIX+C8nRf2dS0kg82FHOiE/iwWsBm5oZ
         VIXM03fr2PgnS+Shs3idMSvDND7rapz4GBZfat6FZG342OB25WrTSBHuORPKlCPnpPHT
         SOqfwfDO9y41rqY1YGs8X7P4CCwgD6OtQkveWfy79RqYrBRa3zvdYryk0+BJQ4Dbf9DL
         FrOt1gWc4zoIm4xUawH1ggaD3yB+fPY5b1RGq+/mkDzB6OQkBGkBSMYoLZEFoq1zypJi
         0tpA==
X-Gm-Message-State: APzg51CqOd1lDrJHlfGKyMr9ymh7bP9YRHuGwo3Zk4XIdKVED2pfGeQU
        rl0InQ1oLpn9q4F0b9aChC5SC4+IFUaZndUZqMdy2SAIhKQ=
X-Google-Smtp-Source: ANB0VdZ65Xun3/poD7ioQgM5Ta3o1JtqghhVIKmkf6lhTwGPoffUz5Ll+Yv2FXO7ceV9A2BwsDmtoj85nXl/k87aAYY=
X-Received: by 2002:a25:9186:: with SMTP id w6-v6mr4540992ybl.316.1536343319883;
 Fri, 07 Sep 2018 11:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180905145401.19772-1-colin.king@canonical.com>
In-Reply-To: <20180905145401.19772-1-colin.king@canonical.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 7 Sep 2018 14:01:48 -0400
Message-ID: <CAOg9mSTSiqaAiSuxN5uqQWoMF1W5ZXFgZ36jFHOFHRVe7CMraw@mail.gmail.com>
Subject: Re: [PATCH] orangefs: rate limit the client not running info message
To:     colin.king@canonical.com
Cc:     Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks... I've applied your patch to 4.19-rc2 and run it through xfstests.
It is in my linux-next tree now.

I put that in there because I'm really just an old system administrator,
and I would always be happy when I could tail dmesg and see some
hint at why something wasn't doing as I expected.

I just looked in ratelimit.h and at the ratelimit macros in printk.h,
I should try to think about those more when adding sysadmin-alert
messages.

-Mike
On Wed, Sep 5, 2018 at 10:54 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently accessing various /sys/fs/orangefs files will spam the
> kernel log with the following info message when the client is not
> running:
>
> [  491.489284] sysfs_service_op_show: Client not running :-5:
>
> Rate limit this info message to make it less spammy.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/orangefs/orangefs-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/orangefs/orangefs-sysfs.c b/fs/orangefs/orangefs-sysfs.c
> index dd28079f518c..19739aaee675 100644
> --- a/fs/orangefs/orangefs-sysfs.c
> +++ b/fs/orangefs/orangefs-sysfs.c
> @@ -323,7 +323,7 @@ static ssize_t sysfs_service_op_show(struct kobject *kobj,
>         /* Can't do a service_operation if the client is not running... */
>         rc = is_daemon_in_service();
>         if (rc) {
> -               pr_info("%s: Client not running :%d:\n",
> +               pr_info_ratelimited("%s: Client not running :%d:\n",
>                         __func__,
>                         is_daemon_in_service());
>                 goto out;
> --
> 2.17.1
>
