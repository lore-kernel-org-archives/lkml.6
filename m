Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED09AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A806D20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksO+4op0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A806D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeHaX3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:29:43 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40033 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaX3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:29:43 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so15765656qtj.7;
        Fri, 31 Aug 2018 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RmevfmgB7VSCZ1jzSodnoqr52FqJ2xAyUY5f50FO8Zw=;
        b=ksO+4op0oAjrY2ri4v/3BPSeO9E3d8whsIQUqTeTN5lURZl2nNBnGg1mwnWaSXXU1l
         M8SsmBwsCbZRuglY7iEl7B8eBKJgQZmmETzp7sfNEBj5txM3IYNs10KNsXyXEzc4HOBs
         kqEgkKK0wDZyPhddCMzJRYO9K1K6ZWHU1b1Buv01SefndBDnbBp+V6bDaUUGgIMoYIiT
         YWcc7NI+n8ibjOG26FVTtdXAO1GbfshA5rqkQGvsoFq8+RN2VubZ/cECngGXqTHDCHZD
         weoghYWp+jtML0nzr3wIIBmw83FPnzhSrsv3i5AlnhjGt525lmW5frEjZGpm2BPRE724
         yUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RmevfmgB7VSCZ1jzSodnoqr52FqJ2xAyUY5f50FO8Zw=;
        b=E1XK7WfQsdHUwI0qSk7Z7ZNm5wchmiOO8s3xRAv/DIeVMmWwQZ93uJkUuNfcTyukoR
         cRv2eWSRjDphgwNLwrpH1bLiEEHlXQUweYPsLLlO7SWaF7aoylfpdqz3H33vqnL19po6
         7Q9qi5YBu8kop9v4ZQkIbE3wOk8FDp0hppyrAWQyzfALtYb9TD+9YWFIeyaYcaDptw+F
         OSjxpUMd/tNWLFWZ2ArwEFNhtXEiskkknhQjAL+Gb6ronwRJNkbKPDDLvDcPwHetidPy
         bEjZp5OIpb1hjDfZnCsBuyOzxdOddouyyult77k+exI0MOf3dQsaNi/Y+NzieQNjS7Lf
         WFhA==
X-Gm-Message-State: APzg51AHqs0sTQuYjJmS+e5n1Vn7BJkEGVoTJELEHvlVjpbkxcHU/R2+
        3yUDuqu9InlGbV0lOVEBays=
X-Google-Smtp-Source: ANB0VdblO8mneKGNbCdxEbIQ/ygfKg2b6PQgJyyYSGmDAplCcvC97Sv3vJKVQQAg1I/OrkdsHvxNUQ==
X-Received: by 2002:a0c:983d:: with SMTP id c58-v6mr16692026qvd.221.1535743249584;
        Fri, 31 Aug 2018 12:20:49 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f53-v6sm6949160qtk.40.2018.08.31.12.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 12:20:48 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        andrew@lunn.ch, rmk+kernel@armlinux.org.uk
Subject: [PATCH v3 0/3] ARM: NSP updates to support switch interrupts/SFP
Date:   Fri, 31 Aug 2018 12:20:36 -0700
Message-Id: <20180831192039.11842-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series updates the ARM NSP DTS and BCM958625HR in order to
support the SFP connected to port 5 on these reference boards.

I will be submitting the functional changes to drivers/net/dsa/b53 once
net-next opens back up, but this is largely independent from getting
these 3 patches out.

Thank you

Changes in v3:

- changes i2c controller node name from i2c to i2c (Ray)
- updated binding patch to have bulleted reg-names and interrupt-names
  (Rob)


Changes in v2:

- added missing managed = "in-band-status" property
- reworded the commit message to explain the limitation of i2c-proc
  is of 63 bytes per transfer, not 256 bytes

Florian Fainelli (3):
  ARM: dts: NSP: Enable SFP on bcm958625hr
  dt-bindings: net: dsa: Document B53 SRAB interrupts and registers
  ARM: dts: NSP: Wire up switch interrupts

 .../devicetree/bindings/net/dsa/b53.txt       | 36 +++++++++++++++++++
 arch/arm/boot/dts/bcm-nsp.dtsi                | 31 +++++++++++++++-
 arch/arm/boot/dts/bcm958625hr.dts             | 26 ++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

-- 
2.17.1

