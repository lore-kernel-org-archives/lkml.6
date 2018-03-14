Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2033369-1521041950-2-2202526992857149101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521041949; b=j8JgIvfk1HZGNWqB11ecnRQowc0r0g0hGOP1Uk3/Oxx0C3M
    eqUQwQWHNCSPFzJsYJq5H8o6UINJ5nTHvNnCWWcNwvE7AxDOaKlrRuvg0BCJV10n
    XEvXms9PRosDmp/5Tw1SDuBxH755fSniD+DhNydrD4z6cauFqx3CQu0OSD52yDpZ
    6APlNMiejMpNhbQpwzo56wL/WIFVOKimWdNB3AsEUbDc32A1DdMLHqJcjxC0WdbP
    bKbwiAwcCBLTFFb4LYzrOhnqgfwLI3q9C46iaV+xmdn5xcQVP4y1kq3N7cmaMuPY
    WsrOTAQ7qqPJ5hM3j+oUDZksPjD5HVso6YFLvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521041949; bh=WkfUvPNZYcuKqNS0W1IXwud6qi
    wTmr60oQg/rNt1Pvo=; b=gTuGxsHIhLDEv8HIu0V07dDDe7rtiK/e4/pa/+djxW
    ua5Hn6HRrW/NQGeK5HENY4UL73SzH3YEjgdGR+wLmLJRkbu71v1OMNDAAaEEa2vJ
    BRChUY7mZRwrLhrWpp4RH3tK/l/Cxj6YlPIaJYdteH0jZsbAiXkW+1N7GEiXWIPL
    Nv2oB+qJS1l5pBnWwTHsR4hRiGrxyGi7O1lfEJd7gu8DP3qMUsI87m89cw9ixWF/
    jUMzUHpM7ZuNfM7X4LSh4liFL+4nG7tf56IyVWSuWsNzzFk8XYQmANENqW026ZSC
    wWJ8xrm+hKza34yY5mXAWstGEGSSuZQXJ5ypuHZ0h1Cw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeCNPjA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 11:39:00 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38987 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeCNPit (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 11:38:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux@roeck-us.net, corbet@lwn.net,
        tj@kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, bp@alien8.de, mchehab@kernel.org,
        linus.walleij@linaro.org, wsa@the-dreams.de,
        dmitry.torokhov@gmail.com, ulf.hansson@linaro.org,
        boris.brezillon@bootlin.com, cyrille.pitchen@wedev4u.fr,
        wg@grandegger.com, mkl@pengutronix.de,
        alexandre.belloni@bootlin.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, jslaby@suse.com,
        stern@rowland.harvard.edu, b.zolnierkie@samsung.com,
        shli@kernel.org, linux-watchdog@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-raid@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 00/47] arch-removal: device drivers
Date: Wed, 14 Mar 2018 16:35:13 +0100
Message-Id: <20180314153603.3127932-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:1s4F6Ssxy/PD/WM7koPJ+6Xw/bnIq2YqeLP3iO7W9F2uHzZr/GH
 ufBBQ5pGEQWlpxvzmXCd6x7iDxK71BieedprSlpBqBRGpsVZ6N+UOllSMss9KdvSTSORQD/
 IwP/2WnDQjLOEj5TTlePKfXsXzW5csPR3BiB06yXakHLQw2GWFslVinUTj9VpDPeIE+QKP6
 SaBY+EVwWu9YOvnUl6YGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FpJltreOk68=:tnZRPqJoY1PiP1686zYRU1
 Bbvrb8y3YGIIQNdSLFPIJkXw9sfK7c1Xi0fuuVON6V3/j6hJRAE8W/R0btvHu5YA3yxSQnZOh
 DWXD4P8lrY8BlNbLeV8wKKvU2IVstU044Lutku3c5K9djD59exN4t6YL+hgoY5UUoon4DyyCD
 zspcIXV2jQ4Uw8dOR9HnwELXNO6WSiHGq5tItWV1A2aHTIIWr0aQjvwVQfxRqs+ZFQtCFBkni
 ERoUYDJmMNnh/e7oBy55e5jwlELMKOTEItoJ9u7jvoRJPSU2l5WwMyyZHjqiRnA5Wvm0KrG/p
 myWG58dg4WMos5fMTxYYE+hKNfwqxK83E4A91jSzz1xiK99QYedO5mr+0xpXl/9QVwXjgYR3z
 hzRugpNIihnT8XwLf0cn8wU/mvqSP3jxT67zBoIAuRWeT3ev6SJGRsj+Wtj9rJXn1OgsId+vZ
 OfncSDcnxKsPqqxzZ9NbOp6HgeWgJqOifXX3GYdg3N/0J6Obd/sv8D/1cN0ZotS0lTgXBHU+U
 iy9mP9VC7GxhzGheH9tM+7gT/+3jRG2kcaGJT+w1d+dIpl87csQHYgZuqiVH9SLWsTw6j8Mep
 3uNAKPhNwroY7On3ybhAiZdmg8dq6ILIp4dvU18ioPIlQ8NEaAlOnIV+Dw7fD8GbWvRQjr74R
 AWftTOrhVN1pz1LL/Mjb3jVaOchWnOP9EL8C7rYXhjrXJRX5RE0dyyZEij/JyzebeIpH19qSM
 /+JMXyunRnolKx6nMtrn2Q8T0N8NOpYxdH3VmA==
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi driver maintainers,

