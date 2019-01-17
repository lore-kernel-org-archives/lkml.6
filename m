Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1DF20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0WSDUkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfAQU4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:56:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39941 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQU4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:56:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so5283509plq.7;
        Thu, 17 Jan 2019 12:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=6dRiwnU7dEsS54XPGrobTejwCFXBBqstWxAa5OgZsRM=;
        b=p0WSDUkVFH+GbltwgBltyI9+cDWusOZg4dWWX1gKGCnmAaOf+qRg4seNu6Ws56HLTN
         Me7cugQqS7zdVSUF2Y5dU3d568B3x3DSdiJ64/2n22ulmrc/7KyQjmKXJtJyU3lryKY3
         VB/YC1+cv4ABgVffcOFDKy/0IIN85HczbhfNx4d9xojXTbTaAfbj0vn/Bf/CnyfzkFsI
         RUNuK2kVH4q34HsqQlJb3TRbgWEYwIlonplxRFlh7zNfblthZ1BBPkRrCKbm50vg9KSY
         c4aHfp9GgvScdnqJNrlWaoEoRhfVZjC/mRjrFllWvQCJud8ygR1PUqsAJEnmZ9K6inVJ
         aXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=6dRiwnU7dEsS54XPGrobTejwCFXBBqstWxAa5OgZsRM=;
        b=toyj4fH5xS7NC1r7OrLRNRubOtiE/Ve4JDfzStY78scEsctPsEzmNWiElH68QzG1VB
         BkzRtPWcGApLrRA5R8hFZNoZEv+HxmvZkFxeQ/Q4ZebIext1zxFQjrq3/rPXCkC6KG50
         cCzxoR3I9DveY3V1ll10LSlcx1WPwm3vrjuNR/4znHYmYYlM5Z8HwF74Ilc50m5+/fpG
         I6+GArnrHF18GdalEPdMZepj9wfrjko33lFTFqSRV1c6DigLDtLa7ZXrkjRMvX1vnOby
         //20cnqvrJBZkYWZZuc4xkrZJtngbtTAhLeyHE/svIFKoG/PEE4h7fkJQOqDsyins3v9
         9Seg==
X-Gm-Message-State: AJcUukcJw9n0lQMYO9T77zMJVZQtA2ELcIE63w3+SW7I8ytbirqLpKRm
        sY0K+8tkSlR83T/E9nl4QZkBBMrV
X-Google-Smtp-Source: ALg8bN4WYm28UB6Ut8hAieQM0N/2uOBa/EPitJS5KhQzQ3RtUlvtSmJMHPsPMtPov+UnPEikHINSgg==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr16564651plo.316.1547758613143;
        Thu, 17 Jan 2019 12:56:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2sm3439313pfb.28.2019.01.17.12.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 12:56:51 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for hwmon-for-v5.0-rc3
Date:   Thu, 17 Jan 2019 12:56:50 -0800
Message-Id: <1547758610-27138-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux hwmon-for-v5.0-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.0-rc3

Thanks,
Guenter
------

The following changes since commit 3bd6e94bec122a951d462c239b47954cf5f36e33:

  arch: restore generic-y += shmparam.h for some architectures (2019-01-06 18:16:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.0-rc3

for you to fetch changes up to f422449b58548a41e98fc97b259a283718e527db:

  hwmon: (tmp421) Correct the misspelling of the tmp442 compatible attribute in OF device ID table (2019-01-17 12:54:52 -0800)

----------------------------------------------------------------
hwmon fixes for v5.0-rc3

Minor fixes/regressions.

----------------------------------------------------------------
Cheng-Min Ao (1):
      hwmon: (tmp421) Correct the misspelling of the tmp442 compatible attribute in OF device ID table

Guenter Roeck (2):
      hwmon: (nct6775) Fix chip ID for NCT6798D
      hwmon: (nct6775) Enable IO mapping for NCT6797D and NCT6798D

Gustavo A. R. Silva (1):
      hwmon: (occ) Fix potential integer overflow

Wei Yongjun (1):
      hwmon: (lm80) Fix missing unlock on error in set_fan_div()

 drivers/hwmon/lm80.c       |  4 +++-
 drivers/hwmon/nct6775.c    | 12 +++++++-----
 drivers/hwmon/occ/common.c | 24 ++++++++++++------------
 drivers/hwmon/tmp421.c     |  2 +-
 4 files changed, 23 insertions(+), 19 deletions(-)
