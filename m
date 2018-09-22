Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D1DECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652372150E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="P2cqTVHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652372150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeIWCQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:16:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42141 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeIWCQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:16:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7-v6so6286ljc.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TpjITTMq3K2B8oubWBkLj9T9cH6X6cxErWKC+hpIBWY=;
        b=P2cqTVHOre8iKGJ10jfmjnRwDEfzQuh+Olr9VR3MPWYLEzOA8nmFAcjYcifBTn+iX4
         tgmgVVZgsPkKF9qapjPSdyCjTwEUMHjNCJTe/xJuzSVVHAnCBSsT5IeTpZjxMDK9xcmf
         cnDRureBfv22mgdgqgs/sWlD7H8/dsJHE96wpYtzow9IoJQ5FfDMqB+ychpq01JRogbv
         GKZApxAAlmlJAbYsfySmNwjXRUEzMH0Qa2Qy6R5AlnkYNDPGkOdUXi9lN24RKpBJ9Aww
         AyB35xsooOsgjTJAFRZquFwXrJKeLU5JuP12LjySiDz+c5Ytf7LDoYo4eXh79ohDtTTk
         xZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TpjITTMq3K2B8oubWBkLj9T9cH6X6cxErWKC+hpIBWY=;
        b=ibaoXRYbe8PMGhKPCJ2/biais9j2qaJeJ3w+u/U9F9R7xaYBs1pCeS/wsD2Bmj+ZXD
         H+608zmluTtkLfprFpumg0k7WqyRNyJMKVgoMI9CQsH8SfbymHDTiw4NtqouUYZ3HSgZ
         fUJsc2RDvGwrBuDbfbHfPK0/Lqvs/Yllfhw2ljiMcs5G1S2uRn0MZpuoqkzwJUPC/l/3
         3SebiI0nDDD2bb5X1FW8Yb8/9e2j8eEoQhRK0TPid3JE8G7ZY75BQPcJra6lf/2J5gSm
         Xvtq/HwWufP6GQOWARIHYhBOJ8RVUqz4hwQMPjwEraNTyTP3xkqxY3KZ9bt/P3RqZALW
         PIJw==
X-Gm-Message-State: APzg51DL183oCiH5HXxYHAHhTmS3HPimDh0N2em0E0YkCis1+wzpEiwT
        3rKNthkfWKhCYpOSyPSbN5PH7WL6lmuiuQun3VTa
X-Google-Smtp-Source: ANB0Vda1MOvlOwZkjGJ4GkGPPisEjZHNAOczSPxKIXTts2OkSgZyq+ZUmC0vKsmN9uXdkyhvglCzPO84UUkMrrNbHz0=
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr6249771ljj.139.1537647715052;
 Sat, 22 Sep 2018 13:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180921233822.4362-1-glebocki.przemyslaw@gmail.com>
In-Reply-To: <20180921233822.4362-1-glebocki.przemyslaw@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 22 Sep 2018 16:21:43 -0400
Message-ID: <CAHC9VhQPxoWDPOuPqHSKTxFxHnCnf44mDQ_J0MkUT-E2+SZLNw@mail.gmail.com>
Subject: Re: [PATCH] audit: fixed a braces coding style issue
To:     glebocki.przemyslaw@gmail.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 7:38 PM Przemys=C5=82aw G=C5=82=C4=99bocki
<glebocki.przemyslaw@gmail.com> wrote:
> Fixed a coding style issue.
>
> Signed-off-by: Przemys=C5=82aw G=C5=82=C4=99bocki <glebocki.przemyslaw@gm=
ail.com>
> ---
>  kernel/audit_tree.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I generally dislike accepting coding style patches from people who
haven't made any significant code contributions.  Would you be
interested in participating in upstream audit development?  We have a
number of open issues that you could take a look at if you are
interested ...

* https://github.com/linux-audit/audit-kernel/issues

> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index ea43181cde4a..3d0e45fa765d 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -112,10 +112,9 @@ static void free_chunk(struct audit_chunk *chunk)
>  {
>         int i;
>
> -       for (i =3D 0; i < chunk->count; i++) {
> +       for (i =3D 0; i < chunk->count; i++)
>                 if (chunk->owners[i].owner)
>                         put_tree(chunk->owners[i].owner);
> -       }
>         kfree(chunk);
>  }
>
> --
> 2.17.1
>


--=20
paul moore
www.paul-moore.com
