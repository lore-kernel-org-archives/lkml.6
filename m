Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E288DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E61204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxK6I0FP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E61204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeKBG22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:28:28 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39954 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeKBG22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:28:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id f18-v6so13722197qkm.7;
        Thu, 01 Nov 2018 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mZQPhMbuiKPKLa3SsVx7RfxkvjitF2oH+HrILE03B+Y=;
        b=gxK6I0FPlUhHqdpxvvLQMEbyNLZUZo4779MrLzODHlsxTc+5EKYHaJk6PwuxzuwZ9t
         1sAXJhkS628xI/OP3HQkZpVzUZlH2LL47x3YwjLqeTVAjW2+Urt7/+wUXZhDSHerji1n
         EfEhnXfYmQMzsohFnm2tgYF/r+b0ZFPu5GoBp7tSHEeKwrEOMfiPXlNoCBndr+kDtnpu
         b3Nc3xvu6n4pjIj0MCbTpfdcBZFusJp+l7stXqnNNJi8DBeJwYm9QWyq3iiuuQoGXdpA
         RTwP+Gc7YxnoBTbt/yoJ54ofn/jnR6YDlrXmu+tIJ8Uyj89KqXzn2G8l5zh4YHAvvmGS
         GLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mZQPhMbuiKPKLa3SsVx7RfxkvjitF2oH+HrILE03B+Y=;
        b=KOUptGKqDkArYTrW+YIIqVtkjfWnR2d5Qpeoy7cs42ZTsMF3cRP2DX2n+8DMg+G03f
         amxgaZqTNnZNoAc6VV/4HMUXMyCOZOpOGHAYPoYAIzFkpQNXrzugEFbq4bG7/bDmxSbg
         jfZd4IDVPBMVRyLkZY4AE4/mjH1GeCciEVJ8LpYq24wbQM9l8P4T38dG9aq4+BI/YUWg
         5OkL82YpsuaQ0NHWTo6bZeICsz0NgH3xHkNWbxfUz75QwGcIyRYcdeSLNCSVNuwMcUex
         CHbGu6INzhCKawSxZircMnho1CaTw7KO1k/1sH1CWBmRWHDxKrytJdnagApYa8o1WHGw
         bPdA==
X-Gm-Message-State: AGRZ1gIXiGo3v2kd3Ry4o4l5atImriq7lBLi1K0zGFLvWeNL1CiPBClk
        MZg4pA3w89lZ1rofA3yJwPMXCta3i8Tf1NxX6A==
X-Google-Smtp-Source: AJdET5ewc25TjJddEl/n6x1T9eLzVwYifHaNVVeaEuHr760Z89SXZcwDfcvAxIkMbjToDlW/NpyodqTP17WGwfDDhM4=
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr8140886qkb.326.1541107426743;
 Thu, 01 Nov 2018 14:23:46 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Thu, 1 Nov 2018 16:23:34 -0500
Message-ID: <CAL_JsqJ8tAUbbHp9Ymu3gsfSGSK=qgPDofxA9yH8T9k67QjPNQ@mail.gmail.com>
Subject: [GIT PULL] Devicetree fixes for 4.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of fixes for rc1.

Rob

The following changes since commit d061864b89c3234b53d8884027b0cd6f06bd3149:

  ARM: dt: relicense two DT binding IRQ headers (2018-10-26 07:46:32 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-4.20-1

for you to fetch changes up to c961cb3be9064d1097ccc019390f8b5739daafc6:

  of: Fix cpu node iterator to not ignore disabled cpu nodes
(2018-11-01 16:16:54 -0500)

----------------------------------------------------------------
Devicetree fixes for v4.20-rc1:

- Fix cpu node iterator for powerpc systems

- Clarify ARM CPU binding 'capacities-dmips-mhz' property calculations

----------------------------------------------------------------
Rob Herring (1):
      of: Fix cpu node iterator to not ignore disabled cpu nodes

Viresh Kumar (1):
      dt-bindings: arm: Explain capacities-dmips-mhz calculations in example

 Documentation/devicetree/bindings/arm/cpu-capacity.txt | 8 +++++---
 drivers/of/base.c                                      | 2 --
 2 files changed, 5 insertions(+), 5 deletions(-)
