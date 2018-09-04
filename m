Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B28BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2C2206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMK1bU+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2C2206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeIDXnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:43:35 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45859 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbeIDXnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:43:35 -0400
Received: by mail-qk1-f195.google.com with SMTP id z125-v6so3203080qkb.12;
        Tue, 04 Sep 2018 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQL7jUWem6kMGLNIcogZn49muYCKvk9zTcMig8k4HWQ=;
        b=vMK1bU+so2ey6+q1ymJxjSCSsV+0MRLMMipeNJ58zF0IBui36k6mKzbu3mpnYkPcSV
         bgJDtNqFbRqAYw4mFzPBCJS+2yfs1iCSaGLwDQ2WsbMvoE/po6/ucAW+QYNknoVPooZw
         fdF9+zu7al4NHCpt2f1MfPQfsjuu1TYSuffYZ4uEpN1v4qbdOqcY5kAFlqW8VxBBv0I2
         mPqNFRsVzTOXZNNzUhzQHIV5bdK12EjaNhIaA1QE8hoSVG+zocra4ptIVATfkKSvaCT8
         DWWYFlKwhGCVZ94oUEgmSvarWvKdR/Q2Oucx10WcOlYdzf0t9ZrWTPwRkt5fEKonpjaj
         nWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQL7jUWem6kMGLNIcogZn49muYCKvk9zTcMig8k4HWQ=;
        b=NKepaqRMAiIeYPars0yimi9z6SK/y+hiafVmE+WhXXZDGH9Ytm5uyyJsqwmWuZlhQb
         kbI1Zpcop8QnlqTBPeCQBT5ovbcYboh0Cml2hMjKsi9DMkZwOf7s6zQYr8PKqPoH+fQN
         fDrr22oKT1VzrhFZHD4Y3dUJQV/wbdgFSX0Yw9gbMr0pWkKS07wsvwqHGQ5/2OJOpFIQ
         JsQF4H05uNcDMQk24EGQ0i3Pj2ebOeVK2NDPBtWHXPYItP8Rgbps1Zg0ikkHBUAJFA08
         6WfxvOkU6OjjEklZfObWLAaZAx5mGX/hsVb4SsGGlVOHgz6b+s7Zmt2nSlYV5yRcp/HA
         pXMQ==
X-Gm-Message-State: APzg51BgtT6SuovdKT2SvbETKGzlIf0dgV24ACbbL6pJBT6QWdLgzM2l
        0JOmdzz0GpkJCNAAmiSmtBEdbhIk6chH6jqmELS7WEVt
X-Google-Smtp-Source: ANB0VdaJTGpgNQtCrJZD3UdnCFdHVl8oDiHAj3n7PYcvfy9pIippxszmX2RnJLAdAc6nJX+tQNZLEMvk0Quy/1+oYr8=
X-Received: by 2002:ae9:e892:: with SMTP id a140-v6mr29002462qkg.242.1536088625448;
 Tue, 04 Sep 2018 12:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180904200434.10442-1-afonsobordado@az8.co> <20180904200434.10442-4-afonsobordado@az8.co>
In-Reply-To: <20180904200434.10442-4-afonsobordado@az8.co>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Sep 2018 22:16:53 +0300
Message-ID: <CAHp75Vf5w+UhAvH_cufhv9EBrgC2bcUaFc3R0iZwpWrXUm2eRQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] MAINTAINERS: add entry for fxas21002c gyro driver
To:     afonsobordado@az8.co
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 10:07 PM Afonso Bordado <afonsobordado@az8.co> wrote:
>
> Add entry for fxas21002c gyroscope driver and add myself as
> maintainer of this driver.
>
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b7b24b145f0..faf5f41b1465 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5838,6 +5838,13 @@ L:       linuxppc-dev@lists.ozlabs.org
>  S:     Maintained
>  F:     drivers/usb/gadget/udc/fsl*
>
> +FREESCALE FXAS21002C
> +M:     Afonso Bordado <afonsobordado@az8.co>
> +L:     linux-iio@vger.kernel.org
> +S:     Maintained
> +F:     drivers/iio/gyro/fxas21002.c
> +F:     Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> +

Must be sorted. I bet F followed by U, not otherwise.

>  FREEVXFS FILESYSTEM
>  M:     Christoph Hellwig <hch@infradead.org>
>  W:     ftp://ftp.openlinux.org/pub/people/hch/vxfs
> --
> 2.18.0
>
>


-- 
With Best Regards,
Andy Shevchenko
