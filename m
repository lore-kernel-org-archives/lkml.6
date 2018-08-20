Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C634FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E66D2154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS2w52aV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E66D2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeHTMdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:33:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43662 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTMdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:33:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so5144660pgb.10;
        Mon, 20 Aug 2018 02:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zr9Tvz1ZSeev1ffh6K8dDZmr55b6tJDsKTUGrEj4iYo=;
        b=GS2w52aVHMk1eMoBA+jYpMoMt649/eekGCkZxuduyN1+OeKD27PKwib9S/o24HXsFf
         mKs4RO6WewDbqiLGyr5zT2ZWwdckoBiOi22XDTqeG08sDzCeay0i5/8DPh7nlazR19Bo
         Cch2atkr8Z1bINKbajU4L1FjdvlY43PMbuJRGJmz2MOmaPTuZH2YtGzhs51UGfjGjH/q
         GdJcVY1v8+4TeN2akbx9d3mBbpE2UrgcxEhAAEDdNFf9PE9YuZYInt6tNtYK749Dub2E
         9uVZpssvgzDUoTNTqdLlwxyIeHm/4ExnoNUxpHBHlmYjvtN4nOPJZ9RKQFyVcY2hgmV2
         pl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zr9Tvz1ZSeev1ffh6K8dDZmr55b6tJDsKTUGrEj4iYo=;
        b=iVzbbMFpEIXd6OSAZLeTR0jqaEPrGPoJGSDKazWxBslNw2Il0JVhykxgHfbL7+MBrd
         G5FnrIYBkXWDQYb+pib9tY5TxqfkbDqL9Zo92qKh7yt2Iohv+PhkQBt5f6yWrtzFwePr
         rmwqOe4PBNNUDhfLIFqKCqAxTavU1lfqHobvubsDIPkWIZSueqeBYX0MnplMCIotFQBx
         AyzVLdvp+PdPbmu5chAKTpPEXI5ReRLkfcN5qHoLfMiJnSlMctsPlKRXoqn9Qo9KqZQu
         OIoQPFWNS4ttTlBBo+7icAEC2BWG4rHfOfW+KcoCmggK86UAIIVg6HWLSJukJZDbMN4I
         obCQ==
X-Gm-Message-State: AOUpUlHiPxdeQO0DFUN8BQxhxOcXFbaYvN20B16RYdr+Cje+JC3FKiMm
        URqSRqAA3n3Iw54yS1iPO/b1tQQ=
X-Google-Smtp-Source: AA+uWPwjp767oSf2ydtkQGyA1apW25L4PmNYR3ohs4nWBmym3DXwZE4JaU2ySlmQibxB5bQIfFaXyg==
X-Received: by 2002:a63:40c7:: with SMTP id n190-v6mr42211585pga.116.1534756736205;
        Mon, 20 Aug 2018 02:18:56 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u11-v6sm16166340pfd.117.2018.08.20.02.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 02:18:55 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PM: simplify the code logic on device_shutdown and suspend
Date:   Mon, 20 Aug 2018 17:18:34 +0800
Message-Id: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, the "parent <- child" and "suppiler <- consumer" ordering info
are stored duplicate in two places dpm_list and devices_kset, and
corresponding, there are two sets of routines to manipulate them. The patch
pushes the dpm_list and dpm_list_mtx out of CONFIG_PM, and let
device_shutdown() use them to implement shutdown seq. Comparing to original
code, this patch tries to simplify the code at the cost of a extra mutex if
without CONFIG_PM and nothing if with CONFIG_PM. The cost on dpm_list_mtx
can be ignored, since the device hot add/remove is not very frequently.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org> 
Cc: linux-kernel@vger.kernel.org
---
Pingfan Liu (3):
  drivers/base: move device_shutdown() to base/power
  PM/shutdown: device_shutdown() uses the order info in dpm_list instead
    of     devices_kset
  drivers/base: clean up unused devices_kset_move_*() functions

 drivers/base/base.h           |   1 -
 drivers/base/core.c           | 126 ------------------------------------------
 drivers/base/power/Makefile   |   1 +
 drivers/base/power/main.c     | 119 +++++++++++----------------------------
 drivers/base/power/power.h    |  25 ++++++---
 drivers/base/power/shutdown.c | 123 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h            |   7 +--
 7 files changed, 173 insertions(+), 229 deletions(-)
 create mode 100644 drivers/base/power/shutdown.c

-- 
2.7.4

