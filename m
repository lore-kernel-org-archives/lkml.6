Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B28ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD1A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzkoq3cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD1A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGQSuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:50:25 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38430 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbeGQSuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:50:25 -0400
Received: by mail-lf0-f68.google.com with SMTP id a4-v6so1539863lff.5;
        Tue, 17 Jul 2018 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CvNnfLWCqYNeIcUT2xixkxWSw/wffCJt1xoSRZ87wRU=;
        b=qzkoq3cKPJ51/NxtW9nH7gn9o+tB29LMnNZ7n4qVi8bJllecWgCKlt3I9CBPbutSS7
         WFGSRzMnXveXQiYWVajn4WeEBwZ/CPJnXXWG8cbi8/67tNyY9IWoiWBuP0MshIlQkQYo
         me3jaxfmakJW4NNH7BQTIDmSbFsfs89JPN1Q+7xaEUCKGIxZL3aW9IpjR65zGQT232E3
         B/5Ds6f7DzppuBFXSlkT+QrUVKrix0IZ5kf51zn3Bh0mRD7MENDEP5vl+YnF21l/UlC0
         UzAdDH25OU9IFcfp9iA/lJdpKAeVd6is4POYXP42Dgv13B5thVZ4s7dUzpmycjOiAV2p
         GrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CvNnfLWCqYNeIcUT2xixkxWSw/wffCJt1xoSRZ87wRU=;
        b=DSoUB+MB94Yw7yZB3WO6q5TMxxL0DnKHFdHkX38kDg39SBNUDTKE11sjNRZIjUPaGy
         Zyf4317Ejiow7m9sqivUY2jNo/K0qr53U/jnmZxiXJB5uDetQ/8JGqAM17iTXzhHabyD
         0i6sXD0K4MyEcxVJaxvLP6yltPlP53AOlUHoGxZJu9zwsekIlLzWh67+TGnZxm0f7Ojy
         T3CbWYgYnCtX5xOpqr2tpv25PiEs2GdnConPFewvJ7RqPmLbqzQNOi4MbObkqm2sdOSH
         otTPPTOBcgUcRKcPTPaSky9CaGODVoDYYR9hKEZJapg5tsWnRmuZOtuq86SDPMrMmB1c
         hbRw==
X-Gm-Message-State: AOUpUlHU2UptAMyza/uvdtwlEq5HvrjTwvk9HFf/QioOw7axp1oK99di
        ofLRE6sjQinSCzSbq2Loc3k=
X-Google-Smtp-Source: AAOMgpfmqc1zSiJzozkhqT+BMmYdHr9tguysF9tjCvxIbekSSbegBaYQI1EY2MwFcFse7N/xGWmTDw==
X-Received: by 2002:a19:1003:: with SMTP id f3-v6mr2014974lfi.116.1531851394309;
        Tue, 17 Jul 2018 11:16:34 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id u19-v6sm260911lje.51.2018.07.17.11.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 11:16:33 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 0/2] Input: atmel_mxt_ts: Add support for optional regulators
Date:   Tue, 17 Jul 2018 20:16:24 +0200
Message-Id: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get.

Paweł Chmiel (2):
  Input: atmel_mxt_ts: Add support for  optional regulators.
  Input: atmel_mxt_ts: Document optional voltage regulators

 .../devicetree/bindings/input/atmel,maxtouch.txt   |  8 ++++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 46 +++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.7.4

