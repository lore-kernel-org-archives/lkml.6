Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BBFECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF4E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILifPTdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF4E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeGTIsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:48:55 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:40120 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeGTIsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:48:55 -0400
Received: by mail-oi0-f49.google.com with SMTP id w126-v6so19802287oie.7;
        Fri, 20 Jul 2018 01:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=ogD+Lg+qAMaHxvoC+TqOdEihZIqrOhD38wa70LMibaY=;
        b=ILifPTdiKl7BsvjbQu5Vx7/kr1HV1M+Vb7SHBOLPzijeQA/JK+mcQfAA1jedODCRB9
         FC6jbsp1HOVY9cfR0qbfufDjpPN5goknhrqdsW2ES5h832VM6jqS0thf0kvc6SICTGme
         B0IFjO1aMjwwQoK8HJi2OOopVxLzQD40EvNU//R6iNzhT0bC7Gqtip5MgBLsBqpKmMvV
         73/MwahKdFo64iL5fdBbTx2cAHNuhHIHjSEPXpxuYFciSsr0lgOFmHtUcndRinzQm7Gd
         pyFn75hkSlmuxPHpgpyIAtgddv4D2VVpWDS4cZnqBPYP/ySUBWGzGoYzAaQLZMr/Azmg
         vv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=ogD+Lg+qAMaHxvoC+TqOdEihZIqrOhD38wa70LMibaY=;
        b=XtrFLB7Sgivb3e8FU7KHdbe4+y/LsxZx95yo/dWDRASPtySWteTFtdwYscS1/3HWcp
         Qo/y+MlNjIajkjkoN1HYPlkD4jA18jz5dyHRxR02QSpU201nG4VVbodSF2Iuc1Wr09vg
         uOcemYr8++sKa6g6TXrVcqG7rhS2AAwC6DruArxEJvatxHyP4PEhnl6wRXuyyWzsof58
         TkHP4esbD2i5MN1aSUE8G5ItqyYuStHb7bYcw+ayQrG/TG/F3sf33qCHOuz0XCv9zDva
         WjZsF0OvSrfsPI5gV2g4sNw7OOje+nEAWRCWkOQQO81bz9SJqzAR7SFO/w/q1Q1sFqZY
         Y+MA==
X-Gm-Message-State: AOUpUlEk8p9sZr6eF0h982xroYo084m7lP4S9L3NUpB9kquCwqVhF/uo
        59UNiTBaUWj7VuJ2DAfd2ZePI9mNuYg50QAXZ/4=
X-Google-Smtp-Source: AAOMgpe7v5dcoZWc64bXTozFOlq45fJVTQS9wdR7BMMygkAvEN3W8te4Hy5IMtt6peEfv2hgUPSlUT5ZAYVtJqX8+M8=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr1132946oib.116.1532073712198;
 Fri, 20 Jul 2018 01:01:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 01:01:51
 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jul 2018 10:01:51 +0200
X-Google-Sender-Auth: PKMKc84X7RAA4mxuUwLAHmggI60
Message-ID: <CAJZ5v0hBVRAQCbD33RYRCBL-Qmx2OW1x4tqiLo5C_r5Qjvbp5A@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v4.18-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.18-rc6

with top-most commit 2c4d6baf1bc4f7729773ffcee9ba2a9781578633

 ACPI / EC: Use ec_no_wakeup on more Thinkpad X1 Carbon 6th systems

on top of commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe

 Linux 4.18-rc5

to receive an ACPI fix for 4.18-rc6.

This extends the recently added suspend-to-idle quirk for Thinkpad
X1 Carbon 6th to other systems from that family which turned out to
need it too (Robin Johnson).

Thanks!


---------------

Robin H. Johnson (1):
      ACPI / EC: Use ec_no_wakeup on more Thinkpad X1 Carbon 6th systems

---------------

 drivers/acpi/ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
