Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-438920-1522314894-2-16531750670038253784
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522314894; b=o8hfYFHWnqmP6Oigep21e5EnTQ6i99H/0W9zV1LkK/XJ456oiR
    TV/RHdye0l+vMy8+znY6FVvAg6tPPCddCXGF/VGJy/hX+St841Co+0lUinztrEiz
    f72m8z7bWGNBFeB2w7tFEvJZo3EI2lnsnuQkftm8iUpcgYGY0CePnQjwojrNoE6P
    W9QSQa1yR/0Zw/tgTHSXnUrRSJ3fPJIjd47NuMPSbpcj0AkUEdWISvwXMuHYUEe8
    jYuP7SbdgYeM3aU0PZGWf3GrXG1JPU93Euit/LNermTiRjIER4gHsW087v2LCVrD
    B+RT1fm4OERpvMcAL7jgJ2XMkkANPloAwT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522314894; bh=ZNfj8
    ift1MkWR5u67LMBZB3yJCi5cyNnjW99dOVHiHQ=; b=IFnm3/I0IQ1fbdP3dPzU1
    +UuuTXERQagWZuKxkvnwpmkWp8lMNRPTidqO4DA7UNPKbBv1kxWHhME01glbyJ/W
    Kui11gVnDqWxMdAz8CPXNwGM1RLhvOMMLVNijW8dZPRfnaP0z+PX53yfqjhajZnc
    OwDZJcr9yYQGqdJ0uRN+KibDifFtTyN2kWCIL4aT3PFmX2x9UHiTLky6DtioKanL
    NP3ng0yGcZHt2SDu/xG7+PcWgr/qGc3vAXnq2mQczp5cEz5NRisuSqDmz/8+Hrtt
    wI4WFFLg4ZKJUptf9z+Iu9P996M08yYouvGpbYYgCMINd3KKnMEvhCkXYMdZU5r9
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iZeq7WAX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UVZJsbBw;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iZeq7WAX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UVZJsbBw;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIHEbXxMHjVgG6jP8P/tR1aNtG+x4LPcI8ovG509a6m2lZroLS4e/KLBnGrbSA6Rk6Erca8OGqSHr7AQf+Wvo3rbpWVJHAJp/fqfL3r/ND8Z8qDdH4W7
    HS678Rh65pZuR3t0c5yfKihQK22d0u6YaOZgbm6t4SVG7Bkes8/6nfyjn0WdUFxo482yjrL+lSi1fnxBM/S/AviYrUXC6xRR/9Qu5Oq1apJ41r8ZuKcf+oJe
    Uo8irjNSNNBCZ7jMur34wg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=MsQ-QqnFFZYA:10 a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=Ex3ulyIOycacZa5ezmsA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+iBbSpA+o/Mm+Y4hVRuuHlAhnJc15XSzqfp+jtbDTtyGR8bAoJvagsl1VvG+KDSEx9zHABdw==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: [PATCH v6 3/6] Staging: iio: adis16209: Add a blank line after return
 statements
Date: Thu, 29 Mar 2018 14:44:42 +0530
Message-Id: <517fdc2cff0ef238e74c2114fba1a73d2a40a999.1522306893.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
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
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a blank line after return statements to improve the code
readability.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v6
  -Introduce this new patch in the series.

 drivers/staging/iio/accel/adis16209.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 8f4fa6b..ee7e87b 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -277,6 +277,7 @@ static int adis16209_probe(struct spi_device *spi)
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
+
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 
@@ -290,6 +291,7 @@ static int adis16209_probe(struct spi_device *spi)
 	ret = adis_init(st, indio_dev, spi, &adis16209_data);
 	if (ret)
 		return ret;
+
 	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
 	if (ret)
 		return ret;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
