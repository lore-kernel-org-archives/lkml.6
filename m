Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48879C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CBB20867
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CBB20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=softrans.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeHQPMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:12:51 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:39217 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbeHQPMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:12:51 -0400
Received: from smtp.starsoftware.com.au (n175-33-133-183.meb2.vic.optusnet.com.au [175.33.133.183])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTP id CA97D106FBD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 22:09:36 +1000 (AEST)
Received: from virtux64.softrans.com.au (unknown [192.168.0.6])
        by smtp.starsoftware.com.au (Postfix) with ESMTP id 6008E677E164;
        Fri, 17 Aug 2018 22:09:36 +1000 (AEST)
Received: by virtux64.softrans.com.au (Postfix, from userid 1000)
        id 200DF18E01A1; Fri, 17 Aug 2018 22:09:36 +1000 (AEST)
From:   Matt Rickard <matt@softrans.com.au>
Subject: [RESEND PATCH] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
To:     Matt Rickard <matt@softrans.com.au>
CC:     LKML <linux-kernel@vger.kernel.org>
Message-Id: <20180817120936.200DF18E01A1@virtux64.softrans.com.au>
Date:   Fri, 17 Aug 2018 22:09:36 +1000 (AEST)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=DZtnkrlW c=1 sm=1 tr=0
        a=0SUgGFgJIhXJJGNlngNSLg==:117 a=0SUgGFgJIhXJJGNlngNSLg==:17
        a=dapMudl6Dx4A:10 a=PIVNZ80yAAAA:8 a=OrG7ujNezGqM49X_xi8A:9
        a=Cu6FHRxD0nIA:10 a=3YJQTRF3V1zcZZCg0gjL:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Process clock_gettime(CLOCK_TAI) in vDSO. This makes the call about as fast as
CLOCK_REALTIME instead of taking about four times as long.

Signed-off-by: Matt Rickard <matt@softrans.com.au>
---
 0 files changed

