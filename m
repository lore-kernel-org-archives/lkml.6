Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A2CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E062218AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXJjr0wM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfBQHl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 02:41:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37995 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfBQHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 02:41:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so4644076pgl.5;
        Sat, 16 Feb 2019 23:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=bmikzPTPEG19+IU42RYaq5VeP17CpxYhkjo6p95PD/0=;
        b=lXJjr0wM5xfIyojsblGlb4PqUpygM6chYznwqd/zkr/qQlEHCo3KFjunA0URsVgnuc
         4us3PgrR1nDW+Gw0imv2gclsvSx0Nv7wA95f8v8zFepZzRD4ARmawXiJeh2xXnnRSib0
         bkhZZbIXRBJih5U91LvqUMy/g2opM9zEp3SbkrKVwn2ANoz01UWjbEn5ZMjX3MHBkeSG
         TRpgQgvEcwgx3hk8aDuYdaVaRsG3LtjS5YTl7CeQkrAE1/ZXiTQlZcV+2PqrX1N8Nr0I
         Aih5m0c0oW07hdNgp8pMyXjQJuz6NpyFAaMJXizVVhjCupFCogQLyO9klaYfZRUxoMvV
         7Elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=bmikzPTPEG19+IU42RYaq5VeP17CpxYhkjo6p95PD/0=;
        b=ixKH2d2sFRIKzw8sY0gGipLlMT+5AtuLGRO0l4MzKsA/HUUsRMs2DvgyiVmNSFF0Dy
         F2YrHBsVI/JqTOaGwa7/XW33ORN3zOElaH/f6DMrm+wPkRK7ea2Stlryo7BaS7jxidwp
         TMPEQatCjcQ91HTMFMAdWa1R0ydDYXKItCS4XPZQSpd5lRcMOJip/T8uY/kYmz2xUbHW
         mHO2oGO6njDtks78ygrRJjdo4e38TOHhIo7bBf/D2jehEFj9Zt4cOLY1DfrswhGYdfiM
         51PL2LYkc4VwSIOJz3goF/Ytac75Q5Mx9Ne+BXJrJ3Mgvo7GI+4oA3r8ACyk7OtsMhqT
         S94Q==
X-Gm-Message-State: AHQUAuYc8R6CtFfJDdvX0WzeZQdyRH07EDrIjI6ajqB5Wbd0yfg8GnGu
        osZeojSBTBgJx6JAbL8rLFw=
X-Google-Smtp-Source: AHgI3IaRWx9ozDRS3JaUHI81lCkJhJR+X6HRzTn94y1u0bGXAoJJYvmbXZUBZWqkoVgDj5Ojm/xn9g==
X-Received: by 2002:aa7:808f:: with SMTP id v15mr18443110pff.30.1550389285891;
        Sat, 16 Feb 2019 23:41:25 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 63sm16867664pfy.110.2019.02.16.23.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 23:41:25 -0800 (PST)
Date:   Sat, 16 Feb 2019 23:41:23 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.0-rc6
Message-ID: <20190217074123.GA248187@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem:

- tweaks to Elan drivers (both PS/2 and I2C) to support new devices.
  Also revert of one of IDs as that device should really be driven by
  i2c-hid + hid-multitouch

- a few drivers have been switched to set_brightness_blocking() call
  because they either were sleeping the their set_brightness()
  implementation or used workqueue but were not canceling it on unbind.

- ps2-gpio and matrix_keypad needed to [properly] flush their works to
  avoid potential use-after-free on unbind.

- other miscellaneous fixes.

Changelog:
---------

Dmitry Torokhov (6):
      Input: cap11xx - switch to using set_brightness_blocking()
      Input: ps2-gpio - flush TX work when closing port
      Input: matrix_keypad - use flush_delayed_work()
      Input: qt2160 - switch to using brightness_set_blocking()
      Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G"
      Input: apanel - switch to using brightness_set_blocking()

Gabriel Fernandez (1):
      Input: st-keyscan - fix potential zalloc NULL dereference

Jonathan Bakker (2):
      Input: pwm-vibra - prevent unbalanced regulator
      Input: bma150 - register input device after setting private data

Matti Kurkela (1):
      Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Mauro Ciancio (1):
      Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK

Paweł Chmiel (1):
      Input: pwm-vibra - stop regulator after disabling pwm, not before

Stefan Agner (1):
      Input: snvs_pwrkey - allow selecting driver for i.MX 7D

Diffstat:
--------

 drivers/input/keyboard/Kconfig         |  2 +-
 drivers/input/keyboard/cap11xx.c       | 35 ++++++-----------
 drivers/input/keyboard/matrix_keypad.c |  2 +-
 drivers/input/keyboard/qt2160.c        | 69 +++++++++++++---------------------
 drivers/input/keyboard/st-keyscan.c    |  4 +-
 drivers/input/misc/apanel.c            | 24 ++----------
 drivers/input/misc/bma150.c            |  9 +++--
 drivers/input/misc/pwm-vibra.c         | 19 +++++++---
 drivers/input/mouse/elan_i2c_core.c    |  2 +-
 drivers/input/mouse/elantech.c         |  9 +++++
 drivers/input/serio/ps2-gpio.c         |  1 +
 11 files changed, 75 insertions(+), 101 deletions(-)

Thanks.


-- 
Dmitry
