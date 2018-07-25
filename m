Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F42C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFFA20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ieee-org.20150623.gappssmtp.com header.i=@ieee-org.20150623.gappssmtp.com header.b="fuOfvuHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFFA20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ieee.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeGYMk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:40:58 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39482 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbeGYMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:40:58 -0400
Received: by mail-it0-f65.google.com with SMTP id g141-v6so8148616ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 04:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwpKs0ux4OFYlnFMm0JKTpF/7RbqgkuSPEk/KHisviY=;
        b=fuOfvuHTdl9/n6OBz7yqa+b0JDdM8XsQOp6/ZKrCaIikCGrpTQDhOdHO2N0VuMEmfJ
         OApB0cs/0OqjUx8Gm6v3nsPvQohBKk4HKzjo7xsu9Cvx6NnmeeZJCI7oWUSy97QX4rMp
         4JhmDU5U3r4+RRplZfbR0Tibgd/PXzUFX+aVscB4aoCLnwpj8mRYeyUcm+50YK1HGpEI
         ui1j+jJQfhNvNu9cWIvZc16R1w/wSgQ/GT/SCsGkakw8Ma3Z+yLdpyMNmQs88gw7c+iX
         x8QZaUWzpp68/hWLxqrk3hAkpVw50qyCYspZzSg2IVlCatgQMkwJE4fpaGuqavLUNzEz
         cAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwpKs0ux4OFYlnFMm0JKTpF/7RbqgkuSPEk/KHisviY=;
        b=J4wc4h+XALt+PmQl+iYC0U/UWwiUVfcUMttDAjtFBaZPI0IgiA/vCt9yI+E9Os5dXT
         Zl4NtrhW7cYB86zajvapCgfQQfO0WTAw5da8XZMHWVkzVKe6YxEom/xxf1PkplheUj8e
         iHR2kE3RPObhG0Icbc5oALUe01lur0bWkKGPcDJuz4rIczUWXFOy4ERpWikfZ1FGinup
         gxK86sI+tqZ99Fla5KAfoyY1MbS2OSR0cD3Yxmptf6ISoJmEo3WAA8qqAzdWbxngGfyF
         f4vcKOkU9oXaXfWODMDPSXa3r5XQem075hmm6tm4ToHD1IpLLwXMpm0Zn5dNo5oWkqXQ
         YBSw==
X-Gm-Message-State: AOUpUlHAKCWe6PqKRffjX8utzxn7RFC5TyYy9GzUFgzPhJPem1jaKcoD
        sxyLzzgaohd1tK4iIEQh//LxjbAw9ndX5PRR2TU=
X-Google-Smtp-Source: AAOMgpdoe6pU11YAGCUbLy/7v4CT4DpF05xYTTOA7D0uMADNh4TG0b8EzNx8qlQrQpPGy0lp+vHC3wlCqtUhUSPFEjw=
X-Received: by 2002:a24:eb0e:: with SMTP id h14-v6mr6362848itj.69.1532518182222;
 Wed, 25 Jul 2018 04:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180530103936.17812-1-liwang@redhat.com> <CALZtONBKSVfXe+RHOjgS=4VrDqFsxNRx3OuGctp0o1Hrtix3Ew@mail.gmail.com>
 <CAE1O6mir7Pco=QRBDFTFh7pkVQtXT=PtJ4R-o1RV9PPoY5-nLQ@mail.gmail.com>
In-Reply-To: <CAE1O6mir7Pco=QRBDFTFh7pkVQtXT=PtJ4R-o1RV9PPoY5-nLQ@mail.gmail.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Wed, 25 Jul 2018 07:29:05 -0400
Message-ID: <CALZtONArdk0UQv2UqamqT2OE-x1GVDruUs2UT=0iun0gsy+52g@mail.gmail.com>
Subject: Re: [PATCH v2] zswap: re-check zswap_is_full after do zswap_shrink
To:     wangli.ahau@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Li Wang <liwang@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 4:08 AM Li Wang <wangli.ahau@gmail.com> wrote:
>
> On 30 May 2018 at 20:53, Dan Streetman <ddstreet@ieee.org> wrote:
> > On Wed, May 30, 2018 at 6:39 AM, Li Wang <liwang@redhat.com> wrote:
> >> The '/sys/../zswap/stored_pages:' keep raising in zswap test with
> >> "zswap.max_pool_percent=0" parameter. But theoretically, it should
> >> not compress or store pages any more since there is no space in
> >> compressed pool.
> >>
> >> Reproduce steps:
> >>   1. Boot kernel with "zswap.enabled=1"
> >>   2. Set the max_pool_percent to 0
> >>       # echo 0 > /sys/module/zswap/parameters/max_pool_percent
> >>   3. Do memory stress test to see if some pages have been compressed
> >>       # stress --vm 1 --vm-bytes $mem_available"M" --timeout 60s
> >>   4. Watching the 'stored_pages' number increasing or not
> >>
> >> The root cause is:
> >>   When zswap_max_pool_percent is setting to 0 via kernel parameter, the
> >>   zswap_is_full() will always return true to do zswap_shrink(). But if
> >>   the shinking is able to reclain a page successful, then proceeds to
> >>   compress/store another page, so the value of stored_pages will keep
> >>   changing.
> >>
> >> To solve the issue, this patch adds zswap_is_full() check again after
> >> zswap_shrink() to make sure it's now under the max_pool_percent, and
> >> not to compress/store if reach its limitaion.
> >>
> >> Signed-off-by: Li Wang <liwang@redhat.com>
> >
> > Acked-by: Dan Streetman <ddstreet@ieee.org>
>
> ping~
>
> Any possible to merge this in kernel-4.18-rcX? My zswap test always
> fails on the upstream kernel.

cc'ing Andrew as he may have missed this.

>
>
> --
> Regards,
> Li Wang
> Email: wangli.ahau@gmail.com
