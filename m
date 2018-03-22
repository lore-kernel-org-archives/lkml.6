Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1321235-1521684230-2-11744628603778994927
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endaro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521684229; b=e71JjMGqU39SECxfVoCbWb27tysNpZgVnSiDqcLqRauDHki
    HvqXlFBg0GGZDKTscg2o6QMLrI2O1cVqinQ6FkRFkhCvnDkEm1Sa0FzcVC7nLLj0
    PvyhofuLGigmaH1FD6yr4574ZAA/5wz6bha/pnbCQkyK889NusZtxbMzPEzYmnzC
    RZ/87yvMg4mM/m7omF8EEhVwzA6k6Sf212zHp4IZQ1f6Q/5Xp1Hp+IRA4Ra2G/wJ
    iFp1EpU667vWnH/NEnZ1yR6T0LsNI/trWtJESNlD+MMwcSZ8kX7yZlQCOSqA+xF7
    1J42I4lnElWKs67X5FWBnctffWZZ0amDTWgCIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521684229; bh=X
    SKERGuIXvuJ7olXriTXlxNRO3SbbnZdglWR4Q9Mh00=; b=GlWUwoRNoF268oStZ
    7FoWKGdRicJeLMUHfVnR/naw47DQBZzx8pjZMkEIXFRrdwn5mpNRBJU3tiYXb5IB
    arDEFIjqW484d1cCDi9b+CnNFDFm2GgC667l8BS7OF43WDlt7x4Chk2Z1HObPbgs
    RJC7SBq2mGvxBsI0IgUCo1MBQ/XdT9Bt5WyMUh+e5DYt55xCfknVM4ow0eqNg2Uc
    i9cabNOpq9YwC6lI37OZhWCqonm9RmwGYuLi+sGivPUlzz+xtlCHke0WvYUxb+NN
    nN7MVdHuzWALsiOS0C+2kFxjzJoAwwxoJDKcrV1zHIEKzQKMTXIcp+waF/1xYwHo
    rW1iQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, John Crispin <blogic@openwrt.org>, NeilBrown
 <neil@brown.name>
Subject: [PATCH -next] staging: mt7621-gpio: mt7621: make symbol gc_map static
Date: Thu, 22 Mar 2018 02:09:25 +0000
Message-ID: <1521684565-76447-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes the following sparse warning:

drivers/staging/mt7621-gpio/gpio-mt7621.c:47:3: warning:
 symbol 'gc_map' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/staging/mt7621-gpio/gpio-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-gpio/gpio-mt7621.c b/drivers/staging/mt7621-gpio/gpio-mt7621.c
index 5c57abe..d00c1cd 100644
--- a/drivers/staging/mt7621-gpio/gpio-mt7621.c
+++ b/drivers/staging/mt7621-gpio/gpio-mt7621.c
@@ -38,7 +38,7 @@ enum mediatek_gpio_reg {
 static int mediatek_gpio_irq;
 static struct irq_domain *mediatek_gpio_irq_domain;
 
-struct mtk_gc {
+static struct mtk_gc {
 	struct gpio_chip chip;
 	spinlock_t lock;
 	int bank;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
