Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442A3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D828222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk5JI87g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406375AbfBNJ7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:59:10 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44923 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404576AbfBNJ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:59:10 -0500
Received: by mail-ua1-f66.google.com with SMTP id v9so1801848uar.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Q0oXiUTaSePAZtvAY9YhhNz5awIypAsPqHV+I2fuRg=;
        b=Kk5JI87grQ98H6C47ZHKXM9RF1V/ulhYD9OXZKvRb9VEt58owGYVdnMVyY4aaW0HEk
         aTWipdLNqPPb9uzBTC3COzFhmzj9RXNSWPqS1giaJ1UxmM0vlNT/W64WZv1auKJU8ITA
         JAJ8ZMijMWM85IRfa+7b6SRoYxtinfZjVVVGJgsPVZ+ox5O+KqbxdvqdhpbH87CXTTtr
         YNQ3oKrsYZRFmaHLrhcb6AT2svHPbWxlbvvPa6cI9kMC5ECBJhRNoQ3QK3UjZJgGwWFB
         cubAsHFkIIXui0MHzRVn1yyDo3em0aH9Z15XDaQlxCg7t1DZaMLoDtYZegQRm9QXL1+B
         dChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Q0oXiUTaSePAZtvAY9YhhNz5awIypAsPqHV+I2fuRg=;
        b=iH4hceL/nLAg/bwOGQV0q6KGzWRarsm2dxIGh6sAwgiR70HAqdTVDbNPtqtKG0QPdH
         6J/lWkXe59ew02DgXISf8lM+twpFfvspbAwUcTceQPfQ2DpoNinVjt6rmg4v7p5aC9re
         iqGGfqFziAWuennbfUO7QP6Di2Hw3ZnhFjq67mkU7OeFFtvFWpjWL6W1NON1Nwz4Lk4W
         87ogvO6OJPIIJFuZ5Ys9SYr4bOcEKd94qvvIYz5qyLmHS2B6SweXecd+Hi7qA31BX/Up
         bcvpkr5TrKgPQNFFr3qZrzuA2EkoPPXh0eKq7vRDH3pwP4WF0Z1XwJ990+hVt+Gsmjx8
         gPig==
X-Gm-Message-State: AHQUAuaVp72FtM/dX6hWhj7QP1oWdTQdwXi5oruIIiox3xya2JYLB6Wg
        1BslvdApKyByCFN+nJvIZAiTb8r5owJY8UqqrMGS5A==
X-Google-Smtp-Source: AHgI3Ib28AsG5TRZGqL0NaxEB/Tozn1MO4uRArdSLWzHnKgjqoKbmb22Trnjl1iTqRo5ky8utchhi3SuukAbY5pG1IM=
X-Received: by 2002:ab0:22d6:: with SMTP id z22mr1438065uam.66.1550138348558;
 Thu, 14 Feb 2019 01:59:08 -0800 (PST)
MIME-Version: 1.0
References: <20190211151751.12336-1-oded.gabbay@gmail.com> <20190214071114.GA21381@kroah.com>
 <CAFCwf12VaYSpCtqyYsTGp2TZDJiJ4bYc4egrRY6mdzaceO_5Cw@mail.gmail.com>
In-Reply-To: <CAFCwf12VaYSpCtqyYsTGp2TZDJiJ4bYc4egrRY6mdzaceO_5Cw@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 14 Feb 2019 11:58:41 +0200
Message-ID: <CAFCwf11hP89LwKnyjuwnP1KLe0GwL_T=Z+eQ1uUEiPTnJRASpA@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Habana Labs kernel driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Olof Johansson <olof@lixom.net>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 9:13 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Thu, Feb 14, 2019 at 9:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 11, 2019 at 05:17:36PM +0200, Oded Gabbay wrote:
> > > Hello,
> > > This is v4 of the Habana Labs kernel driver patch-set. It contains fixes
> > > according to reviews done on v3, mainly for the command buffer, sysfs and MMU
> > > patches. In addition, patch 2/15 was reduced in size from 4.3MB to 1.4MB.
> > >
> > > The patch-set is rebased on v5.0-rc6.
> > >
> > > Link to v3 cover letter: https://lkml.org/lkml/2019/2/4/1033
> > >
> > > Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003
> > >
> > > Link to v1 cover letter: https://lwn.net/Articles/777342/
> > >
> > > I would appricate any feedback, question and/or review.
> >
> > There's been some 0-day bot feedback on some of these patches now that I
> > put them in my -testing branch.  So I'm going to drop the patch series
> > from there now and wait for a v5 of the series that hopefully will have
> > those issues fixed :)
> >
Hi Greg,
I looked at the 4 warnings I received from your emails, and they all
appear in i386 architecture.
I don't want to support 32-bit kernel and I don't intend to support it.
Can we just specify in kconfig that we don't support it, and then you
won't get these warnings ?
I initially set in kconfig to support only x86_64, and you told me
(and you were right) not to limit to that. But I do think I would like
to disable the driver on i386.

Thanks,
Oded


> > thanks,
> >
> > greg k-h
>
> Sure, np.
> Thanks,
> Oded
