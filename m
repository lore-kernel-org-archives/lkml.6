Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06858ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD13720834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTNd9j5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD13720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeJZQM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:12:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37911 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:12:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id r22-v6so202442qtm.5;
        Fri, 26 Oct 2018 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8s8U3JSu5h8uRbuI5LIATNyorUWP4l/UhJUD3ZFyujk=;
        b=iTNd9j5UsWAntMBrUEskClvdHJ5HZvVQm39le+y0dQkH+Du9a1NfiAN+jaUvrA9ZRu
         pfLgynOyW4f8Y73D+ov0j8I4UqkoXM5NaRjbrqJsIp3iCGWkwpazuQMztRBPUBcyXGdg
         WPQf+Z3GC9Q9tS6upTCzfk60xEpe2i7EWNakaMX4SHdavWWM/MdXbrGPgC/ueCAijPp6
         MW0Au63+D0MQE86TnyTHmwXEPqPq5IPD1+Bf1qp45+KneNX4bONtC66IjIKcJKdSn5H9
         6GER/36/h/q5ivtNNQdpBzLT+yrx1dP5S/SJ9k1ZUzgkNHnmcadCk6NTYPURC3x3/U/u
         8KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8s8U3JSu5h8uRbuI5LIATNyorUWP4l/UhJUD3ZFyujk=;
        b=XvGvU/uvbYYw6mJd+ZlQfdz3MJ13lDqJGcKypIoO8ZKQEG+RjsS2neHqQ3B7WaSdNH
         lRFaEcSLS3H2ONqLv2gwg/G+M8seH2v3Srwc226lingvM5vHOk29zjD/a3aw44kDeoYV
         8TvYx1FpsDEOAFgi/m3uuPlsax9lRjA6wAmqIvYR3p4lH9S383wBXu4pQiDjw/QazGbk
         tB/Snf2iu0AOy5rup+WjAobUJwC7L4i7iI/ycFBcdPUPya9hvdIDzG1b14u+bvDh7oYD
         ntAHesW5tSGHp9Tl2lpWwU1/w4nxYzZekYTFL+DWrtRJKpk3wMQTE3sVToMWhu6iKiFs
         UrYw==
X-Gm-Message-State: AGRZ1gKJdGpL8gveZXXuKjUPq2bOuI//fjtsVdMIcGucFH9+CS3WIPtI
        WC2szdx5wT+WDdSWo7jYuBDgagF3bC5/GWqen5KfFw==
X-Google-Smtp-Source: AJdET5fbxJ18ZZbIJjbZHtT4i7DtfwMB4ZlZXfLx6mEJWWrbGsUEtnBuzmkFTTiHySJfzkZRH7HR8R62HYRJ4AEUqOA=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr2118326qtl.343.1540539391683;
 Fri, 26 Oct 2018 00:36:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 00:36:30
 -0700 (PDT)
In-Reply-To: <20181025195254.q55noj2rdh5vyw5s@pburton-laptop>
References: <20181025141053.213330-1-sashal@kernel.org> <20181025141053.213330-33-sashal@kernel.org>
 <20181025195254.q55noj2rdh5vyw5s@pburton-laptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Oct 2018 09:36:30 +0200
X-Google-Sender-Auth: 0bljCwgwnlGGTJ5q_lvavqjly3U
Message-ID: <CAK8P3a2eOo=9Pv4XmyX30_PYoRpp_f6rXQn+pk9z21wMvE84Ag@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 33/46] MIPS: Workaround GCC
 __builtin_unreachable reordering bug
To:     Paul Burton <paul.burton@mips.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18, Paul Burton <paul.burton@mips.com> wrote:
> On Thu, Oct 25, 2018 at 10:10:40AM -0400, Sasha Levin wrote:
>> From: Paul Burton <paul.burton@mips.com>
>> ---
>>  arch/mips/Kconfig                |  1 +
>>  arch/mips/include/asm/compiler.h | 35 ++++++++++++++++++++++++++++++++
>>  2 files changed, 36 insertions(+)
>
> In principle I'm fine with backporting this - it does fix broken builds.
>
> It's only going to be of any use though if you also backport commit
> 04f264d3a8b0 ("compiler.h: Allow arch-specific asm/compiler.h"). I'd
> recommend backporting both or neither.
>
> In practice I think it's unlikely anyone will need a microMIPS kernel &
> be tied to the particular versions affected by the bug this patch fixed,
> so I don't think it's a problem to backport neither.

I think the current practice of the stable kernel these days is to take
both patches in this case: They fix an actual bug in the mainline kernel,
and it seems unlikely enough that they cause a regression if backported,
so putting them into 4.14 has more advantages than disadvantages.


       Arnd
