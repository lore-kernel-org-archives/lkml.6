Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC86C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A69216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhL3iPA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A69216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeI0VsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:48:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:47095 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbeI0VsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:48:20 -0400
Received: by mail-io1-f65.google.com with SMTP id y12-v6so2189065ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gDAAVo2wgpXEmXUntL4MPEE7CPihZnVOn4l/xFoHHs4=;
        b=YhL3iPA4Xb3/+RBkJxG/w66jaG3I+kdBMJnEaSraiT70ImG1dsOxAkR4cTC7E1qr6a
         NLFWeTqKWP5Jq3xOT99HanjBOYs6JtxM841I13VhLZ64+lRImx0AmYfsrGTw/ztxYIWe
         uaJW87bX2NbJx/zDXL75HZ0Ef3QhU8/bGYeOmgYv9KhxJ4lk120wuYncUa5shae1iMbV
         N5gK8pCGgwXnuSNi59j1kr41cISrzT/l0k+FMSSTWRrHWTeBKx4bGX9voBau5Xv6cUX8
         UZ9wxi+JxtBfhIe/IvXkt1OPVjdzYpMXFpLa8vdMpWT6QBOE8/9wEe4eVNg5uHVHSBYT
         LhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gDAAVo2wgpXEmXUntL4MPEE7CPihZnVOn4l/xFoHHs4=;
        b=pgaW84995JcLCUq1/8b0bZ+J0ROHDUOZFup1tWu1QVy1mfcgX7EhrHi21Q8yCLkuVj
         XH/Jo+P9dB2H62MWpzcr3PyU900RXayT875QZatGCs71pnJvaFXvgbyy99FAHaJZlUCF
         brE/bpTN5CdyyAILIVZ0eYRg+WnxJyHVcPd1/dGov0l37ygrJuo5wIQ924HwPD09uskj
         b7HihUdD2el9uMERB/fKYwhzs4oqkCpXu3zHVt44cijOoaQgdM07rKykgnMs4idsFg1v
         mfvEKNLV/08QaIOYTu61nVJT+Ynk12WFUPZHnRV1Jnmr7Jk5/3qJ1h0WtdhOzH5cAmVR
         5KNA==
X-Gm-Message-State: ABuFfog/GX6989L8+iqZyST3dNj+38AZ5W3b13KYFeDWr4xiQCUGiIZc
        y4ay3jfw87nVARbFMpmeWtnW3JwYVWuNCKd/JmCoKg==
X-Google-Smtp-Source: ACcGV62tVvI1bmRdqYnakH2iBkMXgPl0XSMIL5ttjIzqD+j2wrNTiSUMYa0j+0z6cu0XTpcYQwns8oLP8zHqq/9Dadg=
X-Received: by 2002:a6b:6209:: with SMTP id f9-v6mr9056979iog.11.1538062171935;
 Thu, 27 Sep 2018 08:29:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 08:29:11
 -0700 (PDT)
In-Reply-To: <010001661b9fad1d-cdbfabdb-5553-446f-bcde-585e42837415-000000@email.amazonses.com>
References: <000000000000e5f76c057664e73d@google.com> <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
 <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com>
 <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
 <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com>
 <20180924184158.GA156847@dtor-ws> <CACT4Y+ZPrngv8GTC-Cw68PBDxZ2T5x1kKMNXL3DmP24Xd0m_5g@mail.gmail.com>
 <01000166110bb882-0b1fa048-fe1c-4139-a1ba-702754bbc267-000000@email.amazonses.com>
 <CACT4Y+aUdAmRmgiV5-KWXF-eGoCUCMhUC+ddLU-heQTQ53PhRA@mail.gmail.com>
 <010001661b631a3e-f398fc0a-127c-4c6e-b6ca-b2bd63bc4a9a-000000@email.amazonses.com>
 <CACT4Y+biYtFUV7hK2ne2RfrbZjMt=4FK4deE0B6WykwT2qSt2g@mail.gmail.com> <010001661b9fad1d-cdbfabdb-5553-446f-bcde-585e42837415-000000@email.amazonses.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Sep 2018 17:29:11 +0200
Message-ID: <CACT4Y+aDFD6O48nV5J9UpXLiNpTPuSFoBQ4HVC+Kg1tM_KFEiQ@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
To:     Christopher Lameter <cl@linux.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 5:22 PM, Christopher Lameter <cl@linux.com> wrote:
> On Thu, 27 Sep 2018, Dmitry Vyukov wrote:
>
>> On Thu, Sep 27, 2018 at 4:16 PM, Christopher Lameter <cl@linux.com> wrote:
>> > On Thu, 27 Sep 2018, Dmitry Vyukov wrote:
>> >
>> >> On Tue, Sep 25, 2018 at 4:04 PM, Christopher Lameter <cl@linux.com> wrote:
>> >> > On Tue, 25 Sep 2018, Dmitry Vyukov wrote:
>> >> >
>> >> >> Assuming that the size is large enough to fail in all allocators, is
>> >> >> this warning still useful? How? Should we remove it?
>> >> >
>> >> > Remove it. It does not make sense because we check earlier if possible
>> >> > without the warn.
>> >>
>> >> Mailed "mm: don't warn about large allocations for slab" to remove the warning.
>> >>
>> >
>> > Hoe it arrives here at some point.
>>
>> It's here:
>> https://lore.kernel.org/patchwork/patch/992660/
>>
>
> Please post on the mailing list

It is on the  mailing lists:
https://lkml.org/lkml/2018/9/27/802

> and NAK to the patch. Testing against
> KMALLOC_MAX_CACHE_SIZE is not ok.

Why?
