Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8187C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3D920856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri4uR0C7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3D920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeICWn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:43:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44946 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbeICWn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:43:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so470609pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RxKV2hCqxXyuXRvqtbBUdObCDD+oLD1M9subWdqBoOc=;
        b=Ri4uR0C7JWEIYSsUm8nqreKHK8fxyTLuS/6sSx3GoeDrxm6Lc/Odf4bKK8N7gP//MY
         1eE+azqK/lCTYH+npHEi7tEdUBxrvdnQC+u8/Rzxt1XgjjPgiXgDtFxFN/qDaNAOq8u8
         iCSpQ84FvaBonmCbr5xDiCWpaKcXdgVSl/R49ZFNlRiH2daURBSdjmk28E/cRTLGgaF1
         dH5BC096qVIt6FCGXMffpPH4LVE/FT/sstHTAd8IpEgttsgH93Y6Al6oGjjNqswZ2jxC
         YNSdq1auYtpJ51/TbFm+LTRKYE7aQreKfLiAeBONRJIGfgI7qbUVwUVnOCqRFdKQObVR
         Xolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RxKV2hCqxXyuXRvqtbBUdObCDD+oLD1M9subWdqBoOc=;
        b=Y5drq+B4V7+6dRK/8+Bi1CdbwnAcA8oe8uIhwdcrG7O7hiHVMRRi9eLCBkgO2C9vEr
         SAOLtN1DrxB30RJaroGTiqMiCsyBnBCFmLlremndATInPxD8U1hb4GrrR24G5pcgHKS8
         OAicPINYDLrQn4nioxFjDpFc15M3FA3/y/FiTy+ISkpU2Zc8C8KKdsqONzC7seW7PlEn
         EEEsTuiMzZKndsgxfrVkC2JRf7m1temxfxf8eWnQ8cNYYsc5jVAv0tHLGsa0yxcBNJ29
         lsYKMWTtbWUxCbYLBl/9SwMWPlKfUK7LUCD6QOP/y9i1z8g9kjVAgZ3TBiymFm96urma
         9zLw==
X-Gm-Message-State: APzg51C6mhWzuBmmVfCYnrCvw6CKkyBqlTKpXcC0tf+aMhmMp5i7OHpe
        TT22DKgCSjLvbCz9Q3zfjYhnDXWD
X-Google-Smtp-Source: ANB0VdYHb4PDANVoaaM0pLajH+4U8I+fn75oBfRGuEmvI9wahOd6Ya4OakENNOqEVQCWOMEEwsJ0oQ==
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr19885673pgl.302.1535998924589;
        Mon, 03 Sep 2018 11:22:04 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u25-v6sm27200264pfk.177.2018.09.03.11.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:22:03 -0700 (PDT)
Date:   Mon, 3 Sep 2018 11:22:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: Linux 4.19-rc2
Message-ID: <20180903182202.GA14258@roeck-us.net>
References: <CA+55aFyG0GbDfoghEhAmKBPcZCiPu6CCpPRz9GwjCzLuP_Vv5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyG0GbDfoghEhAmKBPcZCiPu6CCpPRz9GwjCzLuP_Vv5Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 02:45:22PM -0700, Linus Torvalds wrote:
> As usual, the rc2 release is pretty small. People are taking a
> breather after the merge window, and it takes a bit of time for bug
> reports to start coming in and get identified.  Plus people were
> probably still on vacation (particularly Europe), and some people were
> at Open Source Summit NA last week too. Having a calm week was good.
> 
> Regardless of the reason, it's pretty quiet/ The bulk of it is drivers
> (network and gpu stand out), with the rest being a random collection
> all over (arch/x86 and generic networking stands out, but there's misc
> stuff all over).
> 
> Go out and test.
> 

Build results:
	total: 134 pass: 133 fail: 1
Failed builds: 
	sparc32:allmodconfig 
Qemu test results:
	total: 302 pass: 301 fail: 1
Failed tests: 
	riscv:virt:defconfig:initrd

The sparc32:allmodconfig build problem is the same as last week.
David - any interest/plan to get this fixed, or should I just drop
the build ?

The riscv:virt:defconfig:initrd boot test is known to fail. The patch
fixing it is in -next.

---
Runtime warnings:

arm:

WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 drm_gem_cma_create+0x13c/0x158

This is seen now due to a newly enabled configuration option.
Fix is in -next.

---
sh4:

WARNING: CPU: 0 PID: 932 at mm/slab.c:2666 cache_alloc_refill+0x8a/0x594

Same as before. I'll try to dig up the patch and ask for the status.

---
sparc32:

WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 esp_sbus_probe+0x408/0x6e8
WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 sparc_lance_probe_one+0x428/0x4f4

Fix is in -next.

Detailed logs are available at https://kerneltests.org/builders/.

Guenter
