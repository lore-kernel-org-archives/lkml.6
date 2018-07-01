Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E181FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9156A24E15
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+jYFK+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9156A24E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeGAPnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 11:43:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52804 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbeGAPnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 11:43:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id w16-v6so5911468wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkmGkOnKZf4dlJ9W+baorO4YrsQ6czOX5oe5FlHsAVI=;
        b=W+jYFK+DSHZlVfWUwlGiyA7DjU/z8utnxbkJ/Boiw05IsHf9qgMnRHmQv9w4i9pyoE
         XExqtT44VDqpFoRJaaycPIvedMwbtvgdL/87YF+lPuYVNYDmCLzx2PlC0zg4akuU+I9b
         BOwbtcf0GZ2SJ1IT44SPfpFtb+Kij7iogCHvfNKrg8LqTWMZu1Mt4rAhxNkrYSF+IhYa
         /kUS37vL3NihaN9hmb4V4ZW+6mvDw0074btumAi4eeb+OEw/ngjA6EnanJPnEBzw3Ij3
         wkOa3LBnzALZV/v3gmBW/vE39N2ewAnR3ol7lDndhhD51pOOvaoVE18lQsFQIRv9ysEd
         9/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkmGkOnKZf4dlJ9W+baorO4YrsQ6czOX5oe5FlHsAVI=;
        b=WnN0Gfq4pc0hHXgta4NvR9f67sxWsA2DdppgRJoVncUz2tSovMKKQEKC8zOIaoehxp
         Cl9AkMeYnIyGwnirE/WaLGHo74hZqwCyqGZO0VONSdRy6WnVqzwZ+IFqBGfUMRCyG5SD
         HXnkvBRUXgBNBK0+keGjB8YFaTICzOGaSgncTUCZblxC5LrN0U8zRja71X1XQMkapDP5
         m09TcPd6L20+Ti3U4ayH/yjmOa584tSrv+0xC6q+iUuqmK8ztLRr1UcBSlUrsBb09iOE
         wbaIak+RqMxmzfdiyR1Xy6hpr20msrOui8hMU9SwO83KRFfEyfp1k+/HyOnJ2+stjGoc
         Houw==
X-Gm-Message-State: APt69E3VN6RBlMhRV88E1xX4M01ENgLSqiG8pUfe1zxOES9XTnNct7um
        YzarMmflUfNjT66HGcNHlduobqOn
X-Google-Smtp-Source: AAOMgpdsy6aUiEOARP8/tpqhCH+0tgBL31sPt41vvbaLWsqKdZffB3mAw0PPp6jpPajUMD3gbJxa5A==
X-Received: by 2002:a1c:8312:: with SMTP id f18-v6mr6454996wmd.127.1530459781525;
        Sun, 01 Jul 2018 08:43:01 -0700 (PDT)
Received: from hobbes.localnet (p2003006F8C519F687C36D93C7C7DD354.dip0.t-ipconnect.de. [2003:6f:8c51:9f68:7c36:d93c:7c7d:d354])
        by smtp.gmail.com with ESMTPSA id u13-v6sm4999287wri.72.2018.07.01.08.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 08:43:00 -0700 (PDT)
From:   Fabio Coatti <fabio.coatti@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: iwlwifi problem with iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()
Date:   Sun, 01 Jul 2018 17:42:59 +0200
Message-ID: <1537224.nkESeFtY4z@hobbes>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
since kernel 4.17  my laptop fails to enable wireless card (04:00.0 Network 
controller: Intel Corporation Wireless 8260 (rev 3a) )
with this error:

Jul 01 09:34:36 hobbes kernel: iwlwifi: probe of 0000:04:00.0 failed with error 
-12

I bisected the issue to this result:
d657c5c73ca987214a6f9436e435b34fc60f332a is the first bad commit
commit d657c5c73ca987214a6f9436e435b34fc60f332a
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Mar 19 11:38:20 2018 +0100

    iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and clean up 
intel_{alloc,free}_coherent()
    
    Use the dma_direct_*() helpers and clean up the code flow.
    
    Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: David Woodhouse <dwmw2@infradead.org>
    Cc: Joerg Roedel <joro@8bytes.org>
    Cc: Jon Mason <jdmason@kudzu.us>
    Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Muli Ben-Yehuda <mulix@mulix.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: iommu@lists.linux-foundation.org
    Link: http://lkml.kernel.org/r/20180319103826.12853-9-hch@lst.de
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

:040000 040000 9b907b7d761c6121d603c649421749ffd4e13999 
2f396bd9e11c46e865a46107cd3cc9ef6f9ee6dd M      drivers


By reverting this commit the card works again, tested in 4.17.3 . I've noticed 
that the corresponding amd commit ( b468620f2a1dfdcfddfd6fa54367b8bcc1b51248)
has been reverted in linus tree (e16c4790de39dc861b749674c2a9319507f6f64f), 
and 4.16.X stable tree iirc,  but the intel one has not been reverted.

hw: Lenovo P50 Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz

Please let me know if more details are needed, but CC: me as I'm not currently 
subscribed to LKML.

many thanks.



