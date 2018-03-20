Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2284343-1521581362-2-12013008862060207589
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521581362; b=enN1AgbNtDjJ9Uo7pqi4uvP85/b1teB61XLeXntxAyWeJgC
    QehyGNo9OBYiDXtS3C4wsdALvJIt7Q4xb5kkWO2c9m/5sZUCIcCT685Bgji+oYPN
    wHMrX+pLC9MDEhXh2dYXvvru9i+s0r43Fla9eulMq6BznOVkE2jox8/wJ0zn16O3
    lBk8HlR+CirtySSI6I0rXPUqCsI4WSKmPgYffi0uXvz/qS4PMu53xvIjB2/VNKVB
    4qnKB7cUQYlkDSaaW6UhRqguN8hxZ8LsZYFgxi0BLqyuxwT4dhIyjVRlud8NJ1on
    OJqJGZSaLKNAqtIQl9DDVnFQihAuyjMIYInWy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:subject:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521581362; bh=O
    fpwdV88RO/zY4cz07KtJqB5cdZZuvDxU+zv7uiGFpY=; b=NTXsOHCb2Q69YwVQL
    g5eZilE6snkHpRxhlTjS7aN5hr9H7g4NpuPCrqPRLZ7k6rft2DhKeXCrF36pZxIz
    lEys4ymbw3zb8NjK24ZhSZtze3x0TyJl9xR+MB3IHMgEzF2/FeHawR8kTV+qmSa4
    ODSdr7YzmxfBZrdqiEV6Idgzba22Ly5tl6NWqedJFuyZ0op6SiPycceDoDTlOaNG
    B/m+cSsGJebM2Pbn9sLy0rp38GHWWXiAVRufIgGaZu1xtctywAHOwHNsiIgVOyi8
    EhByGPkQVRVuCTWrt7sA5urFwVg6pQixPIH5ebVfsHUTYIoicIO385Q1RWJ3TkNf
    6iAgw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 20 Mar 2018 22:29:05 +0100
Message-Id: <20180320212905.23568-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.2
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: [PATCH] staging: pi433: cleanup local variable
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

Rename temporary local variable and add required blank line.

Fixes checkpatch warning:

  WARNING: Missing a blank line after declarations

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/pi433_if.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 583b3803cf38..d1e0ddbc79ce 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -711,12 +711,13 @@ pi433_tx_thread(void *data)
 		while ((repetitions > 0) && (size > position)) {
 			if ((size - position) > device->free_in_fifo) {
 				/* msg to big for fifo - take a part */
-				int temp = device->free_in_fifo;
+				int write_size = device->free_in_fifo;
+
 				device->free_in_fifo = 0;
 				rf69_write_fifo(spi,
 						&device->buffer[position],
-						temp);
-				position += temp;
+						write_size);
+				position += write_size;
 			} else {
 				/* msg fits into fifo - take all */
 				device->free_in_fifo -= size;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
