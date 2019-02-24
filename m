Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1214C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8811B20663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfBXQWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:22:09 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:52425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfBXQWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 11:22:09 -0500
Received: from localhost ([2.174.161.193]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MSLlu-1gZieV3ceu-00SdjN; Sun, 24 Feb 2019 17:21:36 +0100
Date:   Sun, 24 Feb 2019 17:21:28 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     afaerber@suse.de, arnd@arndb.de, davem@davemloft.net,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        jic23@kernel.org, johan@kernel.org, khilman@baylibre.com,
        knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh+dt@kernel.org, robh@kernel.org,
        songqiang1304521@gmail.com, treding@nvidia.com
Subject: [PATCH 0/4] add maxbotix ultrasonic iio driver
Message-ID: <20190224162126.vzzstmm7rcv6mnh7@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:SAbNNC5MUIhI8KAerSt3T0epsEO8zx0Wm8Mis03Pj02jIuDtkg5
 XbouBGuFG5z6tLxKWSrs6R3p7TAoq6LMkpKUn/VWuMYucOLLjlTdd+BsDttyOZ/pH/ziDdy
 AWkaOACHaq9lpEcUY+Wy69AJrZjbbgx6b6peym95XRNtYA0tstlbLR+t2jyW79RrNdsxEQX
 FKKlcsHKUMp7eddsj9rLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:teIkQtTBTeI=:/wxAFRqLE8ZNOENbg81Sqx
 vhddWNYWgTqlCZ4SEwTm00UwsVJ6o4Y4wi6PMgGICTvZFJBPBlVWbR8WiJgEvGAyZPLtZUk2U
 sNFK10P25MiZviW8FOGsvJIdKYF5CiJvmcycGkQMNajJnpG0U71p08DCa6+BbGX7kqW5b+w8+
 5AO97WTmExsAOUWFttIVgAR6yTqQGC1/qDEa+SdESP5A+/qHhHXn16z2lUxCKHLMmSmQp0MiE
 SyQtsbCf1SkThhDmtB1r8dQA3t9OMA7AVo2BZusfr8ARGhaiaiWHyyzyJ6ZDj7sRBe32ispYn
 res8J5iHpQiMPvVHVkVvld9WnNkXX64HO2wbmCbB9TuTQblTf3t2MRMZqXnwbuVAkPPqLiSa3
 NPsdZXZEOLcakCut/N1rUEYBWerUZYAjHLv8WlI8wjXphvGt2ypdrUStjTS4GtXDocmrDUdZX
 aOhoPVVASEvf1zLuTjj+QsO/uW0ld+50CUTpS6VNvjTXpEEG7g02bJICSx6niuCrt2iOEf/AG
 NRwXC0wY8XRFc32iMRqhcCTLp9Vt4ksVqExqiFm4U4QbNHKon3E3HLokLt3g0fbUcrFXTQ8Tp
 fph+OToMLqb+OJRAdwlggaOQirRbfTSru3mJHmBbUhkcFqEXgcLFoG/tDUtVN3E4QiNjNTbxu
 YBQQnHKDNT17+JZD6dQlPJtOKk+ZQA2JWwGfNsaYo6cANu0xXwxZwaIHoWLFsoKr2C4id+0rK
 16iteMV+pk0O3TQn75BTqwlXGczHSsBSeMrOwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for MaxSonar-I2CXL ultrasonic distance
sensors of family mb12x2 using the i2c interface of vendor maxbotix
    
Implemented and tested functionality:
- reading the distance via in_distance_raw
- buffered mode with trigger
- make use of status gpio to announce completion of ranging


Andreas Klinger (4):
  maxbotix,mb12x2.txt: add dt doc for maxbotix,mb12x2
  iio/proximity: add mb12x2 driver to Kconfig and Makefile
  mb12x2.c: add mb12x2 ultrasonic distance iio sensor
  MAINTAINERS: add maintainer for maxbotix ultrasonic driver

 .../bindings/iio/proximity/maxbotix,mb12x2.txt     |  22 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   7 +
 drivers/iio/proximity/Kconfig                      |  11 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/mb12x2.c                     | 283 +++++++++++++++++++++
 6 files changed, 325 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb12x2.txt
 create mode 100644 drivers/iio/proximity/mb12x2.c

-- 
2.11.0
