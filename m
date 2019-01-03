Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9899CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E49E2073F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAFnp2JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfACBGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:06:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44815 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfACBGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:06:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so15901529pfh.11;
        Wed, 02 Jan 2019 17:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=LYYf+9cu/NPmPya5v/mLCVVCB4Uf+urqV9mx+fWRg48=;
        b=sAFnp2JQDImbcNRCMfzl6Wm/Sn5X5HWutgLobT2aaRKyk/ZgeqHEg41QDSQeDYlSaI
         e5Lcblr1Hz155Cd4dXYXS+z04E57qKy18c9Ycon1DTYHiBkrTXyP9H7TJXGPhYyGV+nO
         Es86L+ID5/qb18vlR6/XlE6mtZq+js1uWO0XftlTsoYVzjZUoHMswtZnSHunIE377Ng9
         YQk8gma8dHDSPhgizl0HD43uIy2LIxezhuTAclM+hCikaKRuDGvqS+k3wOIJBS9NPCW/
         7a8K+RnLVTfUKGQVNWO8rvGWPsqcPQ0RD1ihhhIdwPZnAM7ECFCCmsceGkB+lhXPpjt7
         +KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=LYYf+9cu/NPmPya5v/mLCVVCB4Uf+urqV9mx+fWRg48=;
        b=gloil3T1lnkfejXIWZdV+FKhF0sc+MLDsaDUFT/5loSkIJwzAKhEGdvW1CMboOK2c0
         zTIQYnKY9cEHa0Hoz5aszC5PcVI5C6gbi+LUDMsQ1ZUagmJVPD/qo3CKIuvv2WGYUJ5v
         YHnQrYvb5/msiVhSxJwOeCZ4XcDHWmQoG+U6dyaFCoILEQt9uG4qttbIzQzSlA1aFwWr
         gyAlME82v+ZrGxfQl+5oQ5XkoUaxrkdjcGKeGfGZv2SKIVgjiNIpZDYuVMQy8EQrwzpG
         tBUj/IMDzNPcs6zlI40CeEHFydgDhqdd3aqznT3Z2MxKe88sA5n4wnqUfHzhqwQxWjl/
         TBMg==
X-Gm-Message-State: AJcUukfAtGnrm4KzOYV9gb4OCJEI5hETR+Q2EhSKm/9rPvYwhTjkArhs
        lr7h/romovS66xxfxuAmRJtHHQRa
X-Google-Smtp-Source: ALg8bN6+nbCJL33xJ+5yoavaTIqi+EQObNYD10FJVgeCxzbUrgz7W1HRnxts3oK93TodXon1MMO46Q==
X-Received: by 2002:a63:484c:: with SMTP id x12mr15204149pgk.375.1546477599176;
        Wed, 02 Jan 2019 17:06:39 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d80sm150530422pfm.146.2019.01.02.17.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 17:06:38 -0800 (PST)
Date:   Wed, 2 Jan 2019 17:06:36 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.21-rc0
Message-ID: <20190103010636.GA189500@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

to receive updates for the input subsystem. A tiny pull request this
merge window unfortunately, should get more material in for the next
release.

- new driver for Raspberry Pi's touchscreen (firmware interface)
- miscellaneous input driver fixes

Changelog:
---------

Colin Ian King (1):
      Input: drv2667 - fix indentation issues

Dan Carpenter (1):
      Input: nomadik-ske-keypad - fix a loop timeout test

Hardik Singh Rathore (1):
      Input: touchscreen - fix coding style issue

Linus Walleij (1):
      Input: ad7879 - drop platform data support

Lubomir Rintel (5):
      dt-bindings: marvell,mmp2: Add clock id for the SP clock
      clk: mmp2: add SP clock
      Input: olpc_apsp - drop CONFIG_OLPC dependency
      Input: olpc_apsp - check FIFO status on open(), not probe()
      Input: olpc_apsp - enable the SP clock

Nicolas Saenz Julienne (1):
      Input: add official Raspberry Pi's touchscreen driver

Patrick Dreyer (1):
      Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G

Sanjeev Chugh (1):
      Input: atmel_mxt_ts - don't try to free unallocated kernel memory

Uwe Kleine-König (1):
      Input: rotary-encoder - don't log EPROBE_DEFER to kernel log

YueHaibing (1):
      Input: olpc_apsp - remove set but not used variable 'np'

Diffstat:
--------

 .../input/touchscreen/raspberrypi,firmware-ts.txt  |  26 +++
 .../devicetree/bindings/serio/olpc,ap-sp.txt       |   4 +
 drivers/clk/mmp/clk-of-mmp2.c                      |   4 +
 drivers/input/keyboard/nomadik-ske-keypad.c        |   2 +-
 drivers/input/misc/drv2667.c                       |   6 +-
 drivers/input/misc/rotary_encoder.c                |   6 +-
 drivers/input/mouse/elan_i2c_core.c                |   1 +
 drivers/input/serio/Kconfig                        |   1 -
 drivers/input/serio/olpc_apsp.c                    |  28 ++-
 drivers/input/touchscreen/Kconfig                  |  12 ++
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/ad7879.c                 | 109 +++-------
 drivers/input/touchscreen/atmel_mxt_ts.c           |   4 +-
 drivers/input/touchscreen/ektf2127.c               |   2 +-
 drivers/input/touchscreen/gunze.c                  |   4 +-
 drivers/input/touchscreen/inexio.c                 |   4 +-
 drivers/input/touchscreen/mtouch.c                 |   4 +-
 drivers/input/touchscreen/raspberrypi-ts.c         | 227 +++++++++++++++++++++
 include/dt-bindings/clock/marvell,mmp2.h           |   1 +
 include/linux/platform_data/ad7879.h               |  42 ----
 20 files changed, 347 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
 create mode 100644 drivers/input/touchscreen/raspberrypi-ts.c
 delete mode 100644 include/linux/platform_data/ad7879.h

Thanks.


-- 
Dmitry
