Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575272081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaLb6EL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575272081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeLDRsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:48:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36555 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbeLDRsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:48:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so19059263qtn.3;
        Tue, 04 Dec 2018 09:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dM4KttKu+wLhiASYEFkp+GpbNxuGE1kT1xPZtHNaW1U=;
        b=qaLb6EL3559WFshO2sTfzU1ac7Q/gzmdSkGxJSL/etQjM2UfQDIkJB7DeGUgHif0y3
         cC3oqi6FbDiUpt4Efp7kjBJvx24FH2l4e+u2WwPF7AfyZdMBA1T7JJqogHg32uyRdc/F
         uxhnwbyBn9mypptX3trVbYVJJCmqBpWqpP57+CDdaQhWQBg+WKh1P2z0Pk1Gg40iuiDo
         pp6j0HVePbP8pdqopwaNVxxGJcaniVCkErfsl1kTOVSytuAOZoWUbPkGwD7p6tfE7Iya
         +QA5xyfWqjiSCQhNTJrxrjWi7G3/NrmMc1+CTHQnl+bjOLFSy+b6Nkx1t4BhBRK1Qfl0
         zesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dM4KttKu+wLhiASYEFkp+GpbNxuGE1kT1xPZtHNaW1U=;
        b=iZYjeDXrDBYYlIco5X2ymLn4qUhzTUKvwK1q5iTZQ4nYQ/1Ng4TgFTdRVXzAr5QsMx
         LBxBUVDyjcy4eqYNUaJCGOQfT1CL4iukS2UE1Fgl/QQMgNteVZFiA9HTvfUXEvkbzWCf
         v23fgVwVNSi71gWA/PeXcIFvohdsKDvAD+bSUVo4Lc9urdqu2tsBL7IgefdkZ02SNYrF
         78XYntBt40rv6u7Lts/bR7zLEfH7ZVblD1JgnBqDKHFMVmkfVF7Jsxi+MIbCNj8jc2sU
         xtHJhyOOuTpFlFZBugaS086m6CYSZICbe3yeUUZhPLFLugibiZbcGuVtEEqlvwv6zRP4
         jiiA==
X-Gm-Message-State: AA+aEWaT026eql0iZTI4HuL6NDGieUult2ZfeAOr2iUGxwPKOiF6Ug8W
        SPcom0biHYakxwgrZyKnQKoE3/Q76icWq2CNkEU=
X-Google-Smtp-Source: AFSGD/VnkwYBsdijhPHd5S8scWVacZJzS6lGZvPgk6fCxOu9ioaRDBsUOh4rj2xc3L+QTGLczjIDNPsy26Oxkf9t32g=
X-Received: by 2002:aed:3b76:: with SMTP id q51mr20357960qte.229.1543945681279;
 Tue, 04 Dec 2018 09:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20181203034515.91412-1-chenyu56@huawei.com> <20181203034515.91412-11-chenyu56@huawei.com>
 <CAHp75VdSowHk4meQqqUamSjJJoVT59+pMZ1qjmmWd-W5nWBcUw@mail.gmail.com> <6810012e-9a77-dfdf-a738-14ce77a3027a@huawei.com>
In-Reply-To: <6810012e-9a77-dfdf-a738-14ce77a3027a@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Dec 2018 19:47:50 +0200
Message-ID: <CAHp75Vf_nemtPuMZV-1ezyYaB_BuuDM6uqaBf9DLBWLdCnm4Gg@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] hikey960: Support usb functionality of Hikey960
To:     chenyu56@huawei.com
Cc:     Wangbinghui <wangbinghui@hisilicon.com>,
        USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 3:40 AM Chen Yu <chenyu56@huawei.com> wrote:
> On 2018/12/3 17:23, Andy Shevchenko wrote:
> > On Mon, Dec 3, 2018 at 5:47 AM Yu Chen <chenyu56@huawei.com> wrote:

> >> +               .of_match_table = of_match_ptr(id_table_hisi_hikey_usb),
> >
> > Does it compiles for non-OF case? Why macro is in use?

> OK. I will add the "CONFIG_OF".
Why? Is this driver supposed to work without DT?

-- 
With Best Regards,
Andy Shevchenko
