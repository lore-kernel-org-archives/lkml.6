Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A44C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11D520837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFeCm5uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11D520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeHaKJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 06:09:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38438 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbeHaKJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 06:09:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so9161570ljc.5;
        Thu, 30 Aug 2018 23:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExvZ+hbmKKEeL0zrsIcx4hEayt9avlErupWR9P73DQg=;
        b=rFeCm5uH7qTG20R+dH06zGACWa/C6ndSgDgLHwbjfcPxB8nFXcq1kliinTgh7YdC67
         P2AE0iIM8gSyWjEA/JsV/fDby3ukxGhmI24h13P6TX2ykomeH8qS/FpuAyUOG+JnplAs
         dN8A4nEIBvuLcjTIr1XowF7re49cK2nUG8JZkaZ1xHjMDLybLkYOe4MS8QXqNT9i9x5e
         VeOW83ELOoTpruXaTZu0/kYmWAwWHBWzoaZH/MCTL8+RAqtDm+LcmfazBkCoTQ50Bn3i
         cGSpTQomJTGwgFU3mSNiF4+IN9xq/kSdzlB7UYIllvvH7Svczsglxyk2cs2azuj/aZiv
         jtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExvZ+hbmKKEeL0zrsIcx4hEayt9avlErupWR9P73DQg=;
        b=MlRsWuFdEDNsAMp198ArDe+b0s2QROWeCxLSGqELyRAZLhreYMAMPmbBGQ0RERmQ1m
         2hIe4/JGepbJTtomoinsVcDGJsXhEeTFyZnsWiEFHu5llgtAeENLGWg9WSRORBbwm8iX
         ds5JscmYAUDMwYHcmU6Hizzb2E42sTINiqNtVXC6uQ/rOO95aVrkBbXP3HOTGceWxTFu
         dBktiSxpSeguSX6jCNRgVm6LUWemMmGihLJDzL7nzUjW8lSQsG+HHZ1L0jGGFUFQIHq7
         l8sJ8wAqG7jYpGiF3HOg/5kvR2hVl4jf8470W2OM4JeL40mz+LqxuxQ1iNcxUuQYq+zu
         AeAQ==
X-Gm-Message-State: APzg51ANAznc4c47Cj2M3c6EEHTA58qTbzeNVpLv2E5A1uPIo2VNhFJm
        EtlfK3s7v4/0UsjW3OtFh17NUdVWsNKJmd0wrJo=
X-Google-Smtp-Source: ANB0VdZQ4MEkWNj4DyF5ZmhYQi+zLryB/Hmg1OdCrdXpWYH2aaDG07nAi5l4CNsYf7XwnviJpTsEaQNhVNSdtr/VrAw=
X-Received: by 2002:a2e:8098:: with SMTP id i24-v6mr9020440ljg.36.1535695440725;
 Thu, 30 Aug 2018 23:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180830172547.GA4408@jordon-HP-15-Notebook-PC> <20180830163352.5a96cc721ce069bed95fdbe8@linux-foundation.org>
In-Reply-To: <20180830163352.5a96cc721ce069bed95fdbe8@linux-foundation.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 31 Aug 2018 11:33:48 +0530
Message-ID: <CAFqt6zZckYhLJuJr9TSw2KOZrt6qD25xDctuvbKfm0jyBoPycA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Convert return type int to vm_fault_t
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 5:03 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 30 Aug 2018 22:55:47 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> > Return type for fault handlers  in ext4 and nilfs are
> > changed to use vm_fault_t.
> >
> > Return type of block_page_mkwrite() is changed from
> > int to vm_fault_t. The function signature of
> > block_page_mkwrite() is changed to add one new parameter
> > int *err. This will provide a way for caller functions
> > to get error value along with return value and use it
> > further.
> >
> > Return type of block_page_mkwrite_return() is also changed
> > to use new vm_fault_t type.
> > --- a/fs/nilfs2/file.c
> > +++ b/fs/nilfs2/file.c
> > @@ -51,13 +51,14 @@ int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> >       return err;
> >  }
> >
> > -static int nilfs_page_mkwrite(struct vm_fault *vmf)
> > +static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
>
> nilfs_page_mkwrite() already has return type vm_fault_t in Linus's
> kernel, due to the now-merged
> fs-nilfs2-adding-new-return-type-vm_fault_t.patch.  Looks like a simple
> fix.
>
> I'm beginning to feel vm_fault_t exhaustion.  Please remind me what
> benefit we're going to get out of all this churn?

The problem and benefit of these changes was discussed under this mail
thread when the first vm_fault_t patch was posted.

https://marc.info/?l=linux-mm&m=152054772413234&w=4
