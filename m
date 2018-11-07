Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD90CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5DA20837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMRSynpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5DA20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeKHGQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:16:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45362 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKHGQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:16:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id k15-v6so15876140wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 12:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=xM/gbWN7hEiZbkL0SeP476r6S+Lme431KE+i5Zq7sEE=;
        b=TMRSynpTCKHSNx8igBl1pnKbrmpbz2AaFSftZaPARU1qGpBvQX9xqKLAtv2wEgK5cS
         xX6tBW2LQgT0B/PnuRSlL3eLaykQ7OnkJvmXdKzlm6BWW1GOu5B3r5FlHNE8ELLOfr5x
         XrjZYw0BPX8vuCM4WprKvpikWv9VpPwANJ1hKZuuBZWJ2ISM15oGkETGU6FcdtiueZY2
         VkvASzpggPLOKn4lI7CfYQrw953jgSKzOsRPG242o0dzs4jayRBNwTu3cedKevRMYGJy
         NgDHBtoW/jHJpPy0neqWAww6xuqMiVHxaWhtZWBfBUyJlIr5vCbv96gGdsRPVLcnoEZV
         igag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=xM/gbWN7hEiZbkL0SeP476r6S+Lme431KE+i5Zq7sEE=;
        b=Ziaviqce1cSpPeUJfMG0lMYmsXlUYPX4us0P7wyJwAqWFHpXWYiOevXL2BYYLTNz49
         fwVKkDC+wG37Nc9duydKce+hk0TIQSY0EftmDOLU7nHp3wCaFuT33TTqiH/MX6nBev9x
         kwqRD7BoqRPHhB9xbpmevke4fKzDRcKPDfZSVFgkC8L6hu57g5ZL016VilHYhCUVzsEB
         GDom1VCGW3c18fb+G4l4+vFWSeYE4NQNGMfM47lR7h7mJh2eyoiMKW2yiXCjuPRDSOx5
         5FO5wrZm90KFDpxCG81vOSUYeX5AM5pqros03Yvww7TpweirzndntvquFOopG8eeVezZ
         jYdw==
X-Gm-Message-State: AGRZ1gJpPkaXfCFhNwtU1Uqv8DIWjdedGpmkaa0pgvoqyqt12NanPH/N
        ZkXqGLUujHFtZk5ou/PIOLg=
X-Google-Smtp-Source: AJdET5eERL5b9fwKnw5WjFUrkoV+6gfjOo6G2AT+Ln1pp2BE16oXzl+3D0eArZEFQpimdjgpC7tAWA==
X-Received: by 2002:adf:84a4:: with SMTP id 33-v6mr1594307wrg.191.1541623476643;
        Wed, 07 Nov 2018 12:44:36 -0800 (PST)
Received: from osboxes.localdomain (bzq-79-178-252-231.red.bezeqint.net. [79.178.252.231])
        by smtp.googlemail.com with ESMTPSA id y2-v6sm3578764wrh.53.2018.11.07.12.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 12:44:35 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, gregkh@linuxfoundation.org,
        natechancellor@gmail.com, chrisadr@gentoo.org,
        areklis909@gmail.com, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: emxx_udc: Fixed all meaningful sparse warnings
Date:   Wed,  7 Nov 2018 15:44:21 -0500
Message-Id: <1541623464-49041-1-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes all meaningful sparse (running make C=2... ) warnings. 
The number of warnings is reduced from ~280 to 12 (only warnings of type 'expression using sizeof(void)' are left). Resent the series to Greg's request.

Carmeli Tamir (3):
  staging: emxx_udc: Added static modifier to udc_controller
  staging: emxx_udc: Added missing __iomem modifier to handle p_regs
  staging: emxx_udc: Added missing le16_to_cpu conversions

 drivers/staging/emxx_udc/emxx_udc.c | 68 +++++++++++++++++++------------------
 drivers/staging/emxx_udc/emxx_udc.h |  2 +-
 2 files changed, 36 insertions(+), 34 deletions(-)

-- 
2.7.4

