Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B992EC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7465721B18
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="WIfEsyfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfBLKXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:23:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38969 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbfBLKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:23:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so2030503wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7W8G/8FaSOJk9M7YHMfYt+bUiItd3l+RK8BDFjOuhhM=;
        b=WIfEsyfvAQS08gsNmMtnHMcv70Li+F9ZXFAafM6QykN3Gdm2PFkAO6YR2wEFpGLXE6
         4Zno41jwiiocRF91A8WKY4PslqX3MyWFTdzUHGrddos/ekqQ14yMEAWXRV9lRyotx2Qo
         Y+aOop1/iC5p8pblhWMtr8zIWoxl1ACFyMELp/2Zy4mT35xuyqgYyPfsaDZSM5extvm/
         QwOExDWW2w2G9YPwy5/2s64+Ng7/ZEwYc6A/ZcYLdPG9qy/FEy18ZcUbvPdXkyqxaBQ3
         rHph/51Iy9aaGZm+PeO1Uans3WhW76dD8HTwe6HLWZ2x+EiHa6hZDviC4EPytVa39jvr
         eU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7W8G/8FaSOJk9M7YHMfYt+bUiItd3l+RK8BDFjOuhhM=;
        b=HJCzRtqwYeXPi4wbvtQr7Fj+1iEuEhTYA7QGnbV9/ztnldUqhEi07HKT+P2670eNsk
         r4Fijix3T1DG12n2ORi0r/Wo/wwJftQD+q+8OYPlZPHmlxfdGVMTQ60NJ21xYh8UkjA8
         MOmRKjX67T2FSwP5Y3r0C4CoCrS9wUtN3VjUN188P1qpJY3LhaEYrlC9Jz0R6QgW8gwD
         PVgvmGAy1eP2gjCp2IGZ3ojq4dexoYHoBr5/bL9i5m//y3wRx7HY5HkKbOPGKqqkjJu8
         XM2jzwG7olSc/nUhinBeCSYQRrBN3c/3LLVA+zBCT4MkNzJljhp664RpUA7EPTB1wVhr
         W08A==
X-Gm-Message-State: AHQUAubY/52YJDGlNZgOrLrsqs+eQ5qSx99YoNMx0PznUIW+nU2nTRX9
        mViMgXUqnw5HGGDvIeY2/O5HDw6naWKHfUVs8LPciQ==
X-Google-Smtp-Source: AHgI3IY41xL2N5YF5uACORhGdY4bkLqRC823BuTXZ+5OcQgKQSlaaltMz8m1Kin3220iHkzvDN+NxZq889ztE4yDEH8=
X-Received: by 2002:adf:ee07:: with SMTP id y7mr2333442wrn.187.1549967012363;
 Tue, 12 Feb 2019 02:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20190119132650.9978-1-anup.patel@wdc.com> <20190119132650.9978-7-anup.patel@wdc.com>
 <20190212070807.GD26747@infradead.org>
In-Reply-To: <20190212070807.GD26747@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 12 Feb 2019 15:53:21 +0530
Message-ID: <CAAhSdy1NED22YyYrAJDqPkDqT1c2ms2QC9OjHP0qLwHT+o2zvg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] RISC-V: Implement keepinitrd kernel parameter
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:38 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Jan 19, 2019 at 01:28:59PM +0000, Anup Patel wrote:
> > This patch implements keepinitrd kernel parameter. By default,
> > keepinitrd=1 but users can pass "keepinitrd=0" to free-up
> > initrd memory at boot-time in free_initrd_mem() function.
> >
> > The keepinitrd kernel parameter is already implemented by
> > unicore32, arm, and arm64 architectures and it is documented
> > at: Documentation/admin-guide/kernel-parameters.txt
>
> But why do we need it?  Is there any good reason every not to free
> the initrd / initramfs memory when it is not used?

If it is initramfs (i.e. CPIO image) then contents of CPIO archive
are extracted to create a ramfs instance.

If it is initrd (i.e. some filesystem image) then RAM block device
is created in-place at initrd location. (Please correct me if I am
wrong about initrd here).

So in case of initrd we might not want to free-up the RAM but
we can certainly free-up in case of initramfs.

Regards,
Anup
