Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F61EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DCF2151C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pv/VvEkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DCF2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbeISWdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:33:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32806 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbeISWdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:33:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id b97-v6so2968111plb.0;
        Wed, 19 Sep 2018 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lwTqRO2ykRDPuXDuIeZVSmiXJzyd/m90WNtHQhJ/5s8=;
        b=pv/VvEkEGs1oXRUMKUAVWOmcIzKf6J58t9a+3+6+Lrf/D0xJUupK9Tjf7gb92k0DPi
         aY4MCKvFbf0W3CbbMuz3pk6U3zyM/HupC2X7f94Dl9e51cbhv+SGf6JfwIoxmIBLDebZ
         f7iKDP5eXvsVCL/heOBCgGHqXmONKcJP48xFBg/PJvT3zu1Nxt4T3S7GyAGcmqXldkvt
         avbo7sYicwy6XDSqa4uLHhBxovmWakkfWKA+sKzQlyqaLcA3oE4n4RlZNgvjTBtj4+rt
         s27y4IcqMVU4YvsfrQ2DhbH23gEFjZa61g4XuzJNFB1ms4xBJyeXIdCwp6uQQiOHzgS3
         /Xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lwTqRO2ykRDPuXDuIeZVSmiXJzyd/m90WNtHQhJ/5s8=;
        b=IetCXthTVxfDOPFcHIqJlwvAwHo9S3FKxqOFJjPkpJVPUwhaNp3vmt/hmJoF/ZFgAb
         gu9q4Yez417xQWAooBxWMlZIPQTy8Onb7ib7xeqk9eWbbK5fOTP2OASQluYl/EYDagU0
         Mzfk5DQiOtywsrVf5fAUy0T6LLaaFFgwifMEtT79dyce1bwr8LvDgsEuVfhiEw+CqJXl
         pbdI5i+ylFuHA+FIGo3JyZUWY2EnYl1XA/1zm1Vz7xZ6mAfhlTBPxgzBgiObBi97er8x
         XzdohvbJBOUMOtt7WkH9702IfVUesKuqCb6wII7g85dXWmXGqeCYlLAVFN15F/6BaqaE
         WCcQ==
X-Gm-Message-State: APzg51Dd4dSzWYrBT6Ot5C6qr/so5CBTTmekiZn7/tRtJdWRDDugrTEl
        Uh0aGf6N44Ts7yA6D/42/WQ=
X-Google-Smtp-Source: ANB0VdZFVaCCHxx7JKzgubZT9O07LOX4+zrOsCc/OhMvzdoOchRXhuJ1t90io+0vVspjddhLs+yTcw==
X-Received: by 2002:a17:902:b282:: with SMTP id u2-v6mr34512767plr.123.1537376085255;
        Wed, 19 Sep 2018 09:54:45 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a90-v6sm52314167pfg.106.2018.09.19.09.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 09:54:44 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v4.19-rc5
Date:   Wed, 19 Sep 2018 09:54:42 -0700
Message-Id: <1537376082-32219-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
Hi Greg,

Please pull hwmon fixes for Linux v4.19-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.19-rc5

Thanks,
Guenter
------

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.19-rc5

for you to fetch changes up to 55066354285b36ee09dc50e2527f43a97c567177:

  hwmon: (nct6775) Use different register to get fan RPM for fan7 (2018-09-17 05:38:50 -0700)

----------------------------------------------------------------
Various bug fixes for nct6775 driver

----------------------------------------------------------------
Dan Carpenter (1):
      hwmon: (nct6775) Set weight source to zero correctly

Guenter Roeck (4):
      hwmon: (nct6775) Fix access to fan pulse registers
      hwmon: (nct6775) Fix virtual temperature sources for NCT6796D
      hwmon: (nct6775) Fix RPM output for fan7 on NCT6796D
      hwmon: (nct6775) Use different register to get fan RPM for fan7

 drivers/hwmon/nct6775.c | 72 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 23 deletions(-)
