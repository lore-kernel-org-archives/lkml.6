Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D51C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F85A20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhQlB8Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F85A20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeIDHH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:07:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45501 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeIDHH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:07:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id j8-v6so877993pll.12;
        Mon, 03 Sep 2018 19:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iMhPemz6msZZyzFD19nUQgO5wHb0URGKKu4niDcK1R4=;
        b=VhQlB8UmNKA3oOJeJao1OY6bcYF/k7cLJxCEGlWQKLusZk+UVP/bcheK8G9PXklcN7
         GHPJoNmtkLi5EUoYRvxqr2OAKnTDmSMtV8fwMTzhs6HmvfGwyDF4thEDAWs/jg+zeY68
         cmmRJtbCtwbqUk5fNyPyioJbmkrcHrlA2imk/14bpJ/EC8V0erF97VnpzqYYjNPhG2Pe
         +hG4nLCHcBSpm41n8/4w811VtkX9nqM/3W/x9uAY4NgesnSC45G9xZOuM9EmdNvDtgZP
         /MCuCKXlIYenELMvi8CNL9njfnB0V2CNOdirUms0z8+0jqNImBiQd4Y/LaIGvdhvA/s4
         zIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iMhPemz6msZZyzFD19nUQgO5wHb0URGKKu4niDcK1R4=;
        b=hoS/FC5mmH3xCz8Xip413lNbeL57FW0ALxhsyFoUWqipkVPCRvXou7qgwgvLiLxqlv
         73weuJx4Y4YmQiKV7C43OkHZVe+6KqvJSCyJklBnnjnUQQk3RWPAQ+g88sEGfH3NOmQs
         J7nZk/I5lCRM07OD+vmNOtz0GfcMBwWhGfePpBTtENN6oSeLVfX2tgyVQ+XI5P4wQSKV
         46Q7OPpozarrnbnVbxsXIo0BafecIoJMHJZzWo6Q87zCW7U56E0o8YqrLk4ooBFKVV3g
         2hBBfPchzTYmaDasLYl9YHJAyV52NLFPY8Rakq8/mwswRXy+EsY/43SPxrnDMpcOjOHX
         VSRg==
X-Gm-Message-State: APzg51AEyNfJXlVrAY5QqVBizktI4r+GdQ7EVWUKNbXWj436S91Nbyu5
        a1Qb17yyxAZJHaPsrmKk8IE=
X-Google-Smtp-Source: ANB0VdZcrlfo6X3zKVVnvfd1VPq1JqTXSvlCJj1+WppIK86F6Mh9Ss3V5vQp1cEzYWANtv9Haa30zw==
X-Received: by 2002:a17:902:714f:: with SMTP id u15-v6mr32303395plm.154.1536029101535;
        Mon, 03 Sep 2018 19:45:01 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:01 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 00/25] Change tty_port(standard)_install's return type
Date:   Tue,  4 Sep 2018 11:44:26 +0900
Message-Id: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many drivers with tty use the tty_stand_install(). But, there is no
need to handle the error, since it always returns 0. So, change the
return type of tty_standard_install() and tty_port_install() to void
type and remove unnecessary exception handling where we use these
functions.

Change return type for tty functions. Patch No.01
  tty: Change return type to void

Apply tty_port_install() changes. Patch No.02~14
  isdn: i4l: isdn_tty: Change return type to void
  ...
  Bluetooth: Change return type to void

Apply tty_standard_install() changes. Patch No.15~25
  um: Change return type to void
  ...
  usb: usb-serial: Change return type to void

Jaejoong Kim (25):
  tty: Change return type to void
  isdn: i4l: isdn_tty: Change return type to void
  s390: char: con3215: Change return type to void
  s390: char: tty3270: Change return type to void
  tty: hvc: hvc_console: Change return type to void
  tty: hvc: hvcs: Change return type to void
  tty: mips_ejtag_fdc: Change return type to void
  tty: n_gsm: Change return type to void
  tty: serial: kgdb_nmi: Change return type to void
  tty: synclink: Change return type to void
  tty: synclinkmp: Change return type to void
  tty: vt: Change return type to void
  usb: xhci: dbc: Change return type to void
  Bluetooth: Change return type to void
  um: Change return type to void
  isdn: capi: Change return type to void
  misc: pti: Change return type to void
  mmc: core: sdio_uart: Change return type to void
  staging: fwserial: Change return type to void
  staging: gdm724x: gdm_tty: Change return type to void
  staging: greybus: uart: Change return type to void
  tty: nozomi: Change return type to void
  tty: vcc: Change return type to void
  usb: cdc-acm: Change return type to void
  usb: usb-serial: Change return type to void

 arch/um/drivers/line.c              |  7 +------
 drivers/isdn/capi/capi.c            | 10 ++++------
 drivers/isdn/i4l/isdn_tty.c         |  3 ++-
 drivers/misc/pti.c                  | 28 +++++++++++++---------------
 drivers/mmc/core/sdio_uart.c        | 11 ++++-------
 drivers/s390/char/con3215.c         |  3 ++-
 drivers/s390/char/tty3270.c         |  7 +------
 drivers/staging/fwserial/fwserial.c | 22 ++++++++--------------
 drivers/staging/gdm724x/gdm_tty.c   | 11 +++--------
 drivers/staging/greybus/uart.c      | 10 ++--------
 drivers/tty/hvc/hvc_console.c       |  7 ++-----
 drivers/tty/hvc/hvcs.c              | 10 ++--------
 drivers/tty/mips_ejtag_fdc.c        |  4 +++-
 drivers/tty/n_gsm.c                 |  9 +--------
 drivers/tty/nozomi.c                |  8 +++-----
 drivers/tty/serial/kgdb_nmi.c       | 11 +----------
 drivers/tty/synclink.c              |  3 ++-
 drivers/tty/synclinkmp.c            |  3 ++-
 drivers/tty/tty_io.c                | 10 ++++++----
 drivers/tty/tty_port.c              |  4 ++--
 drivers/tty/vcc.c                   |  5 +----
 drivers/tty/vt/vt.c                 |  5 +----
 drivers/usb/class/cdc-acm.c         | 10 +---------
 drivers/usb/host/xhci-dbgtty.c      |  3 ++-
 drivers/usb/serial/usb-serial.c     |  6 +-----
 include/linux/tty.h                 |  4 ++--
 net/bluetooth/rfcomm/tty.c          |  7 +------
 27 files changed, 73 insertions(+), 148 deletions(-)

-- 
2.7.4

