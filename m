Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51A3ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C483214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="G1ZpU7za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C483214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeIWTCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:02:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38231 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeIWTCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:02:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id j8-v6so13297937wrw.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qamf5WVEhA14WoAZkhjKj+Q2aOhf6C5QQjC4bSKGsh8=;
        b=G1ZpU7zaY66sXAdarFUHQzmi+6Y0ovM7X8D5TNxxLmSIh/4xdFzR1bKsqkrFw5drzt
         +Gyc78tHmZU6Hnw5oO38AackCaq36uVgV4N8tNR21agrbhwit0FHnpPGj3ob8ch9EQlp
         KS2FtqkD3VU28IXXoVuocFbkAur3Iul/i+yGHMqcAHcDZ75rzcidqotemzHJfUQtDiGo
         rhLMaHWIAIdPQCLAz38AnhnhYu7dp9Zv4CM6cEUc8iU4ioZrSNE4bVvitSEg29CEKxuA
         KwcPIxx9hQlFu3Dhw0TGA9ijWJMRw9cGSRlkb94RLfwNr0z7ckaHWe1uxc1seRFDf3q5
         zE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qamf5WVEhA14WoAZkhjKj+Q2aOhf6C5QQjC4bSKGsh8=;
        b=era+bmZm7AwxnHb+PUuE+BiQ8Xgl8gT/ZArvK50RaCiKE2RjMjZ+2RQmbHy33hVrMA
         IwiSyZk3Z81bCjvyjaGAPu9xPaQjD09wPZg2X72cCX9mw+goYf42Nr737iak6yqJFnw6
         e5C+tyfNcu+RaZzipchYk3cYk7/2tWcL3M5LW6UMA/Zs2Va7In/Hnl+3l1vPnZO5Wezg
         QOrn98fbbvekUyXo7WPbfABq5aXv0JcJ9GXeFaxQSXfxEzpVhFkLTVGdcTsZzSYEha8W
         oFPH9qnB5INoLwGJ0DHm6VsybJa/5OuPP7Ju5AkTDlOdL0pyI3G2To1VeoKmxIbPkHDq
         P2Qw==
X-Gm-Message-State: ABuFfoiL9bjlFj+gtn8++qtyLumnzBYoitz0G7I8mYsAzhGmxrYwRv6S
        e46olGUEfKz62wn4auZAzDrB5aBjFTs08ZhIGaq8Vg==
X-Google-Smtp-Source: ACcGV60nzfJPk/0zpZGRQwJSX8KmuXroy8ogNxnqbA6aE3CQCNgcRwqvOr/7NvbgBhxo63pfvaV8p2PTrqYGPd91C8c=
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr4653024wrf.46.1537707889488;
 Sun, 23 Sep 2018 06:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180912143822.21948-1-anup@brainfault.org> <72961c71-c4e4-7990-da64-a7f1613f2e1c@wdc.com>
 <20180917141018.GB28689@infradead.org>
In-Reply-To: <20180917141018.GB28689@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 23 Sep 2018 18:34:38 +0530
Message-ID: <CAAhSdy05S_GRbrBcnzt_3TL=Su+QYz8+addqXVumvxmANujRJg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Show CPU ID and Hart ID separately in /proc/cpuinfo
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 7:40 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Sep 12, 2018 at 09:47:55AM -0700, Atish Patra wrote:
> > The extra hart information will not be parsed by lscpu which will make the
> > cpu information inconsistent between lscpu & /proc/cpuinfo.
> >
> > Should we patch lscpu as well to show correct hart id as well ?
>
> It would be good to follow whatever prescedent other architectures
> with different logical vs physical cpuids have set.

Most architectures (x86, ARM, ARM64), display logical CPU id as
"processor" attribute. I think we should use same name for logical
CPU id.

Other attributes in /proc/cpuinfo are very different accros architectures.
For e.g. x86 shows physical CPU id as "core id"

I will revise this patch to use "processor" attribute name for
logical CPU id.

Regards,
Anup
