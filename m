Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D8F1BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E36420693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY5/PsTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E36420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933524AbeFLHtO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:49:14 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42362 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933244AbeFLHtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:49:11 -0400
Received: by mail-lf0-f65.google.com with SMTP id v135-v6so34491434lfa.9;
        Tue, 12 Jun 2018 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s8s9VZvuLG6DKWZfDEtghM7KgX2IJNputjsN+9z4G9w=;
        b=gY5/PsTCpqqeaI2VjkDvn2ahzoHU0e10WFCB8mzcyNqjiquxDhZUzQUZmRIHZe7d7r
         duoq7kNrgijCgYWb2Mhx1d7FDX2ko0ZdlDKrsNmQ/hislo6BR2/nMprSV87ReSjgpGvi
         TtZTMc/i/YlsKhi4UXGfUf+rxRsgb0HqFPNOyJuneJkwEog6qDMHFg6TJlnkabq6+2pS
         xdNG314KBdLSj2gsfcanNVCNlVB3Smy1TbOiSdazMsJ3ffx75OJ12Coz568BlvNhaD4+
         tft9dt510fNqMEIEwzyfwefgSK6hfTsPZ/6joeyjoQMtYVkckpEVz7QFZNnTanVUza2A
         G64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s8s9VZvuLG6DKWZfDEtghM7KgX2IJNputjsN+9z4G9w=;
        b=kcyf15qxK1MTaTIdQwqmFZsHzdc4orm6foPP9QDXxOZ9YVJ90BE8dvMH6fv/6ulUI1
         RI8SzECbtbFP5vcljd/yTP/VqjoPVhvrgT03th+2FCm4bJ1OZJzKb9+ZDS4ZLlj21iTB
         3mrsERHIFvjuj4twTRBhM59ScI7lQmb8SNSSA0O9SqFDqrKIIW72GOhZwmZf0VeHLA3O
         pkyJ3ZpmxMNmY+5HSSnr8PmB2pxlsKSKC5zX3H+bOU9TPOEuLOyMZgaOCPCGkVqxQiUE
         NsA5bbnbLzXd4RM1K0dK6aCuERCsJh4+dNd2FR2g3+MA+RKchbOB/8HWzmepnH1ARQx6
         C3lA==
X-Gm-Message-State: APt69E0OqBHASIiOw3uIJz8DnbQm4mx9NgZeyX8AXitSk1MGdrB5Y3dh
        ADirR4+5IBYmlsHeEC4YNCpzyzh2
X-Google-Smtp-Source: ADUXVKLmX4wFSF3JwTsDvOdSIS1wCH7BO5svmVEkncDrBFHMuMe+ZpMNjjiSHuXYk+eK0Q7Vx21O5w==
X-Received: by 2002:a19:d7aa:: with SMTP id q42-v6mr1436917lfi.75.1528789750076;
        Tue, 12 Jun 2018 00:49:10 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id b65-v6sm62657lfe.80.2018.06.12.00.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 00:49:08 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        jgross@suse.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc:     konrad.wilk@oracle.com, andr2000@gmail.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v5 0/3] Input: xen-kbdfront - allow better run-time configuration
Date:   Tue, 12 Jun 2018 10:48:53 +0300
Message-Id: <20180612074856.28451-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Hi, all!

This patch series synchronizes Xen canonical protocol definitions
which allow the last two patches in the series to update Xen
kbdfront driver with a fix and v5 of the patch to allow better
run-time configuration for xen-kbdfront.

As xen-kbdfront patches rely on protocol changes from patch 1 I am
sending these all together: Boris, Juergen, if you and Dmitry do not
mind, can we have patch 1 applied through Dmitry's tree?

Thank you,
Oleksandr

Changes since v4:
- Added required changes to Xen protocols
- Added a fix for multi-touch XenStore node's locations
- No changes to "Input: xen-kbdfront - allow better run-time
  configuration"

Changes since v3:
- do not connect backend if all virtual devices are disabled (Dmitry)

Changes since v2:
- based on XenStore kbdif features to control which devices are
  exposed instead of module parameters.

Oleksandr Andrushchenko (3):
  xen: Sync up with the canonical protocol definitions in Xen
  Input: xen-kbdfront - fix multi-touch XenStore node's locations
  Input: xen-kbdfront - allow better run-time configuration

 drivers/input/misc/xen-kbdfront.c  | 183 +++++++++++++++++------------
 include/xen/interface/io/displif.h |   8 ++
 include/xen/interface/io/kbdif.h   |  78 +++++++++---
 include/xen/interface/io/sndif.h   |  10 +-
 4 files changed, 180 insertions(+), 99 deletions(-)

-- 
2.17.1

