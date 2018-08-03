Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51C7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BA7217AF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUoF5XzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BA7217AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeHCXgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:36:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44800 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbeHCXgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:36:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so6604029wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 14:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=biQHV8N71mMZRYvXRjc3bMOFQLopD8em2QJMQbeieN8=;
        b=iUoF5XzTq2twGFE4O3bmwivUTYdc/nmtB0NvwmNOJG7QVml6kYhKNo55cAr4QI1/s8
         yoWyJbBl072DyL+Lhh3ygufi0dvJcZuadu+074/Rrl0XpWhx8xb9t98teiToAb+KP2c8
         WYiJXxjGMkmJ5Nw4+UMonQmhFEaWNy0QuweoTd/PxgF6HM1RVm79WTali6nyVB26ar1J
         00SZyEeUlPgqM2fJ9TmYkzCnl0MIMD80xe0XM6iohHNCf46vwHeTjWILr2Yniexhki6N
         8s0V1KoXknzAfCjY8WGAFDgX4bebHaOzyMAvo1/doZSzdOnY3Y/HxaS3GYWXxZoYjX22
         HPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=biQHV8N71mMZRYvXRjc3bMOFQLopD8em2QJMQbeieN8=;
        b=CuS+8/S0h8cHc+rvbwVN6VVhXlvRF30onhFh4HGY5BeRxZIvkffIsZGKiW/9/92cKg
         MNLBgPhqjw+aKUPF3VWy3gUnhD6sP/zg2g4+Ij5xHlbbjshmk/pICAhZUgqWgal/udVi
         u7rDnQb9sDOxoUjcyZImHxsqr2pff74oYss+Bz3S1GpHHbFQIhM240xCfU1Hyybx7TIT
         F/8ZCvvvvi5wCVbQhoXFmvcripEJugNLmajvl7tdNX3GD7Vzuv7AEshfweLXd+/JApho
         xzci02hxgq1x8tqcTrrcjA7c+GGcHtz1FlvDdXCGkMVaAV1mrY3jfvi9CCgfFeGT3Xn/
         lvfw==
X-Gm-Message-State: AOUpUlEkwafgmCRcTUMrTPi8KlSRKN3ZR6Gh/+/BKrs9SFWoVvjG/WwY
        GGhIkDCbqVO27xI1Fz4ytvFnuAgY
X-Google-Smtp-Source: AAOMgpfRSONzMxEujymWoVnvR4umv6svrE9Jvg/xNXijZdEGuTigiBKSPvTXFtdjEO+dvLfyHMtDBA==
X-Received: by 2002:adf:a3d6:: with SMTP id m22-v6mr3691037wrb.1.1533332275608;
        Fri, 03 Aug 2018 14:37:55 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:9545:19fe:eae2:90aa? (p200300EA8BD4D600954519FEEAE290AA.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:9545:19fe:eae2:90aa])
        by smtp.googlemail.com with ESMTPSA id z11-v6sm8440222wrm.94.2018.08.03.14.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 14:37:55 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/3] mei: migrate to pci_alloc_irq_vectors and smaller
 improvements
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <5e0250ff-2470-1128-d8eb-b36e3ca04417@gmail.com>
Date:   Fri, 3 Aug 2018 23:37:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series migrates the driver to the pci_alloc_irq_vectors API and
includes also smaller improvements.

MEI_ME was tested on a Zotac CI321. MEI_TXE is compile-tested only.

Heiner Kallweit (3):
  mei: Don't free irq when suspending
  mei: Migrate to pci_alloc_irq_vectors API
  mei: Improve usage of mei_start

 drivers/misc/mei/pci-me.c  | 51 ++++++++----------------------
 drivers/misc/mei/pci-txe.c | 63 ++++++++++----------------------------
 2 files changed, 30 insertions(+), 84 deletions(-)

-- 
2.18.0


