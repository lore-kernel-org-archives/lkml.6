Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E5C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664722173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alexfeinman-com.20150623.gappssmtp.com header.i=@alexfeinman-com.20150623.gappssmtp.com header.b="An2naeXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664722173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alexfeinman.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbeHTX4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:56:23 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:33797 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeHTX4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:56:23 -0400
Received: by mail-yb0-f178.google.com with SMTP id t10-v6so1575167ybb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alexfeinman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZPERd6ujXtX+mvUghseDqBYvP8ppFYj6YEeS+uTpwc8=;
        b=An2naeXiAYqnJyWB+9kGPGNr60GqqF9WZB/ML9MEJJr3Vrl2uSSgJ0NDc5eirYIAgN
         3wgx4qOR2wkpVytZ6tPb1LiJMclTpl2HMkDsvl2My7dVmlReFvw6E9MqN9TZXM1DID4O
         Z/JWmgzY4pPtKAdbfVn/TYpLLYhGmWhf/WPmQOUNt3n0Qx6KwvRvAozNTefBJnfpefuW
         AlcEduo3pmEtt66eA7VZYwNDm7TZfq94l+Jr9m8zqLL5PPIUhrIvqjEr4QQfft0PGqJW
         EZXjkE4HA4uvYPkGlC66l6jn76jOCmxCjDRgTfwk02wgkEx6ZOzqXoNA98me0l8L95+6
         uO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZPERd6ujXtX+mvUghseDqBYvP8ppFYj6YEeS+uTpwc8=;
        b=NPchHyFtB2w9fivvB4f46Fdpqauf6MghpiCtuTm09I15SP8VPbzxuDE0OacRXmqC/r
         Jbd9Z7fh8TEgfSwnVk0Fh9VX10FY7id57AyvLC26OAXEmdcHcRdxVbQs4vM7Ot9RGxLF
         PBariPJb4IUKH8kQ3Gw9BkRtM6qe7yUMrbzV7BaPSjEdvAZB8/wIJPYI0gjod738SvKy
         GMtOeGZU5mN4yGlmKITLPSwvukQ8c2x536XMHF4CQd258dM72hqTNqRkH1YcxpvIG8ve
         +2qbtB99u1+JyWAMA20HYIKAFf7tcBjo+7J6YPfyOvQg2G8XHDq13byz5QnbThR6nXXH
         6YRA==
X-Gm-Message-State: AOUpUlG861QYL+AVx4dH7OIjDF1PVIvEimkK5t0wbTnUhdCJYRn8jNFh
        WRkhhXsmi2+tQ3r+9aXFMk4yQ9xKTw5RyhdndVzaf2i+
X-Google-Smtp-Source: AA+uWPyT2hhZ032ft7W16cRrNk3SzMug5PFcCVGYCZxPpGv1CcXreVqBsObWdh/0RFBiDLTOtUzi4kmBuGT1pYtTxOE=
X-Received: by 2002:a25:ba8f:: with SMTP id s15-v6mr2527307ybg.305.1534797557224;
 Mon, 20 Aug 2018 13:39:17 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Feinman <alex@alexfeinman.com>
Date:   Mon, 20 Aug 2018 13:39:06 -0700
Message-ID: <CAGXJtFFjVTqYraM0OFipYnNbdLt_BojP5U8WhJETLgw4XWehGQ@mail.gmail.com>
Subject: Contiguous DMA buffer view for a custom device (Intel/x86)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning.
I have a custom PCI device that needs to fill memory buffers of up to 16MB
in size. For various reasons I would like to avoid implementing
scatter-gather support in the device and would much rather prefer a
contiguous buffer view instead. The buffers are allocated using
dma_alloc_coherent or dma_alloc_attrs (as I don't necessarily need coherent
access)

This is on a custom Skylake/Kaby Lake platform

It is my understanding (possibly incorrect) that
a) The contiguous memory space available to subsystems like
videobuf2-dma-contig is limited and I won't be likely to be able tp
allocate say 4 16MB contiguous buffers reliably
b) IOMMU can solve this problem for me by providing a device-specific
contiguous view of a fragmented physical memory allocation
c) In order to enable IOMMU do the above, I need to allocate DRHDs and
DMARs in BIOS initialization (I build my own BIOS)

Please, let me know if I am on the right track? Of course I realize that
implementing SGDMA would be the best option, but short of that and blocking
out some physical memory on boot, what are my options?

Are there any pointers of how exactly achieve this (implementation I could
peruse, articles and whatnot)?

Best regards

Alex Feinman
ReplyForward
