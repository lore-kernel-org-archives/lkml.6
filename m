Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DAFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA10B20659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma8ca68R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA10B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409399AbeKWVXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:23:48 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:34553 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394186AbeKWVXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:23:48 -0500
Received: by mail-ed1-f46.google.com with SMTP id b3so9902370ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 02:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sq+sbiuLU7iqRObtW/qAvtjBwsdI4HCjL2tyQJe4vy4=;
        b=ma8ca68R0lwyKl6ElwPJEM+de0wHXadi8GW1cGlza5P3iydj1Jss4JgtdGokU/nI80
         NwR5+NkfTdJ9HYpdaCens1SGBPKf3/CqP1Mwt/LzVWiFvk2bVirt6X6YzlFe4GhnAhkk
         FubMc2qicFcM4dcPXcWefZqz4ZhnkOX2vEwWaEFzZ/VpKYnXVCuCci3/LMUfWX81K27S
         uTp014CVvbvRsM8JShJ67k8fw+dvlfJmn+BAbV/fm87Wag+z2pa3y7E69YpNLSh6YSN0
         oQ97cbZxzy2y0qtOIi0GKFfjsb1dUwKz+xXbLhyMKP1ysy4uurYjsMPp+8+EkC8Jt1Nn
         bJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sq+sbiuLU7iqRObtW/qAvtjBwsdI4HCjL2tyQJe4vy4=;
        b=epkfG2gXGQOj/ybT95kkBq1s8doLrybqQ22CvEcL8eBsIDuvwi+jGWN4xpk8dDEisp
         JR+BxeNPxXZglX5i/YrLKDramI39evWeSSlBRK77POejJQNH38k76N7eJSiSv6M8DRp4
         yU5Ara3gSL9Pd4nPUYsCkIce4QH7VgUT2C53u7teva4ZdzakfVvF47M0erQkfh+SV8JZ
         iPDSNdlqOqH7MMvAPZ+kHGAHTMFvUJAiahQJQTA12626VCXj28FgYF3t3zLplkPQsRlS
         bkzhR1t2y6Xy0OHgRKHf0IPkG6OcyJyk0uacw06Odj9e2cBbQFquB3r6xopvoWhJiRRz
         pnVQ==
X-Gm-Message-State: AGRZ1gLrfMiQ+bdEOpSqSjMyktLth/xi4E3Qnc/Z+M/pk2JgmjjH0w8G
        LYEBwXUBwbh/8HoW3mmQdNvydc4fjl2UdtUfaACNg0gI
X-Google-Smtp-Source: AJdET5cq8d6E/LQLPnfrGGFz5ZXUQDSXvfjYFJ0KmrzIIvOaASQsutU93CkcNRFhCoMFQE8GrBZUqQ29QHcmEj8KbuI=
X-Received: by 2002:a17:906:1b12:: with SMTP id o18-v6mr10812052ejg.65.1542969601812;
 Fri, 23 Nov 2018 02:40:01 -0800 (PST)
MIME-Version: 1.0
From:   Rishi <2rushikeshj@gmail.com>
Date:   Fri, 23 Nov 2018 16:09:50 +0530
Message-ID: <CAO9XypWCiSwf+5NeG9aRcRG+2tUKE2DufMjHHpsCUh65rvNM-A@mail.gmail.com>
Subject: Page Replacement Algo Enhancement to Flush lest recently used memory page
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for right kernel API to be able to flush the least
recently used memory page from inactive memory.

I want to develop a kernel module such that it will free least
recently used memory every n seconds untill inactive memory is 0.

This is to reduce the memory allocated to a linux VM dynamically and
make it available to other vms of the host or hypervisor itself.
