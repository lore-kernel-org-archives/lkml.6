Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5543DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7B6208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXLfuTJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7B6208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755150AbeFNMNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:13:49 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43555 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbeFNMNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:13:47 -0400
Received: by mail-ua0-f193.google.com with SMTP id z16-v6so3943740uaz.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xpYuZ1HTCoLcfQFlARb8HdNao8setJ3UcEx3avC9eu4=;
        b=cXLfuTJXbGJebDBX9mIYqzbwTmoyLIQw+r6ceIRmeGSRkybQb2Y/Ys4glBaLPNfcLq
         P6JU47BRtYjxJ4P4rQVlfLmvcndIUw625+7shXi9illepp0dP+GCgEAaUslaif250vgI
         cbbZnMRSi9Qsov/QwF3YoKSRLMA8/oU28BHLEp0r/FUy0d1H0M9lQvakec7LezaHxgkw
         09+yHXsNVNVXueFiANgwnGM3FpKr4P9a72z6leCnJoBvYIDD1P7SRZd0DIxNkWV3ye1z
         B5jZjQr/a0KxJ0NIvoTSfYl/5qqbH4paPduAWHX89W5rjLY0RclGpsiavI7y+MH6WAWl
         Ma1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xpYuZ1HTCoLcfQFlARb8HdNao8setJ3UcEx3avC9eu4=;
        b=jBpRn7kLJwaFQSRA5eR6WyyYgyIHmdvpyIDqY1XJs3yyljId5YgMY/BoACLBJ8EEBr
         8PFt8R+xz+H6tlbS1OCBH/18btIZ79zmnQN4pzRwmFl4XzYgUdgEYf+DaB22r5uyCHk4
         B8NJZedEKS8CZVpfFzfsNORtCVul3pSb2ELzs9w1itO7d0zAZzaVcBYwpwIDrDUsEz/H
         Rwx1TwLhTnPUgEkqhrlU99ZSoCwf+nt4UwFKh3MVPjZveF2lYcT8fonXgsyAwYVTvBpC
         rz2oqHSQza5hbmpfTXnevIr8ebg1h2cssQ9FfNr3DYXy3qIRCPsxDCceUkthguAVjwjk
         Pnwg==
X-Gm-Message-State: APt69E0UQoLSiIA2sPgxKC5tPAEznqVP9VBU8VfBEO2CWq6YmFMt6xU0
        LUtjxrysHDI84SsnMkwfPysOS6JrSJ6o2HRdqBjjjQ==
X-Google-Smtp-Source: ADUXVKKKkm16FTk8TUNkE9gRADt0QZAu2Kkimb0V6ZT4cg4ozi3uVhzTIRJdi7ikbKzFOo0Qx6WyZPdsNB9WNxQUqr0=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr1473319uai.47.1528978427281;
 Thu, 14 Jun 2018 05:13:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 05:13:46
 -0700 (PDT)
In-Reply-To: <20180614120029.27315-3-hch@lst.de>
References: <20180614120029.27315-1-hch@lst.de> <20180614120029.27315-3-hch@lst.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jun 2018 15:13:46 +0300
Message-ID: <CAHp75Vcpmx=GLU087Et+LA0_LOCF-xu1beKzb4iLxoOOi91Qmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: move all DMA mapping code to kernel/dma
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 3:00 PM, Christoph Hellwig <hch@lst.de> wrote:
> Currently the code is split over various files with dma- prefixes in the
> lib/ and drives/base directories, and the number of files keeps growing.
> Move them into a single directory to keep the code together and remove
> the file name prefixes.  To match the irq infrastructure this directory
> is placed under the kernel/ directory.

For my point of view, makes sense!

> +config HAS_DMA
> +       bool
> +       depends on !NO_DMA
> +       default y

I see it's just move from other file, though we might switch to
  def_bool y
instead of two lines.

-- 
With Best Regards,
Andy Shevchenko
