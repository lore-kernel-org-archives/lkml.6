Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-426994-1521123720-2-7776365449585904000
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521123717; b=a3ksJ4VEXW1M3COzcQLvU67cieoPGLel4ByMJgJp/tb0VQr
    cMSNZmOhU31mGB3djoz8wekuVXKCQY1qBs483gwuq9/fzATWwksIR+suPbOrR9ER
    01YpA5GDfM9A3LjweolSjFPBAv/YLCsfmUzv0Yh3UnEqBfwUfdZckxy/6raPkY40
    hB5WN/ooKkpF5FI10D088jUPVXlHPFFV4+qwNglGX6vHzQCHpdnSxIMsfm+DOmy4
    afaY7hhORFkzF2jhs6NZ4fWC3XCzCnsltEjKrAL0dg+2oGf6vjsowfgAO9CkNHZ7
    5iQsVPa/PL9P0Dj3PHz82+3ZEhnac6rZ/iw48Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521123717; bh=K
    NHhv5dawyx0oHP558x9m6TUPWF1kCxSo5P509JIrPE=; b=Lal1xC3lzfG+y96qx
    LYAhUFMdfWF2sqvPJxKvhGaGQ87pudq1OWjTryTjuj0qvxZ24Q0ipb093JplqAyq
    +WqfdG8XLhV3K6TapAO8CeREl5jAT4TyfG7r56IhndJFGan3ryeyURQXf4N674gV
    JBn729dxzDbNHWJUmdM0Wu9OFb1Mt8i6YvnoJgAC44arlR+3Vhgg5rWXTIat6Of7
    DVWRx9f5OVxt9csAtwsWIKgW67GTXD3VWIDlPkizHnL2QXZmKAQtYUvmdbvliBMP
    7Yb/AEryqksri4HGH5HFOYMab75fwQ41VbhHRaWB2hbtODvg4sny4NemMT+Snvx3
    epXZg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AtdSLaf4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AtdSLaf4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v4 1/4] PCI: hv: Fix a comment typo in
 _hv_pcifront_read_config()
Thread-Topic: [PATCH v4 1/4] PCI: hv: Fix a comment typo in
 _hv_pcifront_read_config()
Thread-Index: AdO8O7rMHAlYByH/SGW1hEhBeHh68Q==
Date: Thu, 15 Mar 2018 14:21:35 +0000
Message-ID: <KL1P15301MB00060525103D095628E7DE34BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-15T14:21:33.4073419Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2601:600:a27f:df20:d8b5:442c:6a7d:25c6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0072;
 7:Y/XBldcgTeZzpPH5Ru8aqOigBZVsY/wQUV+s01OlNQ2IWCUpvKfwiHVLyH69nMfcJFzGMwaUZYPdqVBdjY3fhOAhwPR5rBFeU62ysOHsrhCnF6ziAe9m26uJqazFsjMrijTXcfJk79ZJZYJ6GKLYL/XVoKMEDF9KD0ZIQfxRQN3ilcOtqmCNnXWLTdFeI+lvQKzAAYVwNeDDrqldVfQnV83lotomHYKVrKmRysUKJh4uwd4ZMc1SebydBDFmqX58;
 20:cQsWetl62B8ZFBQNbeR0azsXrCJ1SgQWiK1Rbg6o4GQOIcln3xWOL/0r+0k2vkzGeAZibkqkv+jRU9UrP5FRVGVZOCZRAm/eB6n/XUuFyBBqJpN8sz6KJUiSS2DVE12PdyTwdvdmLWA2LNwgoAoBpAXeGvOJbDl+TB1Kf88910E=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffd3f38e-e8d2-4031-48c2-08d58a800f66
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0072;
x-ms-traffictypediagnostic: KL1P15301MB0072:
x-microsoft-antispam-prvs: <KL1P15301MB0072C82ECB718F4F0CA0A360BFD00@KL1P15301MB0072.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0072; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0072;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(189003)(199004)(14454004)(7696005)(4326008)(2900100001)(478600001)(5660300001)(68736007)(10290500003)(7416002)(3660700001)(97736004)(110136005)(7736002)(74316002)(107886003)(54906003)(86362001)(316002)(22452003)(25786009)(99286004)(2501003)(2201001)(8936002)(575784001)(305945005)(6116002)(10090500001)(102836004)(33656002)(2906002)(81166006)(186003)(86612001)(77096007)(53936002)(8990500004)(6636002)(8676002)(105586002)(55016002)(1511001)(6436002)(9686003)(106356001)(81156014)(3280700002)(59450400001)(46003)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0072;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: BQuzm1SKAPrh/qetF8Gx9zbsN5ahTTnVljFzX1B8lKRAANZGrJC0RVqEGYu6VqdMUdv2DK5elJdtMJrRD7jFzGugg7XFz7royS0Fk1oHd79XOmXQbOsBgT77d2lELwCakT1kFKYMF7qgeIVniFEKj8F8ujVkUXz7gvSgHsGq7wfmxG/rzgiGUxfPIE9H5jsq2cDt59+TnV09nXiAkx+h64qnvcg2qPhkLmeCOJRwXrjf7QjSqpZ767lh5mDGz5eTht0BwAktZQpaQCQ9w8X/WwpyGppzUcZo9R4QPNSGD2RXgmkL9w/5Rccs/SPLtOw0Mjq3b8OZTb7G8/00Zgj18g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd3f38e-e8d2-4031-48c2-08d58a800f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:21:35.5976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0072
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No functional change.

Fixes: bdd74440d9e8 ("PCI: hv: Add explicit barriers to config space access")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index acb1941423a9..28fce2be0a5f 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -657,7 +657,7 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
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
