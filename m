Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE67C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937E320C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xxws8QNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937E320C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbeISDMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:12:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40331 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeISDMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:12:40 -0400
Received: by mail-io1-f65.google.com with SMTP id l14-v6so2813591iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4ByIeOrucoHrciU9Qb0rVBc52lb77EncTjGevOxdXhI=;
        b=Xxws8QNy0BYmDILNWVdkHsbGFC4IQXBXrstmJ5e75yv46Tq+1MXLdwAS71iIxcMaoc
         qnduUB1ncluEIXjWz/Xw9lriFvzszoUxO1zZqK0Ge9suR1yRyTamnz+Rua0azdpGE8g3
         1Sn9uu+RKlxX8VUnznfb+0hCJn24i48jkk4uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4ByIeOrucoHrciU9Qb0rVBc52lb77EncTjGevOxdXhI=;
        b=jvFTe1YTJEJ9DP3Z5bOiOZWiw8kVddblpAhHhG+2lsfI5sU7kqg74PmpI6/5C0NcZR
         8tvX2LzXRcEoZAgTwz6SjNSefrihrAPlXcKy6BcD0+Ro7GeupnaL6q4wFYwv42nV4pjP
         HXwG5e7Dh20YDnIGD2gouQzB9NNFiRpS5nnia4ugBx0MuWNHptSIrlH3sexgtnQa+Y88
         oUdFMvPttsH8ZAEjGTcgzW9WUVaAja9NOv3cnIs9etykZthnbgZQNNromd0+EQrtpMee
         9i7ywU5iptdCITYqcwhCRiErCmQwC8J8xXo37/pTF7ncrROkNNGzgAJZ9FNjA9EzD2qp
         sA8A==
X-Gm-Message-State: APzg51AYcthBwFZ/S6Boe8P3O8FEXHfnlB+O2eTwQYt20MgZzOxgMTmc
        OcTzZhgMqlE1NvofUspOc6o6nQ==
X-Google-Smtp-Source: ANB0VdbHaBspNeo8KAgpenyXXAxQoYzrJd/VuKteK0Yv5+EJpKthfu8ScBdfYB1hEpZlPm6Wa8kImw==
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr14818520ioa.277.1537306688952;
        Tue, 18 Sep 2018 14:38:08 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id m123-v6sm5018285itg.29.2018.09.18.14.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 14:38:07 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [GIT PULL 0/1] EFI fix for v4.19-rc
Date:   Tue, 18 Sep 2018 14:36:51 -0700
Message-Id: <20180918213652.5648-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-urgent

for you to fetch changes up to d310959365942b100f79b56bcce859968fe7ca9c:

  efi/libstub/arm: default EFI_ARMSTUB_DTB_LOADER to y (2018-09-12 16:41:41 +0200)

----------------------------------------------------------------
Apply a fix from Scott to make the ARM stub's DTB loader opt-out rather
than opt-in.

----------------------------------------------------------------
Scott Branden (1):
      efi/libstub/arm: default EFI_ARMSTUB_DTB_LOADER to y

 drivers/firmware/efi/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
