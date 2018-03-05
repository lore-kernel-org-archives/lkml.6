Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-703119-1520227143-2-721129494070864312
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227143; b=rXc8DYhn0mHCI+KuZIYScepFF6dtYG4vUYvdEGx00028WGQ
    F+9cvMbGovdKo5PNINvyUxypkQBbGxR1uWI3ZyXgXwdmKJF6/dl0XW80u1cQyip/
    N/M5iIG9wp569OQ2zFBmLnjsTNuQFzg5UROyJXXVp0qJVq12/gsepxqzKRN6yyle
    Hv9Gw+X6sDS4hNywi4B9pOOlvXbeJ0KKSGEVQ9A9Mt9Oglt2v7shEHbJD7+af0NV
    tHDxAWeMgfi5O6HISU5r3r3CSV3Qk9sdbNNLwuUVIsrLOREcMUDJCPz6bG8TVrso
    2YzQLkfrAtryCJHdabJfxDGj+txy4MQg77cFoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227143; bh=5IivbdOLc8aCfrZBDB+iKGHR+ZDrOD6sTpNqHzlMw+o=; b=f
    w1MwVMPp7SCwhliNb6ygdjByXZvKoD08cG7shYm6Yy+81rBpq+hnakj62Wz8cDA0
    9siUDrNfXTAOq5FOsjymUzebBbXw4CM9bWN5ZQB6GE0KxVTsqWYXz+hrKhVbezLC
    mUYIrB4KWFbKt4nG/OR2K7o3bZJGAVcGBBQkUt7XTEbYN2MsZotxXf2IiHaRFjVF
    xyz8LlntmohtOUU9X/4nyGmCeaMV+Bbjddk3svVQovD+ruWTp5ny53xBbVaCv8m/
    mEjlwhRQiREUlCPiL7VXKDSUC6qr7EOX+xLkUtwBijYvdQwzn+Th90yCRYOlXuhv
    X1HMCJyW9I4c/qwp10WGQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 05/12] tools: hv: include string.h in hv_fcopy_daemon
Date: Sun,  4 Mar 2018 22:17:15 -0700
Message-Id: <20180305051722.19157-5-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051722.19157-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
 <20180305051722.19157-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfO3FmTSGDr+t1J2VpC6dCIL02eaZf0GUknKOk79IuzofJAxlSZ8x1gdyY9DxeXTIbeFY9CYZSt2hYaNqcAm2MYNYiaW1RdDgOZLqbXf9llZEKVRJAe6W
 +BCV7ExcHDOTn/qi6fLa60yqntcP4MwXB4Ao6GAgzylHDf3ZMXyZQMQGEcu1+Vw8FluHoNGcTofR1gV85lkCx6NgqFvTLmSM56LULO2lWj2mhQCTk11+BnQ1
 hhideXyIJ7grzAeiMaIBx5coK6FZRDzdKdv0jZUqWQPUvBP+XzdZaqDyrPIUPKvzlnOBDK/EnQ7kW4j0+aPwlUdeFjCjIHbnL6Ux9KSiNXubNQHJz140T6zJ
 YilxNUYoJ35MVRozgfUibULtraoZXkEjXn86S8VBh64O4LM1T3JUWvW9DWBYfwYXpoer4+7je5eUWtzs0So5R+pKeK01Fg2Gd/7DM0bwYgcgItT1sH0t2ufn
 +8Hk5vq/02ZkbXgRvDnRq/Miu2IKkzBij0Q0wHTH1Fz95etR9kZuKsNoHhDdd3MzXA1gtNZs3D5IZZh7nrgkpA2UNofPL4++EjUjaA==
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
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Olaf Hering <olaf@aepfle.de>

The usage of strchr requires inclusion of string.h.

Fixes: 0c38cda64aec ("tools: hv: remove unnecessary header files and netlink related code")
Signed-off-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 tools/hv/hv_fcopy_daemon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/hv/hv_fcopy_daemon.c b/tools/hv/hv_fcopy_daemon.c
index 785f4e95148c..d78aed86af09 100644
--- a/tools/hv/hv_fcopy_daemon.c
+++ b/tools/hv/hv_fcopy_daemon.c
@@ -21,6 +21,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <string.h>
 #include <errno.h>
 #include <linux/hyperv.h>
 #include <linux/limits.h>
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
