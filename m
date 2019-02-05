Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A19C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56ED207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZVMJaaet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfBEOAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:00:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43332 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBEOAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:00:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id r2so3697717wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 06:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5eNv+ntw0bTMoVWhK9FZ9KTV1vVRd7PdV0aALPgY7II=;
        b=ZVMJaaetXTOkDk38wy+qAwRpdDk3uGuaerTaMwClWie02sl8P00etI/5M6wOcar9Sq
         R/SlZ5/cyGtK0Jf1CnQgkTtKmuGDe5AxkmN1qQk71D/EeZq1Sc69EcFaI1U/GxP0xeLm
         84oKRS3hdfHIEcsua/hVhkh7KFOeo1TyMjC+GPX1M5cHqPkVMazWRiKX6verZSoMYNVU
         rID7RtViJPd6eaymLO07RQ+ZnHmOZc5OeUv9kROt6JIgn1z3gEiz2wO+qYRiy9tqDjwn
         XTKzyXqyjDHYPWjhKzDzZ2X3AoP9VnJzYkOiedGLHT3CfpzkR8L33IsOX69mB4IUfWRS
         pN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5eNv+ntw0bTMoVWhK9FZ9KTV1vVRd7PdV0aALPgY7II=;
        b=GM4Yf7Jbn91+f0snBK4+mHjcDr/2qiuc9PKFfoceqX+e9xaq+iGdtji556gg8Uq0tR
         nNXwr9dd2zz0sed7MBANIprPj+GF/JhnxjsMPC9QlpMxq4fGt67Zfw2R1ncvZo4+BwHG
         AbWY6/nzGYYdzhN3mDnjtR5KP8agBp/wKDkbYT7egI9KtGRnmwCAmKLRpwOcwLUhLdUG
         BUcRqU6oIgMN+qmz9UzBxrW74E9/scbSGaUhxUF5mEn55QE8CTS2ysXl2k3IfAlUPY0o
         Z9+YRrzB+tPpxUyfWjejRSBARvd4yQFuIRUaLLcggaijVgh+dSQkCsSnJl2wPguSkpqx
         YDRw==
X-Gm-Message-State: AHQUAuYdl+GpkEVts9PqaXibrjYRLOXbHWqXKIE3QHH4GpG/Ab+c+Gw8
        ryC3OV4Nx6lwH96gN50osAp+rA==
X-Google-Smtp-Source: AHgI3IaSbQ++meZa7os+8JIhVmDCzKKyeDxktIqjho0k4ssp+EL1tDV1ryWVl+D/2YcmWGvyeAfxsA==
X-Received: by 2002:a5d:6487:: with SMTP id r7mr3835547wru.263.1549375201929;
        Tue, 05 Feb 2019 06:00:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y1sm5560379wru.4.2019.02.05.06.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 06:00:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] eeprom: at24: new property
Date:   Tue,  5 Feb 2019 14:59:32 +0100
Message-Id: <20190205135934.18841-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Microchip 24aa02t EEPROM is compatible with Atmel 24c02 except that
it's visible on 8 i2c slave addresses. We already support such a
use case with hard-coded config for 'atmel,24c00'. Let's add a more
flexible device tree property - 'num-addresses' - to the binding
document and support it in the driver.

Bartosz Golaszewski (2):
  dt-bindings: at24: add the 'num-addresses' property
  eeprom: at24: implement support for 'num-addresses' property

 Documentation/devicetree/bindings/eeprom/at24.txt |  3 +++
 drivers/misc/eeprom/at24.c                        | 13 ++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.20.1

