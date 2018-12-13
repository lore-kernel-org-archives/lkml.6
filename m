Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF60C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B4C2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iAtgXtNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B4C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeLMUQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:16:04 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32944 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeLMUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:16:03 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so2728221oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 12:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DqkQEf9kyIYcQse5A/i3VKV32fnX4vmMnow5qWhVS0=;
        b=iAtgXtNCbKumiVhJ6+sw7EXkDWpKU42uul5ijgV6Gn4mC5bsUybh2f10kscLs/FF6h
         U9d9LAe3YJZ18DjUpTUtA/gqZJ7/eR7N7yP9GITLt1ra9WynrAQ7N1jZOg45Qi/G3IaO
         NN5LT2qjXp3EWQW9aX1xZ462hy3rzPh2U6Nd/zlMEsiCj7FXf+to/izsNbNWHkpN5j/y
         q4HLB67v+3u44ttNmtWlyLPrdJ2E6HD0W59Vu1Bm6N4hV20nRrwHcRZgyUw1tXxYKBo4
         M2/5oQwVJS0tPkNJ0XrTQayGdkTfZPbglI0GgQvyy/bKXKyhpepvvAqa2du5mkOdgfTu
         wC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DqkQEf9kyIYcQse5A/i3VKV32fnX4vmMnow5qWhVS0=;
        b=WdoEffT7qldQhSBwIraHeggQg7AcXiKv8hry3AQBMwyjda+h+L58ezoDoL0orcC+fP
         ziCvwQg6YB+IQKCZ6+4vGrIfh/mL0x9gaCEOH5s8C79eN4nOw+7ITfar5FadUMNfbRCn
         /OEvDV3ktn5tA35vCARPlhK9QPJeqo32tP028ZvgM/a3hvjVVaCf2q8nRfCCuswWExCs
         C6F3qdHHerRHh1BJVmRuDCU6v01VCLeZBg+irZMYLLMfSw/ke7Z/f9eIaHx1wk4JmbvZ
         xnoJ1liv3pqpNea5OiPiwW5GA0V8o3G3uKKjnsUixVZwoBBHh34yt/7h2zxR3PnZ9OWX
         NfQA==
X-Gm-Message-State: AA+aEWa0bERA8v1lCc//7fO2Sy9okJTBcjx6Y83UptcLOYaeutiM4s7h
        QzXy3qezTbzxFfho1F2wY7kM7eifEPHVD2848vSS5A==
X-Google-Smtp-Source: AFSGD/Wk3OS+2dGDU4VQSCl87b1LLZMOVdSXNjVjQBgZ/PhWGDbCzY1r/19dW5qe6r82e4J6q4bFNhS30z4qtv7XSCI=
X-Received: by 2002:aca:d905:: with SMTP id q5mr157163oig.0.1544732162568;
 Thu, 13 Dec 2018 12:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20181210171318.16998-1-vgoyal@redhat.com> <20181210171318.16998-16-vgoyal@redhat.com>
 <CAA9_cmdLvFqG_Us5ZoBopj2ssWzxVbyNqf4XcgmY+=D_gARWDA@mail.gmail.com> <20181213200936.GU2313@work-vm>
In-Reply-To: <20181213200936.GU2313@work-vm>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Dec 2018 12:15:51 -0800
Message-ID: <CAPcyv4hwPBGLkAN8MKhtti8e-=hksg+oD3CDAUY6B9uh54zBLw@mail.gmail.com>
Subject: Re: [PATCH 15/52] fuse: map virtio_fs DAX window BAR
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>, sweil@redhat.com,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 12:09 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Dan Williams (dan.j.williams@intel.com) wrote:
> > On Mon, Dec 10, 2018 at 9:22 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > >
> > > Experimental QEMU code introduces an MMIO BAR for mapping portions of
> > > files in the virtio-fs device.  Map this BAR so that FUSE DAX can access
> > > file contents from the host page cache.
> >
> > FUSE DAX sounds terrifying, can you explain a bit more about what this is?
>
> We've got a guest running in QEMU, it sees an emulated PCI device;
> that runs a FUSE protocol over virtio on that PCI device, but also has
> a trick where via commands sent over the virtio queue associated with that device,
> (fragments of) host files get mmap'd into the qemu virtual memory that corresponds
> to the kvm slot exposed to the guest for that bar.
>
> The guest sees those chunks in that BAR, and thus you can read/write
> to the host file by directly writing into that BAR.

Ok so it's all software emulated and there won't be hardware DMA
initiated by the guest to that address? I.e. if the host file gets
truncated / hole-punched the guest would just cause a refault and the
filesystem could fill in the block, or the guest is expected to die if
the fault to the truncated file range results in SIGBUS.

> > > The DAX window is accessed by the fs/dax.c infrastructure and must have
> > > struct pages (at least on x86).  Use devm_memremap_pages() to map the
> > > DAX window PCI BAR and allocate struct page.
> >
> > PCI BAR space is not cache coherent,
>
> Note that no real PCI infrastructure is involved - this is all emulated
> devices, backed by mmap'd files on the host qemu process.

Ok, terror level decreased.
