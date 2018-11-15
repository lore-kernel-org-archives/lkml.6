Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F9AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C208D214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ7xg7Oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C208D214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbeKOV53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:57:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54511 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeKOV53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:57:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so18619669wma.4;
        Thu, 15 Nov 2018 03:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZM/2LdCmaMU+xo0886oSy4ErNpU1jeq1qxkIEeDLZsc=;
        b=IQ7xg7OqOpPlw68XW3vcqW7fLg5ArWXTGbHTgex2NkRHRnwk4uSP184EYnMHZz1GvL
         7UWK4Le1hmwRMUvd2wqxuF/OTDYvQE7JkuRvvEIQ3+jAD2woKn2rO7eoi7S8FQo/x9EP
         v086Onpwflik5Iy7gbZJuP8yc/rMiu2onxVOiCE3RkUikONqHlFGJ7BB3rmPr1LhabKb
         cFYI7VeCXkj7fV+4AwD9HE5lRO+lW+lClLg5Y+J+yQAlLRAmxWkOnXz/esKjgAPq4Tjq
         sU/WKcKQRdK0TSnjJworHetORjzAQpnixpymKBpQrt9Cf52/IeOfPx9eRNrF+IRNeUBD
         7eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZM/2LdCmaMU+xo0886oSy4ErNpU1jeq1qxkIEeDLZsc=;
        b=pq6Ts+rcMAWBdZHkuZlt+tAaSSsP8cBvnBrJmRBoH3HQV8/iQXDLdtBvdRmAXOVlWx
         VvM7uGWs5XTkQOFiKbYQtMbCKRVkrhZstwtTCwW+IBMCeKWuGV4/SgzpSCV+tMPEB8BE
         7dVw/HP4CyNZ+NN9vg0YUi4H6Jc4nqfspw3IGG19qY/qRnfJ0e3HMdm0c+kcdqCLr3f1
         pp14+WgD+2FwYsl6qFNvJBOGIwFk4S8IIDQfrPhKg7BsIcvwmgt/I5smUzPytgyNEBVV
         5fmVmXAQEpfFz3NOyfsaLwUeTgxQJeHGRqhwmA0lE6IuUbFdpDuUUIrOMKFThdxN5qX6
         bujg==
X-Gm-Message-State: AGRZ1gJmriEwPbna9tOKIrn8zMEfy6maJWwUS5P8cPvssxkU6yDauzcG
        By45E4iNX6woX6xEKAvE4pj1ciAKn+GVyjpfBFlmvof8
X-Google-Smtp-Source: AJdET5e8n1d6kMsAB2581bUpqErKn90VeSfLhzIQz07mfsHvEHa+i1t7Wp7g8NI5YKY6xOGh/hEfHMJ/mWOnIdDFHnE=
X-Received: by 2002:a1c:84cb:: with SMTP id g194-v6mr5238686wmd.24.1542282596286;
 Thu, 15 Nov 2018 03:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20181107220443.29573-1-richard@nod.at>
In-Reply-To: <20181107220443.29573-1-richard@nod.at>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Thu, 15 Nov 2018 12:49:44 +0100
Message-ID: <CACna6ryKs4LcSK8-FY3MB27O4b7MJqVROaSTQKtpGkqqZoQS7g@mail.gmail.com>
Subject: Re: [PATCH v2] ubifs: Handle re-linking of inodes correctly while recovery
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Russell Senior <russell@personaltelco.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 at 23:04, Richard Weinberger <richard@nod.at> wrote:
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
> Cc: Russell Senior <russell@personaltelco.net>
> Cc: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> Reported-by: Russell Senior <russell@personaltelco.net>
> Reported-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Thank you!!!

Tested-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
