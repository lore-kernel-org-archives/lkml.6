Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD05C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269312077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dILAbcKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269312077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeJNXBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:01:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39423 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeJNXBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:01:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so18366649wrb.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gdhl3XQ2aB1VN8fBtqDa7YLxj47Y/0/I7yKKyUjGXmg=;
        b=dILAbcKLJswwBh0APADRznmyvV0MoveAHgRniAcv6uv9Bicvje5f7rBfaTwrhR+at1
         BecPskt6BnpZ7L5jlzrPsUPqZWP8ooq2adxmO2R/jZBy4jPFQAHyk3akJ1QGKXwcekMR
         huFYn4KaRyayQBMlvEyfyRse3XaxPri3Tid6U/TeNJRTYDeQtrXweHb7t6HqBxWuF26y
         A85mot6uMEE3jKabPP3tNNQmZDIcUE4RVf0LZ7TXCWI7NnynjIIaqscudswR5SS35srA
         T623tuKmNIJTy9WRXQRX4R1uvoaWCf/eX4NZICvYyEfvHlEL+JhbCgg2Q7F7Ae4pd9m4
         POSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gdhl3XQ2aB1VN8fBtqDa7YLxj47Y/0/I7yKKyUjGXmg=;
        b=dOs1q3+DiVi7uGKSOTJH9sQxD7OjlOCBD0RVywztMmkkqpe+QiimlHa7odsNuI1IeB
         1WYzazpVq9i3bDKr4n4M+t+YPiWTmRc3T87i0yCuGMrdO0rhGXqrp3MpMSbGkrx7pN/I
         CKHqydjR50pYmDhS7Fh4ePmEtSqkAxHhqeVw3TPvoIMMw+j4zfbdOXqOOAhDNcxjlnyR
         Hu50ajL4VMscGahEgPRkJnhDNgW2VrsNRs63ubCKaewY5QDLmMreTY8kYdDU5ThX2969
         3HSG0xxeN8XZEydiHG+veHn37CMxaF3s5sjto0sX7s0zeADpu4IRjTtMsgyo38YmnKWB
         Y16Q==
X-Gm-Message-State: ABuFfojTtrtkySWvR4f9bs95oHjyjYrwpOYCC7P3tG7UmkGqbDOjOQJZ
        MDM7HKP+Yvkw7GbazlstKQ6huvDAer0=
X-Google-Smtp-Source: ACcGV63/5icybKhJg6CCt4EeuIKdKa7W6HqJHK6KU2HATIZiS7yl+21MEftJTi0H4Xva06U1WZK++Q==
X-Received: by 2002:adf:b109:: with SMTP id l9-v6mr11130740wra.101.1539530419089;
        Sun, 14 Oct 2018 08:20:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b139-v6sm14789830wmd.36.2018.10.14.08.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 08:20:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH v6 0/4] devres: provide and use devm_kstrdup_const()
Date:   Sun, 14 Oct 2018 17:20:06 +0200
Message-Id: <20181014152010.2021-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

this has been reviewed a lot and three first patches can be picked
up. Please take it through your tree.

This series implements devm_kstrdup_const() together with some
prerequisite changes and uses it in tegra-hsp driver.

v1 -> v2:
- fixed the changelog in the patch implementing devm_kstrdup_const()
- fixed the kernel doc
- moved is_kernel_rodata() to asm-generic/sections.h
- fixed constness

v2 -> v3:
- rebased on top of 4.19-rc5 as there were some conflicts in the
  pmc-atom driver
- collected Reviewed-by tags

v3 -> v4:
- Andy NAK'ed patch 4/4 so I added a different example
- collected more tags

v4 -> v5:
- instead of providing devm_kfree_const(), make devm_kfree() check if
  given pointer is not in .rodata and act accordingly

v5 -> v6:
- fixed the commit message in patch 2/4 (s/devm_kfree_const/devm_kfree/)
- collected even more tags

Bartosz Golaszewski (4):
  devres: constify p in devm_kfree()
  mm: move is_kernel_rodata() to asm-generic/sections.h
  devres: provide devm_kstrdup_const()
  mailbox: tegra-hsp: use devm_kstrdup_const()

 drivers/base/devres.c          | 36 +++++++++++++++++++++++++++--
 drivers/mailbox/tegra-hsp.c    | 41 ++++++++--------------------------
 include/asm-generic/sections.h | 14 ++++++++++++
 include/linux/device.h         |  4 +++-
 mm/util.c                      |  7 ------
 5 files changed, 60 insertions(+), 42 deletions(-)

-- 
2.19.1

