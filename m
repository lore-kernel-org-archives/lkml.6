Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605ECECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211ED2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="tNvzlGyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211ED2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeJ2L7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:59:11 -0400
Received: from nag.0l.de ([207.154.252.120]:44774 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbeJ2L7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:59:11 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=jSPM0bWrxyvE/WaOjD0tmnxseWEsbiu1cyAKgZ6K6B4=;
        b=tNvzlGyYhCT1eXO0nkduUlNdvVZ57lzPBoUUOnhg4a000Z4oct3UxvV6JvhklpxneDyvQe
        AOwFK/pmVQUt5BQL5MFS3/peULfOzPvSLAw3ructwhusDnQoqiVmuXcqyRdOVKDEwZ8cjX
        SJ7B0EfsVvVlmMDhR4jhGhejFVsiC9ayN3NoXbNQtci7d97qAH9ArRxRV28GC182+YoZD0
        3uJ+HkV7wHk4AzysRFGRekqS9d/fw3maAarzDsjUV1m9ZFccUE3R+7XdoEDk5Cenuv8BXx
        sI18Ah+szbiOFEJSrRuVuFWeeoWrO+vMhvTLaT9EjhiADWVBdcknBk/8TVW7Og==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 00/11] w1: coding style and checkpatch fixes
Date:   Mon, 29 Oct 2018 04:03:30 +0100
Message-Id: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=jSPM0bWrxyvE/WaOjD0tmnxseWEsbiu1cyAKgZ6K6B4=;
        b=sOz4G30n/BkT4BSuzh8ZY0ANM8564DPrEUm9mxBIEiKPxMb38shO2z91MBsm9V140QqiwE
        1AR0Z0kK8n0oqV2TPR/gszhTW628e4kyDLupk5MvmSIDvu1UdUIqxkbzqc4C+CbpZfT3yc
        6FEb8rtpwZIhMAP0cgFhaBVs6UlVIB2CBIpU8xxQj1cDAGdJfQXq3kwLB/qBLR2b081Vbp
        ditffjWe0oM0mZXKrAahyhwMXoBhASETnaUT7aWMkIqhQGRo3aaFtUyDlwHV+RiuNY4/4t
        n7p9VPgJGz6aqE4PQhaEx5CJ7jNmdowlxbQ9J9wGru/7pAngY07uWZs1np1icA==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782276; a=rsa-sha256;
        cv=none;
        b=c9ayIA5JsyQqRuI9LfNgQ8fv+2+JM7x9H4yl3HsMQN/By3NY5skCzOyVJkLFz1dvBWhdN4CTcVth9dIiLxsKxjNVuoZ2LMeNxsXEKZAD0kqw7DYPlBsEIO/oAFbmowQzKl1wa2yhIXOfC53QPpROxa1DJ749SlNGUo0XVLVFWHAf0whiDTv1SFg0YzEVwPgakr8R1OIxSU8VyAIFmu0yaoyMMkBnI0XPhrrfg0shnJMY8hu7JULOSuEjgV59MKsgALbz/Mzt9fdTtxYVFl6WUHq9F1JnachLN4JZso38McOnf9Hm9KZr3ygavNH/d/1dETiHJO97MXrvJUQPxnq6sA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is my first series of patches for the Linux kernel.
I started by familiarizing myself with coding style and
satisfying my inner OCD by cleaning the 1-wire subsystem.

Cheers,
Steffen

---

Changes since v1:
  - addressed comments from Joe Perches:
  - re-ran checkpatch.pl in --strict mode
  - fixed commit messages to reflect more precisly
    the checkpatch warnings

Steffen Vogel (12):
  w1: add SPDX identifiers
  w1: improve code-style by adhering tp 80 columns per line limit
  w1: add newlines after declarations
  w1: cleanup whitespaces according to coding style document
  w1: use octal numbers instead of macros for file mode
  w1: do not log errors about failed memory allocations
  w1: use __func__ for logging the function name
  w1: improve code-style of struct declarations
  w1: using linux instead of asm prefix for includes
  w1: use pointers instead of types to determine size of allocs
  w1: replace non-standard %LX format-string by %llX
  w1: fix typo in comment

 drivers/w1/masters/ds1wm.c     |   5 +-
 drivers/w1/masters/ds2482.c    |   7 +-
 drivers/w1/masters/ds2490.c    |  16 +--
 drivers/w1/masters/matrox_w1.c |  16 +--
 drivers/w1/masters/mxc_w1.c    |  10 +-
 drivers/w1/masters/omap_hdq.c  |   7 +-
 drivers/w1/masters/w1-gpio.c   |   5 +-
 drivers/w1/slaves/w1_ds2405.c  |  12 +-
 drivers/w1/slaves/w1_ds2406.c  |   4 +-
 drivers/w1/slaves/w1_ds2408.c  |   4 +-
 drivers/w1/slaves/w1_ds2413.c  |   4 +-
 drivers/w1/slaves/w1_ds2423.c  |  15 +--
 drivers/w1/slaves/w1_ds2431.c  |   4 +-
 drivers/w1/slaves/w1_ds2433.c  |   4 +-
 drivers/w1/slaves/w1_ds2438.c  |   4 +-
 drivers/w1/slaves/w1_ds2780.c  |   6 +-
 drivers/w1/slaves/w1_ds2781.c  |   6 +-
 drivers/w1/slaves/w1_ds2805.c  |   4 +-
 drivers/w1/slaves/w1_ds28e04.c |   4 +-
 drivers/w1/slaves/w1_ds28e17.c |   4 +-
 drivers/w1/slaves/w1_smem.c    |  16 +--
 drivers/w1/slaves/w1_therm.c   |  16 +--
 drivers/w1/w1.c                | 272 +++++++++++++++++++++++------------------
 drivers/w1/w1_family.c         |  15 +--
 drivers/w1/w1_int.c            |  34 ++----
 drivers/w1/w1_internal.h       |  11 +-
 drivers/w1/w1_io.c             |  86 ++++++-------
 drivers/w1/w1_netlink.c        |  64 +++++-----
 drivers/w1/w1_netlink.h        |  39 +++---
 29 files changed, 283 insertions(+), 411 deletions(-)

-- 
2.11.0

