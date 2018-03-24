Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-393451-1521921979-5-18396355140243149916
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521921978; b=sGdX1gNc87FQYhn9b86aliSxjgCkPeptewvBgi8T6UP7UaP
    PDXEFtSXPcXyYiXI6FW7Y8kNsks+W8x9uyQEsmvgMgTYoh14ffZgNd+pS9OLR3X5
    9yxxgOh4Np1OOWp4OpBOJQwG3TVjy/Zhmbt2zk1VQsct/hfu2PVQsxIhUqk0LR9T
    8e2v7ydV3qDzP8jojlWgYrqBFC186g/bPAI9L7oUCEjoIoPIdTMWpeS+7d32yBZv
    f/IpiOL4hTEfd3r9oxa+0baM0WdARLC6ltC0jxnvXuG2kf5u5aw27AE3JVEJydfM
    f/4Hzaf/4to7agc3ezHu9NLSa4oD5nIq2mffc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521921978; bh=a
    JWkXr2bLeq3fZaL+tGYJ8pGozh1SgYHaxKDWNJMKgw=; b=kgmvSLyekhHDWcbRu
    5bb1ku4GBRm6AU2cKlFLdVfOApTzBuWU78Mx/RjPCksXHzVG/WkC3z7KN1Q1NV3Z
    4mtOKoC1fyIOZnKKwiZPMmpRQsUujCbWcEaQGA2WE4Tvdu9od1bPUk7+ZRWH5MZy
    qLSEOJRrVLkTSbEEcjHEBS1WMcfTZHKbfQWHKb+0LbNv/8hKHsaL57AASqwBagf1
    u72U8FtWzjL/0OGbHG40/Uk20Rk/Slsf1zjDsYb7qnQ4siyvBwwjacOiwyDJ693g
    5PUpYnkxjzrMWgPu1z3IU3WbkiKcO7poGxBnvsMhNLlpj6V5jerU2X4g+cVeG6rO
    jKfMA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=ehDOAgRK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=ehDOAgRK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 0/4] staging: iio: tsl2x7x: move out of staging
Date: Sat, 24 Mar 2018 16:05:51 -0400
Message-Id: <20180324200555.1403-1-masneyb@onstation.org>
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
 linux-kernel@vger.kernel.org, Jon.Brenner@ams.com, pmeerw@pmeerw.net,
 knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Here is a patch series to move the tsl2x7x driver out of staging and
into mainline. Driver was tested using various TSL2X7X devices on a
Raspberry Pi 2.

Datasheet for the TSl2772:
https://ams.com/eng/content/download/291503/1066377/file/TSL2772_DS000181_2-00.pdf

Brian Masney (4):
  staging: iio: tsl2x7x: use auto increment I2C protocol
  staging: iio: tsl2x7x: move IIO_CHAN_INFO_CALIB{SCALE,BIAS} to
    IIO_LIGHT channel
  staging: iio: tsl2x7x: use either direction for
    IIO_EV_INFO_{ENABLE,PERIOD}
  staging: iio: tsl2x7x: move out of staging

 drivers/iio/light/Kconfig                          |   8 ++
 drivers/iio/light/Makefile                         |   1 +
 drivers/{staging => }/iio/light/tsl2x7x.c          | 135 +++++++++++++--------
 drivers/staging/iio/Kconfig                        |   1 -
 drivers/staging/iio/Makefile                       |   1 -
 drivers/staging/iio/light/Kconfig                  |  14 ---
 drivers/staging/iio/light/Makefile                 |   5 -
 .../linux/platform_data}/tsl2x7x.h                 |   0
 8 files changed, 93 insertions(+), 72 deletions(-)
 rename drivers/{staging => }/iio/light/tsl2x7x.c (95%)
 delete mode 100644 drivers/staging/iio/light/Kconfig
 delete mode 100644 drivers/staging/iio/light/Makefile
 rename {drivers/staging/iio/light => include/linux/platform_data}/tsl2x7x.h (100%)

-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
