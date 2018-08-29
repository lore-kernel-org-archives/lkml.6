Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F29C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74F52064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnK8zdZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74F52064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeH3AbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:31:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33522 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeH3AbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:31:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so2810175pfn.0;
        Wed, 29 Aug 2018 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=D/s7oFjIA3UyYWin1hDK66kDth5e4zzgivmTvvZltus=;
        b=qnK8zdZRzngpNnAEvWYmhf0Cl9PHQPgRMc3hUAHM9wEQjeYkMNLs/j/wO9o9gyd2eO
         tNVaKlHa3+QHE3qhWdecb2bAtLx4I3nhvxHe+2A9LvTyy7hvXpDEsYvkAstfcIHfcTTP
         Tzkpn0eEIhuf9YiOC2HosC6rn3b4XilxMWP0xbl/7KxAJ9NeqTOop+Bj1jDzBspZqHhv
         r6m+qoBDpTJphvDAG0Pokupd+8/SmiO18IUDcbjoupWDFBgxOHHbnCw6YwLW44zoama+
         7zAOjbeXuAi2mdGohz7ThpoS9dM4Feiw4a6+YEjjpi9PGjW8T4CmLk4E/S+Lik8ULAgF
         Nwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=D/s7oFjIA3UyYWin1hDK66kDth5e4zzgivmTvvZltus=;
        b=A1x1lQ0jN9KsLVEBJZMy8P3oYFuM9Yr9DBbGDlVasYiL4M6XzWkQAFwRSP7unxfDSv
         1+xyum5zA+q5xxttT+6o3T+ZUliFe5xj/tByYPaIjXUyoTTscc4doDr5iD5BQwRVZTc6
         te7aTyEop/XudzS4fTp/tGCsn59VYWPdX6tH/RQE9K2wy5YybL2hgI9yrshBgJ5S0J4a
         UYolWL9ok7QDhCDw6q1Qf8UgIypdS137eFnucS4yohi8slGg/8ZvHplRjwTW7/+mF72W
         ZPLt14xXlLv/V9k2EGMZKuP96JC4xLbuwJsASTF0yp2EZRD3znhs47pkroTWMypCVMsW
         q52g==
X-Gm-Message-State: APzg51BVKHblk0XWXV3M5uYbWI/Ao4k/VPdLjhTED762DbDKZgLgrEri
        ZYZjfNkjtCtprrNXYuTTHKQnjgtC
X-Google-Smtp-Source: ANB0Vda1v/KGcq6/XFBwjj6h+GTnc1vBY8M8MyWb9CDg9tanM+gaRMMADGJm2FWCUS4xJgnoyDk+AA==
X-Received: by 2002:a63:ed07:: with SMTP id d7-v6mr7060917pgi.429.1535574762064;
        Wed, 29 Aug 2018 13:32:42 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f87-v6sm14995715pfh.168.2018.08.29.13.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:32:41 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v4.19-rc2
Date:   Wed, 29 Aug 2018 13:32:40 -0700
Message-Id: <1535574760-11636-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v4.19-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.19-rc2

Thanks,
Guenter
------

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.19-rc2

for you to fetch changes up to d49dbfade96d5b0863ca8a90122a805edd5ef50a:

  hwmon: (nct6775) Fix potential Spectre v1 (2018-08-26 17:45:25 -0700)

----------------------------------------------------------------
hwmon fixes for v4.19-rc2

- Fix potential Spectre v1 in nct6775
- Add error checking to adt7475 driver
- Fix reading shunt resistor value in ina2xx driver

----------------------------------------------------------------
Dan Carpenter (2):
      hwmon: (adt7475) Potential error pointer dereferences
      hwmon: (adt7475) Make adt7475_read_word() return errors

Gustavo A. R. Silva (1):
      hwmon: (nct6775) Fix potential Spectre v1

Lothar Felten (1):
      hwmon: (ina2xx) fix sysfs shunt resistor read access

 Documentation/hwmon/ina2xx           |  2 +-
 drivers/hwmon/adt7475.c              | 25 +++++++++++++++++--------
 drivers/hwmon/ina2xx.c               | 13 +++++++++++--
 drivers/hwmon/nct6775.c              |  2 ++
 include/linux/platform_data/ina2xx.h |  2 +-
 5 files changed, 32 insertions(+), 12 deletions(-)
