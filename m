Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B88C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9404A20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="1eUqeyXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9404A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeLMCUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:20:49 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:40894 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbeLMCUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:20:49 -0500
Received: by mail-ed1-f42.google.com with SMTP id d3so721892edx.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 18:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=brQ3aNNXM95X1fysUmDFyUMMziybv6Y2I3UUhjESCKs=;
        b=1eUqeyXGbwPnMjZzv5eJjcYIIIC9+8lfEP1nAMdMbKDybMJOWquxNsH5P2WgGDcAs/
         CkBJji0CbGqDJiMxZO/ITGgxBqrKUik6UvfzifYfg/Wa4kM9irXDjNm6rh5RrJIvp7yP
         zEE3OD1KDyx3rfXC6WPsVKd9ym5pvck4lMEfs84JBaGu4tj+DZPWgf/t0bcCqrT0YpTo
         LmfrF17G4B5zXI8nqJFCip2aLEDLLoOnElMpQ3E/y2grigbtKHdZsPpDdoisjID3hbhI
         S/lRNcLGahtGv1DGHBER3xonLrWYn5D8EMSFkA7cuVW0oRmfNuCKiDXL0ejzdyBuehHe
         XTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=brQ3aNNXM95X1fysUmDFyUMMziybv6Y2I3UUhjESCKs=;
        b=Y1/Gk4Q0NAi84u3k5V7x/irs4ygzljd0IylSqXJEwUkw0ljh4BXBLoX2HMMj+1T+X/
         5YA68pD/qzcunEL/ezWUm9P0veelXA3h2iRicj6/sK8OxUPr10rz+rhCyTQpYK52PSYr
         4uV/qpEPavSpxBJRtGaZQPE17CRfIbcTv0N8wHLUyM3291t8GGKWHlt0Brfa0Z3bqhQI
         Mewm7mKzD/OzBwhO3XSTn+IIrmuIFPYBu7HqsEi4HNHh0m42hQta3RMDbonPswUK1c9u
         747Gra7zqObjNOCer6/U2HNg3WM9Ch8cnKMhz8Wqcl7FD7vip54qX2Dq8pHffys1Rttj
         ZwCA==
X-Gm-Message-State: AA+aEWafC9X4mR5sySTegzR7oyC5vmz+4ZcbGoh5QyVMgWCXU+WNSPW4
        XLHVs8bv3J7sHOOJPeKB6+GjfEhewLjHbYMKj9iQ1g==
X-Google-Smtp-Source: AFSGD/UMg7eWlF58BHmTMsvN7TgI9Nmh/e5thuVtaHZsSg7+XROHgB2OcHgVYlZMiRR5rTgv9f6bluGYbSpWEi0e1Lw=
X-Received: by 2002:a17:906:62cb:: with SMTP id v11-v6mr16902437ejl.56.1544667647338;
 Wed, 12 Dec 2018 18:20:47 -0800 (PST)
MIME-Version: 1.0
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 13 Dec 2018 10:20:35 +0800
Message-ID: <CAB4CAwfH156yEd-XAkt==u+S8bO0U2=sg8nVr4o57C1q3K97Kw@mail.gmail.com>
Subject: A weird problem of Realtek r8168 after resume from S3
To:     nic_swsd <nic_swsd@realtek.com>, davem@davemloft.net,
        netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    We got an acer laptop which has a problem with ethernet networking after
resuming from S3. The ethernet is popular realtek r8168. The lspci shows as
follows.
02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 12)

    The problem is the ethernet is not accessible after resume. Pinging via
ethernet always shows the response `Destination Host Unreachable`. However,
the interesting part is, when I run tcpdump to monitor the problematic ethernet
interface, the networking is back to alive. But it's dead again after
I stop tcpdump.
One more thing, if I ping the problematic machine from others, it achieves the
same effect as above tcpdump. Maybe it's about the register setting for RX path?

    I tried the latest 4.20 rc version but the problem still there. I
also tried some
hw_reset or init thing in the resume path but no effect. Any
suggestion for this?
Thanks

Chris
