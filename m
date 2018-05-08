Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3450219-1525816201-2-3259549475540243678
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES encafr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525816200; b=C1sw3oIxzKhPKDn2PvHDMAFIOlxZk1Wl7Lx1QM+xRqH9fccgrY
    02aSJQBWRvm+jyFvF2cafaOtg6fuPDuJdmQKBwMZfQxdBM5QHv4VSE3jd3WG8Q5L
    ULi7CrhA8TXk5GZxHzy5DAdFoygT2iqKB24yCFbb31YVujUggAX0E36OdPnsgzyO
    GUON/Pv5+N9CZG/+qpEQSx4r7JC7aP8sEu5CeYGXAxHgKWROFrWKyLpTRMu5Zp2U
    0rC9ZUkOPX5UymqL6huIjhf8qgnzILqFZ30Zo7P/Ud0RxDIGzL0Az3M1WjbXuker
    z/M2+Pf/q9fw2bKZuWayIALsF6he1HweNhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525816200; bh=lAGgu
    fJclkE6C27T8U9X6QnFiFDkfK0vFKbDa6L5Pe4=; b=VUEE2vTNasHHqmo7TNlWK
    BhfXh4dgNzcfuWBUyUI8Lvlh6+CCe81u5TrT3K9sSEK02S1PG/BNgLURkHKiy/tf
    woLqD0AK9HuT5U3Mlql9NKB+zxlSNbj+Sz4KswS0V/H1qCQdiyApGhxD6VHSX0bo
    iUcG7YCMKlXrbPfCqoi7FSy49vVziCZdzj+WHqKbu05RmEzYi1AFTbXtu3FPGGRN
    /KeHO7M2uMaJQ3gYA1qHEkM1j5gvFwxFexuMJuVhKpMY0J99IPbh/3xeCvdfppFf
    1Tffnqsp7b8Cet0X7V+B+9ezbIoUKrA3LH/ANpgPjqbSPhOj6Sqx80bDVUhNGGmI
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN03juWo6kleUqVEjPjC4gPH1wXS+GmeOpZ8TGdQ7kFX/hdagZeLJFYZFC9kjr1u8aSkn6R8SiyiJcYETXWXbHaSUyLt5IzHfaN2j073j4dFZFmijDOn
    JZtsyauHdpA5t2anA1QExHt8bmyjqYIE2DSv+F7Nb5+9U3rkGbD3ShuG5msjuvYGhRJkawCiQ8CcX1O4uu5t/CQYNgfuqmX/IfjHi1KhEW1lNBZ7xc9YV3pR
    oKsbS8xSSugfMIZrsxwz8g==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DfNHnWVPAAAA:8 a=DDOyTI_5AAAA:8
    a=RNu_ZaEUwNt9dBp4LCYA:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Colin King <colin.king@canonical.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, devel@linuxdriverproject.org,
 linux-pci@vger.kernel.org
Subject: [PATCH] PCI: hv: fix spelling mistake: "reqquest" -> "request"
Date: Tue,  8 May 2018 22:49:46 +0100
Message-Id: <20180508214946.19772-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/host/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 50cdefe3f6d3..7e93b4ffb162 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -2071,7 +2071,7 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
 				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 		if (ret) {
 			dev_err(&hdev->device,
-				"PCI Pass-through VSP failed sending version reqquest: %#x",
+				"PCI Pass-through VSP failed sending version request: %#x",
 				ret);
 			goto exit;
 		}
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
