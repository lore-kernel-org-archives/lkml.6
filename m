Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2975690-1525997564-2-13109447482792119827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525997563; b=UB2A0ihZ/64bR9+612/ueavqAMwgV7wCi1OThFGr15dFPkBEcp
    2kZZZkGrgkvVdufdRtLLAVrfBJZ/s/ywN8N2PRI3kKiXSOKvE6OX8RpXHBNIRxa1
    UgZY6z5eD8eAwGUYpHFpS0J8x7ww9uP0V092jV6UL/21idref8nM+L3NwGGrzjHQ
    gCsQJV7nHNxshW5sPHHlZ24Y3DQ1Uql3O+CdPUczVQhDaF/LpqUexxSw8xXkF4aw
    99uVDor4gWaEZVVm9BRPVYnf7PTbahunhTdPzcj0fdYQ4lmkBdGBvvHW3PgDk4BF
    7TqJ1r77mAuU1f0wjPCaH8tanK+lYmG2cwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525997563; bh=GW/9h
    cG08aYVgouGiCtpgk5Mfuy8iEXx4Ln23kA+q3I=; b=gG84lqSeqzd40lsgbMiMl
    CUi1gMGQXy2VnYp8M+fil4yHxFCSk6X9nKV5ra9LAL7gZYS46hi3sbT4l7Yr/v0C
    Bw/X61b+zjFbgmH3lHHP5hv35vGrdhtBk8FpQ659++F09mP1RIrcpnGEkxmYqaKh
    7mXLcDwsXhGRfY+rUnUfr0xJ7CQFtCJvAyIhhDk3g3bdAjJ6mKq0eUstZWauyeut
    a2y8Y9kvUoFR1QAhYAU5ahFChCSxCHXLH2/a7V8PDGPurBk7hYHDktM2+geNA5t0
    diL/2As8U67etrZprChUAIGUgXkow/ndjtOhLeggC5UgXc4heCKn9GiM5PE51Cgp
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=olECgyX4
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=onstation.org
    header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=olECgyX4
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=onstation.org
      header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI8J0SRy4M5ycd894XJaGAKWLDpph3TDx5evYNVjTCTPI/HcITq3tg50Q9f9TZLDf71h+scGm0I79Yzm2TlybiQwpJmhsiULFFY051KhK/StD5KV/JVh
    2JB761/InqBuy8AL295Ggtw5+nkRYL0h0AjK4rsrzVhDXZp4rr6nBF+loOfy02h7RfIaTnDnV1f4KGguTw5NqW1gJNgWe32yGoQib4Ay7l67aEEkLwlnoA9D
    dDSWiSH70t+3lkTt8n+wiQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=GlixS5zuAAAA:8 a=DDOyTI_5AAAA:8
    a=C0GCQNNq987cKD6j32UA:9 a=CjuIK1q_8ugA:10 a=adCy40026U1O_QNtz7Gb:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 0/9] staging: iio: tsl2x7x: move out of staging
Date: Thu, 10 May 2018 20:12:14 -0400
Message-Id: <20180511001223.12378-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 drew.paterson@ams.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hopefully this is the last of the changes that are required for a
staging graduation. Changes since v2:

- Correct values returned in in_intensity0_integration_time_available so
  that it doesn't break expected ABI. The driver now uses the read_avail
  for all three *_available sysfs attributes.
- Remove unnecessary whitespace
- Direct returns
- Turn chip off if IIO registration fails
- Add range checking to tsl2x7x_write_raw

Datasheet for TSL2772
https://ams.com/eng/content/download/291503/1066377/file/TSL2772_DS000181_2-00.pdf

Other datasheets:

ALS only
- https://ams.com/eng/content/download/250043/975277/file/TSL2571_DS000114_2-00.pdf
- https://ams.com/eng/content/download/291224/1065822/file/TSL2572_DS000178_2-00.pdf

Proximity Only
- https://ams.com/eng/content/download/250323/976177/file/TSL2671_DS000111_2-00.pdf
- https://ams.com/eng/content/download/250304/976107/file/TMD2671_DS000176_2-00.pdf
- https://ams.com/eng/content/download/291443/1066277/file/TSL2672_Datasheet_EN_v1.pdf
- https://ams.com/eng/content/download/364923/1210537/file/TMD2672_Datasheet_EN_v1.pdf

ALS / Proximity
- https://ams.com/eng/content/download/250264/976045/file/TSL2771_DS000105_3-00.pdf
- https://ams.com/eng/content/download/250283/976077/file/TMD2771_DS000177_2-00.pdf
- https://ams.com/eng/content/download/365023/1210677/file/TMD2772-E.pdf

Brian Masney (9):
  staging: iio: tsl2x7x: remove unnecessary whitespace
  staging: iio: tsl2x7x: use direct returns
  staging: iio: tsl2x7x: turn chip off if IIO device registration fails
  staging: iio: tsl2x7x: use macro to populate tsl2X7X_device_info
  staging: iio: tsl2x7x: convert to use read_avail
  staging: iio: tsl2x7x: correct IIO_EV_INFO_PERIOD values
  staging: iio: tsl2x7x: add range checking to tsl2x7x_write_raw
  staging: iio: tsl2x7x: rename driver to tsl2772
  staging: iio: tsl2x7x/tsl2772: move out of staging

 drivers/iio/light/Kconfig                          |   8 +
 drivers/iio/light/Makefile                         |   1 +
 .../iio/light/tsl2x7x.c => iio/light/tsl2772.c}    | 886 +++++++++++----------
 drivers/staging/iio/Kconfig                        |   1 -
 drivers/staging/iio/Makefile                       |   1 -
 drivers/staging/iio/light/Kconfig                  |  14 -
 drivers/staging/iio/light/Makefile                 |   5 -
 .../linux/platform_data/tsl2772.h                  |  51 +-
 8 files changed, 494 insertions(+), 473 deletions(-)
 rename drivers/{staging/iio/light/tsl2x7x.c => iio/light/tsl2772.c} (59%)
 delete mode 100644 drivers/staging/iio/light/Kconfig
 delete mode 100644 drivers/staging/iio/light/Makefile
 rename drivers/staging/iio/light/tsl2x7x.h => include/linux/platform_data/tsl2772.h (70%)

-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
