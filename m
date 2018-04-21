Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4094253-1524311723-2-11843885959825960891
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524311722; b=Hqw7Apw//rmKmyaZ4pFG5nG0ox3AAo+UPzV6Ri0vUnHVixB9pm
    QdNt0fQdulhZVsO3gwPhh1C2NSazzzE56iQDRxqxHllukSIOUzkCK+/SLo5yLQka
    NMzBcY/q1CzP/xOYLgiMfM1ktoHrulFdhz6wPi70Cy2sVc/bixn4iwjLcec8RsqF
    EmxOUjPPrTlG3fuHqOqB9Jo7B1S5b4ule6zmUDOq4+hyeDIPGmhBJFCtL3bOWuex
    oJsCgTb7nfnTVCiKdXa4V5rmf/4bWJXkR85SHwQ1YlNMqjjrm0iBU7I8vNY0X/j8
    enf4PPaJ5oicyvp+ilAEqT1vP/Qpfx8Pxuvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524311722; bh=d6EY3
    bQAw1Sqsi7k7sS5A4u+xCIwSxtR8xowD7UoQ5s=; b=kETnqXmLBZeP4+KmDnLRl
    BXeSXT4UNRhxBLdMwNOK+oAij71l3kFkF6X7KwYIVLeuiA2L4hs8Q1rDn3bwh2s1
    BpABCKvPUlEzK+uKKv/6RZ0cSkYeXjeolg5ZNridz4fS9/j6/QbTNDKki8htwUKj
    nlv2yIR5jFmvdmSqMuVwYFqqngCqCiuYGNVcpbrjNLOj6KeFLhBI86JicdmCPof9
    x6omScg+dOzyED3nSf70z9t1ywrIjUoBltflck155TsecDpY07y2C/uSYwKRHQwi
    xOn/DCvoN36T2d6BA6AJBLo/L5XXFJ8UJ4WTAjVG61x6cBNX3Fps5UdFgeTjSToB
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Kkk+yhDT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lUX3BhQd;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Kkk+yhDT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lUX3BhQd;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBuRpxJEdAKcQD6qz+X1+zIfWqgRucEakfXiKrdl241ypek7s041p+c48Me1iVtUmN9Zk0zLDy+HkxyfGthmVkQ6CHbuj4AOuJl+MijU229n1QAtTSrw
    UrCx2i5TFrq2/OXyd2znIbxghHndfawV3b7U+e63v6QdfnUYsoXMEo5ReLeJHJ8n3Vr0/o3jMoROZdlDbOpCZVRgd6COaT/caitkdp3RWztkEwA3DVaHULHX
    gC8rxfnJM+I64l/+esW2EQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=px3f5oUF_X8A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=yly2_HTU7yqINEuI3MYA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49Qgl77WHlxozTySq6ntOSFVUbt5mHLh59nS8wbBHVIO9/bPwIF5eFclhoRVYRY8i74reiYug==
Date: Sat, 21 Apr 2018 08:55:08 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Syne <john3909@gmail.com>
Subject: [PATCH 1/3] stagging:iio:meter: Add iio_chan_spec
Message-ID: <957b06793a65e0209dc794489b0ae815071b0992.1524311298.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180323
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
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds iio_chan_spec struct. Additionally, the channel adds the
support for handling AIGAIN, BIGAIN, CIGAIN, NIGAIN, AVGAIN, BVGAIN, and
CVGAIN.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 029c3bf42d4d..2fbb2570ba54 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -22,6 +22,48 @@
 #include "meter.h"
 #include "ade7854.h"
 
+#define PHASEA "phaseA"
+#define PHASEB "phaseB"
+#define PHASEC "phaseC"
+#define NEUTRAL "neutral"
+
+#define ADE7854_CHANNEL(_type, _name, _mask, _reg) {			\
+	.type = _type,							\
+	.indexed = 1,							\
+	.channel = 0,							\
+	.extend_name = _name,						\
+	.info_mask_separate = _mask,					\
+	.address = _reg,						\
+	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = -1,						\
+}
+
+static const struct iio_chan_spec ade7854_channels[] = {
+	/* Current */
+	ADE7854_CHANNEL(IIO_CURRENT, PHASEA,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_AIGAIN),
+	ADE7854_CHANNEL(IIO_CURRENT, PHASEB,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_BIGAIN),
+	ADE7854_CHANNEL(IIO_CURRENT, PHASEC,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_CIGAIN),
+	ADE7854_CHANNEL(IIO_CURRENT, NEUTRAL,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_NIGAIN),
+	/* Voltage */
+	ADE7854_CHANNEL(IIO_VOLTAGE, PHASEA,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_AVGAIN),
+	ADE7854_CHANNEL(IIO_VOLTAGE, PHASEB,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_BVGAIN),
+	ADE7854_CHANNEL(IIO_VOLTAGE, PHASEC,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_CVGAIN),
+};
+
 static ssize_t ade7854_read_8bit(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
