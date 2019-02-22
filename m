Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6197C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FA120645
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RwbLtgZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfBVV3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:29:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43537 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVV3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:29:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id z20so2780912ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBp0dTqFzbvl8R/0avjnRfahZGjSD4PiV4YBmToiLC0=;
        b=RwbLtgZ5aOoO4pgKHAifejQCJh2QnBaYSO4HPaLQ7/dOJKJNpMSuyD+z69MBmix5ye
         F4w3GwK/dgs4FwONbRj/B7by1CTFf28xd+EqgqbUd/dXnGzJlt0peaUncmPLlyCDEkAQ
         TwLtD9vF6uhh3XiNa19WcT+Lzjnq+NFYJNYBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBp0dTqFzbvl8R/0avjnRfahZGjSD4PiV4YBmToiLC0=;
        b=Rrt8p8snKZoAwv0ieOMK99GBJRn7VgQywgatZdulGlnrhIpMIiZtrxA+50IV8MsnaQ
         Kgzq+UGOV12hoHHKHuzxtOMg7r4h8p2ik2VWmWrkh6Ngci27IVwiJJku7if2ZZvpTUf8
         GwcFnX9BmSt20V8FGSWpWNlEuoGYQ5y7py7z1CCg0HIBnmiwchdaT6sryCy5tS5F/aoW
         COAYk9fXPQ7lASmixK6KdHIU11vz4HEuBBZU48OvOusXJ6D2k+1CQjnsGFsrk3wRGiY8
         +PrnyZkVL4uGXXwJ4PBzUKodoOcKv56jcEiFlA+2pQRbWsb5JV8fsjPzwsgn6NS0/G01
         YuCQ==
X-Gm-Message-State: AHQUAuYb9kXd2VmSzE3gUewqHkS+qJ1QYLv0sMNSWz8pIHPFRRfc4okE
        mcfC89JySfAN5xBQ3SFWgOgk3m08fEc=
X-Google-Smtp-Source: AHgI3IbwvI+ez3FkUBe07qtI6YYIHeedCwSel9/MKMlH2xphGx+ev7ItG8KyTVtdlDrk93UFjbi1kA==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr2197994ljj.61.1550870940428;
        Fri, 22 Feb 2019 13:29:00 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v2sm725300ljg.6.2019.02.22.13.28.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 13:28:59 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id q11so2809730lfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:28:58 -0800 (PST)
X-Received: by 2002:ac2:415a:: with SMTP id c26mr3935916lfi.62.1550870938609;
 Fri, 22 Feb 2019 13:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
In-Reply-To: <20190222010502.2434-1-jonathan.derrick@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 13:28:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
Message-ID: <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alex Gagniuc <alex_gagniuc@dellteam.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 5:07 PM Jon Derrick <jonathan.derrick@intel.com> wrote:
>
> Some platforms don't seem to easily tolerate non-posted mmio reads on
> lost (hot removed) devices. This has been noted in previous
> modifications to other layers where an mmio read to a lost device could
> cause an undesired firmware intervention [1][2].

This is broken, and whatever platform that requires this is broken.

This has absolutely nothing to do with nvme, and should not be handled
by a driver.

The platform code should be fixed.

What broken platform is this, and why is it causing problems?

None of this wishy-washy "some platforms". Name them, and let's get them fixed.

                 Linus
