Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2597699-1521060264-2-10844003762237917463
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521060264; b=KyIArEQ4+JpbMgo/ZVmKjX1lLkCzuX75KbtLmbtrkZXdKil
    muuJig+2uw1lYxdJsAvLiPRlBAn+V6QgPfz0a+PmOEc2U8RD1Mi2QyUPXtXX4IeF
    aEo6m2Jpd1q7Za0BPyWmV8IJC4ElPMySZ6it6Atm3zJG/5Em9grsFVQM5z7+uSYz
    Iuq3ZGoUAfznphVD8rTKgtLOm3Ml18fNlE0hvHr/EHx6EjjuRv1uTCwgViEHe9tK
    xJQMbvl9dJbn/tl4E03hXJtUnSDHqBS0ro0gqVVkNoR9TS/NavuGN5stuCuP6ElA
    7i0sLNnMyCxXeGdtHHcQFpUXEXYk6GeekhqFmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:subject:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521060264; bh=V
    Ddyf3Plig4E4O6J9Zb0mUNOHeViir3PD4wQM2kFe0I=; b=VIaRkvePLXh1xLfNK
    UMYpf66bWFmUpwrbN9jpl/E+H/BGwY4HusIMNffC/F8ARPCnwoodYOpOMIIhVSoj
    DUC1+UpbYacGeqdKZr4KSLBTljt9GrxCzjGFN2RW44E7eQv0p5bqWNe4KlXHX7fX
    /gGRqUURlcBZSmPUEsYo17DpzxkDQZw/JNoHqprDxyeAByGoj0NDdZyKubcmmKuT
    89JmzlHJZhpum2kriMCZuX+/gpoBImmLFIcMWkyCtMH4O58+rISexvzJIbs8GQRG
    rT5B8jZFBQVKYsLHbUHTI2mTU1qzeuqxMi2ZpEOUEzI49WlQ8Zo/GGBi+9N7u9uq
    YeQFA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 14 Mar 2018 21:44:01 +0100
Message-Id: <20180314204407.2777-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.2
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH 1/7] staging: pi433: fix CamelCase for GPIO functions
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
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
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Valentin Vidic <Valentin.Vidic@CARNet.hr>,
 =?UTF-8?q?Luca=20S=C3=B6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>,
 =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch warnings:

  CHECK: Avoid CamelCase: <setup_GPIOs>
  CHECK: Avoid CamelCase: <free_GPIOs>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/pi433_if.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 5c6a7224180a..583b3803cf38 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -997,7 +997,7 @@ static int pi433_release(struct inode *inode, struct file *filp)
 
 /*-------------------------------------------------------------------------*/
 
-static int setup_GPIOs(struct pi433_device *device)
+static int setup_gpio(struct pi433_device *device)
 {
 	char	name[5];
 	int	retval;
@@ -1059,7 +1059,7 @@ static int setup_GPIOs(struct pi433_device *device)
 	return 0;
 }
 
-static void free_GPIOs(struct pi433_device *device)
+static void free_gpio(struct pi433_device *device)
 {
 	int i;
 
@@ -1174,7 +1174,7 @@ static int pi433_probe(struct spi_device *spi)
 	mutex_init(&device->rx_lock);
 
 	/* setup GPIO (including irq_handler) for the different DIOs */
-	retval = setup_GPIOs(device);
+	retval = setup_gpio(device);
 	if (retval) {
 		dev_dbg(&spi->dev, "setup of GPIOs failed");
 		goto GPIO_failed;
@@ -1261,7 +1261,7 @@ static int pi433_probe(struct spi_device *spi)
 device_create_failed:
 	pi433_free_minor(device);
 minor_failed:
-	free_GPIOs(device);
+	free_gpio(device);
 GPIO_failed:
 	kfree(device);
 
@@ -1273,7 +1273,7 @@ static int pi433_remove(struct spi_device *spi)
 	struct pi433_device	*device = spi_get_drvdata(spi);
 
 	/* free GPIOs */
-	free_GPIOs(device);
+	free_gpio(device);
 
 	/* make sure ops on existing fds can abort cleanly */
 	device->spi = NULL;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
