Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3256414-1519144654-2-16400262517769777253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519144654; b=sFV5Im2zsTNHqOuahkcxz7FyxYpwcBLs8TqWLHZO849BGlK
    dPpA/PwcNZGzZ1BboGLaqnh/U90p1e3w/SyYfKZ/dS7tA2gUTMa/udZqzw69vJu/
    P+ihapHjKMv434AX1EwJTdYWQ3fT18Vm8zgqqffY18ZlVUcq5BZjx9eaTbFlvjnM
    jw6GgJp/uGxFDqRttTI9n7gM/fhLp8crYzy9RhJka8q3rWcKiT93KlmFTzC/bOHP
    QrwKutbtgtbyFNtbhUlxQ6RIASZiw9mPoiiuAJYtfadVDQGUuQcOX37EsGUOJtLV
    i+fI4mGI7SKc5hoAZRf1r4YgzvNpFumuXs8Ui4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519144654; bh=H
    GP8Uka8tkINK8E4d4A+ogAZ3lpyfgNDOWbQhfQtaZ4=; b=QiVRu6LkCTuUcDw0Y
    X4+l1IbYX/Poc+MveYIyXI/HzB9KyvSLrcpL/dyLcLGB8GNBg3OCvLfedmrVHEqM
    O9gnnxeJOZ5cOYDbelPmLPfW1FAWWDGetgSlTZg0tl4S71Zhu5mtkRkHBUx6oPX0
    XY9gpNWC3uxxlSs8AtRk6PiCgCIhTC5gUz1/3Mu4z0s18oyH1iTvZeeBtyGixfyv
    4fiBBtj99YxKvKsMPxdK5NoFAI5oqh0paBVTj7Muax/kLYn+RNlHWQxP43tucPnZ
    BOZx5JVZWDyiyTF80cd9iON+svzvTCWUgjmgOpsLlhGf2yiArG8r+gyXs4bNSmld
    vwZSw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gentoo.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gentoo.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gentoo.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gentoo.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christopher Diaz Riveros <chrisadr@gentoo.org>
To: gregkh@linuxfoundation.org,
	Larry.Finger@lwfinger.net
Subject: [PATCH-next] staging: rtl8188eu: Remove unneeded cast
Date: Tue, 20 Feb 2018 11:37:22 -0500
Message-Id: <20180220163722.14694-1-chrisadr@gentoo.org>
X-Mailer: git-send-email 2.16.2
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
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix Coccinelle alert:

drivers/staging//rtl8188eu/os_dep/usb_intf.c:336:13-27: WARNING: casting value returned by memory allocation function to (struct adapter *) is useless.

This issue was detected by using the Coccinelle software.

Signed-off-by: Christopher Diaz Riveros <chrisadr@gentoo.org>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index 32c7225a831e..127ecf896fc9 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -333,7 +333,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	struct net_device *pmondev;
 	int status = _FAIL;
 
-	padapter = (struct adapter *)vzalloc(sizeof(*padapter));
+	padapter = vzalloc(sizeof(*padapter));
 	if (padapter == NULL)
 		goto exit;
 	padapter->dvobj = dvobj;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
