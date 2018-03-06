Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-984164-1520360535-2-15577268851499281435
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520360535; b=nr3XXQKV48ZQV8bnJXpBKzI5JgrJoV6AiQtMYYcedG8w70l
    wkGIjVCXFQWRTh//CpcCeHwFw11RXtLah58OCD78b2SPxoitzA7RSX2oofm74QUd
    yAwKZsaUM+MGfTQu2H98cA5EBD+mTJgMWtzkpef9S/3OH5YgAViRcwKlxg81R1nO
    rmF7sMWMTCdyPVjmqMp8eI/4UmIUrUHARQeqYi91u+wDm/Apbv+v7enHHzigovaf
    Wz7JVgS50VU93SS1PUQtQ8QnRk5RhzUKQvbQ9HkR3tOoZayp5urm/xg2g3o9M2n5
    KKnPT5EzgX2b+OC3ebx++0ZgPDqyRzQypTzLh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520360535; bh=D
    eBUW/+Gh7l9gKeY1E+zSR3a7KDnWgvB8hhC7K7wvv8=; b=c292CU6cRsGX3o9Q5
    QmUJ9PxLrtR83HwOAmOmmAFz/ziRK8YoOLR3o+TWRLPW+10P6Bom1UqJ655T1EFG
    eBfJ3aTU3c0+OPBBwWE+Idar2HrAloAUrfVnHfNvQWAEisIFzDkx6Iu4pZCKNFx9
    wzRG0BKt1w/eKa9YkTGT0sDTF85FJzVdIxpEuUSFjd9I7SDW3kkv/xSvXMhIkuPy
    9M/dKPOAQlqbfwh+fZEv6RPcZefa0lLj4qaUcYJcyZ65oaXO99ZDkVihlP/FX7Ke
    RwHLAx8x/paNH2NnkREAkF37JO+rRJ+7CFBroK3o1Bb67+S8z6DAseXPzorXbhFR
    xpjEA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hkqC6Y6h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hkqC6Y6h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: [PATCH v3 5/6] PCI: hv: hv_pci_devices_present(): only queue a new
 work when necessary
Thread-Topic: [PATCH v3 5/6] PCI: hv: hv_pci_devices_present(): only queue a
 new work when necessary
Thread-Index: AQHTtXgBUSAq7dV8DEe3C/6N5QPNyw==
Date: Tue, 6 Mar 2018 18:21:55 +0000
Message-ID: <20180306182128.23281-6-decui@microsoft.com>
References: <20180306182128.23281-1-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0021;
 7:HFPR8nHojIROAv3x5Jm5xDjVs8nlMjvqU86DwJIoc/wHVr049c/xxmwJBW4oqthg2Y800wm5BQS3OOkjCja33kYDqsBVX/USq2aNXifpE/4jJY22GBNaulnCLtPSk9BtjoOQ5bOaOB+2RBBXt7u3ZfFsszSy+ypeE8q1sL31xYP9Zk9D5f1/chK1wMeyrHMm/k34coowP57YYQXs4pw9WIMaRv2ZHDZIXHYG61pXDjpEYlDVV/F9c8bfCFH9HTy5;
 20:TgUiBIQweZs1V4QQMoKFzd3lnCWqiiakgLpq2dPD4MNVp3OJcowzz5eVrpLsITNOS5YO7JkBI2a23kHCfKvP4/wrlRVuWpqq065bt3aAjwEvM6Upjir6YOEKfIV7MVgr7XMIpNlDT6IJLXAedPg50/hLls6fsJZI09rxoNp7rEE=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d9546b5-13dd-476d-0fda-08d5838f245b
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0021;
x-ms-traffictypediagnostic: KL1P15301MB0021:
x-microsoft-antispam-prvs: <KL1P15301MB0021A7DFBD85EB2603429DA5BFD90@KL1P15301MB0021.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:KL1P15301MB0021; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0021;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(39380400002)(346002)(376002)(366004)(199004)(189003)(5660300001)(36756003)(22452003)(1511001)(10090500001)(2501003)(66066001)(316002)(7736002)(14454004)(10290500003)(2201001)(99286004)(305945005)(7416002)(478600001)(76176011)(25786009)(4326008)(86362001)(102836004)(106356001)(6506007)(105586002)(186003)(77096007)(26005)(3660700001)(59450400001)(110136005)(2900100001)(54906003)(68736007)(50226002)(97736004)(8676002)(81156014)(81166006)(8936002)(53936002)(3280700002)(6116002)(86612001)(6436002)(6512007)(2906002)(1076002)(6486002)(2950100002)(3846002)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0021;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: zr+8NMmESl+2t7Ib5NPmLbs+7P8stW2Th7pU0a009pmgi+pZTMI1LmvcYdpQrDzSqPhHAsH0eZe3S72Tu2INSGqAKhffG8XvgoAJt39iK+xhbdWZFb5RQpb/K98zcuBc/XYQ9S7w48GgTt3hB/8XmlmK2ZGl8q53XsMHnmMSRwlskm2CtGc2Qj0SPnXcH60IP4k+j5z0Zd0+Aem3MXJ1+iF+cOpW27oouVuAadjP/MpZI0PhK7612qxPriy51nN3hOCVIYevDZlUszh1Adek4lKKcTw/hzP9oRtZNl5Vy16JWm6Jof6C2sdCK+PgiIN/BTXsXH8sshzakzmRCkKVjQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9546b5-13dd-476d-0fda-08d5838f245b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:21:55.1338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0021
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
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jack Morgenstein <jackm@mellanox.com>, "Michael Kelley
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

If there is a pending work, we just need to add the new dr into
the dr_list.

This is suggested by Michael Kelley.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 3a385212f666..265ba11e53e2 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1733,6 +1733,7 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 	struct hv_dr_state *dr;
 	struct hv_dr_work *dr_wrk;
 	unsigned long flags;
+	bool pending_dr;
 
 	dr_wrk = kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
 	if (!dr_wrk)
@@ -1756,11 +1757,21 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 	}
 
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
+	/*
+	 * If pending_dr is true, we have already queued a work,
+	 * which will see the new dr. Otherwise, we need to
+	 * queue a new work.
+	 */
+	pending_dr = !list_empty(&hbus->dr_list);
 	list_add_tail(&dr->list_entry, &hbus->dr_list);
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
-	get_hvpcibus(hbus);
-	queue_work(hbus->wq, &dr_wrk->wrk);
+	if (pending_dr) {
+		kfree(dr_wrk);
+	} else {
+		get_hvpcibus(hbus);
+		queue_work(hbus->wq, &dr_wrk->wrk);
+	}
 }
 
 /**
-- 
2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
