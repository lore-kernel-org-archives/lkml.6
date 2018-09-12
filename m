Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42006C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED22020880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWVCAkP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED22020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeILT2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:28:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45025 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILT2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:28:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so1140103pgp.11;
        Wed, 12 Sep 2018 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3Su25iH5FovopcismpQqAWnRqtJ6RIIPdTIPIgNjw7Q=;
        b=TWVCAkP65Z8NkLePWeSswydAojQkEU9F0IFZD0SE1g292xW9l+n/5a/92ratqtdx/X
         EMaJc0x2YJXFAEgPrWZQFrNBGwrRfF7p4Mes5JAWlHGKpzboJFAjQZ3OsJutkeTuI66K
         r0un1zv1ig+B3mJrABh32qxRD16oxTCRDRHCYTJC6y7ZK40Lg+b45BHEKaKz0cS8trDf
         RyaSZlGtIpQFSX3Q33tDknAAcZiBx2g9tjipFWy4KSRBwyLQlLDdc/f6ru/Bv19klxBr
         mxfSbExJuT4GDv8uqmJJMIkmeiIdBP/N4SlHWndooCfHC9LJ30yjpffHX87yoReW1C8e
         unWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Su25iH5FovopcismpQqAWnRqtJ6RIIPdTIPIgNjw7Q=;
        b=fYHrQMh9L+/cTaoN4Hah2+tNmZxHG+nd5foUR0y1Nsp84UCXvWmN2R5mc9JHaUiKGK
         bDphzxWMUHqVBfHIw7TYCJi3lZbPIzfhze1FuTdTSK+m6lNUo0BRfJafQUZT4Kd/1osU
         eU+etlaso6p4lv4N29DqPFOhkEXoyGu3dTFOzPWezsTiE4bo71RuLcAbseoWbaCTuYHT
         PPw6SUgt3z4Cmkrp3cIjmdQxfEbYnjNwOLVYG8ccMDAQ+wy2xUP4ku148en3BR4lfaOs
         QkNvu17F/Ta4p0+J6UDa/yKFgGcAIYUPSuv0BW2RYN4V/1LFlpI+PKTFGDyITPfdLr/p
         1TQA==
X-Gm-Message-State: APzg51CPED3vYh9gvJHRjTSkZjHM/ppxjA3RXKbo2gtWfsvKpJ5qmlE8
        pmBohHMQxlCZ73D/YLJNg0k=
X-Google-Smtp-Source: ANB0VdZOBWwK2MqYQtSuhWTiXLHXzda2HRAPoAd//TjYOQ4qIBLfGHQXB1AeUg9rW+YyOUM3XjLOuA==
X-Received: by 2002:a62:fd06:: with SMTP id p6-v6mr2648880pfh.167.1536762250423;
        Wed, 12 Sep 2018 07:24:10 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id t9-v6sm2124213pgi.87.2018.09.12.07.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Sep 2018 07:24:09 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 0/5][RFC] Encryption and authentication for hibernate snapshot image
Date:   Wed, 12 Sep 2018 22:23:32 +0800
Message-Id: <20180912142337.21955-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset is the implementation of encryption and authentication
for hibernate snapshot image. The image will be encrypted by AES and
authenticated by HMAC.

The hibernate function can be used to snapshot memory pages to an image,
then kernel restores the image to memory space in a appropriate time.
There have secrets in snapshot image and cracker may modifies it for
hacking system. Encryption and authentication of snapshot image can protect
the system.

Hibernate function requests the master key through key retention service.
The snapshot master key can be a trusted key or a user defined key. The
name of snapshot master key is fixed to "swsusp-kmk". User should loads
swsusp-kmk to kernel by keyctl tool before the hibernation resume.
e.g. The swsusp-kmk must be loaded before systemd-hibernate-resume

The TPM trusted key type is preferred to be the master key. But user
defined key can also be used for testing or when the platform doesn't
have TPM. User must be aware that the security of user key relies on
user space. If the root account be compromised, then the user key will
easy to be grabbed.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Lee, Chun-Yi (5):
  PM / hibernate: Create snapshot keys handler
  PM / hibernate: Generate and verify signature for snapshot image
  PM / hibernate: Encrypt snapshot image
  PM / hibernate: Erase the snapshot master key in snapshot pages
  PM / hibernate: An option to request that snapshot image must be
    authenticated

 Documentation/admin-guide/kernel-parameters.txt |   6 +
 include/linux/kernel.h                          |   3 +-
 kernel/panic.c                                  |   1 +
 kernel/power/Kconfig                            |  25 +
 kernel/power/Makefile                           |   1 +
 kernel/power/hibernate.c                        |  62 ++-
 kernel/power/power.h                            |  59 +++
 kernel/power/snapshot.c                         | 576 +++++++++++++++++++++++-
 kernel/power/snapshot_key.c                     | 303 +++++++++++++
 kernel/power/swap.c                             |   6 +
 kernel/power/user.c                             |  12 +
 11 files changed, 1036 insertions(+), 18 deletions(-)
 create mode 100644 kernel/power/snapshot_key.c

-- 
2.13.6

