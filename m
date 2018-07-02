Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF13C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FF625447
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LBs7iYvI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i7D0qQa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FF625447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeGBQAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:00:42 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34406 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeGBQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:00:40 -0400
Received: by mail-yb0-f194.google.com with SMTP id e9-v6so5277719ybq.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AaT+c8drCI7LjtnWVfgBDzNHmKkWFGFv2OMYu0F7c0Y=;
        b=LBs7iYvIU/xObAp2y2MCPMLO3pyVsEauliAvFmwqYCx9BRWR2NA0UvwGIjVEJBPIj5
         U6MSvL6wEkV1FTXQQAztEo6dHRIokJt88rABpzFguk8vejNFdMGDSqElA1HFusdOqJSy
         VAZz+rpe9NDoR6+yW0u9WN0VAfKAsH90j0SFE0Op8jWXARW8XsNmaWh4SxIfg26N72ec
         ADl4IWPIWSuicBP6cs5nu04M3Ega8lvXltbnuTHb4/YLz9jA/GRvDY/fweS+A+VNI90g
         SvYDaEQ+uVu/4iOik6DJQN6pnCvxUNI+ahx/YgId2R77okmCgx2J72vnC7FoqUoLLPQm
         t7Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AaT+c8drCI7LjtnWVfgBDzNHmKkWFGFv2OMYu0F7c0Y=;
        b=i7D0qQa1YS4lGM/TygeKSoLeSa9irrC3zjtX72vN9eUgShlKF1k2M9oAyjI3UXxuvH
         19eTJUsgFBZ6eOfJ+GqDCiGS4HqwgMaQ6Qn1dpalkPe8vodfyoSHxS+NAjgdRuowt1uH
         MppK4Av1swW45Q6JgxlCR+BMCooBK9ZHfxBr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AaT+c8drCI7LjtnWVfgBDzNHmKkWFGFv2OMYu0F7c0Y=;
        b=ES1/gevxj0JPc2bCyf6z/0hspEsxdqHpkUpUTXBar/A0tf1X9sN2lm7Zbrl7qUeMMc
         C2gjlev/VOJiu0/xPah5gih6epB8Gd6x/o8LvuN3kt9YO1DA3ae5V0jbTnxzVXuOKrrm
         UN9Qk2pJqkAeUXGgVENzmSfYEP/L2Yt2FNNxKm2Sj+TL5XlV0F65w8Ly1n7BcciiT1KB
         4WasJAZJraXhDrE05dkN5l6+O/ERDR3SoAVqXTu30aW3ZbPFajPP2vid19h66iQ8F1iB
         s3KoPoOThixpVOtJXWFI53BhubSRNIfGUfa4MY4WH13zZ7myo35Ce9Q17OPSV+tpZCPa
         P7ig==
X-Gm-Message-State: APt69E02O3N+QXoBwKhVToS5yjiNI6rd90Z5MIYlb/ddCy6Qk7P0w+AC
        R7KV3l/bQf245t0CLl5ZGi2AMcVWrisD7TMijtGJFA==
X-Google-Smtp-Source: ADUXVKIg7R9HEmF11x+DcGICt+0lm8+K8+UDiIczZC1PXFYNcdw4GvmMDl39hbQZKdOn9c77OHhr3rW9nVVtnsr+RXA=
X-Received: by 2002:a25:3445:: with SMTP id b66-v6mr13771624yba.484.1530547240013;
 Mon, 02 Jul 2018 09:00:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 09:00:39 -0700 (PDT)
In-Reply-To: <20180701212051.29486-2-richard@nod.at>
References: <20180701212051.29486-1-richard@nod.at> <20180701212051.29486-2-richard@nod.at>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 09:00:39 -0700
X-Google-Sender-Auth: _MIQXxaMyTB3iT3BB5ihZ8DZXFU
Message-ID: <CAGXu5jJcrNtM4HXX=YJJjgMAiYRtWAtsdMkMxhon9XmR7O_Htg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ubifs: Check data node size before truncate
To:     Richard Weinberger <richard@nod.at>
Cc:     Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 2:20 PM, Richard Weinberger <richard@nod.at> wrote:
> Check whether the size is within bounds before using it.
> If the size is not correct, abort and dump the bad data node.
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: stable@vger.kernel.org
> Fixes: 1e51764a3c2ac ("UBIFS: add new flash file system")
> Reported-by: Silvio Cesare <silvio.cesare@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/ubifs/journal.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index da8afdfccaa6..eea12d25a58b 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -1387,7 +1387,16 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
>                 else if (err)
>                         goto out_free;
>                 else {
> -                       if (le32_to_cpu(dn->size) <= dlen)
> +                       int dn_len = le32_to_cpu(dn->size);
> +
> +                       if (dn_len <= 0 || dn_len > UBIFS_BLOCK_SIZE) {
> +                               ubifs_err(c, "bad data node (block %u, inode %lu)",
> +                                         blk, inode->i_ino);
> +                               ubifs_dump_node(c, dn);
> +                               goto out_free;
> +                       }
> +
> +                       if (dn_len <= dlen)
>                                 dlen = 0; /* Nothing to do */
>                         else {
>                                 err = truncate_data_node(c, inode, blk, dn, &dlen);
> --
> 2.18.0
>



-- 
Kees Cook
Pixel Security
