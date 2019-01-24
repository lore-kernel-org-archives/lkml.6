Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40968C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD7A218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXVaK32V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfAXXWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:22:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37387 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfAXXWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:22:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so3357051pgb.4;
        Thu, 24 Jan 2019 15:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sFCryOBLmr8CfzbPNIAHf2uPCMEyKYNi673kD/2zNuE=;
        b=oXVaK32V02eacmfR8SAzMLu8mpmjsN/yxWsGnmZbj6UWMl2D//enwbXLSNzXFvlqpD
         4Gyw9a7SfJDnodZkR6a0Zf26ZSS6uCzAGeL+txT6ytX/cAxLd0goZSvLqXAxL44ntw9Y
         BjIFhe1g6Y4ES3kdtmuvFJe9crG/5cimhUN9pDB7JdwU/J5Y8oBq+QLyKn71A4U5K5TI
         4Z8ibH233hxYXYAIT4nvqKZidLNZFJmKzIg6+oSq9asps/+mUye86p/bzzzUK4ulcNVh
         el+i97AtZUaHJe4La3EAGnqsfCOB3MUvgHDFbP20bz03NZtAgvNZENNdMHDoSy1gxJMq
         8/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sFCryOBLmr8CfzbPNIAHf2uPCMEyKYNi673kD/2zNuE=;
        b=n1geHfV7o/8Qqcdcub9S8cCDeow1TWaC+C1qhbI5l756UxvdqV2E5/om+R6S8EgpXa
         H3zi/+HUhxAVDZEUgQV6IYvVtRn9tLOW8vUr8LuBQWySIjudXsAv5R/N6TbNWOqQSmxe
         XevZa/nhR6rNdFIGO6u4cFEkoHCqqy4iWqLvSCcCyCK3V2UXDtb38M7kCRLM4j25GWyK
         dpkE39W8f0DegZoYF43r+7bYJPg0xHChAquOjvcLWqSNce6wqUUjp+fvaGyGMqVYuAdu
         QOfFsOKzETQDO2fkpkp2O9MFGazFYwC01LR1u8oUVgf95EyPjOoVMfa+RzteUdK9ecQg
         sFQw==
X-Gm-Message-State: AJcUukeIJb6qouomqLMyrK8Dv+E1ijnnQTMZSsTLBox9Flz+MsEIZja4
        CKMIMcY+UhV3H953HSKbRSs=
X-Google-Smtp-Source: ALg8bN7Np7aZJdQ88Lj7+nJvhxKD3b/XmmQa4tfya8WVxW6HGfSRhT5YkSUbYeYURVFoIUZQqcPPEQ==
X-Received: by 2002:a63:a553:: with SMTP id r19mr7727763pgu.53.1548372171434;
        Thu, 24 Jan 2019 15:22:51 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id g15sm95216217pfj.131.2019.01.24.15.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 15:22:50 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] of: unittest: minor cleanups
Date:   Thu, 24 Jan 2019 15:22:12 -0800
Message-Id: <1548372134-15729-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

1) Suppress expected error message when adding unittest data to livetree.

2) While writing patch 1, noted a misleading function name.  Add comment
   to the function header warning about possible unexpected results.


Frank Rowand (2):
  of: unittest: remove report of expected error
  of: unittest: add caution to function header comment

 drivers/of/unittest.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

