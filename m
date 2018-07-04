Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2B3C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FD0243AC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="E+LNJxvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FD0243AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeGDRQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:16:14 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41787 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeGDRQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:16:10 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so11938473oiw.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oxzA+KgKBHBxJx7P11nv5hfS8rGdc2n6GSYWgnPk84M=;
        b=E+LNJxvkINdbMmCRjh6JbeqIG3lMPOJxGksKUHkxVI0iXOpEVDrXoSMuoVv/Hoynh/
         cM25+f03BIZVSl9jP8P6JyyM7rns9VejemmWRsCEODU/6oTPAnST6iTYZZk0hXBmLk6k
         RJL7JnldwomQvHxgmMn5H9OeNlkcZmw/VzmzvW49kmUgOXWu5vc5dS0XakVGiztq9A9l
         a9+F4xUMl02VRnX9s6vPsNwaEnllw7DL/ejnMOHwyikLfn298mr6WhdTH5gLMmaj3oJJ
         i1M1GJbiyCtuxQVKAqA0Lw/vvVdNZy3Gk9faXEvINKmZqwnq7rFe+FftIkFO4XV8IzDg
         stvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oxzA+KgKBHBxJx7P11nv5hfS8rGdc2n6GSYWgnPk84M=;
        b=l0MBICh7SddiDdG16lZ5nAaTthEgoaBDoc/rWFsmHqB+jw+0L03B9YmEGnyYdGdEyS
         c+lPCJuuPXz7FP34h5st4cVt9yJy+EPcKoF+P7jWgIFhqUMSX7aYww6V72AsY+Ftvghv
         6T//jNHpwBwKN2q9oyYRFPZE6M8tt3shYD3keKYNXsyAt0KpR/ADaZS5rLoh2sfH2jui
         nvLd2QDhbHRx0tyUeK5o0nz9Sj/hwTfxMZvH0104i/3THcEkFIUMp9Y5xAyz061T99q4
         FGzJkVPWXpT89WhsPNEcm6p7D/IiMsz32iGDS+HYc6yBUdpGRMj9y5iHfX450WPEbROd
         gH5A==
X-Gm-Message-State: APt69E0SSZCkgdUg4DIKBXghkTdg28XCM4iAzKEX7Iqtbujs763WjSvi
        CKu2Ceiy6Iz3tCHs++SOz1JBHCMptX+0onx/MT9Nuw==
X-Google-Smtp-Source: AAOMgpfpPC0p+GIzgduslCT/cnD9iR8oXDNO3f2aiy3HV46k1pGF74SCVVD7Z9cn/2QC+ngzl53z2TzTyutb/+4eGuw=
X-Received: by 2002:aca:3954:: with SMTP id g81-v6mr3315190oia.215.1530724569872;
 Wed, 04 Jul 2018 10:16:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 10:16:09 -0700 (PDT)
In-Reply-To: <16466385fd1.ddcc3b7a51249.6994139134661160061@zoho.com>
References: <20180704163823.9980-1-yehs2007@zoho.com> <CAPcyv4hgk89NKGhmZ1Z3XsGFzJAn1y+46WJn_61r8rj5bmqv6A@mail.gmail.com>
 <16466385fd1.ddcc3b7a51249.6994139134661160061@zoho.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Jul 2018 10:16:09 -0700
Message-ID: <CAPcyv4iDUYMsHzAmuRb1S_fiwCXWEXm90Q=j_fqTeMETwvKFzg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Assigning NULL to gfn of dax_direct_access if useless
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        colyli <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        Huaisheng Ye <yehs1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 9:55 AM, Huaisheng Ye <yehs2007@zoho.com> wrote:
>
>
>
>
>  ---- On Thu, 05 Jul 2018 00:48:40 +0800 Dan Williams <dan.j.williams@intel.com> wrote ----
>  > On Wed, Jul 4, 2018 at 9:38 AM, Huaisheng Ye <yehs2007@zoho.com> wrote:
>  > > From: Huaisheng Ye <yehs1@lenovo.com>
>  > >
>  > > Changes since v1 [1]:
>  > > * Collect Jan's reviewed-by.
>  > > * According to Dan's suggestion, update the unit test infrastructure
>  > >   tools/testing/nvdimm/pmem-dax.c for checking the validity of gfn.
>  > >
>  > > [1]: https://lkml.org/lkml/2018/7/4/81
>  > >
>  > > ---
>  > >
>  > > Some functions within fs/dax don't need to get gfn from direct_access.
>  >
>  > Any reason you are calling it 'gfn'? I'm assuming that is a typo and
>  > it should be 'pfn'.
>
> Oh, sorry.
> I made a mistake, it is a typo. I will correct it right now.

Don't worry about sending a new version. I'll fix it up when I apply the series.
