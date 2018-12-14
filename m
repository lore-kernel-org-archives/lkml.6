Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1A8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA97206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2Yeas6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbeLNPMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:12:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35303 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbeLNPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:12:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so5209841ljb.2;
        Fri, 14 Dec 2018 07:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPHoOoeJrXFhGW2NBg+BqikfLbQmuY9aUqs4/W1ky7c=;
        b=W2Yeas6ZXnzwszhlrs0ZnACmpcAZ9cbC3GBmbyIXz4dpJz1UR8r8UQkptMVFfw9zG/
         LQgCKTHvkCozMA+GdaA1YUOuwZyarbwEap0SnZepjk2hxeVp3TUJacwX9v/FdDjjR3XP
         qbUcNjROXPKo26zMxTP3/U8GZPRtSVFd8/NFqcn2xGglj3MALW0Xu029bDOt0kmR5O9I
         puXi1MYcH5q2O08MuF8OzTQ1NstIa8Z+SH6NaxXrFVTzinp4SUGsnnFWcAqyAEUZbtlg
         6E8gbOnKeXUHqZe4l8E7mPQDGBQDM6uRk91C0EPqCreOX3rJUjQu5QMGrrZvVM9mm8Ju
         maxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPHoOoeJrXFhGW2NBg+BqikfLbQmuY9aUqs4/W1ky7c=;
        b=s9S9QHkfuv6xxQZWhluCQ3xD19PIMTYXcBPyryYA/hBMWwufmvGjkl4QQt8pOnquPy
         pCWwggOGbesHZkbv2+5urpIjSk5ipS40h3zyWBf35mB2CcqtAYXSs9uzEyYlxVoYew2K
         E7h4FgV6l65ruGbzDi7QbmXg5CogkNrxzhkSYaSYVQAPY9vjmZ33XnQ60ea2+J9UVsMR
         a2OoHYEm3qF4+2gZpShFS0pNdZYH+MVlijQrlR24jrg42Q34RsF8D92rxym8su/PIly0
         fJtlny2mUhbbBwPWcail0Yor6sO4phqvoQGePTZqYzN84/oqERDqk4aW0otjKSWxoJFV
         DnPg==
X-Gm-Message-State: AA+aEWY6bHUTcQfYwFyhSaMPjvZUKWYGhaC5skEi5oma519ATBkJ9E7q
        NN0eOPkv4fRKJwjr5dgXuhQ=
X-Google-Smtp-Source: AFSGD/U+9KaXGsGqwuBABPN/lwCpvYF8mj5iSDHz0VERNJNL16gje4tgrlv3GuDznjavpqJHE9Mg5g==
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr2256449lji.133.1544800358706;
        Fri, 14 Dec 2018 07:12:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:976:99fb:a7e3:627c])
        by smtp.googlemail.com with ESMTPSA id o17sm951975lff.77.2018.12.14.07.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 07:12:37 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v5 0/3] Input: atmel_mxt_ts: Add support for optional regulators
Date:   Fri, 14 Dec 2018 16:12:11 +0100
Message-Id: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds optional regulator support to atmel_mxt_ts.
First patch adds regulators to driver.
Second patch ensures that device is ready for communication.
Third patch updates documentation.

Changes from v4:
  - Add missing regulator_disable for vdd in case of error,
    when enabling avdd regulator

Changes from v3:
  - Checkpatch fixes
  - Drop punctuation from subject of one of patches

Changes from v2:
  - Add reviewed-by to one patch
  - Move code for enabling regulators into separate method,
    to make code more readable.
  - Add wait code, to ensure that device is ready for communication.

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get.

Paweł Chmiel (3):
  Input: atmel_mxt_ts: Add support for  optional regulators
  Input: atmel_mxt_ts: Wait for device be ready for communication
  Input: atmel_mxt_ts: Document optional voltage regulators

 .../bindings/input/atmel,maxtouch.txt         |  8 ++
 drivers/input/touchscreen/atmel_mxt_ts.c      | 78 +++++++++++++++++--
 2 files changed, 80 insertions(+), 6 deletions(-)

-- 
2.17.1

