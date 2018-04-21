Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2940329-1524271338-8-7784531523664656617
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524271338; b=me3Xi2yHl2ncAFE7BfhoSBqpjxo9kWki4woBJrSCiYq4ZGO6XR
    06np2WPtTQzzwqS8yT8McvoC74WU++taUyEbI9vFzEEBPgxrgax+lEqRnUEYdcGF
    cacur31+KS0XWCkhMDt3Uhkys6s/zK/fAXLgIeI/Zbe9kO1fHmY5Tq9C9U2aXnAK
    hYHVryTbdpDAQNDVHLNoX87IBG83WFwfv0hInuxXDhmRJJRyvrLgKCy93i2e1RP/
    GtkJ8LWemi36eczBwWftB/v3kJhioeEQuzzQhvX5ubLR2aUGjnggHyFsRybFP3RZ
    mCaGCrVW0DLpfX1wlwM0Co4PSNrWvrKpNZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524271338; bh=lCUCH
    KpCVTEj3+jgkwJwDN08JEgwX7WSCaeA1L19SdE=; b=h1qnhci5kZBkG1QbwuwSL
    oSEvw5Z9BJLfCVR2FLOA8uKYf2iOJA4fRqkFprQhDn5Kf55TYpvs2VK7OBJ4Ge+t
    xFrpArs5rGESLzKhEbgGzkE2vXlNH7xnuTuN2wf1Lm7zyOiL7HYDyxxNcHLz8t6j
    wUu/xwTw03ZNSNTkX35pLFgMSRVdCa/Wg5l+4EWMozdX31EKSM4C9eyOZv0lUdI4
    CwerhUa3S5ypY1C+eTINwRxOOr40+SPehGQFEISdHpEk85TgtsoHjHBlE8dWUcli
    mYJ2BRo5lOH7tJOOViDf9tXyInOsrUGS/muYTUWxQJaXb2xcw5xtGCFFNngy2w+D
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=jDWNYb28 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=jDWNYb28 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEfgKzOr5w+pQn8HtnaPWY7TST/9q2J0IeSZUHARwRQNdqotqyL1S4wiUwV2WZRz2zZa+Ab0JPG5gqeNMjkI3xMcH5op9MgEA2oGDPcLs4u/TR7y1LP6
    y8QkEGHhWwkitLM89GzMsKRMnK4HItxKQX8a6OpiFCCB/ib6ChSXCOjjAtc5xsvtiYB60VRyx9tPrFmVV22VJrJNv4xxeMvz3LpHpbhaNrUCcxYKd0SK/7c3
    Ij84PehQJTkeAtEGvmVgZw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=4fVpNkbaJbf7GpT03SYA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 00/13] iio: tsl2x7x: staging cleanups
Date: Fri, 20 Apr 2018 20:41:40 -0400
Message-Id: <20180421004153.19073-1-masneyb@onstation.org>
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

Here is another round of staging cleanups for this driver mostly based
on Jonathon's feedback. We're very close to a staging graduation and I
only have a few items remaining on my todo list:
 
- Remove wildcards from the driver name. Jonathan suggested tsl2571.
- Don't make the events/ directory available to user space via sysfs if
  an interrupt pin is not configured.
- Go through the newer ALS part numbers on AMS's site and see if there
  are other part numbers that can be added to this driver.
- I found this week an issue with the integration_time sysfs attribute.

Hopefully I'll have time to wrap this up next week.

Brian Masney (13):
  staging: iio: tsl2x7x: move integration_time* attributes to
    IIO_INTENSITY channel
  staging: iio: tsl2x7x: use GPL-2.0+ SPDX license identifier
  staging: iio: tsl2x7x: don't return error in IRQ handler
  staging: iio: tsl2x7x: simplify tsl2x7x_clear_interrupts function
  staging: iio: tsl2x7x: remove unnecessary chip status checks in
    suspend/resume
  staging: iio: tsl2x7x: simplify tsl2x7x_write_interrupt_config return
  staging: iio: tsl2x7x: simplify device id verification
  staging: iio: tsl2x7x: add range checking to three sysfs attributes
  staging: iio: tsl2x7x: move power and diode settings into header file
  staging: iio: tsl2x7x: rename prx to prox for consistency
  staging: iio: tsl2x7x: use device defaults for als_time, prox_time and
    wait_time
  staging: iio: tsl2x7x: various comment cleanups
  staging: iio: tsl2x7x: rename prox_config to als_prox_config

 drivers/staging/iio/light/tsl2x7x.c | 217 ++++++++++++++----------------------
 drivers/staging/iio/light/tsl2x7x.h |  81 +++++++-------
 2 files changed, 125 insertions(+), 173 deletions(-)

-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
