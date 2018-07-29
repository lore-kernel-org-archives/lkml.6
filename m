Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BE6FA3731
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD53520882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd2hFNTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD53520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeG2Kjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 06:39:35 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:34545 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeG2Kje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 06:39:34 -0400
Received: by mail-yb0-f181.google.com with SMTP id e9-v6so3662144ybq.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FN9aD4W60jNdb/kPBFrOauRS3YTaIGCx31hwoikrBmE=;
        b=Gd2hFNTugwnrhRl1/oXHod4ZsbZWsrUZPdpGHlCOR8OxIeHwTlMIRkrZJdUfOqrOA1
         ZJFGCp80UZ9/v+w8wmuvTHJaG1eFiL3rtjAokbrlVACe6E7KZlawOBntvoKnOPHAhncp
         IDaULItX8vATjkD0AvCCPUzCfEEPLzLUC0Q9vEmSo7VnY3SvEBX2BgPPLB8sx27wfr8f
         uhDMPpejeiQ3R5qpL2AI8qBg+UqMLzhrbgDOkgaoT4Y5X7GdjasYlu00bQ67FPw7NiP8
         TqfAogCDngXR3lhs2o3+8d/UgRFs2bSaWHY74a1XDvXJCC0UB+hclUN8lGVvDphz2Wkw
         ssHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FN9aD4W60jNdb/kPBFrOauRS3YTaIGCx31hwoikrBmE=;
        b=r/1A9PVo+F/hMWMS4ISJH70AIda2n3VL1QRn1usS5zq4t8cm9rMoj7XPDvE1S7GSu2
         hN5DDLVAhnmky7IIBUqMRgbbiNUPYKziIdkTIJ26MlPVoW+xZUP3NezbOeazxj2rjnL8
         7IrMdfrhor3Xagli14PPJKuxAZU1IhCgJXLg/l8msbfOxKJ8H+09/OYd55ULYd5vDXJg
         dXJ1bIEy1BpbGRza9yoEOZxLefGEP+WEFnvBrwiymvEdO6NXoq9i7Yajt23w6rlrDQMq
         LfpPrhmhJYvB2hXvqQXKP/ycJ7145i2h4bePD0pSOYMtnqFmlqkEtr7Kg1hhsK+R2XDo
         BQpg==
X-Gm-Message-State: AOUpUlEA3x87w+fDTNHzqLf+Jb1J3ywaEj32Kgol66LpZvjm/F2s770k
        nAVK2TyMBKEGov3ySfvIVLa6Ts9Y2svizYXvDRAYGrSm
X-Google-Smtp-Source: AAOMgpf6Y3Ylx40fJzkLefSqsG3wxDnLAqckqgDzS5AtZ3joCMTxFnD4Nf/ePs3sbqo1yfkUzLWL1eBD124Nl53Hmws=
X-Received: by 2002:a25:ef04:: with SMTP id g4-v6mr6829991ybd.223.1532855389139;
 Sun, 29 Jul 2018 02:09:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:3007:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 02:09:48
 -0700 (PDT)
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Sun, 29 Jul 2018 17:09:48 +0800
Message-ID: <CAAJw_ZuQXrYaEu9_pXWtoDpUjR2au1gGT_FP9F1e1Y7veHSz2Q@mail.gmail.com>
Subject: How to secure erase PCI-E NVME SSD connected via USB3?
To:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm testing the USB3-to-PCI-E NVME SSD. It's works using uas module,
recognized it as /dev/sda.

Since it's an USB device, the nvme-cli tools won't work, nor does
hdparm, as it's a NVME SSD.

So, how to secure-erase the NVME SSD connected via the JMS583 chip?

Thanks,
Jeff.
