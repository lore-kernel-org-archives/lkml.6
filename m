Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeBALbk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:31:40 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:44619 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbeBALbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:31:37 -0500
X-Google-Smtp-Source: AH8x225wxbhUJrNOn3JRMKOhXL7WrNgcV1qKEoOR/kjtL1VtoG18jzqJnMYaq+nuEoLYeqaHN/gZGDB3j3trFclvfTQ=
MIME-Version: 1.0
In-Reply-To: <1517480584-4588-1-git-send-email-geert@linux-m68k.org>
References: <1517480584-4588-1-git-send-email-geert@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 1 Feb 2018 12:31:36 +0100
X-Google-Sender-Auth: LRXDfaOiZHoeFAgOKxca4xzvPkk
Message-ID: <CAK8P3a1N-Yh65y6bEb+d7DwVOqB8ee=T1gM1cc7k6=cg1c3Jtw@mail.gmail.com>
Subject: Re: [PATCH] xfs: Add missing braces around xfs_scrub_agfl_info initializer
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11BVmQm024614

On Thu, Feb 1, 2018 at 11:23 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> With gcc-4.1.2:
>
>     fs/xfs/scrub/agheader.c: In function ‘xfs_scrub_agfl’:
>     fs/xfs/scrub/agheader.c:770: warning: missing braces around initializer
>     fs/xfs/scrub/agheader.c:770: warning: (near initialization for ‘sai.oinfo’)
>
> The first member of struct xfs_scrub_agfl_info is no longer an integral
> type, but a struct.  Add the missing curly braces to fix this.

I suspect gcc-4.5 is affected as well, but not 4.6+

> --- a/fs/xfs/scrub/agheader.c
> +++ b/fs/xfs/scrub/agheader.c
> @@ -767,7 +767,7 @@ int
>  xfs_scrub_agfl(
>         struct xfs_scrub_context        *sc)
>  {
> -       struct xfs_scrub_agfl_info      sai = { 0 };
> +       struct xfs_scrub_agfl_info      sai = { { 0 } };
>         struct xfs_agf                  *agf;

Looks ok to me, but

        struct xfs_scrub_agfl_info      sai = { };

might be slightly better in case the first member changes again.

     Arnd
