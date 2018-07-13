Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A14EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD5B2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S42qhvIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD5B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbeGMSqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:46:19 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:42396 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMSqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:46:19 -0400
Received: by mail-lj1-f172.google.com with SMTP id 1-v6so25155306ljv.9;
        Fri, 13 Jul 2018 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VHVX5vm/OsoHLUF87/Oha94rXcySAAw1odTPT/HA8JQ=;
        b=S42qhvIY+TOzyjG3oXMmy2La+rr7yo6HSe39own4AbLuysGBa72b/tbgCgBv8m8SYF
         bbeCeTkO9CS+TthmeITgvaEU0sJfhYZ1iE46Z1Uadg+aVk/IPVHfDbjoq+dcQxedGf+k
         GiYxzF/y6iJuT8L+uOhxsMvc4Kp8ZXM+ILeG5FT39ihUPZ1EJGfqjFNVrBp5MA58fcxf
         F94kSOSxjypX2xuW/briWZN7bQXFlS93Uz9LOTqiUOl4Nec1YhWWvtpg6pISpSaTzAid
         fP83TOzymGCL+r8B0O8omZii2zzCY1YLd40mflIbXRyNhChnHWE31II2FKM/xGmOw5d4
         d9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VHVX5vm/OsoHLUF87/Oha94rXcySAAw1odTPT/HA8JQ=;
        b=jQDKQVMQcGfGPkhPQckuTXXKEeCJ0ZLpvv0M/Dc1B6fuia2wRfMaVkxZBgC8y8/DzX
         VDdjRxAEFRQYIeOKrFpUeipzaIOY3rqMDojSRzWrAl6xiuJKn6bTyu3ms8j/xTmcTvjT
         fs6ee8Sw0/oWRpj7R/0JeEIkWadYgoyaAY65W6WQK16HCAK4LZPPEIiLoG+hkLR+SsTe
         phu4ZIHWYV8h1lrcqEvDbHKktnwDBMgVujX5Xe0l9l1OzlK1iWPICQ4iitbh/FX6Fvr7
         ZmcG/gqwkIfao3cfZMn0qEEHxhzcWZAcQdjOBPEmc7xvzOZkQkR82YUM+QIS1kNrD+Ai
         A00g==
X-Gm-Message-State: AOUpUlEhss6w51SsOxEadXL7BlfiDU98y+jCwIDC2Ybk0kEOYNXqppEd
        GEqahpfVHzmXbu9rTWCCQsw=
X-Google-Smtp-Source: AAOMgpfyRHb5lEBIFVb5F21pe6aVyBX/HGESBSiot+bzXoYidWeEVnAz4Gjs7V8f9R35aENf9VyT4g==
X-Received: by 2002:a2e:60:: with SMTP id 93-v6mr4114425lja.96.1531506630345;
        Fri, 13 Jul 2018 11:30:30 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id j12-v6sm491268ljh.13.2018.07.13.11.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 11:30:29 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 0/2] Input: atmel_mxt_ts: Add support for optional regulators
Date:   Fri, 13 Jul 2018 20:30:06 +0200
Message-Id: <1531506608-24479-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This two patches add optional regulator support to atmel_mxt_ts.
First patch adds regulators to driver.
Second patch updates documentation.

Paweł Chmiel (2):
  Input: atmel_mxt_ts: Add support for  optional regulators.
  Input: atmel_mxt_ts: Document optional voltage regulators

 .../devicetree/bindings/input/atmel,maxtouch.txt   |  8 ++++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 45 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)

-- 
2.7.4

