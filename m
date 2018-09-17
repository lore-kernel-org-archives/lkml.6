Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64573ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B1C20867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrM9pgj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B1C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeIQXWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:22:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34477 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeIQXWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:22:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so8038266pgv.1;
        Mon, 17 Sep 2018 10:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nytzIxUjfksfX2nhDHA4EPdGkfQJ0vfUCjG/JpAN6eo=;
        b=qrM9pgj8+1ZtIYLTINzc4TUCXDFRNlGY5Mr8ptCTKVcjqDU8qDj2U5iemOQz2ovp4S
         qsIEz0QeI2bx7W/L68B29Mej5rw+jP8C2fUSNk/R7Y3MGLrFpnAjjiaZEBq4qQRb1Tf/
         TPFN/mIJUajC618HcAD2ZpApb3LKHkudQZjFoaP+ZpJCG3Xsk89jGasAQdJjWxs76mUU
         Po+0ws57dufAdBzsf144a7gAo54Vqk9fo2HeV4iVW8Q3KC3f9I6KKjBNNYvF/j+us5Vp
         nor+BMNNFtEMkEbvhEkzFuhl3lsBwJKpA8vLvHyOb6siNduzqKUinDHjlrv0Caqk77bP
         JmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nytzIxUjfksfX2nhDHA4EPdGkfQJ0vfUCjG/JpAN6eo=;
        b=K98JXB+TnjpE9BzZbiP6xUcmftaGNRq+tBCjDOvNvc5BGogPZctnwjwhFsl0mo0i7S
         mYJv4gVNbiug1capX9xp2xSJhG7wqxSYOYanYY41OGppVMMcrd/Ywq7uVS7NR3DLV4fg
         1wH1gy/JHGLsh2ttqd/UnYCTuCVsaVFM5bOd1Yx5ilW04eAuE5fjwd4VbYaHtkNuFVrZ
         m9jSbgT7PD69Lnj23ounV/fhqOirraisRSKg1F41BDc57MLKa75l9jdQvP43ctpA2YFS
         sr4ioj8nmSM1h9WH0JxyCy+LYB3mehO4cu7ghousSFv39vfsFKOPacBx+D15+xy6YhVJ
         coiw==
X-Gm-Message-State: APzg51Bz1toYx23EWMGKjRxhjKKtsM6gJ3CENOATt+1fwsHOrphV6yBs
        0W1tOgoTXt+n3AFR7IgUfyw=
X-Google-Smtp-Source: ANB0Vda28AlLaxvT5wygKN03IoKdelWSI6LPX0W4+ez9euIIIgVGRcTRt2UYFiWE6GvJx/rj6AYiUQ==
X-Received: by 2002:a62:a05:: with SMTP id s5-v6mr27348561pfi.147.1537206825304;
        Mon, 17 Sep 2018 10:53:45 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([61.68.124.14])
        by smtp.gmail.com with ESMTPSA id p11-v6sm26230893pfj.72.2018.09.17.10.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 10:53:44 -0700 (PDT)
Date:   Tue, 18 Sep 2018 03:53:37 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Subject: Re: [PATCH 3/3] mm: optimise pte dirty/accessed bit setting by
 demand based pte insertion
Message-ID: <20180918035337.0727dad0@roar.ozlabs.ibm.com>
In-Reply-To: <20180905142951.GA15680@roeck-us.net>
References: <20180828112034.30875-1-npiggin@gmail.com>
        <20180828112034.30875-4-npiggin@gmail.com>
        <20180905142951.GA15680@roeck-us.net>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 07:29:51 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
> 
> On Tue, Aug 28, 2018 at 09:20:34PM +1000, Nicholas Piggin wrote:
> > Similarly to the previous patch, this tries to optimise dirty/accessed
> > bits in ptes to avoid access costs of hardware setting them.
> >   
> 
> This patch results in silent nios2 boot failures, silent meaning that
> the boot stalls.

Okay I just got back to looking at this. The reason for the hang is
I think a bug in the nios2 TLB code, but maybe other archs have similar
issues.

In case of a missing / !present Linux pte, nios2 installs a TLB entry
with no permissions via its fast TLB exception handler (software TLB
fill). Then it relies on that causing a TLB permission exception in a
slower handler that calls handle_mm_fault to set the Linux pte and
flushes the old TLB. Then the fast exception handler will find the new
Linux pte.

With this patch, nios2 has a case where handle_mm_fault does not flush
the old TLB, which results in the TLB permission exception continually
being retried.

What happens now is that fault paths like do_read_fault will install a
Linux pte with the young bit clear and return. That will cause nios2 to
fault again but this time go down the bottom of handle_pte_fault and to
the access flags update with the young bit set. The young bit is seen to
be different, so that causes ptep_set_access_flags to do a TLB flush and
that finally allows the fast TLB handler to fire and pick up the new
Linux pte.

With this patch, the young bit is set in the first handle_mm_fault, so
the second handle_mm_fault no longer sees the ptes are different and
does not flush the TLB. The spurious fault handler also does not flush
them unless FAULT_FLAG_WRITE is set.

What nios2 should do is invalidate the TLB in update_mmu_cache. What it
*really* should do is install the new TLB entry, I have some patches to
make that work in qemu I can submit. But I would like to try getting
these dirty/accessed bit optimisation in 4.20, so I will send a simple
path to just do the TLB invalidate that could go in Andrew's git tree.

Is that agreeable with the nios2 maintainers?

Thanks,
Nick
