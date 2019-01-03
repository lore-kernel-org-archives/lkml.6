Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8524C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827E6208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrtTbPvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbfACOci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:32:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45297 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfACOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:32:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so15974128plm.12;
        Thu, 03 Jan 2019 06:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U8LyK7GEASf9Es0BDGjeJP/s2murtK3VQAlerjTkU1I=;
        b=LrtTbPvr3TannS2qz+7mHcNtdT4jOIgayHuyLZbvLMWQbMbp/JYpRCsWQcL35sq8sN
         KwoD+Ah+37aiGE/dDEs4tWgkvb+CclNAaLXGyDK+FM9bTU4hmhuT9863BZir0DNmEF+T
         mb1qPFx48a2PU3q7ZXSloXCq5A7KdzHgSQra1TNdU39HMrCwXIXLO9cEVs6a222lP6r5
         GUoX5uhQZbLW264kBXxroo9KaHxw+MHjdQ2CGSgm1pcTusz0A90cYHZMabXTs26hrUel
         w8+L2L5yV1umIFo8GIOzANN4fRlNzxa6Xshu1iVsFxvlJqwMa3Ent3HP0S/MEZD6pjxj
         FWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U8LyK7GEASf9Es0BDGjeJP/s2murtK3VQAlerjTkU1I=;
        b=ooYxZkLosehY3qODf4PL+OikkoOB2Whsbt3Fet+wDfhLYy+WZg1NqZEhsNM8NHlKr8
         rcmuHElO2I/mK6ua95dyo8fnFh+2ZxSHK9tYISOrHa11sPe0SHZv5TCUshOZcwxpi8lV
         RMi/xxtZFne91U3kN+z9+N38vs/ngGs/2rNSpwx8Mv5tBZNiAj5mFanXZN8jzevgHtAL
         BZgZN5gQ++FlPQl5HvDS4KELt4/WuPqj8WyXqLgFuSmsz0u/lMfOHISphOG4FX+AeJUF
         HX7Xrzjfug5tdgd845DscA1VB7uEaParFmguRZ89TCO4g4mvMv+/nxqnvyD0RtLedwPi
         1gDQ==
X-Gm-Message-State: AJcUukdBAIqF7Xdh6AreDkxTr0EpUH82S28PD3c6St/1xEWzkg3Pe44N
        9L5M/ABVizNJavHSlmzO5TI=
X-Google-Smtp-Source: ALg8bN5ZwXSlKRdEhusumN+4Wb5f4GrBQ6Kaeimkxohx5m2eU5+g2x0RCuqVY8Tti8PnZ5R1mA2t2Q==
X-Received: by 2002:a17:902:9006:: with SMTP id a6mr46586597plp.334.1546525957295;
        Thu, 03 Jan 2019 06:32:37 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id x3sm184403100pgt.45.2019.01.03.06.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 06:32:35 -0800 (PST)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate snapshot image
Date:   Thu,  3 Jan 2019 22:32:22 +0800
Message-Id: <20190103143227.9138-1-jlee@suse.com>
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

v2:
- Fixed bug of trusted_key_init's return value.
- Fixed wording in Kconfig
- Removed VLA usage
- Removed the checking of capability for writing disk_kmk.
- Fixed Kconfig, select trusted key.
- Add memory barrier before setting key initialized flag.
- Add memory barrier after cleaning key initialized flag.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
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
 kernel/power/hibernate.c                        |  59 ++-
 kernel/power/power.h                            |  59 +++
 kernel/power/snapshot.c                         | 576 +++++++++++++++++++++++-
 kernel/power/snapshot_key.c                     | 312 +++++++++++++
 kernel/power/swap.c                             |   6 +
 kernel/power/user.c                             |  12 +
 11 files changed, 1042 insertions(+), 18 deletions(-)
 create mode 100644 kernel/power/snapshot_key.c

-- 
2.13.6

