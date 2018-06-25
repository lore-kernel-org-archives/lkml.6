Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7F4C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16DF2083F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2Aea2bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16DF2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeFYIIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:08:34 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38497 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeFYIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:08:31 -0400
Received: by mail-it0-f65.google.com with SMTP id v83-v6so11016605itc.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NtghunKHmc+eEQGDO67cyjSzGj3mWEiseRIZi5QrqoI=;
        b=u2Aea2bYsjkbjDG7yGAKJo0tXgC967bKNO3fXd9RyFgkZBn/SF1I4MXEBpZISAw1v9
         H90PmCBDi0VEQCrNpef9cGJu2G9zwnJnmCuchMvxIWBi6GorexA0JOVjj1VDU2B7sSRz
         ZZS96caTzIngFWdCayIjUU+zepGQSfaBRiCOl5V2VT7qAdO/B0mMR0jhvSQrvVDx+8QK
         jK6k9hjCS4AEjGO/mqn49z0kZgsakHR/dJ41aTotb859JlL9mlg3s03EvUCfBKEDOtPK
         REd9NpSBPvJ6gvKTo8bhY1ClFcIl0F40f5Tm9jKMDiCZ4kMS2LErJy4rTAPutoVwYHRR
         kFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NtghunKHmc+eEQGDO67cyjSzGj3mWEiseRIZi5QrqoI=;
        b=sInEEU74WRMk9BgeNuFhSh9UDBl9CgGmiuIevt4Onx30MtLcaYKHP3/VA6P/o2glMj
         hyG7RH71oq/6fEu6fIvHhw8/Gx7fWigZUQpTS8FafwVp8e7D+4Q4vNkVbI9s9ZyGZkw9
         OaPXbdYMxPDjvzh2tM5+MxiOEgOtjycIOx83jaGiS3BbW4X6lOgB1FbOao0EqVmUyXHA
         Fl+vwZ/DMmffRxyuqGgmkm5eKEYr61XqGOTVylqp02n5LQKdi9ZjEh+/rNCbmx4sEBJJ
         yD5jvevo0RyErjztOi47z275aIfPKC9cBgskB628bt8LPEVbG+aC3xKC1ljXe9G0WkkV
         sl1A==
X-Gm-Message-State: APt69E0+aQFphSLnjNU2VkVXtku1qxTPwrDm6UQO2vAZ5Di3UWDx6WCJ
        vax7mlqaXk/lKkcp0vSDYPWTDlwZtR+kiosEWBDrgXzc
X-Google-Smtp-Source: AAOMgpcSebbp6Vc1anN4fuWuHwfaWLV7pFnuK6fSX7nnX8zyDF88SG2N153yzII+ojxi8cRFkMXtLrWNQR5tB0cJ4kg=
X-Received: by 2002:a24:7ac7:: with SMTP id a190-v6mr109386itc.7.1529914111254;
 Mon, 25 Jun 2018 01:08:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:8308:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 01:08:30
 -0700 (PDT)
In-Reply-To: <CALZtONBKSVfXe+RHOjgS=4VrDqFsxNRx3OuGctp0o1Hrtix3Ew@mail.gmail.com>
References: <20180530103936.17812-1-liwang@redhat.com> <CALZtONBKSVfXe+RHOjgS=4VrDqFsxNRx3OuGctp0o1Hrtix3Ew@mail.gmail.com>
From:   Li Wang <wangli.ahau@gmail.com>
Date:   Mon, 25 Jun 2018 16:08:30 +0800
X-Google-Sender-Auth: wMrkAgTwFps8o_GcpqfacZvzwzQ
Message-ID: <CAE1O6mir7Pco=QRBDFTFh7pkVQtXT=PtJ4R-o1RV9PPoY5-nLQ@mail.gmail.com>
Subject: Re: [PATCH v2] zswap: re-check zswap_is_full after do zswap_shrink
To:     Dan Streetman <ddstreet@ieee.org>
Cc:     Li Wang <liwang@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Huang Ying <huang.ying.caritas@gmail.com>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2018 at 20:53, Dan Streetman <ddstreet@ieee.org> wrote:
> On Wed, May 30, 2018 at 6:39 AM, Li Wang <liwang@redhat.com> wrote:
>> The '/sys/../zswap/stored_pages:' keep raising in zswap test with
>> "zswap.max_pool_percent=0" parameter. But theoretically, it should
>> not compress or store pages any more since there is no space in
>> compressed pool.
>>
>> Reproduce steps:
>>   1. Boot kernel with "zswap.enabled=1"
>>   2. Set the max_pool_percent to 0
>>       # echo 0 > /sys/module/zswap/parameters/max_pool_percent
>>   3. Do memory stress test to see if some pages have been compressed
>>       # stress --vm 1 --vm-bytes $mem_available"M" --timeout 60s
>>   4. Watching the 'stored_pages' number increasing or not
>>
>> The root cause is:
>>   When zswap_max_pool_percent is setting to 0 via kernel parameter, the
>>   zswap_is_full() will always return true to do zswap_shrink(). But if
>>   the shinking is able to reclain a page successful, then proceeds to
>>   compress/store another page, so the value of stored_pages will keep
>>   changing.
>>
>> To solve the issue, this patch adds zswap_is_full() check again after
>> zswap_shrink() to make sure it's now under the max_pool_percent, and
>> not to compress/store if reach its limitaion.
>>
>> Signed-off-by: Li Wang <liwang@redhat.com>
>
> Acked-by: Dan Streetman <ddstreet@ieee.org>

ping~

Any possible to merge this in kernel-4.18-rcX? My zswap test always
fails on the upstream kernel.


-- 
Regards,
Li Wang
Email: wangli.ahau@gmail.com
