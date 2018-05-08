Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2552373-1525773960-2-3343243231224465035
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525773959; b=Lotbnz0chxQ/r33tXRZKHauAt/OL/uAT6zbmYgjuOV8k65TJ0n
    MdjG32InTqgxShpIgXUutE2QmYqSE/OZdUvo3TmEWiXoY/kEwpT6ewi6SNyBTeAe
    RcKhg9WULCQgsz4I6UQcR5iQIkA8i3WOLjFgKiuUcx5ihaUE+jHWgy1rOpSlfQom
    aiXNLf7Za+ytNHhj2kGhq70nduIeU4s0vMpC/pQoEtWzPU1kTyEd6cN704D6OU04
    QygrQfyzfc16YL9Qst0cd6DeyVYjEDKrbU4VI/vnzssQPHP6kcVY1TInSYnTyGO2
    92d0OIvF35cRWwhx+sDOlWvNply7L8mSFBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1525773959; bh=IHbmAdkszzsuwOXwfuKzdLD35UBzLi
    a/+gSdNwQ0Mb0=; b=PUrVLOZbuejdwoNg4GAud0O1gaJcZvtOsuFKPNjJm1l/uS
    +1HTkS4ubYdXBltqGCj8SyxixI4Z+OtVrokoSfZ+8x90xNePw0clOt4r+qhnDIck
    94FEYw+yoUyQI1SGHnxGpSFtMB8p4eKZwGn9/Vfp59im2jtL/urKIGOK1L/5DKcU
    tAafMUIe68XM0Tb6U/lMQazCZSDjmQJphOVo4tS08+jjl1M5CJU0tYmDBxffNygq
    VDHCMPFL2qaQTausyryyp6N3fYdW5kMYyChtFQLvVgZfNWI4Iizq+7iIb3U+T/17
    Nfa+r1EAcWEmBfOJyZ/f+gUuDUThLO31N79yp+rQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=pengutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=pengutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMeiadgKdxByjChu9gc3FBGfXiwZpDdcf6aF020YBi2hQxf2ZbqAsIKIJuFoD3uhd+rBiy07/4Yu/ABDFNminSnLz9tJeLX+KTR5kZUxrxI9VVmaghGz
    fLKr1BjVOs5A9NzDYv21QQs3cZHN/6EkX8f3SSC5hnHMvgZqM7IGTNhmqy1ArQlgbVkwiqqugIlGlSIsFuNsxFYhenjPgP5W+tbw4vM0yLuOzvu45IGXy3ah
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=T56u2SMLJXeTU8k1wZ8A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932086AbeEHKF4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 06:05:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55389 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754757AbeEHKFz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 06:05:55 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc: linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] led_trigger_register_format and tty triggers
Date: Tue,  8 May 2018 12:05:40 +0200
Message-Id: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

while working on a patch that adds led triggers to drivers/tty (patch 3)
I thought that being able to pass a format string (and the respective
parameters) to led_trigger_register_simple instead of a constant string
would be nice. This is implemented in the first patch. The second patch
converts the can leds to this new function which demonstrates nicely the
added benefit for users. Both patches are new in v3.

The third patch finally implements the triggers for the tty framework.
Compared to v2 I reduced the need for #ifdefs, make use of
led_trigger_register_format() and excluded serdev devices from
triggering as suggested by Johan Hovold.

Also code cleanup in the error case is done now and hopefully the kbuild
test robot is happy now.

Best regards
Uwe

Uwe Kleine-König (3):
  leds: triggers: provide led_trigger_register_format()
  can: simplify LED trigger handling
  tty: implement led triggers

 arch/arm/boot/dts/imx25-logitech-baby.dts | 192 ++++++++++++++++++++++
 drivers/leds/led-triggers.c               |  84 +++++++---
 drivers/net/can/led.c                     |  30 +---
 drivers/tty/Kconfig                       |   7 +
 drivers/tty/tty_buffer.c                  |   2 +
 drivers/tty/tty_io.c                      |   3 +
 drivers/tty/tty_port.c                    |  32 +++-
 include/linux/can/dev.h                   |   3 -
 include/linux/leds.h                      |  30 ++--
 include/linux/tty.h                       |  22 +++
 10 files changed, 341 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx25-logitech-baby.dts

-- 
2.17.0

