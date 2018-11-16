Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E473CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1772086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXKd/0Xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1772086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeKQJBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:01:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33264 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:01:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id v68-v6so12065668pfk.0;
        Fri, 16 Nov 2018 14:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AsXz0h6YmLD89vE09fzjRHMErhEC2L65Q2l0CMr+qu4=;
        b=tXKd/0XusdWXGWNu3ZmXrOHoEXseNMmbXrUxaonTH8VCbubkxvJzNL56jCg8KTwJlv
         kXS7zXHbwPqrKdpR+zwZ5R0QE/z/wWvMQi7ub+/sgT7i0kEFRDic9B15u7XzA/BMbpny
         CAIbRah9AtLZ4mgrBTDnTzmeH4EtHNW1frIO6CJsyFi2rX7w+KE+wmI3r1Uu+rer4Peg
         F1pA9Vn1DD/AMh4LxUNDdTw2MdtJrRhihc8KYi6HWJ9aZZvHBGKzOFYPt1tXAU/KHCZP
         /g/tqhCYTI1oMxBKgNJf4u36hc3wJIgQu0LGsXk5RDucAMar0zDATCBRK8zBmdoPNmJg
         yPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AsXz0h6YmLD89vE09fzjRHMErhEC2L65Q2l0CMr+qu4=;
        b=ZJOmCdXanCOa2Kx4ROqTPZQT7K9JRy0KFhry+iuiYj5aOrGq6YHmvbW2M9hgIblkce
         moA5JNEksqaVa/RiXErQ/eYf6nC8YYfiYTV4MlRK75ieC8wY+1qLeBKgGLsi5QLq/E+Q
         /rQZYSbHc95eRxJfZNfLZODUkeGUKZ2QGMKtTEhQ9o2FSj9xkiCYo7mJ9oJnoKRzwVTO
         bBBdLptX8naiPjvzTswhtTjSqjYDX60xovqG3i4HlN/sFfnrb8nWd474YpSNNhit96Q5
         uV8HQ12II0St9gJ1v3H8oR7KjReZ6laLBvfz8/5LIudq4x194lSC3kQ74WcVhiUttaDm
         P2RQ==
X-Gm-Message-State: AGRZ1gIRBrZxbnH2K0pq3SWGuRdl0mqYGHuGMAGze01zRdl2skLZPzbX
        K3oZlb3c3e+Gr5uQYOdseo8=
X-Google-Smtp-Source: AJdET5djmhbYhAm6ZK/8yiy754bwQCiANNzAvuYUpDc8yBGPn/FuRPqpg1gYLB7IM4DCk6mn7S27RQ==
X-Received: by 2002:a63:b34f:: with SMTP id x15mr11821804pgt.243.1542408429964;
        Fri, 16 Nov 2018 14:47:09 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.154])
        by smtp.gmail.com with ESMTPSA id p11sm26282018pgn.60.2018.11.16.14.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:47:09 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Remove platform data and introduce DT bindings
Date:   Sat, 17 Nov 2018 04:17:04 +0530
Message-Id: <20181116224704.24294-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces device tree bindings for adt7316
driver and removes the usage of platform data from it.
Also, it sets the data field to it's appropriate value in 
the i2c read function which was nowhere being set before.

Shreeya Patel (7):
  Staging: iio: adt7316: Set the data field
  Staging: iio: adt7316: Add an extra check for 'ret' equals to 0
  Staging: iio: adt7316: Add of_device_id table
  Staging: iio: adt7316: Use device tree data to set ldac_pin
  Staging: iio: adt7316: Switch irq_flags to a local variable
  Staging: iio: adt7316: Change the name from irq_flags to irq_type
  Staging: iio: adt7316: Use device tree data to assign irq_type

 drivers/staging/iio/addac/adt7316-i2c.c | 19 +++++++++++-
 drivers/staging/iio/addac/adt7316-spi.c |  1 -
 drivers/staging/iio/addac/adt7316.c     | 39 ++++++++++++++++++-------
 drivers/staging/iio/addac/adt7316.h     |  1 -
 4 files changed, 47 insertions(+), 13 deletions(-)

-- 
2.17.1

