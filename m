Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071FBC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924C320843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZUZKoPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924C320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeICTE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:04:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37325 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:04:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id f1-v6so310556plt.4;
        Mon, 03 Sep 2018 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zFIa4yTHD2cv+PEcsrYAmx8BGULwCR2msK+b5KYdg+I=;
        b=OZUZKoPIHPZsEW4Cqqo7SnfaA6Brmc9dRedk8cEiKnWhQYJmjGuaqUbDPuINe1BYjn
         x2ZPwxUqnUdBsC59kx8gF9hBtW3D+tCODOv/vZgY3mJGIs43RVcWxNWvlc8HmubpEmBA
         c2A9iCTjHjNVAg8wfWNjRGov7ckAtRIhYFpFwa0XRt3br15sCC7F5KMQ8CINvcUabW3R
         PwiBxAJFuDkK3KgKMIelV/RxL5lp1PjLX6A/sUgbHesFUgi+K9y4HgX5cMEP2HFZ4bgD
         Ide2mrPKh0+3jLZhhC6r2FyhHqLsXideeJRw/LYWRA8iqne+vOMlQQ02euebl0pVRlss
         JaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zFIa4yTHD2cv+PEcsrYAmx8BGULwCR2msK+b5KYdg+I=;
        b=IVmk/XhKB74ZsqsOUMUYy36gckOE0ow/DANWMzF2xaQQFW72xkyRwKH+dujSijjsp0
         36tNrjeWZ/JLqBClowqkbZ8tdzGbrlRyHK5ig8z5l/nfGWc64ASgiloplrSt8N83LxX6
         q1mcBkBRMwsaFkO9vv13jsozdo1zszSgyHnDdByWuRxxG4A0RS53a+qkeQ7RBCO9majd
         VE84BfJ0J1th4qo5+cy0qOTij7THVs+mrIg2ixG9W1nvSfNB25LhFcbLBPnZzbWwqDiW
         SJPRBxQ3EGVeWntuHp6MBVAK1g0/2imWLW9QJfp7Upxt/zs45JkuxShk7LGfq310oGKU
         v9fQ==
X-Gm-Message-State: APzg51DGAzBxs9+UkdR10tlVR6UhzEkhfyLL8kHesWp6XEQh9ba+4M/T
        +LCK+hCeIJ5qsEMNpEAyGPGGqjCpZyaLCIB3eHeH5A==
X-Google-Smtp-Source: ANB0VdaK+qbAXK2IcZa/YChQr02zS60OFlF+h0dqyQJ9Z6YDZZfNPpk8rh1AdobPej83ZIwkSQV+uAMABHY+OoWhBAI=
X-Received: by 2002:a17:902:ac1:: with SMTP id 59-v6mr28778422plp.18.1535985868266;
 Mon, 03 Sep 2018 07:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180903131558.21cdeb35@canb.auug.org.au>
In-Reply-To: <20180903131558.21cdeb35@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 3 Sep 2018 09:44:17 -0500
Message-ID: <CAH2r5mu99E39iwx=70w6F5MxvNh1MrzbVwTRb2e8dmz9WU52sw@mail.gmail.com>
Subject: Re: [PATCH] fs/cifs: suppress a string overflow warning
To:     Stephen Rothwell <sfr@canb.auug.org.au>
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

Merged into cifs-2.6.git for-next

Is the message annoying enough on powerpc to merit going into
4.19-rc3, presumably should wait for 4.20?
On Sun, Sep 2, 2018 at 10:24 PM Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
>
> A powerpc build of cifs with gcc v8.2.0 produces this warning:
>
> fs/cifs/cifssmb.c: In function =E2=80=98CIFSSMBNegotiate=E2=80=99:
> fs/cifs/cifssmb.c:605:3: warning: =E2=80=98strncpy=E2=80=99 writing 16 by=
tes into a region of size 1 overflows the destination [-Wstringop-overflow=
=3D]
>    strncpy(pSMB->DialectsArray+count, protocols[i].name, 16);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Since we are already doing a strlen() on the source, change the strncpy
> to a memcpy().
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/cifs/cifssmb.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index dc2f4cf08fe9..dcf939cb9d2f 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -601,10 +601,14 @@ CIFSSMBNegotiate(const unsigned int xid, struct cif=
s_ses *ses)
>         }
>
>         count =3D 0;
> +       /*
> +        * We know that all the name entries in the protocols array
> +        * are short (< 16 bytes anyway) and are NUL terminated.
> +        */
>         for (i =3D 0; i < CIFS_NUM_PROT; i++) {
> -               strncpy(pSMB->DialectsArray+count, protocols[i].name, 16)=
;
> -               count +=3D strlen(protocols[i].name) + 1;
> -               /* null at end of source and target buffers anyway */
> +               size_t len =3D strlen(protocols[i].name) + 1;
> +               memcpy(pSMB->DialectsArray+count, protocols[i].name, len)=
;
> +               count +=3D len;
>         }
>         inc_rfc1001_len(pSMB, count);
>         pSMB->ByteCount =3D cpu_to_le16(count);
> --
> 2.19.0.rc1
>
> --
> Cheers,
> Stephen Rothwell



--=20
Thanks,

Steve
