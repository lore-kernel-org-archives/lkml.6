Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3A6C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 03:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC4120897
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 03:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNLe+ZkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC4120897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeHYGim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 02:38:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42154 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeHYGim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 02:38:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so5330662pff.9;
        Fri, 24 Aug 2018 20:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=Tj4JIaHF/UzMqiqoRgQruJrP1tA6YfrhXZt8z1Ywk/w=;
        b=CNLe+ZkKAF5h8QULJJLe7dYPvE8fgfg8562qahGnAYnKvX1dbpsGTi7A18BkTfGAs8
         MpJdXnh5RUvhRprXAYwOQJtTxHaQChqlwAqHfFczI9fDXdDVCo8oRS39EgMtwtYMHr1r
         bZO+7tFY2y5ERYxn9RLh9Kr4KQZuW8jfxTXMaNoGErZW5VsWRC7LuLqYjXAfwxS/D2GD
         WdnxqJ40QptznrcOIwjnHscBKmyBdAbgX32GK17+GivPQhZn5CvlJ5+ys6MXs52DzC4p
         lwtUfZhFOycURiIDDviRkTEAjM403xcSkSlcnEAd8T+0ykImZAH0oON4yUla6e2/Coma
         eUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Tj4JIaHF/UzMqiqoRgQruJrP1tA6YfrhXZt8z1Ywk/w=;
        b=Pb/dQ5qW8lUWKTqsWSLMImWzytKmnJLqAueZLS4a+EIhRmCgu0jvLliacmITRe/kFl
         GgXtWhR9NnEnwW4JZRNOVqFXEMTi167BcPBYnB/SsIfr0TVJLvvZKDj+uqMSseCP3q5e
         FTP1s0VhHwoCuErLI0dTepvP5hdXZrnqZZaQNS3dTRy+bFXbMobPvprxXfnCgb1QaX8b
         9sk19WYMwNoQMai9trtGaRIdMOS0+sLZwi0CiOLCLP8Xkoy051o1eYFny2n3qJWwDo3f
         zRof26KtsGxW7C/+P1hXIrMWQMwv6z68U+aux7nzPTeNR/u38guT+Ar/KRLjgVb66Rtu
         2OhQ==
X-Gm-Message-State: APzg51BKaS2AoMMoaEaB1fDYWlOvl6xpEirrSMJPaWDAv5LsquCABGxp
        FG5jzNIgROrSemPGKskH7Rw=
X-Google-Smtp-Source: ANB0VdYvnsjfQaTHM1AwuVtAOyAfeVpCx2BLv9pSXYQgNiEAiaViKBQSX1IUPiKbTQnkD5cfgdgebA==
X-Received: by 2002:a63:d613:: with SMTP id q19-v6mr4096376pgg.327.1535166082621;
        Fri, 24 Aug 2018 20:01:22 -0700 (PDT)
Received: from [0.0.0.0] (96.45.178.72.16clouds.com. [96.45.178.72])
        by smtp.gmail.com with ESMTPSA id v20-v6sm16592867pfk.12.2018.08.24.20.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 20:01:21 -0700 (PDT)
Subject: Re: [PATCH] fs: Fix double prealloc_shrinker() in sget_fc()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, dhowells@redhat.com
References: <153131984019.24777.15284245961241666054.stgit@localhost.localdomain>
From:   Jia He <hejianet@gmail.com>
Message-ID: <3a12cb86-5d2d-aa24-56fb-ec046570705d@gmail.com>
Date:   Sat, 25 Aug 2018 11:01:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153131984019.24777.15284245961241666054.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2018 10:37 PM, Kirill Tkhai Wrote:
> Hi,
> 
> I'm observing "KASAN: use-after-free Read in shrink_slab" on recent
> linux-next in the code I've added:
> 
> https://syzkaller.appspot.com/bug?id=91767fc6346a4b9e0309a8cd7e2f356c434450b9
> 
> It seems to be not related to my patchset, since there is
> a problem with double preallocation of shrinker. We should
> use register_shrinker_prepared() in sget_fc(), since shrinker
> is already allocated in alloc_super().
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/super.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 13647d4fd262..47a819f1a300 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -551,7 +551,7 @@ struct super_block *sget_fc(struct fs_context *fc,
>  	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
>  	spin_unlock(&sb_lock);
>  	get_filesystem(s->s_type);
> -	register_shrinker(&s->s_shrink);
> +	register_shrinker_prepared(&s->shrinker);

should be &s->shrink here  ?

-- 
Cheers,
Jia
