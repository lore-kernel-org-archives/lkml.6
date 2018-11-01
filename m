Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F417C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7492081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxdXqRJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7492081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeKAR6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:58:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35341 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeKAR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:58:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id z16-v6so1401056wrv.2;
        Thu, 01 Nov 2018 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fnliN7UP7YCK7qUknfPTfGoK2X8M0YGbRat0lYRnmSU=;
        b=CxdXqRJjBClvciTxOpf7mJtNM+tOT6Cik/LrWaJWXQUdYdzEoHtMebdPjLqI8ZAb1b
         5x5eXfYhdeHGqjhQF2lqrl4ophHK91Gi0kSjof3r4ijVkYAVWq7mnqXr4pEaKqbNijgi
         hpCFMoj+jLfsLB/JQdgFny3arJWC3fghFRBIMeQXacIrmBksOoMT9HKTzLM/4bU8Yu6U
         AXL8Ss/EaBoRpbIvGi3GS3a6ycicBAAkR84gKof1UJLRE9Aah90KErlRKXbYmjfZeMNb
         a6SZDTKYcXmY0KA1QlQENWEBw02O4wtKnoNTxjN7NlErhgYnmgwQHvof0tPmnJ9UFrdk
         Bbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fnliN7UP7YCK7qUknfPTfGoK2X8M0YGbRat0lYRnmSU=;
        b=qK8lekeKVEq39MayW38ErnHMXarWbS/tbcQBtn47V9E3IP1bgRYcuhy3F3+NFOjPOE
         fXb7L19+LMfDVZQPxy/nrCU6VKena5K0l6ydVKN65mltP8p2cU0shzW0WVPbc2DvUXLv
         60OObp/mF1o+6J0XHMUUc5ewsnqolbQZApHoMwhVivPKr3AwAHKBngHPIrststtiQTBQ
         RXFQ9VnMTLmQftJnA/Ze/ThiM5jloJtTxndci2ybyj9gMwojy9aJUZP9lZ0ecs4jBS8S
         KL4VP3NtTaUR/DFVnsbpJSMZgAgnXKWpp4CklqL0nOYjt3l/Yx8RGW050UbP6OR7Gzj+
         bCvA==
X-Gm-Message-State: AGRZ1gInHbqII4UenSTeo7tKiT4w9q2FbUPL/qHQPfaczHHAsBLZf48Y
        SB829Y4E2MwXYgvYoUofp2G3SsGVPIItz9ogcCjwBCHn
X-Google-Smtp-Source: AJdET5dp9UDjpLbGD7Aqnq39Fw5SWR6ljFHTNncHE1sgycSmNuNElPwCx7294gWr9fCIazMGm9kCBEUIWo0kZYsLHm8=
X-Received: by 2002:adf:fd49:: with SMTP id h9-v6mr5977615wrs.280.1541062565006;
 Thu, 01 Nov 2018 01:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181028214407.20965-1-richard@nod.at>
In-Reply-To: <20181028214407.20965-1-richard@nod.at>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Thu, 1 Nov 2018 09:55:53 +0100
Message-ID: <CACna6rxJBR=uUfVv3tBfwyKHvK_4HhEy7rD6f66n0o8FkPmmhQ@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Handle re-linking of inodes correctly while recovery
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell Senior <russell@personaltelco.net>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2018 at 22:44, Richard Weinberger <richard@nod.at> wrote:
> UBIFS's recovery code strictly assumes that a deleted inode will never
> come back, therefore it removes all data which belongs to that inode
> as soon it faces an inode with link count 0 in the replay list.
> Before O_TMPFILE this assumption was perfectly fine. With O_TMPFILE
> it can lead to data loss upon a power-cut.
>
> Consider a journal with entries like:
> 0: inode X (nlink =3D 0) /* O_TMPFILE was created */
> 1: data for inode X /* Someone writes to the temp file */
> 2: inode X (nlink =3D 0) /* inode was changed, xattr, chmod, =E2=80=A6 */
> 3: inode X (nlink =3D 1) /* inode was re-linked via linkat() */
>
> Upon replay of entry #2 UBIFS will drop all data that belongs to inode X,
> this will lead to an empty file after mounting.
>
> As solution for this problem, scan the replay list for a re-link entry
> before dropping data.
>
> Fixes: 474b93704f32 ("ubifs: Implement O_TMPFILE")
> Cc: stable@vger.kernel.org
> Reported-by: Russell Senior <russell@personaltelco.net>
> Reported-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Thank you Richard!!!

Tested-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
