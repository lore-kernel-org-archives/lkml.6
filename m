Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B262BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFF02087E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArZtR2tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFF02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755373AbeFNRDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:03:32 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34756 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755214AbeFNRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:03:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id a63-v6so3549884pfl.1;
        Thu, 14 Jun 2018 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3BkHA9xFqUX1zuLR9IfQ62Zrt8h+Os6UTsy1x+HZSMo=;
        b=ArZtR2tcclRjA0/Xh1lV9Q7QhozaZi1h/UV9aSM8Su9w00XOHa8sE6cSvq/hzVDcb1
         BlGGe7SzpgQYfb6FCWYIrNtB/vn5DQ9Jeq5aWWR6GcpObxh1TxNv9BOF9W5kWKNAYvBk
         ehJmnjfNvldVIKiw1QXXglVDSPvmZd4rxXsV5buoyy2PfzCDS9vUQcrp0NN1PtMyRSbj
         DvbXe+082rxlNEiVuyS8A2mw1i4qOLiJZUvvtZYWJ1xO4LJefkbHsLa3uqFmS5cwdfjL
         i80vHNcJ+Wv5tL/BJ19rB5FIXBIY/Y/tcTwzEncPXBMsvrKk9GlokqDuyNc0Buh8y3Kf
         bZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3BkHA9xFqUX1zuLR9IfQ62Zrt8h+Os6UTsy1x+HZSMo=;
        b=XwjccEdnRxIlYL/YCs/P9GqAVe0MvhXvMOYPFBjBo47sXwUv+21TOYGXTUwhQBz1TC
         m4mfs+n/VviuLEHAjBTMzY6FHuSpcZzsWFmy9zOVx69iNIIqY8BeU5tUMbIYqKzyEfgc
         85sGizLrsz5AuLljd5KSNwIYgeyMN0tzn1VdMk6Rbq9X06UoiwrsaMFoFdbgrQX/oRJp
         FS0xFZGrMwozHbsyfgp5AOOahuWSkBxJdDZrZRb3gGZVz17Li6C3sTlqcaXHOnrLnj7g
         CViSblBU2a93Bbd22kJSXlqTIwX8CQCj4k0Fg0suZ6uvgrjfQePVgIB/VAlpWRn1z689
         58pw==
X-Gm-Message-State: APt69E3+xZ10SDf5FUAX4kHppCJyA8Gbv/Bm5eLj6EJstZ3u5VJjxPwl
        UK2KZB6Y5wpZR4PbG52yEiANhhlNLCqghY4yac4=
X-Google-Smtp-Source: ADUXVKL8KQYvoW7No9iQRvxglCi+b8RrDPPgCVTlx53pehR1vm4etATVQM8l2KZNHjwvP2oZroDziN2KBpio4KowAdk=
X-Received: by 2002:a65:42c2:: with SMTP id l2-v6mr2981384pgp.237.1528995810339;
 Thu, 14 Jun 2018 10:03:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:284f:0:0:0:0 with HTTP; Thu, 14 Jun 2018 10:03:09
 -0700 (PDT)
In-Reply-To: <20180614142448.GC24762@mellanox.com>
References: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
 <20180614053446.GB18426@mtr-leonro.mtl.com> <CAM_iQpXxHk+yFqqK-Hezsc83_mKfbUXr4=jjNnik5DwGscRKUA@mail.gmail.com>
 <20180614070108.GD18426@mtr-leonro.mtl.com> <20180614142448.GC24762@mellanox.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 14 Jun 2018 10:03:09 -0700
Message-ID: <CAM_iQpWz9b01ksW_OUHgr1=pf-bNsq_TxoNCQxuDdhUXfvoyOQ@mail.gmail.com>
Subject: Re: [PATCH] infiniband: fix a subtle race condition
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 7:24 AM, Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> This was my brief reaction too, this code path almost certainly has a
> use-after-free, and we should fix the concurrency between the two
> places in some correct way..

First of all, why use-after-free could trigger an imbalance unlock?
IOW, why do we have to solve use-after-free to fix this imbalance
unlock?

Second of all, my patch is _not_ intended to solve any use-after-free,
it only solves the imbalance unlock. I never claim it solves more
anywhere.

Third of all, the use-after-free I can see (race with ->close) exists
before my patch, this patch doesn't make it better or worse, nor
I have any intend to fix it.
