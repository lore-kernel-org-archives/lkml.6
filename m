Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-179927-1521384793-2-14312465104005644602
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521384792; b=dU3L/cDcYLqj5pyNnFOmvobzBxQgsQ7GF+YH5aOofMxjMzb
    LBi67w8RZiHaXG7TpPm+rAt2c5ltwtimbZanUrSxwpXv951VZY1yRzRYAiOVz5eq
    GDtqeeTEYHmUjO3LZIdhGR5n8gP2X3b740pv4KsvruZo2SxSEzabGBFtOVEJu7IN
    jbCTkqFzLKLVuD5IKTI+MKb9x4gl1afXM1SxvIVMIjtZUsrCj8SKw/pbNkDMz4WC
    260HNfre841G7jokUvWeveoH8kiMbeMCShGGOiFYgiggilfEVifNcRjZtAA4p0/C
    uyXYAZd3ztEfhyZJivPvlF0enHYrHaqJMZPzFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521384792; bh=U
    8oieHLHvF17IIlq6nZN91LNO4IYlk2dbOLNLysyTrE=; b=USsZGEPnslbtB3FDe
    Yi17xE2BiHvV+0OuPy148LzfooArfwNXEeds7dCkqP6CVPkOnYgzw+pxH3K9Ybiu
    WK9xfsWXJl1PoeJNNiJVqDOwRO30KGK6YoTAJgD3BnrwD2UrXl1KuBfSNw7FPZfn
    s3vxLjm3KS/k3bXLShcvp3+z1AjjHDgnsMJYvP5l1aUScQeJ/VmfKbL8YPfn3HC6
    I/ntrIprTx7rpvqljqfC6kp9waAYX++x1Ze1tbz+m9tQeRDC1dG5HT51T1Os3VgL
    gwcDI4/KGpQr4jX7RRuJ2qL+HlXl++qf7kSYMb6AeTYPJh6kUQF9Zt7lkt1Vixfl
    XApuA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gIF+2ckM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YFNbYV3M;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gIF+2ckM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YFNbYV3M;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELukio+5xgA3NTnQQh5PFLIG8Qo7eXfzyAERpH19zt8uHP+aYgo9Gp7fbVVVE0Q+16URSXFlSA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 bhelgaas@google.com
Subject: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with GFP_KERNEL
 in hv_pci_onchannelcallback
Date: Sun, 18 Mar 2018 22:53:02 +0800
Message-Id: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
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

hv_pci_onchannelcallback() is not called in atomic context.

The call chain ending up at hv_pci_onchannelcallback() is:
[1] hv_pci_onchannelcallback() <- hv_pci_probe()
hv_pci_probe() is only set as ".probe" in hv_driver 
structure "hv_pci_drv".

Despite never getting called from atomic context, 
hv_pci_onchannelcallback() calls kmalloc with GFP_ATOMIC, 
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL 
to avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/pci/host/pci-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 0fe3ea1..c5c8a99 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1887,7 +1887,7 @@ static void hv_pci_onchannelcallback(void *context)
 	struct pci_dev_incoming *dev_message;
 	struct hv_pci_dev *hpdev;
 
-	buffer = kmalloc(bufferlen, GFP_ATOMIC);
+	buffer = kmalloc(bufferlen, GFP_KERNEL);
 	if (!buffer)
 		return;
 
@@ -1899,7 +1899,7 @@ static void hv_pci_onchannelcallback(void *context)
 			kfree(buffer);
 			/* Handle large packet */
 			bufferlen = bytes_recvd;
-			buffer = kmalloc(bytes_recvd, GFP_ATOMIC);
+			buffer = kmalloc(bytes_recvd, GFP_KERNEL);
 			if (!buffer)
 				return;
 			continue;
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
