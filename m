Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BB3ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6BC20831
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXW6SQ3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6BC20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeJ0I2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:28:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44036 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeJ0I2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 04:28:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id d23-v6so1164797pls.11;
        Fri, 26 Oct 2018 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kM09Tv1c2zOf2gNK3DgXTR3BNL8w5tzluQThDACq4hQ=;
        b=EXW6SQ3lKya6YWyVK7fDdWi+ssqi6RSwNThdxxivNphus4w2JLt5ebr+0JqQww1QWp
         KVis9oIuyu1FDuaRmKwFhwgJsH39RbjpCvsr/U5izI5GD8U49t2WGT3tBLHNiR5Y053h
         g7aU8O4DTNDn1xL2ubzbgGOxIN5aYT6f3vhLgj52SNTNB9jdJ8YP4goD/B4F9opXBIPs
         uBqx94CesKocVwwzMiZjkm3O2xXOSgWL27Zd6T7vCptIWAu03WU2x5auNQ7WYK/dlzLx
         oBRLf0UO5rAEgEv7DY5fhL5rCayovi+XeBKuxlMxzFGWhyoFonSJe4fcOe6MauJZZXyX
         XVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kM09Tv1c2zOf2gNK3DgXTR3BNL8w5tzluQThDACq4hQ=;
        b=fBUKchZCvKATAjcfPPJv+dg9mFzn5g4aV8jv5jAZmTbKyQkL9DP9206U6vuYei8c/o
         w5QGIGEm3Kg0rKMObF1aPcOfNLT2lkTvsOjwqXfN3RvJfjo7TIuXh793fmti2uqV4eYO
         giq6cwjvf/l35CgXpi/NWOF6hUYS0BRT6pKCYNbjaBv+NxO5GAOrGBN80w2mGyvKoXEk
         6x0MmLKij1/vDkOPcqZ1oVlXaJ8/h7zhvwaUijQmrkzPneAGcl9jfMCFbLlkuzTLLJvF
         nQMr+6kG3q4YfjycIIywGNmtxmfoLKUL4/wpKUpxx4RuE+NmHOKRqxeJvZHLZbsujHSU
         dCNQ==
X-Gm-Message-State: AGRZ1gKesfMFlF+gnYtwS6UGr/xL2RZpDnYwQNyKHibdaM/GpQh5WfIO
        vFf8i9OARXN5oc7tsFZny/U=
X-Google-Smtp-Source: AJdET5dzlV0QYEtXCYowqb+YUotDPUvJwYuA9L3PKpNnL8Kq6JdocGY4nXlL1QJtG+KM83kDVtvwNQ==
X-Received: by 2002:a17:902:3381:: with SMTP id b1-v6mr5374471plc.323.1540597761205;
        Fri, 26 Oct 2018 16:49:21 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id j14-v6sm15522423pgh.52.2018.10.26.16.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 16:49:19 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:49:17 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.20-rc0
Message-ID: <20181026234917.GA196749@dtor-ws>
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

to receive updates for the input subsystem. Just random driver fixups,
nothing exiting.

Changelog:
---------

Brian Masney (1):
      Input: pwm-vibrator - correct pwms in DT binding example

Dmitry Torokhov (1):
      Input: synaptics - avoid using uninitialized variable when probing

George G. Davis (1):
      Input: atmel_mxt_ts - fix multiple <linux/property.h> includes

Gustavo A. R. Silva (3):
      Input: cyapa - mark expected switch fall-throughs
      Input: atmel_mxt_ts - mark expected switch fall-through
      Input: xen-kbdfront - mark expected switch fall-through

Hans de Goede (1):
      Input: of_touchscreen - add support for touchscreen-min-x|y

Julian Sax (1):
      Input: silead - try firmware reload after unsuccessful resume

Linus Walleij (1):
      Input: Fix DIR-685 touchkeys MAINTAINERS entry

Martin Kepplinger (1):
      Input: st1232 - set INPUT_PROP_DIRECT property

Randy Dunlap (1):
      Input: wm97xx-ts - fix exit path

Rob Herring (2):
      Input: sun4i-lradc - convert to using %pOFn instead of device_node.name
      Input: xilinx_ps2 - convert to using %pOFn instead of device_node.name

Stephen Boyd (1):
      Input: elants_i2c - use DMA safe i2c when possible

Diffstat:
--------

 .../devicetree/bindings/input/pwm-vibrator.txt     |  4 +--
 .../bindings/input/touchscreen/touchscreen.txt     |  6 ++--
 MAINTAINERS                                        |  2 +-
 drivers/input/keyboard/sun4i-lradc-keys.c          |  6 ++--
 drivers/input/misc/xen-kbdfront.c                  |  2 +-
 drivers/input/mouse/cyapa_gen3.c                   |  4 +--
 drivers/input/mouse/synaptics.c                    |  4 +--
 drivers/input/serio/xilinx_ps2.c                   |  2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |  3 +-
 drivers/input/touchscreen/elants_i2c.c             |  7 +++--
 drivers/input/touchscreen/of_touchscreen.c         | 36 +++++++++++++++++-----
 drivers/input/touchscreen/silead.c                 | 13 ++++++++
 drivers/input/touchscreen/st1232.c                 |  1 +
 drivers/input/touchscreen/wm97xx-core.c            |  3 +-
 14 files changed, 64 insertions(+), 29 deletions(-)

Thanks.


-- 
Dmitry
