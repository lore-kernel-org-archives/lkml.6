Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F968C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC319208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chKVjw2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC319208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeGaQ7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:59:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41274 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbeGaQ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:59:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so14057614ljy.8;
        Tue, 31 Jul 2018 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sIWxCQcNhmHMDRvdWTVb2439FNYZts1ZgsX6p9AdvEw=;
        b=chKVjw2/xgyzSYD7pb8Zf0Cv0Ldhurf0zIp+xdRDUptcua1eaCeqaTwz9NsyVCiO+q
         q+XDthYos0NCZgCbo8LmK4iHzy3qAp5/L2eeeDLqqN6S0C908CAsF2AbaUXlzfgd4UQt
         Pm4KIZnfvvxb1ts/tDMN0KXkjelFeKRhJDukj5zoh+UQo0sz83sigRtycHvjgkhS73sU
         2VHjZGb3MXHd/9+76D4NrsU27qy2BxLS8URIFOTzxVCpsEnCkFJSZb2+UzQYf+M3sS3q
         LndYrpuD5VseYZqqNHPPCA2opOSc3xduUkOq9Y6Xm6IFvBBSNx6G7e/EkGysv6gS7Bp4
         9V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sIWxCQcNhmHMDRvdWTVb2439FNYZts1ZgsX6p9AdvEw=;
        b=W1995J7Ot2aG3L9TbVHKqAa/18WJKRA1AZBr4HPLgBuTx2UtMI8mtZo6TIledXYZ9L
         2hbX0zAN/MJGSOw6LW0hZKOoT+6GLP/n5bYpZ6yMfthNl5bjb5jcfI/kv6sAd7UucoGO
         kW0HVEO1ovVspnDGADc5TTCZ8WxZbTshwcHcdqGvTCB4L8K8AI0AC4wFPK5/suvk+22P
         H1uqIQ6rCW6UUfm3ypbDozCQpz+E7ns5CMRj7wf7C5UlSmy6NMIEId2abfHUBoe/3102
         rmjC5jTLIFRi7DpqmensB9cQKSu5pM0CqmKrvzKwk3WGnttZ6E6UiCJnxa8wJx4L+dzs
         HYtw==
X-Gm-Message-State: AOUpUlGFfgin10xX82nok0MxK5nQqBDJMAHNNv4iOAM7Ky//Ch9fae+X
        28TjuqGzBeR7X2sKbsFMDHIxNwCG
X-Google-Smtp-Source: AAOMgpdR7wUCKkmtv3jpHuO2KIh+DpDUHwZbTRevCbvVcCSpQEGwgF8YrgEo5xJKEWA18PkEpX+BwQ==
X-Received: by 2002:a2e:1b83:: with SMTP id c3-v6mr15945669ljf.0.1533050300476;
        Tue, 31 Jul 2018 08:18:20 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-173-71.play-internet.pl. [94.254.173.71])
        by smtp.googlemail.com with ESMTPSA id p88-v6sm2606209ljp.90.2018.07.31.08.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 08:18:19 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 0/3] Input: atmel_mxt_ts: Add support for optional regulators
Date:   Tue, 31 Jul 2018 17:18:08 +0200
Message-Id: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds optional regulator support to atmel_mxt_ts.
First patch adds regulators to driver.
Second patch ensures that device is ready for communication.
Third patch updates documentation.

Changes from v2:
  - Add reviewed-by to one patch
  - Move code for enabling regulators into separate method,
    to make code more readable.
  - Add wait code, to ensure that device is ready for communication.

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get.

Paweł Chmiel (3):
  Input: atmel_mxt_ts: Add support for  optional regulators.
  Input: atmel_mxt_ts: Wait for device be ready for communication
  Input: atmel_mxt_ts: Document optional voltage regulators

 .../devicetree/bindings/input/atmel,maxtouch.txt   |  8 +++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 76 ++++++++++++++++++++--
 2 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.7.4

