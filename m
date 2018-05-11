Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526036969; cv=none;
        d=google.com; s=arc-20160816;
        b=mcipsGpdrKEIM6GKJFrUr996aHNRyjQJvO/YqRQ/7iswxWLnQlkwgJG+Q03vfiwKml
         JQN/juhURnbglTS2ZBZPaLXJd3T1T8EBFZ76/a+fDmu4YBQsOlEhLtf+y9Fl50vNkSfP
         hpKAJEXXGpUIUer9PJPmHpsqBEEphqUtdyEswbGFU8VrNnrq9hN4NYNU5lkd5D/TnoF4
         MLDkTX0JU30GvDqn7Uowp8Y6OeOJFMoAGAoo02gG4uCFWZAeNOeozGWAThUhG5j2uPBK
         Nl1DMNYO0CRaB0IRQAbphmVK4mKVC5xPzy/RkQQwzuA2BRoJ4TM1zrTkzarw+tAYVftc
         n15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=rZA7mpeWn81QZnJHiHVDFrsZQlN9TH0Lcl45w1EZ/Cs=;
        b=p8dpiPpEHClNUHx/RxjlSvQz07xIeUFZJ/IQhXm9hqtqDptuzh1o4s743TUToLn19T
         E91yjgwajG3njBix+0QJz06LDFF6bXjnrvsk/2UsNWhsSRVf6Ks1LvGztSLXCODRvxOy
         GoIVCr3euJ5pJrZLybjELYhgOt9iYkH8jv2/NM1rUCIFLNXayC8cpVANsXW7dB+Z85ix
         6/kQkxq4Wx6G/GYDokyddEAVjedmiLrY53Pg+mAmThD8W+69j0QoaEI8MsOV3jpqi0PP
         UYR3+g48Glxzi7mNvdkvSn2Ghe6rTgtUTCYQZQK021/B3Y9r/E+F8olNaYPm3OPFlP3G
         ITQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=IeoCCWcF;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=IeoCCWcF;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpUDSCphNH4aNuQWQpEu97LXmXj3JJ7hhCzBljfKMvi21f8pxqxWK0EpIBdSLOBac+Rcfc2Mg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org
Subject: [PATCH 0/8] nvmem: patches for v4.18
Date: Fri, 11 May 2018 12:06:55 +0100
Message-Id: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600165740989682591?=
X-GMAIL-MSGID: =?utf-8?q?1600165740989682591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Here are some nvmem enhancements, fixes, write support to meson efuse
and new RAVE SP eeprom driver.

Can you queue them up for 4.18.

Thanks,
Srini

Andrew Lunn (1):
  drivers: nvmem: Export nvmem_add_cells()

Andrey Smirnov (2):
  dt-bindings: nvmem: Add binding for RAVE SP EEPROM driver
  nvmem: Add RAVE SP EEPROM driver

Jerome Brunet (3):
  nvmem: meson-efuse: remove econfig global
  nvmem: meson-efuse: simplify read callback
  nvmem: meson-efuse: add write support

Mathieu Malaterre (1):
  nvmem: properly handle returned value nvmem_reg_read

Srinivas Kandagatla (1):
  nvmem: core: describe add missing dev function parameter

 .../bindings/nvmem/zii,rave-sp-eeprom.txt          |  40 +++
 drivers/nvmem/Kconfig                              |   6 +
 drivers/nvmem/Makefile                             |   3 +
 drivers/nvmem/core.c                               |  33 +-
 drivers/nvmem/meson-efuse.c                        |  41 +--
 drivers/nvmem/rave-sp-eeprom.c                     | 357 +++++++++++++++++++++
 include/linux/nvmem-provider.h                     |  11 +
 7 files changed, 465 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
 create mode 100644 drivers/nvmem/rave-sp-eeprom.c

-- 
2.16.2
