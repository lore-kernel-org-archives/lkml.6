Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5D8C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A4D20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIs/tdYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A4D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbeLLRPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:15:10 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:34777 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeLLRPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:15:10 -0500
Received: by mail-io1-f46.google.com with SMTP id w21so1731415ioc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/2Y+CQiA5KF8LF48fNAOnHc0IejZfP6EYOf7EA62Ii0=;
        b=HIs/tdYIhydw5CDGtSirV0EJbyMsFvwRLD4WK0VZghmdBczH1Ad0zZr/nn1Q/tfrXb
         ZWl/LhdggMn+PZ8vsCDRrpviNb66jyEMTF9MXqMUOILfzXMKhirZwRTdu5Hl8Dh4NY6x
         xO/alt0iO5K5bxcC2/3lx7yev0u0GACj5JJ4FEGwQIF5hvUaunEBvHSA+X87CjzUW23s
         /kja3O40+CN4TWHQc8gpyfvpNd4yfpLpZek5Zua380bDn0nJJYx0eFNhjhtTyaIP3IVA
         pwoIqUzCU2zESrTgFv2YRa5dT6dagTfWcCzc+v9t2tjAR4BxziYn1QGNcLP6bU2rvo44
         7Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/2Y+CQiA5KF8LF48fNAOnHc0IejZfP6EYOf7EA62Ii0=;
        b=lopKKUzq1v0MKvBsWzOmZbJF3gnvzijIFxaMpmRHgk0JxrXOJZQF1pDUSGveeOWDO1
         +kikkFdSfAVSTU+Ao0svPbc/xCA5FTkj/uHDBwMtUAnnNWsNP2SL+sY3UDNbDZTTVw7/
         pUtVBAPSy5KDfwWXJbv8tnm3/Mx4U+axeKbMfv6hAl8ufIhHU4zkr24uSUg2Fw9ipkbu
         65fSrR0dgKchQHjaE5aUFmVFoTM2+dxg5E7gHYo3Xxrw83mzpB/mO4h+6fZFzIy/4jeP
         NFzpZODuuCmy4NNpvcTE6bis9QywpvW0sZs+9pgKpBudAKQqDp97Tmq6Jl+YnnHh3J+j
         ILhQ==
X-Gm-Message-State: AA+aEWZHlKsLYYtmX1l8X2u03hXt1xiNGuh1P2RSMJQmcP57SpTP4+wr
        26CZuxPPqP+yoVK4d2PYRwjs+in9l9xjAimq1Jw=
X-Google-Smtp-Source: AFSGD/XWkojWXboFmMDTVUmYK21YNtnQjIORmAhmqa2EvEU5AWIy1OZzK87uvDFlzqUe0r5gVUAxFPmeLJA9GSzvzb4=
X-Received: by 2002:a6b:8e43:: with SMTP id q64mr16741070iod.197.1544634909714;
 Wed, 12 Dec 2018 09:15:09 -0800 (PST)
MIME-Version: 1.0
From:   raymond pang <raymondpangxd@gmail.com>
Date:   Thu, 13 Dec 2018 01:14:56 +0800
Message-ID: <CAHG4imOadbc2QNckBPj0dT3=SJ3nR_0JsWOCTUbBesKrEw_Kcg@mail.gmail.com>
Subject: vt-d/iommu: RMRR-declared ACPI device handling in current VT-d Driver
To:     joro@8bytes.org, dwmw2@infradead.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Joerg & David,
I have a question about current VT-d driver. I found it can not handle
following case:
An RMRR-declared ACPI device (it's also declared by ANDD) cannot
work using current VT-d driver. its DMAs will be blocked by VT-d.
The reason is that current VT-d driver only tries to setup identity map
for devices in dmar_rmrr_unit->device[]. But it doesn't add
RMRR-declared ACPI device into dmar_rmrr_unit->device[]. It just
allocates memory space for this ACPI device in dmar_parse_one_rmrr().
Let's see RMRR-declared PCI device. VT-d driver allocates memory
space for it and then adds it into dmar_rmrr_unit->device[] via
dmar_iommu_notify_scope_dev().
If there is any mistake, please correct me. Thanks

BRs,
Raymond
