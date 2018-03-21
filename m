Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3734533-1521628177-2-17931093171248521845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521628176; b=wYIjrcVBTvjZ0ovrcqPBfoo0ZqrMlD9Kqx7l9/tJyDB9vkP
    53KNFCqgX4a9fR0HZKyCWd/RdGyoF3h4X002k7Qpvu5s4w8AIZbMwc/QTxwHYOQc
    pu4NoDnr21hqIUYQqXT6bwSOgrru5Z6inDquQ762RPkfLKJMBqbHD//54tV67yPr
    XU24wBYG51b7uUrCrc6mIP1IoqIT0RwO6wgJBHlhnFUbv4yTueevHgp4WfVsMvPv
    I9MPLwnSQkKBzj7k5ARDAdJ+0vNiCRzqdbcJFoQFocbtShCI9M3R0UFpLoWpSFBV
    +F3mKAb0J6Tpvug2A8DWIQXNBTFDX89M7mck2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521628176; bh=3
    O8RuuYwMvBRyu+TEpSma3TrRW/97Sa7CdLvdAuoHow=; b=qJWVXEVmpOHizm953
    F0o7KgYdQGSe3LT6PmmWCA7l/cSROvDhxba/X+ErIJazOP1ftd9w4CPdw/ZgX0Bz
    6EThJjHYWYeY0jKPRLb8k1dP/YRXiEO1LsdKKLGnYY6G755MeX37sAqN5sCS61t4
    /sJaiBbuh6+HIcuJ94RLEAhOWj0CIl//bdHMC/2PvytLjibK/+eMNyn9PcMPJokP
    q/TP39jEspusEayakN318yn1/W5FhE6I5Tl9DN5TVay6EQYf9CwwgplU3CHs2MoD
    wjiLZCj+MDEZtpt8tiI21qTw3YWRH/NDrk9u0xqFBWO+NwYAwDNVtE/k2284MhV9
    cUF7A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=kE/No04q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=kE/No04q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 02/11] staging: iio: tsl2x7x: correct interrupt handler trigger
Date: Wed, 21 Mar 2018 06:29:03 -0400
Message-Id: <20180321102912.5130-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321102912.5130-1-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
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

tsl2x7x_event_handler() was not called as expected when the device was
asserting a hardware interrupt. This patch changes the interrupt line
trigger from rising to falling.

The driver was tested on a TSL2772 hooked up to a Raspberry Pi 2. The
interrupt pin also had a 10K pull-up resistor per the requirements from
the datasheet. The relevant device tree binding:

&i2c1 {
	tsl2772@39 {
		compatible = "amstaos,tsl2772";
		reg = <0x39>;
		interrupt-parent = <&gpio>;
		interrupts = <22 0x2>;
	};
};

With this patch, iio_event_monitor now shows the events when the
channels are outside the defined interrupt thresholds.

$ sudo ./iio_event_monitor tsl2772
Found IIO device with name tsl2772 with device number 0
Event: time: 1478193460053760446, type: proximity, channel: 0, evtype:
thresh, direction: either
...
Event: time: 1478193463020270185, type: illuminance, channel: 0, evtype:
thresh, direction: either
...

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 82cf9d853b18..59921850a226 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1763,7 +1763,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 		ret = devm_request_threaded_irq(&clientp->dev, clientp->irq,
 						NULL,
 						&tsl2x7x_event_handler,
-						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						"TSL2X7X_event",
 						indio_dev);
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
