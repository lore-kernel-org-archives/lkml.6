Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6CEC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98662174E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeA4PN/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98662174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeH0FZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:25:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36869 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeH0FZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:25:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8-v6so6648463pgs.4;
        Sun, 26 Aug 2018 18:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i9Z7rEls0JEQvQvEc89rJmx3AYA6dhgiIxxDGQFg1SA=;
        b=qeA4PN/tT7ibR06sdCZB4qvkJrHDjrgvxVhj7FO2cj7e42gWQuCfc7rY6V2xPupgkU
         CEOiSQIuwpozUE8cEeX5TjJlXYc6GKnQVIdehnmC2Z8whq9hGJDaH2ZpY0HKERbncWHK
         +yypBG9bCSdpE54PfXj7CEtppLp6Q30+51ZMsCQKuzcsgwkzMS6FxjDLkpehCZZHK922
         SvrAqevDnESEEiIYDErDWprNCfknoiCxMfP3dQW//7UWeqOhEDar5gB72DOryYCq99r6
         cv2+txeBxn00ilgxZ/iqsFm4aa7xPuhrQhvuRsRgbuTBGaexDMCos3hz/xUhPx43TRED
         RXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i9Z7rEls0JEQvQvEc89rJmx3AYA6dhgiIxxDGQFg1SA=;
        b=q01+uX3A/QdKWcDgKfGTXOdko1oygaakDELvbcUTe2Rdc9fk2heeTpo7c001u/lY+m
         O5GoaR3MxvQmtIC3YBojTrzt/cYG2m8tF/tlBgOaz+8Z9yU8a4csa75AHl16EKJbmLze
         OwmnFQkx27/db1h/P36Quk+9SZ2oQnBSCtBaQ4n7ZYYo2LI1djA3PyPpFfqa2bGtEthW
         B2qq7+iAnb7A4oLyJ3vsrqjXiWgQ/Py4CUqaL67unWYlv59KLzo0oybWjqiUUbAYgzzZ
         7KCKtnw7thfm1iHam1LI6eWp1XgxK0LYBg7UxpkYnDMF0xNQlq18Osyg3Xpr/PFzhkLE
         JfDA==
X-Gm-Message-State: APzg51AJcpqwSqlBZS/gQk4qlDhGu5l+u+EX4jnq9ioSNRjr/fp6dH9m
        tL8hp27jAITI6XkvbhbLCBHGNcx06/YUNQhZ12s=
X-Google-Smtp-Source: ANB0VdbszLKtEc8JLQROweXokTQ7SyZemGsRw8xD+3rarA9piKKZka9tb/lGj0qNaWJysfZWhs05jDP586XUHG8cENw=
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr10216917pgc.344.1535334067643;
 Sun, 26 Aug 2018 18:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180709143314.4378-1-jkuhn@barracuda.com>
In-Reply-To: <20180709143314.4378-1-jkuhn@barracuda.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 26 Aug 2018 20:40:56 -0500
Message-ID: <CAH2r5muQXJFzut4upVAk-nTFv3qGGOaG+QKLkGgqGA1HitUMGg@mail.gmail.com>
Subject: Re: [PATCH] fs/cifs: don't translate SFM_SLASH (U+F026) to backslash
To:     jkuhn@barracuda.com
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tentatively merged into cifs-2.6.git for-next but would like a little
more experimentation with it if possible (or description of what
scenarios/servers have been tried)
On Mon, Jul 9, 2018 at 9:53 AM Jon Kuhn <jkuhn@barracuda.com> wrote:
>
> When a Mac client saves an item containing a backslash to a file server
> the backslash is represented in the CIFS/SMB protocol as as U+F026.
> Before this change, listing a directory containing an item with a
> backslash in its name will return that item with the backslash
> represented with a true backslash character (U+005C) because
> convert_sfm_character mapped U+F026 to U+005C when interpretting the
> CIFS/SMB protocol response.  However, attempting to open or stat the
> path using a true backslash will result in an error because
> convert_to_sfm_char does not map U+005C back to U+F026 causing the
> CIFS/SMB request to be made with the backslash represented as U+005C.
>
> This change simply prevents the U+F026 to U+005C conversion from
> happenning.  This is analogous to how the code does not do any
> translation of UNI_SLASH (U+F000).
>
> Signed-off-by: Jon Kuhn <jkuhn@barracuda.com>
> ---
>  fs/cifs/cifs_unicode.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/fs/cifs/cifs_unicode.c b/fs/cifs/cifs_unicode.c
> index b380e087..a2b2355e 100644
> --- a/fs/cifs/cifs_unicode.c
> +++ b/fs/cifs/cifs_unicode.c
> @@ -105,9 +105,6 @@ convert_sfm_char(const __u16 src_char, char *target)
>         case SFM_LESSTHAN:
>                 *target =3D '<';
>                 break;
> -       case SFM_SLASH:
> -               *target =3D '\\';
> -               break;
>         case SFM_SPACE:
>                 *target =3D ' ';
>                 break;
> --
> 2.17.1
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Learn how to protect users, data, and applications with security engineer=
ed for the public cloud by Barracuda. http://barracuda.com
>
> DISCLAIMER:
> This e-mail and any attachments to it contain confidential and proprietar=
y material of Barracuda, its affiliates or agents, and is solely for the us=
e of the intended recipient. Any review, use, disclosure, distribution or c=
opying of this transmittal is prohibited except by or on behalf of the inte=
nded recipient. If you have received this transmittal in error, please noti=
fy the sender and destroy this e-mail and any attachments and all copies, w=
hether electronic or printed.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Thanks,

Steve
