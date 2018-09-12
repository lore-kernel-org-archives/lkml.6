Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9804DECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FCF20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="SO+sdpMJ";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="WeabCxTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FCF20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeILT6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:58:39 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:13454 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728409AbeILT6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:58:38 -0400
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CESBkN025894
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:32:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=from : to : cc :
 subject : date : message-id; s=pp;
 bh=+V8fAYC2/ylaIlrOo7i1iwbCwcrAPXfVL23PyOKr2FU=;
 b=SO+sdpMJHZbqpnas++jl7hV7USwWt0gMyWKe42v7Xaj1vkIAj2rhugxsCfdd8gM2wJEE
 7O2C2gWDVKe4MMrl+e8qetkf6Gn+tcqq/8roGas2YLD2xEd+5+t+DgKRQefhK5wJQw0k
 PZPCXgVkeTpoXvTiT4OXATUIDRb9823mKzgugX9SmxwXqw0Wnah32l4i6FuwluDy3Bg+
 ibJfWAmtzJHK39lCsei0WA+YXgD6/ufT7EhdkapMxoXn7U4rGFGOriCuxv/McY6V0uvk
 KDut9kqsoaalxjMrPF7L6K6OE8uEwVZSrgAwKq3GDgDYGCwmHWnMacyqT0Dric21Tx4d eg== 
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        by mx07-00252a01.pphosted.com with ESMTP id 2mc3u0j16u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:32:13 +0100
Received: by mail-wr1-f69.google.com with SMTP id l45-v6so2084665wre.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+V8fAYC2/ylaIlrOo7i1iwbCwcrAPXfVL23PyOKr2FU=;
        b=WeabCxTHJqWut+jnr5vLELHZZ14ehl+vAR09mo6S2zZyfLgVq2Hd6ctMRoYTW+IQnq
         WFXhpVGt6jARHKO2vtaCtW9DZJHrAok9NNnQ+EttEEHDS8iiTn+A5kLfeZ3XbZJpO4yJ
         S2P7MBE7L7mzzeYdmY//W47aMaHIpXZv9Dnh50iwopQ4wiv3ASt338iDBoT3Rjnhav1a
         L4hs5uhvGeY+l8DQdgnicOfwLGmXOUckoyz9+ewr4MCTiJ1tiSPO3rHHwaLOE658KAdt
         pJKpBDXluwTho03EqYxXUYT44greC3YnKaXxiSAYKkWd6uyVbVK9+ia5X24gUaXVTapW
         +LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+V8fAYC2/ylaIlrOo7i1iwbCwcrAPXfVL23PyOKr2FU=;
        b=cLNATYTGqKqFSZfCIM8X0TOsKXpN3HDgNnpRBl4z0kvERoO+Bu9qY9hXL/mKaJQ2Lx
         +vkuKUG2XJZm1mPAJ9u3jNts4xHPSZ67TzPULFo1czHmqM1U5US70RISW31fIN9ZtzbR
         RPq6QrVs3GYzngW71Bq/ouYU/NT9rfyJqpXk3uPlfMsmVNJ/CdF4cs7SkIYnPmshy0vH
         UYbzmncwUvGlPCkRfzuRbEntfkwnxolvDg+n+WXtvfd7qtqgmpdT00DVnS5zoGUpfGe/
         P88DZS0XZBdXUsS5c78GUhLi0n/xidxSmSOyyNzS3MXAAXWJjAje6CRA7FLsNUM9dQYm
         jkDw==
X-Gm-Message-State: APzg51DuA4HhyH9M1o/fszWrkzxj78yqwUHZ5Nh7GMRBxcclCmf6p6fK
        1lvNOsyDdQVv2gkCiC1DTqogwBRpjm848E8VxCfZo2py8Ru/ahu2gGpn5oDBG05RzrK/avkkcIu
        sCbpXjXQn3VE3o0v4mLdCZUvQ
X-Received: by 2002:adf:9a46:: with SMTP id z64-v6mr1728026wrb.109.1536762732760;
        Wed, 12 Sep 2018 07:32:12 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdaYJBGO5r/pUeikiqjzOHRlpRNtRos9+84MJ9QG1pXvfTY4wOts3xZVaZwcHnKRU1tFk4xRIw==
X-Received: by 2002:adf:9a46:: with SMTP id z64-v6mr1728005wrb.109.1536762732437;
        Wed, 12 Sep 2018 07:32:12 -0700 (PDT)
Received: from buildbot.pitowers.org ([2a00:2381:fdf7:14:e45c:95a2:cfa0:31e0])
        by smtp.gmail.com with ESMTPSA id h82-v6sm948217wme.11.2018.09.12.07.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Sep 2018 07:32:11 -0700 (PDT)
From:   Phil Elwell <phil@raspberrypi.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH 0/2] sc16is7xx interrupt fixes
Date:   Wed, 12 Sep 2018 15:31:54 +0100
Message-Id: <1536762716-30673-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt handling of the sc16is7xx driver is broken in a number of ways,
as observed by multiple Raspberry Pi users. The attached patches attempt to
address its failings, with apparent success.

The first is a workaround for a side-effect of the switch away from using a
thread IRQ, a change which has necessitated using what is actually a
level-triggered interrupt as if it were edge-triggered. Doing so is fraught
with potential race conditions, but the patch makes them much less likely.

The second is a workaround for a bug in the design of the SC16IS752 which
requires mutual exclusion between the interrupt handler and access to the
Enhanced Features Register.

Phil Elwell (2):
  sc16is7xx: Fix for multi-channel stall
  sc16is7xx: Fix for "Unexpected interrupt: 8"

 drivers/tty/serial/sc16is7xx.c | 50 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

-- 
2.7.4

