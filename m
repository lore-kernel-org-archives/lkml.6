Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B48C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E29F21741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E29F21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbeHNPqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:46:17 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38319 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeHNPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:46:17 -0400
Received: by mail-qt0-f194.google.com with SMTP id w26-v6so20948032qto.5;
        Tue, 14 Aug 2018 05:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNrVNm0Fm9fDtAEzktnGrsf3O+UObo/ybPCr5pvFSmg=;
        b=mpo6oihitMg/3ZHP4Cw+3k//UyztkwOi5Oe9+IU/FQw4EJuiEhXcDRexIv7AmYq1lV
         dCNScZK6p53FYbXo+4vt65wJAqZCK4M2f35Ey/2lr4udX9WYlyrb09JjMqugs8dMkel9
         2gBEzZ3H28kW6ajViLsKkbI0cTHmnK1awnmiUDTPOXEK9gBaQ5sCzJWp80hhRHBTuLH5
         osSExaSDGv3ah0zwQe6XDUy03kQR+IeS39BKSgRR+5USGeIJ/Z6a9XwfVODxxO9oxECo
         9NGyy8Rwp93Crs/ploUCkcXeKW/blgm/dnL7zI/fBzqmVA3aHlsetLug9/5jjWj8t+lv
         rbbQ==
X-Gm-Message-State: AOUpUlGQYCQFp8cuLwsYH5PyIeotnfdwV07rNXX23YPCRP8DvMAfD5WA
        G4Ya9AjihDHI/upYxCZoZnAN8UlybsK+4ni1gilQyUSA
X-Google-Smtp-Source: AA+uWPzr4zKrbS4wrOTiwhXn5Z4RhXQ5eT98Kh2PFdM/ZTUC6NK/YYpA0KoF8ojd26GUeiO/pdeXWDkyceuWIvxxPcU=
X-Received: by 2002:a0c:93b3:: with SMTP id f48-v6mr19044538qvf.151.1534251552184;
 Tue, 14 Aug 2018 05:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180814091636.1960071-1-arnd@arndb.de> <565437f4-e01a-4558-ccc1-4f312e26cf35@linaro.org>
In-Reply-To: <565437f4-e01a-4558-ccc1-4f312e26cf35@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Aug 2018 14:58:55 +0200
Message-ID: <CAK8P3a2swXMsOnOv_Oow6TCShna4LLfm=uuNmvKk+O2GTZMr+A@mail.gmail.com>
Subject: Re: [PATCH] [v2] media: camss: add missing includes
To:     todor.tomov@linaro.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, hansverk@cisco.com,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 2:45 PM Todor Tomov <todor.tomov@linaro.org> wrote:
>
> Hi Arnd,
>
> On 14.08.2018 12:13, Arnd Bergmann wrote:
> > Multiple files in this driver fail to build because of missing
> > header inclusions:
> >
> > drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c: In function 'csiphy_hw_version_read':
> > drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c:31:18: error: implicit declaration of function 'readl_relaxed'; did you mean 'xchg_relaxed'? [-Werror=implicit-function-declaration]
> > drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c: In function 'csiphy_hw_version_read':
> > drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c:52:2: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
>
> Thank you for noticing this and preparing a patch.
> I build for arm64 and x86_64 with compile test enabled and I don't see these errors. Do you have a guess what is different that I don't have them?

I try lots of randconfig builds, and only one of them hit this, so
it's surely some
header that may or may not include io.h and slab.h depending on the
configuration,
or based on some other changes in linux-next.

Since the solution seemed obvious, I did not investigate further.

If you want to try reproducing the problem, see the arm64 config file
at https://pastebin.com/raw/bNTPvYfZ

     Arnd
