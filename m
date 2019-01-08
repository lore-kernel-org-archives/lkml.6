Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3AFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B602171F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ9CZ3fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfAHOPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:15:15 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33445 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbfAHOPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:15:15 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so3236269ioi.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 06:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XaWuP8Bsy3jie2bERK+JSr2AwDdL+fT7FL42sQKhrpY=;
        b=RQ9CZ3fheqOUrqH1lX0Yj4Xtp1aY/74fHAdJIXcWQfnvo/A7mmi6rB5h1Z6r+/Adx6
         PGEI4GWEY3kr9Jlk3x1a8OYiHN39tbo9zX3FL+qRRxScOZCj3qIxob7EjtDlMPJOMIKq
         uMcAvIcUIEjgCdx/8iO3NIx6rM2p1Uj+ATR8ZfSvuC7MiAQk4EycAX5wpd4xiRiuAnus
         Vd9Xi7Q3Cs/K+8M6LY2WsSZrMmMUWvJVmRxcJpn5AIJMK3ON8cYuimFe7pA4kwXl1V2i
         ICgP93iUox7uyIFb/OdIIk5qxE6UTKFgan/tFhJqGtWngZdcWeu/HprvM6Ijz1H+1r9K
         GYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XaWuP8Bsy3jie2bERK+JSr2AwDdL+fT7FL42sQKhrpY=;
        b=oc8JPeGYaCCBbKwea7hCfPATQm2NS1zhcgR8vKifLN1i1+iZ72Hne1JjRQOtPJkDj9
         gKkWJkYndZvCnkHn73jXU0+k/GQTGdJBsxvdoT9YomcKJHtEnY3wWHpxGwP/LkjJBJlV
         gkzdWJQv38Qii0antyIJbSx2L4uDpHa6aAWf+FZaXoivgRuHS3RM7W7KIK2zDWDIqimF
         2/RssTwuGEofRoqFGMEplyonPeVidqrXq1kw+ZamCBOoSEguhAjuJ6MbbW+2uRUXnp/K
         7KWo4qIpo/+GvBAXC87PNnwiepm6Ijtq85TKLqcXAd6KQ9PgOuKRymfsLgVwdO2h+wAw
         WFMQ==
X-Gm-Message-State: AJcUukcqKqO/9hCgwsuQDssZjqtdQGDsgqR0JA02/AH8XYiCnVwmy9VJ
        6cAKs7wFn4A0Re5nDBYSXCMW6D5QFxlCWttneE0cvvsj2dk=
X-Google-Smtp-Source: ALg8bN4OKtJtvuVcJxPJrEQza7bZkXUdvI3R15tsa5wQB9fmEDhbli+nKkTDKEyQKWCZf9Ivc+B08GFeDhhJYEmCi2c=
X-Received: by 2002:a6b:6111:: with SMTP id v17mr1210232iob.107.1546956914179;
 Tue, 08 Jan 2019 06:15:14 -0800 (PST)
MIME-Version: 1.0
References: <CAEAjamunJjFFJ8Yd-DQAv64MxYiiktsTUWex=boAOdc0+7h+uQ@mail.gmail.com>
 <20190108135020.GA10504@kroah.com>
In-Reply-To: <20190108135020.GA10504@kroah.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Tue, 8 Jan 2019 09:15:02 -0500
Message-ID: <CAEAjamuyjcxVNF5seJ0w0LQT0FSqvHYG30fzhe1s7UgVWzdaFg@mail.gmail.com>
Subject: Re: general protection fault in spk_ttyio_ldisc_close
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>, kirk@reisers.ca,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 8:50 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 08, 2019 at 08:37:37AM -0500, Kyungtae Kim wrote:
> > We report a bug in linux-4.20: "general protection fault in
> > spk_ttyio_ldisc_close"
> >
> > kernel config: https://kt0755.github.io/etc/config_v4.20_stable
> > repro: https://kt0755.github.io/etc/repro.a670e.c
> >
> > This occurs when the function kfree is about to execute
> > (driver/staging/speakup/spk_ttyio.c:68).
> > Particularly, kfree takes the argument like speakup_tty->disc_data.
> > But speakup_tty is invalid, so the pointer dereference causes GPF.
> > At a glance, it seems that speakup_tty was deallocated somewhere ahead of kfree.
>
> How did you trigger this?  Did you shut down and close the device
> already somehow?  Do you have a real tty device that is driven by the
> device?
>
> thanks,
>
> greg k-h

For this crash, we did without real speakup tty device.
I'm currently trying to figure out how this actually happens.

Thanks,
Kyungtae Kim
