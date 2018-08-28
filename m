Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5510C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7679420898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7679420898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mni.thm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeH1QdG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:33:06 -0400
Received: from mout2.fh-giessen.de ([212.201.18.46]:39020 "EHLO
        mout2.fh-giessen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeH1QdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:33:06 -0400
X-Greylist: delayed 1100 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2018 12:33:06 EDT
Received: from mx3.fh-giessen.de ([212.201.18.28])
        by mout2.fh-giessen.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <frank.kammer@mni.thm.de>)
        id 1fud1l-000FKl-9U
        for linux-kernel@vger.kernel.org; Tue, 28 Aug 2018 14:23:21 +0200
Received: from mailgate-3.its.fh-giessen.de ([212.201.18.34])
        by mx3.fh-giessen.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <frank.kammer@mni.thm.de>)
        id 1fud1l-00DsTH-6F
        for linux-kernel@vger.kernel.org; Tue, 28 Aug 2018 14:23:21 +0200
Received: from pd9f67c8e.dip0.t-ipconnect.de ([217.246.124.142] helo=[192.168.221.10])
        by mailgate-3.its.fh-giessen.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <frank.kammer@mni.thm.de>)
        id 1fud1k-0003Tg-V6
        for linux-kernel@vger.kernel.org; Tue, 28 Aug 2018 14:23:21 +0200
To:     linux-kernel@vger.kernel.org
From:   Frank Kammer <frank.kammer@mni.thm.de>
Subject: Bug in /drivers/scsi/3w-9xxx.h
Openpgp: preference=signencrypt
Autocrypt: addr=frank.kammer@mni.thm.de; keydata=
 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
 v/UwSrwapaJJrZVkUw==
Message-ID: <491de4ae-0ba3-0fce-a400-3ebb41e21ac4@mni.thm.de>
Date:   Tue, 28 Aug 2018 14:23:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a 3ware 9650SE RAID-Controller with 20 LUNs. Using an unpachted
kernel (no matter which version, e.g., 4.12.14) , only 17 LUNs are shown.

The problem is that the driver was once written for a 3ware 9550SE
RAID-Controlle that supports only 16 LUNs.
There are some changes in driver to allow 32 LUNs, but one change is
forgotten: 

In drivers/scsi/3w-9xxx.h, one must replace the following:

467c467
< #define TW_MAX_LUNS(srl) (srl < TW_FW_SRL_LUNS_SUPPORTED ? 1 : 16)
---
> #define TW_MAX_LUNS(srl) (srl < TW_FW_SRL_LUNS_SUPPORTED ? 1 : 32)

Best regards,
Frank Kammer

