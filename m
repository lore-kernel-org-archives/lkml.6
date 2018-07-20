Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94047ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA8320661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="gk0voJ1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA8320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeGTVJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:09:50 -0400
Received: from vern.gendns.com ([206.190.152.46]:50532 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbeGTVJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OZ+92FVS16c6+uI61K8BA9wc6JH4JIxcAAB8wt6E29E=; b=gk0voJ1t4EGTiGu2tE5DIl/yWH
        YImNB7UlT3T7rLVnS0k6VDDtAT6GAyzunipEKZiBUcd41q4sQG7SqNMtpIm+IIuKfogcpyVZxYwIZ
        hpQEZ4M63rkdyhlqOgQJHkhSTRJufQiS3nDbITK5dCoMaj1KW+IY4xiTG3oMrag9cbr0o+1KPpz3B
        CQKK+e6/1vinBP/dIYaav3B92iba8SXzhtU6brDv52zz2LHzXzoapaAxcQl44pNz4rIL/RMyiHarI
        b9DxbA6beXxgn2T9Gbkp5OKI6qwL1V9cBm/+69a3aB20rZ9x82VneMl9XeZQLUWY+pxi3X69kEp5I
        AoIfdQSg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41598 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fgbsd-006e0i-LN; Fri, 20 Jul 2018 16:19:59 -0400
From:   David Lechner <david@lechnology.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] power: supply: lego_ev3_battery improvements
Date:   Fri, 20 Jul 2018 15:19:42 -0500
Message-Id: <20180720201944.20503-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves error handling and accuracy of the LEGO MINDSTORMS EV3
battery driver.

David Lechner (2):
  power: supply: lego_ev3_battery: Don't ignore
    iio_read_channel_processed() return value
  power: supply: lego_ev3_battery: fix Vce offset

 drivers/power/supply/lego_ev3_battery.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.17.1

