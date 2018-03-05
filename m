Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2389728-1520277747-4-13498432584689085979
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520277747; b=s2Z0RIvExZwkTTL0Cet72tABTK2k8nccnQ67YqUiQuRf+CU
    nyjin68/r5c9qubp2XVoGqWtiCwjIrGVY8cdDPGOaPTTuWCcdNAn5LSZKyEJgHvm
    rC5j3Ly57ETfb0hPenpOsrcWT8bDVtn4bLFsOSa5xCtdTYzSxpXOSlTxBeNVwoPH
    b3DCdh5Fno0sI2ZOH4uo6CNQvAoHRN0yrmc1C9IVLW8l+ZCvUrd9FmYlRWgVWiz+
    mbJ59wnyjB/cr0DESBNJaDMp87zacOXop+vqc4A+y9P/7o+9reBzb5N/CYAjVYaz
    4q2BhTwTKicFYfhXwS022y2NJT3TBeKy9nMn6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520277747; bh=A
    SItIaoAWdgdlC5IwIuuur9GQ1GTLNOkH5stU7YtVoY=; b=NSefoqxmdPbkKQcQ4
    qrsI9o3T0ljgpx0HU3LkXR5muZ4EaJX1/81FzRRmb4o2hW9eyfcRY0EhkI/L1jl6
    6SCOTriPX7N5izCuQqoNzn3GNccfdJS+9ofEmD/kZhRxvwVL+LwhTfr3LI7uZFsj
    eYfq3vJofRoM6mI+GQlHW6UW4qjJT09ziLEzAdKvHwrILaQIuYRbzrEQ75xL4Wfk
    b5sdYwobi8Kjjud6zOkeDI7Us0OWezD1rYZKhRNoKOxSQxDhMquHVrimFRfhYSk5
    /tqM6Lhyd+Do8MW66TOnBCl226uhknNWSAYECLZQg20Is5c9txE3ch9IGvwXjPd0
    87wJw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RGpupETC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RGpupETC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: [PATCH v2 1/6] PCI: hv: fix a comment typo in
 _hv_pcifront_read_config()
Thread-Topic: [PATCH v2 1/6] PCI: hv: fix a comment typo in
 _hv_pcifront_read_config()
Thread-Index: AQHTtLdDye0SosGGjkSB+GGEOLKKDg==
Date: Mon, 5 Mar 2018 19:22:13 +0000
Message-ID: <20180305192134.32207-2-decui@microsoft.com>
References: <20180305192134.32207-1-decui@microsoft.com>
In-Reply-To: <20180305192134.32207-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0039;
 7:DIQacIwhDGDThZr8gRr2CSuBldaNkiynCHZllVmWgvKb40zh9XLgh2qh01RdJES/R5Tm4qOWNQHkzvYnaWFaLvS2Op7072GgIy2js3ZfyMMpocVtWCmw94dUJtHPNcLPWZg3iewtcFCOmvtQdX/7bSiYqlEtPXT4GNDbK0w06ACj6SbMe6T18y1TtC22hqdvhzPlIT3M2aylbzEyQMiC0DE4Xr20vUj/HyfZlC6T695xBDKNDD3+KMxMBrFCqMGk;
 20:5pVyzSHIUpbDJ1n+GXJemtegCjxjkLH4OZfOx2ufhngIIZtPnBry7/yathJVc/O3sPBSUwdOREqHJsJxSP5KqGiMqWYXlD7LYQ5iV6DW2tPnm+/Z/wWgt4/Rz1IJeGQQd3LYCCe9Jghc1gVUhHxRZFahn8imE1p1kOKHD+eioZw=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc8805a9-641e-4c91-ada6-08d582ce6683
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);
 SRVR:KL1P15301MB0039;
x-ms-traffictypediagnostic: KL1P15301MB0039:
x-microsoft-antispam-prvs: <KL1P15301MB003907336040074991CA8D12BFDA0@KL1P15301MB0039.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0039; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0039;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(199004)(189003)(1076002)(7416002)(5660300001)(6116002)(316002)(76176011)(86362001)(106356001)(36756003)(4326008)(105586002)(2950100002)(77096007)(26005)(25786009)(3846002)(22452003)(110136005)(2201001)(59450400001)(99286004)(102836004)(6506007)(54906003)(186003)(86612001)(8936002)(66066001)(68736007)(3280700002)(81156014)(478600001)(1511001)(14454004)(8676002)(6436002)(81166006)(3660700001)(53936002)(2501003)(10290500003)(2906002)(6486002)(2900100001)(7736002)(6512007)(50226002)(305945005)(10090500001)(97736004)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0039;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: SsHnRiH8DmlH2rLN6M0qKSv4/W8IUaOp2deL1UiXGwBlWI0lm+BvP7JKBSi/5OJCuMAb6qiXC2IMKiWIBlghd3jDDqySCvlgOLY5yOHGnevGWcodfSB9rjGoJfQmsLySn8UwI0NgAfmVF9nOP6BoIIF1HyYcbkSbxaNRtHOexC9jrSlFVqJaYSumbOqpbVJ1QmUFN8j0QCgb7pHm67+29IRbUYi0kLIoGWo0BSiYDOC4afER0ugqJGILzwFMzWl/aGN7JiBqzer5HAfgGua4UjzKUU5B9GTSv4HuE/oCz3EMBWA+NA9z9D+HHqVvgPkKi8bsUofrABKwC8yBm3jYEQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8805a9-641e-4c91-ada6-08d582ce6683
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 19:22:13.1617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0039
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No functional change.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Fixes: bdd74440d9e8 ("PCI: hv: Add explicit barriers to config space access")
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 2faf38eab785..1233300f41c6 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -653,7 +653,7 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
 			break;
 		}
 		/*
-		 * Make sure the write was done before we release the spinlock
+		 * Make sure the read was done before we release the spinlock
 		 * allowing consecutive reads/writes.
 		 */
 		mb();
-- 
2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
