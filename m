Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D9CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32A22147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="0McvXsgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfBTMUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:20:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37618 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBTMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:20:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id z15so1135793lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Hz6NNP0/DGkTyzPNqe9pbnUxKNZhS95TnvhBzEIF0U=;
        b=0McvXsgxn6SRU3MN1Ucmy6S9Yso8I1yCtpAZcEIVbcY4R8t74R2Eh6kbtnLlHMnSIV
         lO9U9a8vvIizfhAqFCQY0p8kg2aGeb6E9guh6KfJclBT4/Rxesy9JuesPE8lyMbxaePz
         j0hpWVxKXp9bdv7049dIgSb7f5L/1r4lRKkAjSAw9Azm1iFr6ZrZN93StI7KM3XoWb/3
         +fiHkdmWayCGPILNEO0qTZVOyIdkbP5YoEzku4I1+RBIb4jQD3nObvZ0arS6j8flkq5q
         +0DHzLzW2fm2KmFSLyH+LPFFYRWA4hfONY5tQzCrXyX99ZmOBGcf01ZBWqxNCKX7bmWq
         NaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Hz6NNP0/DGkTyzPNqe9pbnUxKNZhS95TnvhBzEIF0U=;
        b=FhRPUkLRorGvnyRMAJmKAj8sZRclZvxREQlQ2tJXLq5lbHQAvYuB7m3bO91fihsmzB
         UEmKYK1SNpr4FOuOwO7Krfm4ANY6AzWTWpVEDe/cQyh7iFNYesjNLneSsrrkuqKS3fyp
         wCOU3lNZUkYVvNAOFaQu/gINHVSgk0Lu0fHVL7E67XbC3KZEFNOkdfZgiy5s1RQcRzXV
         9w84CYv/eI+4uW0Ood+YX06kCNQXjflW5hlPuAMiTYB7g9dLbK+bilrh5ykBh1SVx5sB
         I566HLhAGas5LBRg7ayyGGiDR3J5bGQK7LPg/F4Q8mWIayGJmgvGQbBpDpW2uafX20VL
         y6hw==
X-Gm-Message-State: AHQUAuat+czGN6AuBdOd/Lynt/y2no8WfwsJ9npz4vlx/Ims7ELs8utR
        +01k30hVyGB92Di3TjnQiBG38ClDmF8=
X-Google-Smtp-Source: AHgI3IZHwQsn1TKl/gRu6gSGCU0Ol5OAhgkuuUmPFybRLQwK3qqxV5Yzs1BD63XXBoPBFGzxfig2FA==
X-Received: by 2002:ac2:4282:: with SMTP id m2mr1520430lfh.141.1550665214155;
        Wed, 20 Feb 2019 04:20:14 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id r2-v6sm5270270lja.78.2019.02.20.04.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 04:20:13 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 0/3] usb: gadget: atmel: support USB suspend/resume
Date:   Wed, 20 Feb 2019 13:19:58 +0100
Message-Id: <20190220122001.5713-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series hooks up proper support for USB suspend and resume to the
Atmel UDC.

Jonas Bonn (3):
  usb: gadget: atmel_usba_udc: simplify setting of interrupt-enabled
    mask
  usb: gadget: atmel: support USB suspend
  usb: gadget: atmel: tie wake lock to running clock

 drivers/usb/gadget/udc/atmel_usba_udc.c | 84 ++++++++++++++++++++-----
 drivers/usb/gadget/udc/atmel_usba_udc.h |  1 +
 2 files changed, 71 insertions(+), 14 deletions(-)

-- 
2.19.1

