Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B156C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A282082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOOSNg//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfBDWKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:10:03 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51180 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfBDWJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:09:57 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so3766112iti.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 14:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0fJCNj7MFD9xvIfs2NID/T373ukM8ea/SKUT6zyDj+o=;
        b=FOOSNg//1pQoNLMp5zeZPRgKr+7XT9AnY+QfLxlZikP9ybej7abN8RrYyYAkbAX/83
         mL0v7hQas9VnGkXglhiHYegG1wuHZw8vUC+P5NPshw0o7UbmPz+zvzrL/aRhlmQWjMDs
         k05+lGZb7qkHONSU8gLKIXWqi49na+ZAmW/tokWI7Em/lhSSt4tz99lyf1vQ2rSKKojr
         pQFrv+JGl5R1LjsHnTiEQ8cJ13McgRnNndZjsthFOrpGUXtOpgCFw1s3oXs33qmwgvaR
         7vLfT9POwUzUsya19LcVbdL0/sA6mAhLEpg1FcRGrqinm3Nf7yzU+mZ2Qsh56xj0ueR9
         mJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0fJCNj7MFD9xvIfs2NID/T373ukM8ea/SKUT6zyDj+o=;
        b=NawFgCiVoJExtqu2cW/ikJVWqjjWGrfCtnkpgs1/HIYzZvUmUVhpkfpH8D/YpZrHGT
         3XW+TUi6DuZmb1+Xed5iSHwS5uC+2lWP/ie4z/dWpj2ReqQmLyAjqq2XJ+HLjmuav7/3
         1Vluav9P6rGtwgsEvE8RfVI3e3l8F5eXLjoDCHefzICQ6aVNB0vODjb1EAmTA5tE4KkN
         eNHtR6vkTpAtS1qkTvJwHvR5iSz+M/V2YD9LE9g4lO8kd5owuOqnkYtPYosonIBf7HNY
         aL9u/TYoR4N44ERgUcQqvRBdg/Qhxk4iABbktLoathf8q+5gojNU2TppPZ0np08GO64G
         wZ1A==
X-Gm-Message-State: AHQUAuYEj2KPX/W3J+QifEtUCh8PniBZywRLHAEe6KVahBETdapJe9HY
        /eUbyNJ3XWMeRx8kSxzYQwvP1SM/
X-Google-Smtp-Source: AHgI3IZ4D5GUSfK7hJVujNJMz0mJExWTySofNv93R/1H9ZjzqMWrfPSkaI/+fXr21icSkRZJx32zUA==
X-Received: by 2002:a24:76d0:: with SMTP id z199mr833835itb.165.1549318196499;
        Mon, 04 Feb 2019 14:09:56 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id z1sm531602ioi.77.2019.02.04.14.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 14:09:55 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC v1 0/3] Address potential user-after-free on module unload
Date:   Mon,  4 Feb 2019 17:09:49 -0500
Message-Id: <20190204220952.30761-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think there _might_ be potential use-after-free issues on module unload.

They are hard to trigger, but I think I've seen them bring the whole
kernel down when they do occur. Can be triggered by doing an insmod of
a vulnerable module, rapidly followed by an rmmod.

Caused by drivers which schedule work / delayed_work, but do not clean it up
properly on module unload. Which means the work function could run _after_
the module has unloaded.

A quick grep through the kernel sources brings up many instances.
I leave it to people more knowledgeable than me to determine if this problem
is likely to happen, and/or if it can be exploited to become a security risk.

Perhaps developers can be 'nudged' into doing the right thing by using
resource-managed versions of INIT_WORK() / INIT_DELAYED_WORK(), which may
address the issue quite elegantly.

Attached is a proposal patch, followed by sample fixes for two vulnerable
modules. As far as I can tell, many more modules are vulnerable.

Sven Van Asbroeck (3):
  workqueue: Add resource-managed version of INIT_[DELAYED_]WORK()
  max17042_battery: fix potential user-after-free on module unload
  cap11xx: fix potential user-after-free on module unload

 drivers/input/keyboard/cap11xx.c        |  6 ++-
 drivers/power/supply/max17042_battery.c |  5 ++-
 include/linux/workqueue.h               |  7 ++++
 kernel/workqueue.c                      | 54 +++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 2 deletions(-)

-- 
2.17.1

