Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED7AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2222184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="RziLZFQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfA3NPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:15:48 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25445 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfA3NPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:15:47 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548854120; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=aRBpQHS4/IxjRBchKpZBD3bx+85u2dpdVIZk4YaIUDmLqNhzOY2LWvvvOnjuADQWCyOIvqhHVwRI/w/Dq4cyKftW8HREK0pPGnmRoOil0ooc7STQaQp0bNB3LrJ+E0Nh9DYlmPM4vu3YjxA2w29GPT58B/tUB8Cl0bvZneePJLg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548854120; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=dF14UUuxihUjGz8dFcCH+pDeFKwSY+izQnw97ISFm6M=; 
        b=mqddQnDh339vopQw+6jVL1MBJGiApZadUCBl8w90TvWIQYkMeAmXn1OqBXmWIA7okCmYNassgeQXzDhfvMOrwC4skaT7tK7fG3xd47ltoLXr7rcRwluF2ECQDO2jw/HVjUUR1X34OJTwOj3SgXg1aQhtc387Bfk24guoPL5rwVw=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=BvSsHLTW3jsbHacQBLxFow7qUKyHcD+COEwMAxKRDxcijFUoQX0BGqOW8vQGdRW+5XYb4F/tAcH5
    GwaVoNfbw9a/dADODnOh5g6L+akyc/pNG4PSgYd1nFxMHoOw/Aa+  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548854120;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=28;
        bh=dF14UUuxihUjGz8dFcCH+pDeFKwSY+izQnw97ISFm6M=;
        b=RziLZFQyRQgGJ0zMw9xWfVrL8Gn0bO8g01YgE1d5EzXRscntjxs0i8nnx0Jkefxl
        O1EZRLz0DyZCMAOhNyGv2pTh0SDcOfO7QfKTs/9V4iQwEL6ai6RrDku1xRKteSI6Unv
        bUKDXhxvL+F/GFaY4JEh0BNLAFou3i4PIE6Pg86s=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548854110412238.4593032870613; Wed, 30 Jan 2019 05:15:10 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul.burton@mips.com, ralf@linux-mips.org, jhogan@kernel.org,
        robh+dt@kernel.org, ezequiel@collabora.co.uk, paul@crapouillou.net,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com, ulf.hansson@linaro.org, malat@debian.org
Subject: MIPS: DTS: CI20 board DT updates.
Date:   Wed, 30 Jan 2019 21:14:02 +0800
Message-Id: <1548854044-56483-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix booting time warnings.


