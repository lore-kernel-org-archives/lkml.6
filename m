Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED5CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27288208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiuyNC3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27288208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbeHWSUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:20:51 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:43442 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbeHWSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:20:51 -0400
Received: by mail-io0-f173.google.com with SMTP id y10-v6so4491849ioa.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=N9CVFTF5QYzBCK556n8iOYtmEniKa29whJJ+26h7ajw=;
        b=PiuyNC3mkumFiVN48hKUXxvLjcsGNWoAVgb+BsnWjj/kmDZI3wEFrzRFDeqyzbSqNd
         ufJKm7kWdrqQB7ngXkt2qx71hp4uJeryXeZDmszgeAC2eUuRi36CiR6E/r4E+p1RzKHN
         zK6lQSfT5aNeFXsKQOFUbT8+0RDOvzMR7nvNJAElzHx+rCyh1SEtzjO9ijL3LSiXFIpE
         p/xus6HCycBDrQ3B4bet25B3yQ5/khV83jpI1YL3QRgyGpVE3BAKFYevFyUvytQHHbXX
         cSe12JwFhYhzP41aoFXPbwR7acsqQsa5vN5MuYhsfW9c3b3hMuMMg36CsbixjHgGUp6f
         fzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=N9CVFTF5QYzBCK556n8iOYtmEniKa29whJJ+26h7ajw=;
        b=OM2a0gWxofDli2odKPg9+yvRMJXV+t5HYkAs4TvvLXgb2zr03nugeXUCGM/pW5C5YX
         2NbbD+n+41fW+2hVDe3VKZSeUUsAljt3fMrlWH56EbyfIjTlQagkUGjp7igGUtcK9/Sm
         a3EzEF1xi2nEjEhCrXx09NCj73PY84O6r6TADym7Awclmjfvckl4Ij+N5UNrORO7G5o7
         eudp/VscdjAiCfimWfGx3wUP5w5jz6ExxFyTDbCgJ5cSJG9f9ABrCPoW4YB+vdxLkx6T
         W/llkdRGa0iiD7tWUf2gq4EwrSVnr1NEY4OvzorkmjU3RNAWJJ4HPuxAkL0M9QWDDjU+
         odmA==
X-Gm-Message-State: AOUpUlH4deGtoibr/sKEmIAYVMIOikTz7BWD9HsRrZxi+D4qCLULo1UI
        1M4mIW2inBa92p2DvQc3lZuP6JyvgzfJug/xmKM=
X-Google-Smtp-Source: AA+uWPyhpU6LCJ+MKCBp9nZaaokmE6P5FTep+H/EFVYN4fe39zd7oIlU40fexoFbk0siPF+vQJttujdxzvIYHe098E8=
X-Received: by 2002:a5e:c705:: with SMTP id f5-v6mr41541222iop.197.1535035849840;
 Thu, 23 Aug 2018 07:50:49 -0700 (PDT)
MIME-Version: 1.0
From:   Kedareswararao Appana <kedare06@gmail.com>
Date:   Thu, 23 Aug 2018 20:20:36 +0530
Message-ID: <CANdmM3O_q_dAzVAd5Lk+u_OHqgEkHR2p1ucgEZ5v_tLQ6G+3Rw@mail.gmail.com>
Subject: Query on dma_set_mask_and_coherent() Usage
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

              On arm64 platform I have booted Linux only with > 32-bit
Address i.e from 0x800000000 (reg =  <0x8 0x00000000 0x0 0x80000000>)

In my driver, I am using dma_set_mask_and_coherent(&pdev->dev,
DMA_BIT_MASK(32)); which should fail if I boot Linux
with the above configuration but the API is returning success.

I have debugged it further and observed that, in the arm64
dma-mapping.c swiotlb is zero resulting dma_supported ops always
returning 1

https://elixir.bootlin.com/linux/v4.17.8/source/arch/arm64/mm/dma-mapping.c#L321

 I will be grateful if someone can send me some pointers for fixing this issue

Regards,
Kedar.
