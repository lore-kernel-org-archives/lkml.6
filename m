Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD8CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D49208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNyOtlCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D49208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbeLDDhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:37:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45569 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLDDhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:37:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so7470062pfd.12;
        Mon, 03 Dec 2018 19:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dQ9p9xAvVskm4ZKhMM4JZxZVUBWrwmmYrogB2Q78QZA=;
        b=bNyOtlCtWOMv2qmOF4ZVREhp5rauBo4TOsawu9knGDRvtTodPGN1m22BQTkewN1IMz
         YaOL2cGNedfV6AFodz1ugo8T8x0wEVcNLDreyi90muaJB12gjgfyRWky0aCWrFTPbgzN
         SUhb3riqeFTyktouud2CAhX3CN86sKhfTyomU10l88RV0Ieb0w+4pQDRrlhEC0DU3a/9
         Npfdtpe6DzQd5To8ZSCPfl4Rt0RV2W6S5pzrKmztR+7om+7tdL3TfvQ+x0ut27nCdGvQ
         aatmcCgFwJNx2sRDChqpqe7ihijUeKR7YQoS4lgJ7qMJWoerRGAC5EKeGH9HxqVH0YZv
         Ayyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dQ9p9xAvVskm4ZKhMM4JZxZVUBWrwmmYrogB2Q78QZA=;
        b=E5iNGuNruAKapExt3n//sYnuVLQ8MJV2ubywSegHVv6/HGS4bNRb1ePL8kx4xpzoA3
         KSMRm7/veOAO7ZWbZxfTct3dF4yI8zTnOCmIeJNl/SfoU7Uek/I2uqwL4nu8acclOYoG
         ZOflAhT5cYGTrbGD/iSNtVA6W1m+VTepccQ5Eztg+uXLOS3nWQVjAuvrKe7INuMpiABY
         DGjZnUTmDU3J+s9WH1+6+49VQ7H6XITgKz3DAm4WPT7dVzse+xlizliZtIZoYRs9hXgQ
         IwgGMFDN+uIhfv9X6Jl4bJ5hde37DkoS0GbqXxhHC7zDwkrTQjSAF31n0RODH+DxIJfo
         TpMA==
X-Gm-Message-State: AA+aEWZkSn1alXbrPm/rDfcSwwM2NJppQDlmd0as9adKMf8//b91GTmm
        NMjhMQ5Enp90LkHNtzY8GeY=
X-Google-Smtp-Source: AFSGD/VmAWmAZzNbTAUXbQDfbzA4BaV53lrgDtWsHB5ObShXoCqZZIzi4rcoOW5tieKfnZylFjmzcg==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr15287091pgh.6.1543894669373;
        Mon, 03 Dec 2018 19:37:49 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r8sm16488321pgr.48.2018.12.03.19.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 19:37:48 -0800 (PST)
Date:   Mon, 3 Dec 2018 19:37:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.20-rc5
Message-ID: <20181204033746.GA235290@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Mostly new IDs for
Elan/Synaptics touchpads, plus a few small fixups.

Changelog:
---------

Adam Wong (1):
      Input: elan_i2c - add support for ELAN0621 touchpad

Brian Norris (1):
      Input: cros_ec_keyb - fix button/switch capability reports

Cameron Gutman (1):
      Input: xpad - quirk all PDP Xbox One gamepads

Christian Hoff (1):
      Input: matrix_keypad - check for errors from of_get_named_gpio()

Colin Ian King (1):
      Input: atkbd - clean up indentation issue

Ding Tao (1):
      Input: dt-bindings - fix a typo in file input-reset.txt

Kuninori Morimoto (2):
      Input: migor_ts - convert to SPDX identifiers
      Input: st1232 - convert to SPDX identifiers

Lyude Paul (1):
      Input: synaptics - add PNP ID for ThinkPad P50 to SMBus

Noah Westervelt (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR

Patrick Gaskin (1):
      Input: elan_i2c - add ELAN0620 to the ACPI table

Teika Kazura (1):
      Input: synaptics - enable SMBus for HP 15-ay000

Tony Lindgren (1):
      Input: omap-keypad - fix keyboard debounce configuration

Vitaly Kuznetsov (1):
      Input: hyper-v - fix wakeup from suspend-to-idle

Diffstat:
--------

 .../devicetree/bindings/input/input-reset.txt      |  2 +-
 drivers/hid/hid-hyperv.c                           |  2 +-
 drivers/input/joystick/xpad.c                      | 16 ++++++---------
 drivers/input/keyboard/atkbd.c                     |  2 +-
 drivers/input/keyboard/cros_ec_keyb.c              |  3 ++-
 drivers/input/keyboard/matrix_keypad.c             | 23 +++++++++++++---------
 drivers/input/keyboard/omap4-keypad.c              | 18 +++++++++++++----
 drivers/input/mouse/elan_i2c_core.c                |  3 +++
 drivers/input/mouse/synaptics.c                    |  2 ++
 drivers/input/serio/hyperv-keyboard.c              |  2 +-
 drivers/input/touchscreen/migor_ts.c               | 15 +-------------
 drivers/input/touchscreen/st1232.c                 | 12 ++---------
 12 files changed, 48 insertions(+), 52 deletions(-)

Thanks.


-- 
Dmitry
