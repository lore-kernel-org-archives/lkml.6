Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A4AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68AB2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548350228;
	bh=DJDvNUthn8gVeZhaCOM9cp1JQ+bl2CBs7ni+bDIq4H0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gFOyAi2lU78qXLY95HP/LD/p2KXtI/y67ugrD/QSQu40qdTx7H83A3diOVg6bDb8a
	 1+0O4RfYtpzfaojbXZPoR0YLWkzaHcgvyRNaB6Yw2FjQkgXdJgAmh+X7u8G9sdkJ+A
	 kzyPmJi8Dy99/4BXd1wWvarm55jcsaP4GHNUOyOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfAXRRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:17:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbfAXRRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:17:07 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 039D3218AF;
        Thu, 24 Jan 2019 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548350226;
        bh=DJDvNUthn8gVeZhaCOM9cp1JQ+bl2CBs7ni+bDIq4H0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hcJUsTvkeKqiKY0tyiDVE12SlnZOKmG5TT+ITHtd6zbiFRdCKyl3cGWaV/VyCeQC3
         oxRZN0L62y9Bu2aubSDW7wcXJYRgVnWdeLqEjZyZRQfRahJYkOJ5rI9VVGNy3jR0Xg
         ksDcRho7z7FkWXfKj0KSZmUWLPAmdyt9S4fOVdNQ=
Received: by mail-yb1-f176.google.com with SMTP id c65so1062159ybc.3;
        Thu, 24 Jan 2019 09:17:05 -0800 (PST)
X-Gm-Message-State: AJcUukdevMWt5b+UqJz8MekhPaOy8BQ40c8YJ5ozX1eGy8x0MLFlRX7H
        1G7/HkRhacTeeOxMaS0+AbMsSR5dkwNvKK57RtY=
X-Google-Smtp-Source: ALg8bN6exrjqt6d+BIA1IITR6q8mYiCHx077dHBpWSDIcL0kA9sFjBUoE/pyChFbdj90FzzStcyOBRgAvPx8l569OIY=
X-Received: by 2002:a25:ce8d:: with SMTP id x135mr2635556ybe.255.1548350225201;
 Thu, 24 Jan 2019 09:17:05 -0800 (PST)
MIME-Version: 1.0
References: <20181129231016.4580-1-colin.king@canonical.com>
In-Reply-To: <20181129231016.4580-1-colin.king@canonical.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 24 Jan 2019 11:16:28 -0600
X-Gmail-Original-Message-ID: <CANk1AXRP-65fK48vqQ+Dy9-cz-4XQ1bWNyDCvzJK8rkoA2F24g@mail.gmail.com>
Message-ID: <CANk1AXRP-65fK48vqQ+Dy9-cz-4XQ1bWNyDCvzJK8rkoA2F24g@mail.gmail.com>
Subject: Re: [PATCH] fpga: mgr: altera-ps-spi: make array dummy static,
 shrinks object size
To:     Colin King <colin.king@canonical.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 5:10 PM Colin King <colin.king@canonical.com> wrote:

Hi Colin,

Thanks!

>
> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the const array dummy on the stack but instead
> make it static. Makes the object code smaller by 26 bytes:
>
> Before:
>    text    data     bss     dec     hex filename
>    7371    2032       0    9403    24bb drivers/fpga/altera-ps-spi.o
>
> After:
>    text    data     bss     dec     hex filename
>    7281    2096       0    9377    24a1 drivers/fpga/altera-ps-spi.o
>
> (gcc version 8.2.0 x86_64)
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Alan Tull <atull@kernel.org>


> ---
>  drivers/fpga/altera-ps-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 8c18beec6b57..678d0115f840 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -205,7 +205,7 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
>                                     struct fpga_image_info *info)
>  {
>         struct altera_ps_conf *conf = mgr->priv;
> -       const char dummy[] = {0};
> +       static const char dummy[] = {0};
>         int ret;
>
>         if (gpiod_get_value_cansleep(conf->status)) {
> --
> 2.19.1
>
