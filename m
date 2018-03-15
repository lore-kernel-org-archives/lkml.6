Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-444702-1521124647-2-14376612600524763237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521124646; b=WW/B9XdKxm4qnQJdnDsJJKqHB8mhmsjEH/hVVJiSww+1gOp
    d6KtA2oFsUaRTEzBPzoMkvAIN3M61hSk6Rp12vBie726b32W23dhWHMGwbKOk7So
    bz293iR15IFeRi4J6QTI5EHBKEmQ3+ggb1QB/1fTdimplpRqZeuSD5G/K8jvaxvk
    HrkG1xnGAL/QJ3zjT531ToicTSvLXN5N4VXZdVq/qfAU0as8fL9epDjWcT1Khglh
    JxNPlerf5cIXovAHRRhvBpawQLD7n4t/0Ial5Ko8EkjDpgPQD1yH7E6kJc5VjwUy
    kmeL6rp7QFMq6sescfMcRjqcXOOhYzhl1CCJc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521124646; bh=h
    fJAqmr7xXVE6StTDfmfeJooUrp7bHqR02hQJM5UzVk=; b=kpXvEK2QiP6wo044A
    L4CIVaCkPaYsx/C6Z8G1/abKjECV9A3KbIkyyJ4kzxiYig5uD1FxGCajYCHYz/HX
    MQQOPtjq6LjFBWTqg3O+4WTvOyXgzFkegUXy47kijU3elTuZzFRWdWrUq3brlRBG
    ikscC/RVIY2A4Z0Kj3N7JqCwGgNJ/0ZO7TQMSJToV0Tfed+KofaqBKnI7SOSUg86
    fIP4dFE0Z6aLufRPQtZz3vU8zT7IfTflZMpoC3DxsAObexuLUQvs8LV5VkMD1t5m
    hNbj68GsV2yHUENOCxepFUWqpQkwotCvY7i/hpS4t1h6Aa9S87PI5Bigu3gVuvzc
    2vuVg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=czYYuuA6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=czYYuuA6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v4 2/4] PCI: hv: Remove the bogus test in
 hv_eject_device_work()
Thread-Topic: [PATCH v4 2/4] PCI: hv: Remove the bogus test in
 hv_eject_device_work()
Thread-Index: AdO8O8t/mCo4wvQ+QfmRTFskL/RTVQ==
Date: Thu, 15 Mar 2018 14:21:43 +0000
Message-ID: <KL1P15301MB00069CB9573BB682DEAD8404BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-15T14:21:40.8955883Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2601:600:a27f:df20:d8b5:442c:6a7d:25c6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0069;
 7:wplNC3JkFrbrH4fwkA4QFxKsr43TRYwK7Q3jFpiqtk+gU/f32lgD66HkDdqqleEa0izodZ3UUlEvBRqp1gsmhdMZZsr4iK83fFAUYykr+lZVAjwHlGDjjX4kVAxvEV88yqmCOzZJkbVabxN6nvMdMLuFryqCnyO2eGXdUluMaxIz/NRsiOkscQjISnu24x013B25PuAIS5z9rg+14V25/oXc5EqFx682S1KkNL+TkVwtFbo5h89/PMonr++TMChk;
 20:K0pkmmTX28IVTqnvpLxIHEwH4vCIsZYvO4x/euP14bohZ+/T1AdtWcqi77op/9GlDLn79qiTdpdfn7zcWLqP7AcEbnY2ugX3UBGC2QivtMXgK3ang8SU67Z/fhU02fXdKi0TDbeI64CWxiLJzqjfG4GIiDe03xFr/CIqZD2e2OA=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bdd3a580-25fc-43eb-2ad7-08d58a8013d5
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0069;
x-ms-traffictypediagnostic: KL1P15301MB0069:
x-microsoft-antispam-prvs: <KL1P15301MB00695202D595373AE35B351DBFD00@KL1P15301MB0069.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0069; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0069;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39380400002)(346002)(366004)(39860400002)(376002)(199004)(189003)(105586002)(77096007)(8990500004)(7416002)(2501003)(102836004)(106356001)(1511001)(6506007)(5660300001)(186003)(3280700002)(2201001)(4326008)(8936002)(86362001)(575784001)(33656002)(3660700001)(2906002)(10090500001)(68736007)(25786009)(8676002)(81166006)(81156014)(6436002)(6116002)(7736002)(74316002)(46003)(305945005)(107886003)(110136005)(54906003)(53936002)(86612001)(478600001)(22452003)(14454004)(316002)(6636002)(97736004)(9686003)(7696005)(99286004)(10290500003)(55016002)(2900100001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0069;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: 75u67U1MU9ZOwGz523ysK/lLp6zlllregiwb/vyo6blODdMySbAMpDBpLj+xSovLC6dAieCw39cWM7wx2AqY4n073VgdWN3tylir2TLOzpykmntviDXtuDfos0pCjk4Em+lhLEBHPFe6T+YHh+o13WPcVLYSBFwojALTeC3pR5uCMVOW8KthYSKpgYj9rCGb/Gteec4XHDQsl4T4Qn56PDkJVDZemzDinKloqZHEnGVdVtVAD6WkSyf/o/X3PV8l+JsMY+2+zP66LFhi4y2oix9si4C9PNFZ1rqu//XZg3FdpCKBbmzbGDl5S97uecseq43os0aASzTkeI9vhZZKOA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd3a580-25fc-43eb-2ad7-08d58a8013d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:21:43.0664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0069
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

When we're in the function, hpdev->state must be hv_pcichild_ejecting:
see hv_pci_eject_device().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 28fce2be0a5f..1d2e1cb617f4 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1854,10 +1854,7 @@ static void hv_eject_device_work(struct work_struct *work)
 
 	hpdev = container_of(work, struct hv_pci_dev, wrk);
 
-	if (hpdev->state != hv_pcichild_ejecting) {
-		put_pcichild(hpdev, hv_pcidev_ref_pnp);
-		return;
-	}
+	WARN_ON(hpdev->state != hv_pcichild_ejecting);
 
 	/*
 	 * Ejection can come before or after the PCI bus has been set up, so
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
