Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2033369-1521043016-2-8103249997613201172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521043015; b=NA8OkHk9VLUVLej8gG6ZbK+4Qs5RfWo8ZGWQG8mVsndHWGm
    paiHG+TEtknKSltwG6JwJD+fHfmUDhQpMGnY9ZgoVZOk2TwOd6ZY47sLH4tDnh0L
    H6xWLjH818gVxBhenadC9ke9hkHV1bQFx+KVzUwlh0Q9igpEXZdk2HobRr71wlCv
    v9mPGj96kkg6ClAKEzSkPmna9lVBYwTJCjwBcqxL7kDq1gipYV4z/vgyq5Goi22C
    cFBCUGkYRxopmMlG/+lCLUT3OqMX2h01CVT2Ygo4uTOJFuBwJi5yIQsxTPnXfXu9
    Yh0ovSLvF9GJuyLJF+4PI41mDTjDOzHwtZAeiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521043015; bh=S
    zFVeoxGWi+snvgyEtoNmh7QnxVCDbMMH1NLjKub7pM=; b=aNqeiLuXTzOdehM3f
    V7+3yW39pG+gZqfTsULB2E1Om4tYdUOWP2hTaBFBS86HhwMAXhBeeiqSmJ34sRnC
    gbKJpP0R7I6GERd/nGct2+ZPLSfHcXzDv8x2kcmIVi5Y67v55bq/m4Gtr3hXcIyP
    w3K3XDeUkV45fbbXDt8wM4wBQnwdZT6u/N8sKJ407IGZmRQMBebbI/5u9nR2Cmv+
    u+rI/jDiaD52DP3DONOTUkCZz5QLYjYb7amrN4kxbkOsv70TDAzBxm7qKG3cuQoY
    eYhVSYrPTIezxRbyaKed+yO0/KDnxS5OiD/VUqY8rQBhnmmzvZf73+yFneRCO0bR
    wLegQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 47/47] staging: iio: remove iio-trig-bfin-timer driver
Date: Wed, 14 Mar 2018 16:36:00 +0100
Message-Id: <20180314153603.3127932-48-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:TrBMClO98cCwWuAWe8BduH/1pQhC37SSuTDlabTt3gsQV9CYmnc
 gnwu+n7lnb4CnWiX+atg4mlGXx5xxv7qfXIqHUrnjUXIUlO8qcGXXZ3jd+a0IvExESWIStm
 dOw3t8YpOiJoVnGtEGxZ3kupeGonebvepPA/ZCr7WxDqoL1NZGAWUOUjfkk9bznG9OWS2sa
 quUkvBQnEHMv0YtXqw7nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4sjwmSdo2GU=:L214qX7l5/hZ0tLukhdK6K
 KXZWMaF/hX/eO84zOmd0m80XXQhl9+WzazLPwvoOOUo+4ix7pV7X5D8WGDX6IeQtZtiXDRhml
 bKi3DVDhSS9nnGAFi8MyXHMwpm1y5/J9r0Xu+g2RUsK37PjCMgOjx2LY844XItl1flW6Q7pCp
 xAN8mUaQINf/HWXltZgBNJ9bcqGZyV9deW4isfqhmLTmHr6uglxNYtfQPp4qSgpV/IdghSZuc
 oqOx+M6W2y3LCcrMa/+669+zl6aGNb85nvjw+w0QDdmJVbRHhdGuCuoWhlHsRzhmAndw/q9fG
 38rlMVroJ6Pmp8vlPjDvasCJ7z2cvGbGpxVMvbFXfAxMlR263ac+uZ85L3Una+ek3Sc0R9bk6
 GSwMbDJW+JYNbJLX2lPSaeM02RmbQAID/wjrozZjSoQumWVOyvbYAGUbg8w7jbi0ZyoQm/++8
 JZcTtM0KBfGlF1WvIfi49XfZPyGXQVfL7pbrkr+YtXu9jWKxMLtSbdSFcoZhpZXDdwYoYkyy8
 MRj/FJ+aPvqwCfZNfTgGotph30PI5uFlOfxd8OECUIfvGJxWKaQpdgB2P2t04S3s17xujuMxv
 U5HY4aF9FnbxMrupZbcS9rcum+V9Yw7k4cm9pUTZC3T2nPMJMBABUEjvUYvM/vTsRnYlDDvkI
 e7v7OgHcHowZJQlQ+IHWSvERsL/Yt6usFbabFPSBpfDsUd99/ZOb737t3WiOhMPWaeu6svCJi
 b49Lya7EnUW0SAePBCPIF7ZUcnOMpfimahJDWQ==
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
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The blackfin architecture is getting removed, so the timer trigger
driver is now obsolete. Since this is the last remaining iio trigger
driver in staging, I'm removing the entire directory.

I'm not sure about the other staging iio drivers though: almost
all of them are for Analog Devices devices like this one. They
are likely used along with blackfin SoCs, but could easily be
used on any others as well.

It might be time to consider whether they should be removed, but
it doesn't feel like a decision that I should be making.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                                       |   1 -
 drivers/staging/iio/Kconfig                       |   1 -
 drivers/staging/iio/Makefile                      |   1 -
 drivers/staging/iio/trigger/Kconfig               |  19 --
 drivers/staging/iio/trigger/Makefile              |   5 -
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 292 ----------------------
 drivers/staging/iio/trigger/iio-trig-bfin-timer.h |  25 --
 7 files changed, 344 deletions(-)
 delete mode 100644 drivers/staging/iio/trigger/Kconfig
 delete mode 100644 drivers/staging/iio/trigger/Makefile
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.c
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eb7387bb1e9..c85ce0cd5038 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -859,7 +859,6 @@ F:	drivers/iio/*/ad*
 F:	drivers/iio/adc/ltc2497*
 X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
-F:	drivers/staging/iio/trigger/iio-trig-bfin-timer.c
 
 ANDES ARCHITECTURE
 M:	Greentime Hu <green.hu@gmail.com>
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 8abc1ab3c0c7..bd9445956511 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -14,6 +14,5 @@ source "drivers/staging/iio/impedance-analyzer/Kconfig"
 source "drivers/staging/iio/light/Kconfig"
 source "drivers/staging/iio/meter/Kconfig"
 source "drivers/staging/iio/resolver/Kconfig"
-source "drivers/staging/iio/trigger/Kconfig"
 
 endmenu
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 455bffc29649..e99a375c07b9 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -13,4 +13,3 @@ obj-y += impedance-analyzer/
 obj-y += light/
 obj-y += meter/
 obj-y += resolver/
-obj-y += trigger/
diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
deleted file mode 100644
index 0b01d24cea51..000000000000
diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
deleted file mode 100644
index 1300a21363db..000000000000
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
deleted file mode 100644
index 71f11d7472c0..000000000000
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.h b/drivers/staging/iio/trigger/iio-trig-bfin-timer.h
deleted file mode 100644
index fb05a2a8397c..000000000000
-- 
2.9.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
