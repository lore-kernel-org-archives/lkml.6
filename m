Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22015C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D452521473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAP0a5wV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D452521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeHTVEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:04:10 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43507 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:04:10 -0400
Received: by mail-qk0-f194.google.com with SMTP id 130-v6so2526044qkd.10;
        Mon, 20 Aug 2018 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=BkbfFwAGP9WY4mbrW9EOZQ5TVtYMYkCKBapJ6WJ1aH0=;
        b=FAP0a5wV4XRw+ouXOZBSOKlrKWfsvDZMZi9IzCv59E4YN9FMOeVngqRPuq/c4sU6n1
         3hnCm3SbMfjs/i6ALD2TtRRWD11Klehpj71lHIzRDgb+af6qN3R+fRSBORTYKBq5hJ7e
         9HaFoB5MFzMSG3lfLh2HF+VZitROPS7F4ipHdof7byTPRJhN4cpXyT16Pv5DBYOc7/FT
         iFKcl8Hd2qTWX4FGzyemIBys0TlW+jplwyCpQEMORuWlWrWYwyMq4hWpeF32v5slz69C
         cWvZPXkjc2LJuzk6wrta6zf0hOB3iFZ7KtF/dm4grgy6C89hrmbjQWmcPM1W+0xlr6p9
         fB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=BkbfFwAGP9WY4mbrW9EOZQ5TVtYMYkCKBapJ6WJ1aH0=;
        b=PBJ7/cK8jwfgJv6Ub9uBSNDvQdZuv8YyXlyS79Zu5zAwdhOMTMc49oP8tBek5p4B4C
         vSYd5AQHKZ1io0AZ+khF8jmiJ0frXYrIu2o+kCRRebVAhwwvZAzjwptcvDrtXIDMY0U7
         2hMxecmKmZrmV5W4mWCDiAtnrhvJEUBaQQCPHKgtTKrydPPpdTBCGUZidyPcLyv1L+3Y
         GOsrsnDY8M24VwKQD3TRMK7xTixMHe/fti5x/o563rcOminqM1ktvy3WqzH2dYJgiPaY
         JWSROuVhMCblpeo8N2XCA7JSj8VbPnrn/dHSbCZZaedWCZWkFIQZen+T7ny8qNcCbVJe
         hYmg==
X-Gm-Message-State: AOUpUlG2fnkC5e1lzC3AaN4Y4qBEWCtvjuf3pL9CyPmg3HZWwhPlYYAt
        XCnoK2WZd9sJze3pp0WQTU4YlWuGpd9wP26PJEjZ+/Uw
X-Google-Smtp-Source: AA+uWPzvkItHMaVHcnveg+xC7MYgsB98BoFnQnp8y7QE9bIAoMyywA0u0En9/fdvnI/nxH2XGKw38f9p3fj87Tg84jI=
X-Received: by 2002:a37:21cf:: with SMTP id f76-v6mr16607526qki.263.1534787254605;
 Mon, 20 Aug 2018 10:47:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 10:47:14
 -0700 (PDT)
In-Reply-To: <20180820000218.GE19200@thunk.org>
References: <20180820081323.23a47af3@canb.auug.org.au> <20180820000218.GE19200@thunk.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 20 Aug 2018 19:47:14 +0200
Message-ID: <CANiq72nHvUW1sF2RiWTuLE4h5GbSaSH8Xm+gg0aucKSqrqpB2A@mail.gmail.com>
Subject: Re: linux-next: build warnings from Linus' tree
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Mon, Aug 20, 2018 at 2:02 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> P.S.  It's really, really too bad there isn't a simpler way to shut up
> gcc.  You need the #ifdef __GNUC_PREREQ nonsense because otherwise
> older versions of gcc that don't understand the particular warning
> you're trying to suppress will complain loudly.  (Ask me how I
> know....)

Please check out the __nonstring patch I sent (the one Linus is
referring to, I guess) and see if you think it would be a good
solution for your case:

  https://lore.kernel.org/lkml/20180814193813.GA5473@gmail.com/

I just tried the patch below with 8.2 [*] and those two warnings in
fs/ext4 go away as expected.

I think marking those fixed-width fields is a good idea anyway (i.e.
makes it clear that they are not meant to be null-terminated), but I
would like to hear opinions on the matter.

Cheers,
Miguel

[*]

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0f0edd1cd0cd..3eef4b286895 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1277,13 +1277,13 @@ struct ext4_super_block {
        __le32  s_first_error_time;     /* first time an error happened */
        __le32  s_first_error_ino;      /* inode involved in first error */
        __le64  s_first_error_block;    /* block involved of first error */
-       __u8    s_first_error_func[32]; /* function where the error happened */
+       __u8    s_first_error_func[32] __nonstring;     /* function
where the error happened */
        __le32  s_first_error_line;     /* line number where error happened */
        __le32  s_last_error_time;      /* most recent time of an error */
        __le32  s_last_error_ino;       /* inode involved in last error */
        __le32  s_last_error_line;      /* line number where error happened */
        __le64  s_last_error_block;     /* block involved of last error */
-       __u8    s_last_error_func[32];  /* function where the error happened */
+       __u8    s_last_error_func[32] __nonstring;      /* function
where the error happened */
 #define EXT4_S_ERR_END offsetof(struct ext4_super_block, s_mount_opts)
        __u8    s_mount_opts[64];
        __le32  s_usr_quota_inum;       /* inode for tracking user quota */