I just posted one series with the removal of eight architectures,
see https://lkml.org/lkml/2018/3/14/505 for details, or
https://lwn.net/Articles/748074/ for more background.

These are the device drivers that go along with them. I have already
picked up the drivers for arch/metag/ into my tree, they were reviewed
earlier.

Please let me know if you have any concerns with the patch, or if you
prefer to pick up the patches in your respective trees.  I created
the patches with 'git format-patch -D', so they will not apply without
manually removing those files.

For anything else, I'd keep the removal patches in my asm-generic tree
and will send a pull request for 4.17 along with the actual arch removal.

       Arnd

Arnd Bergmann
  edac: remove tile driver
  net: tile: remove ethernet drivers
  net: adi: remove blackfin ethernet drivers
  net: 8390: remove m32r specific bits
  net: remove cris etrax ethernet driver
  net: smsc: remove m32r specific smc91x configuration
  raid: remove tile specific raid6 implementation
  rtc: remove tile driver
  rtc: remove bfin driver
  char: remove obsolete ds1302 rtc driver
  char: remove tile-srom.c
  char: remove blackfin OTP driver
  pcmcia: remove m32r drivers
  pcmcia: remove blackfin driver
  ASoC: remove blackfin drivers
  video/logo: remove obsolete logo files
  fbdev: remove blackfin drivers
  fbdev: s1d13xxxfb: remove m32r specific hacks
  crypto: remove blackfin CRC driver
  media: platform: remove blackfin capture driver
  media: platform: remove m32r specific arv driver
  cpufreq: remove blackfin driver
  cpufreq: remove cris specific drivers
  gpio: remove etraxfs driver
  pinctrl: remove adi2/blackfin drivers
  ata: remove bf54x driver
  input: keyboard: remove bf54x driver
  input: misc: remove blackfin rotary driver
  mmc: remove bfin_sdh driver
  can: remove bfin_can driver
  watchdog: remove bfin_wdt driver
  mtd: maps: remove bfin-async-flash driver
  mtd: nand: remove bf5xx_nand driver
  spi: remove blackfin related host drivers
  i2c: remove bfin-twi driver
  pwm: remobe pwm-bfin driver
  usb: host: remove tilegx platform glue
  usb: musb: remove blackfin port
  usb: isp1362: remove blackfin arch glue
  serial: remove cris/etrax uart drivers
  serial: remove blackfin drivers
  serial: remove m32r_sio driver
  serial: remove tile uart driver
  tty: remove bfin_jtag_comm and hvc_bfin_jtag drivers
  tty: hvc: remove tile driver
  staging: irda: remove bfin_sir driver
  staging: iio: remove iio-trig-bfin-timer driver

 .../devicetree/bindings/gpio/gpio-etraxfs.txt      |   22 -
 .../bindings/serial/axis,etraxfs-uart.txt          |   22 -
 Documentation/watchdog/watchdog-parameters.txt     |    5 -
 MAINTAINERS                                        |    8 -
 drivers/ata/Kconfig                                |    9 -
 drivers/ata/Makefile                               |    1 -
 drivers/ata/pata_bf54x.c                           | 1703 --------
 drivers/char/Kconfig                               |   48 -
 drivers/char/Makefile                              |    3 -
 drivers/char/bfin-otp.c                            |  237 --
 drivers/char/ds1302.c                              |  357 --
 drivers/char/tile-srom.c                           |  475 ---
 drivers/cpufreq/Makefile                           |    3 -
 drivers/cpufreq/blackfin-cpufreq.c                 |  217 -
 drivers/cpufreq/cris-artpec3-cpufreq.c             |   93 -
 drivers/cpufreq/cris-etraxfs-cpufreq.c             |   92 -
 drivers/crypto/Kconfig                             |    7 -
 drivers/crypto/Makefile                            |    1 -
 drivers/crypto/bfin_crc.c                          |  753 ----
 drivers/crypto/bfin_crc.h                          |  124 -
 drivers/edac/Kconfig                               |    8 -
 drivers/edac/Makefile                              |    2 -
 drivers/edac/tile_edac.c                           |  265 --
 drivers/gpio/Kconfig                               |    9 -
 drivers/gpio/Makefile                              |    1 -
 drivers/gpio/gpio-etraxfs.c                        |  475 ---
 drivers/i2c/busses/Kconfig                         |   18 -
 drivers/i2c/busses/Makefile                        |    1 -
 drivers/i2c/busses/i2c-bfin-twi.c                  |  737 ----
 drivers/input/keyboard/Kconfig                     |    9 -
 drivers/input/keyboard/Makefile                    |    1 -
 drivers/input/keyboard/bf54x-keys.c                |  396 --
 drivers/input/misc/Kconfig                         |    9 -
 drivers/input/misc/Makefile                        |    1 -
 drivers/input/misc/bfin_rotary.c                   |  294 --
 drivers/media/platform/Kconfig                     |   22 -
 drivers/media/platform/Makefile                    |    4 -
 drivers/media/platform/arv.c                       |  884 ----
 drivers/media/platform/blackfin/Kconfig            |   16 -
 drivers/media/platform/blackfin/Makefile           |    2 -
 drivers/media/platform/blackfin/bfin_capture.c     |  983 -----
 drivers/media/platform/blackfin/ppi.c              |  361 --
 drivers/mmc/host/Kconfig                           |   19 -
 drivers/mmc/host/Makefile                          |    1 -
 drivers/mmc/host/bfin_sdh.c                        |  679 ----
 drivers/mtd/maps/Kconfig                           |   10 -
 drivers/mtd/maps/Makefile                          |    1 -
 drivers/mtd/maps/bfin-async-flash.c                |  196 -
 drivers/mtd/nand/raw/Kconfig                       |   32 -
 drivers/mtd/nand/raw/Makefile                      |    1 -
 drivers/mtd/nand/raw/bf5xx_nand.c                  |  861 ----
 drivers/net/Makefile                               |    1 -
 drivers/net/can/Kconfig                            |    9 -
 drivers/net/can/Makefile                           |    1 -
 drivers/net/can/bfin_can.c                         |  784 ----
 drivers/net/cris/Makefile                          |    1 -
 drivers/net/cris/eth_v10.c                         | 1742 --------
 drivers/net/ethernet/8390/Kconfig                  |    3 +-
 drivers/net/ethernet/8390/ne.c                     |   23 +-
 drivers/net/ethernet/Kconfig                       |    2 -
 drivers/net/ethernet/Makefile                      |    2 -
 drivers/net/ethernet/adi/Kconfig                   |   66 -
 drivers/net/ethernet/adi/Makefile                  |    5 -
 drivers/net/ethernet/adi/bfin_mac.c                | 1881 ---------
 drivers/net/ethernet/adi/bfin_mac.h                |  104 -
 drivers/net/ethernet/smsc/Kconfig                  |    4 +-
 drivers/net/ethernet/smsc/smc91x.h                 |   26 -
 drivers/net/ethernet/tile/Kconfig                  |   18 -
 drivers/net/ethernet/tile/Makefile                 |   11 -
 drivers/net/ethernet/tile/tilegx.c                 | 2279 -----------
 drivers/net/ethernet/tile/tilepro.c                | 2397 -----------
 drivers/pcmcia/Kconfig                             |   26 -
 drivers/pcmcia/Makefile                            |    3 -
 drivers/pcmcia/bfin_cf_pcmcia.c                    |  316 --
 drivers/pcmcia/m32r_cfc.c                          |  786 ----
 drivers/pcmcia/m32r_cfc.h                          |   88 -
 drivers/pcmcia/m32r_pcc.c                          |  763 ----
 drivers/pcmcia/m32r_pcc.h                          |   66 -
 drivers/pinctrl/Kconfig                            |   19 -
 drivers/pinctrl/Makefile                           |    3 -
 drivers/pinctrl/pinctrl-adi2-bf54x.c               |  588 ---
 drivers/pinctrl/pinctrl-adi2-bf60x.c               |  517 ---
 drivers/pinctrl/pinctrl-adi2.c                     | 1114 -----
 drivers/pinctrl/pinctrl-adi2.h                     |   75 -
 drivers/pwm/Kconfig                                |    9 -
 drivers/pwm/Makefile                               |    1 -
 drivers/pwm/pwm-bfin.c                             |  157 -
 drivers/rtc/Kconfig                                |   17 -
 drivers/rtc/Makefile                               |    2 -
 drivers/rtc/rtc-bfin.c                             |  448 ---
 drivers/rtc/rtc-tile.c                             |  143 -
 drivers/spi/Kconfig                                |   19 -
 drivers/spi/Makefile                               |    3 -
 drivers/spi/spi-adi-v3.c                           |  984 -----
 drivers/spi/spi-bfin-sport.c                       |  919 -----
 drivers/spi/spi-bfin5xx.c                          | 1462 -------
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/trigger/Kconfig                |   19 -
 drivers/staging/iio/trigger/Makefile               |    5 -
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |  292 --
 drivers/staging/iio/trigger/iio-trig-bfin-timer.h  |   25 -
 drivers/staging/irda/drivers/Kconfig               |   45 -
 drivers/staging/irda/drivers/Makefile              |    1 -
 drivers/staging/irda/drivers/bfin_sir.c            |  819 ----
 drivers/staging/irda/drivers/bfin_sir.h            |   93 -
 drivers/tty/Kconfig                                |   13 -
 drivers/tty/Makefile                               |    1 -
 drivers/tty/bfin_jtag_comm.c                       |  353 --
 drivers/tty/hvc/Kconfig                            |    9 -
 drivers/tty/hvc/Makefile                           |    2 -
 drivers/tty/hvc/hvc_bfin_jtag.c                    |  104 -
 drivers/tty/hvc/hvc_tile.c                         |  196 -
 drivers/tty/serial/Kconfig                         |  198 -
 drivers/tty/serial/Makefile                        |    6 -
 drivers/tty/serial/bfin_sport_uart.c               |  937 -----
 drivers/tty/serial/bfin_sport_uart.h               |   86 -
 drivers/tty/serial/bfin_uart.c                     | 1551 -------
 drivers/tty/serial/crisv10.c                       | 4248 --------------------
 drivers/tty/serial/crisv10.h                       |  133 -
 drivers/tty/serial/etraxfs-uart.c                  |  960 -----
 drivers/tty/serial/m32r_sio.c                      | 1053 -----
 drivers/tty/serial/m32r_sio_reg.h                  |  150 -
 drivers/tty/serial/tilegx.c                        |  689 ----
 drivers/usb/host/Kconfig                           |    1 +
 drivers/usb/host/ehci-hcd.c                        |    5 -
 drivers/usb/host/ehci-tilegx.c                     |  207 -
 drivers/usb/host/isp1362.h                         |   44 -
 drivers/usb/host/ohci-hcd.c                        |   18 -
 drivers/usb/host/ohci-tilegx.c                     |  196 -
 drivers/usb/musb/Kconfig                           |   10 +-
 drivers/usb/musb/Makefile                          |    1 -
 drivers/usb/musb/blackfin.c                        |  623 ---
 drivers/usb/musb/blackfin.h                        |   81 -
 drivers/usb/musb/musb_core.c                       |    5 -
 drivers/usb/musb/musb_core.h                       |   30 -
 drivers/usb/musb/musb_debugfs.c                    |    2 -
 drivers/usb/musb/musb_dma.h                        |   11 -
 drivers/usb/musb/musb_gadget.c                     |   35 -
 drivers/usb/musb/musb_regs.h                       |  182 -
 drivers/usb/musb/musbhsdma.c                       |    5 -
 drivers/usb/musb/musbhsdma.h                       |   64 -
 drivers/video/fbdev/Kconfig                        |  103 -
 drivers/video/fbdev/Makefile                       |    5 -
 drivers/video/fbdev/bf537-lq035.c                  |  891 ----
 drivers/video/fbdev/bf54x-lq043fb.c                |  764 ----
 drivers/video/fbdev/bfin-lq035q1-fb.c              |  864 ----
 drivers/video/fbdev/bfin-t350mcqb-fb.c             |  669 ---
 drivers/video/fbdev/bfin_adv7393fb.c               |  828 ----
 drivers/video/fbdev/bfin_adv7393fb.h               |  319 --
 drivers/video/fbdev/s1d13xxxfb.c                   |   10 -
 drivers/video/logo/Kconfig                         |   15 -
 drivers/video/logo/Makefile                        |    3 -
 drivers/video/logo/logo.c                          |   12 -
 drivers/video/logo/logo_blackfin_clut224.ppm       | 1127 ------
 drivers/video/logo/logo_blackfin_vga16.ppm         | 1127 ------
 drivers/video/logo/logo_m32r_clut224.ppm           | 1292 ------
 drivers/watchdog/Kconfig                           |   17 -
 drivers/watchdog/Makefile                          |    7 -
 drivers/watchdog/bfin_wdt.c                        |  476 ---
 include/linux/bfin_mac.h                           |   30 -
 include/linux/linux_logo.h                         |    3 -
 include/linux/platform_data/bfin_rotary.h          |  117 -
 include/linux/platform_data/pinctrl-adi2.h         |   40 -
 include/linux/raid/pq.h                            |    1 -
 include/linux/usb/musb.h                           |    7 -
 include/linux/usb/tilegx.h                         |   35 -
 include/media/blackfin/bfin_capture.h              |   39 -
 include/media/blackfin/ppi.h                       |   94 -
 lib/raid6/Makefile                                 |    6 -
 lib/raid6/algos.c                                  |    3 -
 lib/raid6/test/Makefile                            |    7 -
 lib/raid6/tilegx.uc                                |   87 -
 sound/soc/Kconfig                                  |    1 -
 sound/soc/Makefile                                 |    1 -
 sound/soc/blackfin/Kconfig                         |  205 -
 sound/soc/blackfin/Makefile                        |   40 -
 sound/soc/blackfin/bf5xx-ac97-pcm.c                |  480 ---
 sound/soc/blackfin/bf5xx-ac97.c                    |  388 --
 sound/soc/blackfin/bf5xx-ac97.h                    |   57 -
 sound/soc/blackfin/bf5xx-ad1836.c                  |  109 -
 sound/soc/blackfin/bf5xx-ad193x.c                  |  131 -
 sound/soc/blackfin/bf5xx-ad1980.c                  |  109 -
 sound/soc/blackfin/bf5xx-ad73311.c                 |  212 -
 sound/soc/blackfin/bf5xx-i2s-pcm.c                 |  373 --
 sound/soc/blackfin/bf5xx-i2s-pcm.h                 |   17 -
 sound/soc/blackfin/bf5xx-i2s.c                     |  391 --
 sound/soc/blackfin/bf5xx-sport.c                   | 1102 -----
 sound/soc/blackfin/bf5xx-sport.h                   |  174 -
 sound/soc/blackfin/bf5xx-ssm2602.c                 |  126 -
 sound/soc/blackfin/bf6xx-i2s.c                     |  239 --
 sound/soc/blackfin/bf6xx-sport.c                   |  425 --
 sound/soc/blackfin/bf6xx-sport.h                   |   82 -
 sound/soc/blackfin/bfin-eval-adau1373.c            |  173 -
 sound/soc/blackfin/bfin-eval-adau1701.c            |  113 -
 sound/soc/blackfin/bfin-eval-adau1x61.c            |  142 -
 sound/soc/blackfin/bfin-eval-adau1x81.c            |  129 -
 sound/soc/blackfin/bfin-eval-adav80x.c             |  145 -
 198 files changed, 7 insertions(+), 56230 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-etraxfs.txt
 delete mode 100644 Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt
 delete mode 100644 drivers/ata/pata_bf54x.c
 delete mode 100644 drivers/char/bfin-otp.c
 delete mode 100644 drivers/char/ds1302.c
 delete mode 100644 drivers/char/tile-srom.c
 delete mode 100644 drivers/cpufreq/blackfin-cpufreq.c
 delete mode 100644 drivers/cpufreq/cris-artpec3-cpufreq.c
 delete mode 100644 drivers/cpufreq/cris-etraxfs-cpufreq.c
 delete mode 100644 drivers/crypto/bfin_crc.c
 delete mode 100644 drivers/crypto/bfin_crc.h
 delete mode 100644 drivers/edac/tile_edac.c
 delete mode 100644 drivers/gpio/gpio-etraxfs.c
 delete mode 100644 drivers/i2c/busses/i2c-bfin-twi.c
 delete mode 100644 drivers/input/keyboard/bf54x-keys.c
 delete mode 100644 drivers/input/misc/bfin_rotary.c
 delete mode 100644 drivers/media/platform/arv.c
 delete mode 100644 drivers/media/platform/blackfin/Kconfig
 delete mode 100644 drivers/media/platform/blackfin/Makefile
 delete mode 100644 drivers/media/platform/blackfin/bfin_capture.c
 delete mode 100644 drivers/media/platform/blackfin/ppi.c
 delete mode 100644 drivers/mmc/host/bfin_sdh.c
 delete mode 100644 drivers/mtd/maps/bfin-async-flash.c
 delete mode 100644 drivers/mtd/nand/raw/bf5xx_nand.c
 delete mode 100644 drivers/net/can/bfin_can.c
 delete mode 100644 drivers/net/cris/Makefile
 delete mode 100644 drivers/net/cris/eth_v10.c
 delete mode 100644 drivers/net/ethernet/adi/Kconfig
 delete mode 100644 drivers/net/ethernet/adi/Makefile
 delete mode 100644 drivers/net/ethernet/adi/bfin_mac.c
 delete mode 100644 drivers/net/ethernet/adi/bfin_mac.h
 delete mode 100644 drivers/net/ethernet/tile/Kconfig
 delete mode 100644 drivers/net/ethernet/tile/Makefile
 delete mode 100644 drivers/net/ethernet/tile/tilegx.c
 delete mode 100644 drivers/net/ethernet/tile/tilepro.c
 delete mode 100644 drivers/pcmcia/bfin_cf_pcmcia.c
 delete mode 100644 drivers/pcmcia/m32r_cfc.c
 delete mode 100644 drivers/pcmcia/m32r_cfc.h
 delete mode 100644 drivers/pcmcia/m32r_pcc.c
 delete mode 100644 drivers/pcmcia/m32r_pcc.h
 delete mode 100644 drivers/pinctrl/pinctrl-adi2-bf54x.c
 delete mode 100644 drivers/pinctrl/pinctrl-adi2-bf60x.c
 delete mode 100644 drivers/pinctrl/pinctrl-adi2.c
 delete mode 100644 drivers/pinctrl/pinctrl-adi2.h
 delete mode 100644 drivers/pwm/pwm-bfin.c
 delete mode 100644 drivers/rtc/rtc-bfin.c
 delete mode 100644 drivers/rtc/rtc-tile.c
 delete mode 100644 drivers/spi/spi-adi-v3.c
 delete mode 100644 drivers/spi/spi-bfin-sport.c
 delete mode 100644 drivers/spi/spi-bfin5xx.c
 delete mode 100644 drivers/staging/iio/trigger/Kconfig
 delete mode 100644 drivers/staging/iio/trigger/Makefile
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.c
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.h
 delete mode 100644 drivers/staging/irda/drivers/bfin_sir.c
 delete mode 100644 drivers/staging/irda/drivers/bfin_sir.h
 delete mode 100644 drivers/tty/bfin_jtag_comm.c
 delete mode 100644 drivers/tty/hvc/hvc_bfin_jtag.c
 delete mode 100644 drivers/tty/hvc/hvc_tile.c
 delete mode 100644 drivers/tty/serial/bfin_sport_uart.c
 delete mode 100644 drivers/tty/serial/bfin_sport_uart.h
 delete mode 100644 drivers/tty/serial/bfin_uart.c
 delete mode 100644 drivers/tty/serial/crisv10.c
 delete mode 100644 drivers/tty/serial/crisv10.h
 delete mode 100644 drivers/tty/serial/etraxfs-uart.c
 delete mode 100644 drivers/tty/serial/m32r_sio.c
 delete mode 100644 drivers/tty/serial/m32r_sio_reg.h
 delete mode 100644 drivers/tty/serial/tilegx.c
 delete mode 100644 drivers/usb/host/ehci-tilegx.c
 delete mode 100644 drivers/usb/host/ohci-tilegx.c
 delete mode 100644 drivers/usb/musb/blackfin.c
 delete mode 100644 drivers/usb/musb/blackfin.h
 delete mode 100644 drivers/video/fbdev/bf537-lq035.c
 delete mode 100644 drivers/video/fbdev/bf54x-lq043fb.c
 delete mode 100644 drivers/video/fbdev/bfin-lq035q1-fb.c
 delete mode 100644 drivers/video/fbdev/bfin-t350mcqb-fb.c
 delete mode 100644 drivers/video/fbdev/bfin_adv7393fb.c
 delete mode 100644 drivers/video/fbdev/bfin_adv7393fb.h
 delete mode 100644 drivers/video/logo/logo_blackfin_clut224.ppm
 delete mode 100644 drivers/video/logo/logo_blackfin_vga16.ppm
 delete mode 100644 drivers/video/logo/logo_m32r_clut224.ppm
 delete mode 100644 drivers/watchdog/bfin_wdt.c
 delete mode 100644 include/linux/bfin_mac.h
 delete mode 100644 include/linux/platform_data/bfin_rotary.h
 delete mode 100644 include/linux/platform_data/pinctrl-adi2.h
 delete mode 100644 include/linux/usb/tilegx.h
 delete mode 100644 include/media/blackfin/bfin_capture.h
 delete mode 100644 include/media/blackfin/ppi.h
 delete mode 100644 lib/raid6/tilegx.uc
 delete mode 100644 sound/soc/blackfin/Kconfig
 delete mode 100644 sound/soc/blackfin/Makefile
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97-pcm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97.h
 delete mode 100644 sound/soc/blackfin/bf5xx-ad1836.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ad193x.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ad1980.c
 delete mode 100644 sound/soc/blackfin/bf5xx-ad73311.c
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s-pcm.c
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s-pcm.h
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s.c
 delete mode 100644 sound/soc/blackfin/bf5xx-sport.c
 delete mode 100644 sound/soc/blackfin/bf5xx-sport.h
 delete mode 100644 sound/soc/blackfin/bf5xx-ssm2602.c
 delete mode 100644 sound/soc/blackfin/bf6xx-i2s.c
 delete mode 100644 sound/soc/blackfin/bf6xx-sport.c
 delete mode 100644 sound/soc/blackfin/bf6xx-sport.h
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1373.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1701.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1x61.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adau1x81.c
 delete mode 100644 sound/soc/blackfin/bfin-eval-adav80x.c

-- 
Cc: linux@roeck-us.net
Cc: corbet@lwn.net
Cc: tj@kernel.org
Cc: gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org
Cc: herbert@gondor.apana.org.au
Cc: davem@davemloft.net
Cc: bp@alien8.de
Cc: mchehab@kernel.org
Cc: linus.walleij@linaro.org
Cc: wsa@the-dreams.de
Cc: dmitry.torokhov@gmail.com
Cc: ulf.hansson@linaro.org
Cc: boris.brezillon@bootlin.com
Cc: cyrille.pitchen@wedev4u.fr
Cc: wg@grandegger.com
Cc: mkl@pengutronix.de
Cc: alexandre.belloni@bootlin.com
Cc: broonie@kernel.org
Cc: jic23@kernel.org
Cc: lars@metafoo.de
Cc: jslaby@suse.com
Cc: stern@rowland.harvard.edu
Cc: b.zolnierkie@samsung.com
Cc: shli@kernel.org
Cc: linux-watchdog@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-edac@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Cc: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-rtc@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-raid@vger.kernel.org
Cc: alsa-devel@alsa-project.org
