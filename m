Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387C5C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BD32080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="EAruKCXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfBEJsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:48:53 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:51680 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfBEJsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:48:53 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from localhost.localdomain ([1.128.190.166])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id x159mCMm027133
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 5 Feb 2019 20:48:30 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1549360111; bh=VHrjZRA03rUOZJwg9H3fp/uIvW5e4VWC0K/L+S9NChM=;
        h=From:To:Cc:Subject:Date;
        b=EAruKCXkzK0e3Rdd2V8UJvJtT1PW4k2AqaYTvt7CYKppgRiZ155VK4WYEhtwcQXms
         1oWF7wWfSY+7vH1YpDg4CO3NKZQhXQ1Gto6UDU7XnnknIoK42QgSXcOxDCI+FEtfYo
         aYitJx16mfC67WCLV0PFHt1DrPDqVSen4eGmOeE5ZfnaY0ivoLAAP+oEohpdFtS7Vk
         T2MXCxPrSOGjj0XxRZ6ScJr1NedjXC/sziE4O2sLI+aVo+xUgOcVql0SYvNq8WKe27
         URWkOGwNIkf4HXxtZN37FYBs2f4ezT577SVq8qeKdZq3qC9qjWXcHKHkCL9GFErgeD
         e9l34ccwTrrHA==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tom Burkart <tom@aussec.com>,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH v16 0/3] PPS: pps-gpio PPS ECHO implementation
Date:   Tue,  5 Feb 2019 20:46:32 +1100
Message-Id: <20190205094635.1765-1-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
would you please add this patch set to the kernel tree at the next opportunity?
It has been Acked by Rodolfo Giometti, the PPS maintainer.

Tom Burkart

Tom Burkart (3):
  pps: descriptor-based gpio
  dt-bindings: pps: pps-gpio PPS ECHO implementation
  pps: pps-gpio pps-echo implementation

 Documentation/devicetree/bindings/pps/pps-gpio.txt |   7 +
 drivers/pps/clients/pps-gpio.c                     | 153 ++++++++++++++++-----
 include/linux/pps-gpio.h                           |   5 +-
 3 files changed, 125 insertions(+), 40 deletions(-)

-- 
2.12.3

