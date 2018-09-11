Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F117C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B2C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="yfaWkGo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B2C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeIKQeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:34:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40266 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbeIKQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:34:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so18983033edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVhRgIlPEjRqK/ZN5gK2x7+CRAD4Jh4Ur0W/4tsrY/4=;
        b=yfaWkGo+agYwvm+WHFZRTbe2x7cqZ2obiMDxm2VbcKL7AtMYGszErITtQuhC8m0OMu
         Xl1gb+JdCxtO3LK0L+EgKfbOy/ldM6N3z9YHqwqLf9uE/1ZD4AKhmSYDK8A1P1m2xAwU
         rEKw61/Yv+wuL1cyzBbr54fI8/DEST+Z2sJhFrQwbI8LhZwt/mvXmfRSL8aP91DQyLLU
         44fF8XILFRaNJ9XStMXuUnRDgyF0Xn5dIDVc2rVEOxDqjxgH18lgKFGQeKFjgSsaEkmK
         OyBZ6d4r11VjPZWV/ths6S8yW4VIAwflnklkgizcmIvPhcqknpP+js0fpbaHVJsI5FLN
         a1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVhRgIlPEjRqK/ZN5gK2x7+CRAD4Jh4Ur0W/4tsrY/4=;
        b=s4GoRlzPqTGzIv7dMhsTPDId/wOv+ELqKVyhrsYTaUDITenbLuAvl5eBKvkMcHjpfM
         LqcKvz/7SqYQxaGNXNhWE2ibASkvesHIpACbTxloJx8FPhnAEqtjaQmxtQBTO1TmVX+a
         R9fIE1zGrFf1s8Cu3pbYcuyW4QfyGev05EyiSQluFKXBiD8hJm7+xRZ4UV52NQNeWDUQ
         eiuWTHviOs1NyNfzTZNUA51c+3kWswgsjCgDh43RvYGR3JBmZB2VikJdQJp0sUd/pj2Q
         i/f7ExjYpn2M90pE8Z+uZkoKExHfUxAwzmyJ2FhTG+yFpQn9zYHPw2yH8Xl3OoIgB6Yx
         yXjg==
X-Gm-Message-State: APzg51ClulDqJwLUIw+EWlQMLoV7/BU1JL0ZIw8YtyDUbFfizm3udE4o
        WOUFY8SFDHx7y4fALVrgtea6qw==
X-Google-Smtp-Source: ANB0VdbkEk3yyTMvh/Z48xNteMiKEIADEPgpe9S55A5F5y4V/agEbFP+YY+6sBIwkqGVJgk8LQRc+g==
X-Received: by 2002:a50:8b25:: with SMTP id l34-v6mr27785251edl.265.1536665740128;
        Tue, 11 Sep 2018 04:35:40 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id n15-v6sm10934976edn.44.2018.09.11.04.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 04:35:39 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V2 PATCH 0/2] pblk: retrieve chunk metadata on erase
Date:   Tue, 11 Sep 2018 13:35:32 +0200
Message-Id: <1536665734-14305-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matias,

Here you have a new series. Please refer to for-4.20/pblk for ordering. I left
the OOB extension patch out since Igor will send a version for it. It is on my
branch though for completeness, until we ifnd the patch that should go in.

If we need to do some rebasing then, I would suggest that we do it directly on
core.

Thanks,
Javier

# Changes sinve V1:
  - Remove patches folded into Matias' 1.2 chunck patch
  - Rebase on top of Matias' core

Javier González (2):
  lightnvm: pblk: add helper for printing chunk state
  lightnvm: pblk: retrieve chunk metadata on erase

 drivers/lightnvm/core.c      | 44 ++++++++++++++++++++++++++++++++++++--
 drivers/lightnvm/pblk-core.c | 51 +++++++++++++++++++++++++++++++++-----------
 drivers/lightnvm/pblk.h      |  9 ++++++++
 3 files changed, 89 insertions(+), 15 deletions(-)

-- 
2.7.4

