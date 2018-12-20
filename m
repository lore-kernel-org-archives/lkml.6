Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3617C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690E220869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="hXbJyKN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeLTQrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:47:52 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34399 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbeLTQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:47:51 -0500
Received: by mail-oi1-f169.google.com with SMTP id r62so2427090oie.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sI7bwHbYAijeaUBXeZ6PRDz4NTwZhRzWaAh7mcZwI5I=;
        b=hXbJyKN9glTdOJX5WLb85KxgBftkNyVc+ecemjGFcYqV3PZU4nChGkCfblEAUxvi82
         JnekDX5STu/0bbhwMLC8T9XM/s9s5gKNmzhVz12BrVPHnitbVL+rDog9A2Wbrswaf2+s
         2NsCBTdfCUFkLN+TPJnjzSV2Q2cVVWdxPuuQKLZHCUWxzHZJFembSuN9TjFObVpbpPL4
         csoPF01LlGuMFx3/0DtDKjDKYa6ZeTqz3vETCXUgstROJv1ehXeq1o05LT+9if+QRnYh
         zQ+KumwbzX+6K/5xiM2Zaz96n6DiCD4rig4FqOu/iRPkd7EKlviMESsvwP9TBPfgpyas
         hSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sI7bwHbYAijeaUBXeZ6PRDz4NTwZhRzWaAh7mcZwI5I=;
        b=pz87ou5/fxkUj2Pa0a8sKkmnCg94w5XO3MNQzDm0jm4sf5vBcneya+WhnBAk8v7lXf
         Qsov3aR+KutNPTzVvlzGBP+haSIdzc1PKJw1id1HFIbm69fqgCpi+N6qgDvg/7tSkZ6R
         oT6qjViMazfRtqitfjWY4iax4mPVk9lwg9ujwDdaIhqKsI9HqBbV6WVNgf7ufKNlkufd
         T0wfz+Lcs5ouzfp9bhQKIYI/PxTFK/5aWBTotPLJnmO+Mm5dfSJ1muwO8ZdNxgX6TtQz
         1UJzVSztKgzsv0JmTyVAi4esSWFWEOZgGQ+lf7Mptpm102kgM3gfbraoTNixx+ibHq3j
         kAtA==
X-Gm-Message-State: AA+aEWav9OzyVC1h+OgVsEZ+Mp9A5FhofRcgY8sozS6QCIC5Nur/xef/
        AkXKxGQwHwqPwHV5bjdCzJeIjFjnmrHjltOzPrUWQg==
X-Google-Smtp-Source: AFSGD/UsVdLYgb28HPXi1k9t2yBinuvAuN2uAnk6NO1MPTD/rMq3iYwlMqn3/8qlSeNYzc7HJlSjuHCABOD/Qbae16I=
X-Received: by 2002:aca:b804:: with SMTP id i4mr2753790oif.280.1545324471176;
 Thu, 20 Dec 2018 08:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20170817000548.32038-1-jglisse@redhat.com> <20170817000548.32038-8-jglisse@redhat.com>
 <CAA9_cmeag7n4yeiP6pYZSz80KyxqfwbsXJCWvyNE4PSaxCKA3A@mail.gmail.com> <20181220161538.GA3963@redhat.com>
In-Reply-To: <20181220161538.GA3963@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Dec 2018 08:47:39 -0800
Message-ID: <CAPcyv4ipg7smdCZTLeEogKdsKJGrCpaDKaghbTjrM8wkZDaoSw@mail.gmail.com>
Subject: Re: [HMM-v25 07/19] mm/ZONE_DEVICE: new type of ZONE_DEVICE for
 unaddressable memory v5
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 8:15 AM Jerome Glisse <jglisse@redhat.com> wrote:
[..]
> > Rather than try to figure out how to forward declare pmd_t, how about
> > just move dev_page_fault_t out of the generic dev_pagemap and into the
> > HMM specific container structure? This should be straightfoward on top
> > of the recent refactor.
>
> Fine with me.

I was hoping you would reply with a patch. I'll take a look...
