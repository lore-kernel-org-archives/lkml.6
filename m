Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-179927-1521384820-2-8680211289818931995
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521384819; b=cczHsB6nJ3qiYizpIwkJIRRCgBEu5w0TGnZwE3WcgundJ36
    bmYAbJkdtOOoaMmhIJERcbz9cSsvfc37fttuah0RB8Pv2dGHLBoouctj00crws3o
    SW0Ddn9MfEHwogT8bbuNhSgl2B6yQM+gP3+icvMAH6OreGoyclWe8hHDVOT+zl9H
    53edVoZvmlJiQn3CVKivTEdeaSGzFc20mCdz/As9dZ5WqUGipOpufcID/dkuzP9g
    CeXaPglb7h7WovIkP722dT5Y9HuxxYuR4HIEj/r5zfPZXoN2L1XjfNssl10r/kNC
    HYCyOsaQhetwT/JPdrBFgO0oGuTv430OfldwX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521384819; bh=/
    21mBCPASsByApaSzu3yA/EBzXxxliOkN7R3/j26PCU=; b=QjEoaXBa+QOjip9f8
    NpZMI+UlsCYhCbi63MkiXuFVScl5qYfY7rQY5BSPsTjUA1oiBUgm68Sba6mxpcvY
    28moz3nVLCylMv9kcQl1ew8nuNCaYThqMNocTNlJgySKuVeYFC52CmuF0qL/knnC
    W0zj5tX2s3Yf/Vybkndc+XyXc6bLYIinMR75r9P9bqDhDwmssB3c7Z2jsygNq40v
    //rFXcXa9AfXVYDSu0UTrG6BpqUs7sa2FJK12GCRTVSUNFGavUCKxtgWA3BEJXLX
    0tjCuXHhcO8QJrt6GwpllLRyhU6M2u89NapPs1NO3QwwKk7mzpJVRQY9q+simYUZ
    zqNKw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=irpfLv0e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kaeaLy7b;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=irpfLv0e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kaeaLy7b;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuyasd571ZOOgIkSy8xgStvqvuJcGSC1IFvq8aSfMyXiv3IvT94MswD4tSOf2665x0QKUAyvQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 bhelgaas@google.com
Subject: [PATCH 2/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with GFP_KERNEL
 in new_pcichild_device
Date: Sun, 18 Mar 2018 22:53:28 +0800
Message-Id: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
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
Cc: devel@linuxdriverproject.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

new_pcichild_device() is not called in atomic context.

The call chain ending up at new_pcichild_device() is:
[1] new_pcichild_device() <- pci_devices_present_work()
pci_devices_present_work() is only set in INIT_WORK().

Despite never getting called from atomic context,
new_pcichild_device() calls kzalloc with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL
to avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/pci/host/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 0fe3ea1..289e31d 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1500,7 +1500,7 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 	unsigned long flags;
 	int ret;
 
-	hpdev = kzalloc(sizeof(*hpdev), GFP_ATOMIC);
+	hpdev = kzalloc(sizeof(*hpdev), GFP_KERNEL);
 	if (!hpdev)
 		return NULL;
 
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
