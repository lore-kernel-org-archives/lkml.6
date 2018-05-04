Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3535272-1525402419-2-12302219216634390803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525402418; b=cU+vOtfY56Kmm5U2XAUeYsPq7ME10OtOAww9pJhGdo4+R7zOYK
    oPuUOfQ/PyEr3Amd9wKTUWJJUJXyCbU1pNNpfddzKVh8fcRS0wWUHKPqPpO5KXLC
    RJz3Utdby7kTctkUzZ2IFWIpoWMbXn5mP5Sry4KAM7rz0YyGGsS+ZBA2F+yht8gG
    hL3IkhKA5uKJVc0Oac2eMQairt7rBJeiFUn1DQlyKkcApjr8c+R9q7G0YCU8F4Wu
    9YHftwiath5a1Xu/xtAFh2IYdHsyXJPod2kk5boqbgN85znUeO5K/AnJ2nl+BlHk
    5dcqoeh8ZZIyiQE+nykiarAPtRDU3/sfZF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525402418; bh=4LQPr
    Y/ziAU6YsoWFn6tUOPN8EsKTGXhC18xQKP/pGQ=; b=BD7U+zdZNj8HxiYx+NxiX
    U1M0N/axtLyJeOBzViH7SHKQVh5Gy2GfK918aIINhBKarcSblCjHdw00mJ+EWx6V
    JdCvwDU11upgCO//WnzGoHBcuZl+/5HAY+hTvG/7ldC+cYfu9rlF/fPiJvHDGcfX
    m5iG0WcWWMsxo1tAdoHgZTr0lKtwvICQYGEijKKdSj61AL0exOh++AMMxC6H/2iK
    a4T3KQPEBhC6iyr3NtQI3uUJdJE4qAhBSnqbA/8T6v5AstOxvKJ50R0HkdgwF1xd
    kkOAtodpyAtbcz9L+030ckMKt0JjezWakX1Zg2HC0723WGlQHCz6BM7KuskpBwVA
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=OCrinXIG
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=onstation.org
    header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=OCrinXIG
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=onstation.org
      header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ+UXaKHZ8QJl/UtFQVGQsACMYLUmdNR5pqCwvFzqgv0G+aIHWbr8tD98x3oXnhi0WY654AfGsrUyOt1NO7TmmaaF6vvXIkG6mwwcPiq3dII3S/ziAwm
    mhRbbp8rnMJ7UsKYpI9tXNtyYGCS3mQvx7UkZCzSgk/xbaYmpOEq1XRDbjml4mgtM1v48bJ3+VmfDU/9xAERno0B2dUqgYvHai16wft9hzfe9DimC3hLE5At
    CHzUDzDUaRENuM1TH64vYg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=GlixS5zuAAAA:8 a=DDOyTI_5AAAA:8
    a=8zmZHBd01WwV5EFtf9MA:9 a=CjuIK1q_8ugA:10 a=adCy40026U1O_QNtz7Gb:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 00/11] staging: iio: tsl2x7x: move out of staging
Date: Thu,  3 May 2018 22:53:08 -0400
Message-Id: <20180504025319.28953-1-masneyb@onstation.org>
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

Here is a patch set that should hopefully be the last of the changes
required for a staging graduation. Changes since v1:

- Use correct syntax for SPDX license identifier
- Use kstrtou16 for range checking
- Correct integration time sysfs attribute. This fix required correcting
  all of the equations and coefficients. Fortunately TAOS / AMS has
  really good documentation available.
- Rename driver from tsl2x7x to tsl2772.

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

Brian Masney (11):
  staging: iio: tsl2x7x: use GPL-2.0+ SPDX license identifier
  staging: iio: tsl2x7x: add range checking to three sysfs attributes
  staging: iio: tsl2x7x: don't setup event handlers if interrupts are
    not configured
  staging: iio: tsl2x7x: move calibscale_available attribute to
    IIO_INTENSITY channel
  staging: iio: tsl2x7x: use IIO_CONST_ATTR for calibscale_available
  staging: iio: tsl2x7x: correct integration time and lux equation
  staging: iio: tsl2x7x: support 2.72 and 2.73 ALS increments
  staging: iio: tsl2x7x: add device ids for code readability
  staging: iio: tsl2x7x: correct IIO_EV_INFO_PERIOD values
  staging: iio: tsl2x7x: rename driver to tsl2772
  staging: iio: tsl2x7x/tsl2772: move out of staging

 drivers/iio/light/Kconfig                          |    8 +
 drivers/iio/light/Makefile                         |    1 +
 .../iio/light/tsl2x7x.c => iio/light/tsl2772.c}    | 1137 ++++++++++----------
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/light/Kconfig                  |   14 -
 drivers/staging/iio/light/Makefile                 |    5 -
 .../linux/platform_data/tsl2772.h                  |   65 +-
 8 files changed, 631 insertions(+), 601 deletions(-)
 rename drivers/{staging/iio/light/tsl2x7x.c => iio/light/tsl2772.c} (50%)
 delete mode 100644 drivers/staging/iio/light/Kconfig
 delete mode 100644 drivers/staging/iio/light/Makefile
 rename drivers/staging/iio/light/tsl2x7x.h => include/linux/platform_data/tsl2772.h (58%)

-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
