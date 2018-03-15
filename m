Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-444702-1521124701-2-2967799934436304984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES encada, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521124701; b=oTuYQPTOdDNaYJHYZbVUghshQZCRtcG9FACVfEkFN0/zkFb
    QdStVqGNG6pCp7rMYfFzJLAUNiHbYeJTJ+iimYvJKTn3aPQYUbojeby00NxO55lP
    pkGxT4UxknOpzH/si3VlXBxSNIjCwumys4ivIdTXThrwGrFUbwyrRJBmoGHBuWrm
    e3o19blTjHITvhKdAQj5EpGp3s/lFMKbjWYOp62nJcURp00KKPPSq4crnqc24jNe
    Yg9p/FNQ+BybiJQk/lkGZHvEXPaXKfkGn0WoUwp/lLMYqI5RYWK5uKUcza0iqkEe
    fzFC1fmP8zrE5DWpa5KYuH6HHGUb131pmrXjOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521124701; bh=h
    GP6e+iLbpB338HdESerqofYJj1nywCQaBYa9UcvVXE=; b=a8Ip+P6mLszmz0Ujz
    UWyPYbW3Jj3/A4rXHP7bxWgpsl2tamL4YVPQuSTQ62avz9XS4wq6JIR7iiztfmlm
    8ac63cCTMa3lsIEa7j8sm7j8QPMdP8QfNsN8dur9N3jcYaC268B1wpvLnpZR7eq3
    M3eId4GSm2e4wSByyYZ1AnPWaqSYaFDwgdEWQxrM7c6q7LimW2s8yVIB5rJUOajE
    SSZTKrwTb2Kjq73gHwj0bOw/8qEBJ++XS9gDbu9RNgBI90CjUCb2R2rJWlR2p84/
    xY30j4A1DWw2jwpyApqiyBBf9Kz4Z0Iln/fLNtUV5NOQApihQ7NtCKAL+t7HNpv2
    cD70Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jk0jY9p2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jk0jY9p2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v4 4/4] PCI: hv: Only queue a new work in
 hv_pci_devices_present() if necessary
Thread-Topic: [PATCH v4 4/4] PCI: hv: Only queue a new work in
 hv_pci_devices_present() if necessary
Thread-Index: AdO8O+5kR8xWt6mdRW2rNfrvNdXo1Q==
Date: Thu, 15 Mar 2018 14:22:00 +0000
Message-ID: <KL1P15301MB0006CFED2B13C56CDDD2A153BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-15T14:21:58.1991440Z;
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
 7:vYEgZCyCYXHce0A0ppOlN/d7VVVopweu9H4kK/ZI7uDTAFOx/+xjdsc2m6fx5929H3FwGC+TdcBlmyOAVQz5zQPCypChbJV6QAfnp3RTpaxdsH81gZy4oAV+SwFrut13aw2GmKTf9juEnvMt+oI1bvWZJkKtqX19e48BqUmtrSY1E0Kd2ZYsexU4XwccJ+0qyW6nylEiwE4ePoBvZv49QWIRhjG+w0iqX7Cs9HA9lNYBtPtTcJiFI/VHVZhEuE2B;
 20:6xda291qB3uSDDrQ6wXsZcLZDKOxaKU5UybysvDcIJiey9Fff+E2bgr5+tb1T7KXeOtOHh/30xnkM2vS9CbRpl6dOgbG4/+66YYFyD240GBq7NrDAAG4yGJ++psgo1jpTVtGUtAYYKQljNXDo6JJd/Xs+bd1HO0nGj6zZRpPnIA=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 459a910f-dff4-48c7-f225-08d58a801e39
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0069;
x-ms-traffictypediagnostic: KL1P15301MB0069:
x-microsoft-antispam-prvs: <KL1P15301MB006923E5ADE32A634C95E2F8BFD00@KL1P15301MB0069.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0069; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0069;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39380400002)(346002)(366004)(39860400002)(376002)(199004)(189003)(105586002)(77096007)(8990500004)(7416002)(2501003)(102836004)(106356001)(1511001)(6506007)(5660300001)(186003)(3280700002)(2201001)(4326008)(8936002)(86362001)(33656002)(3660700001)(2906002)(10090500001)(68736007)(25786009)(8676002)(81166006)(81156014)(59450400001)(6436002)(6116002)(7736002)(74316002)(46003)(305945005)(107886003)(110136005)(54906003)(53936002)(86612001)(478600001)(22452003)(14454004)(316002)(6636002)(97736004)(9686003)(7696005)(99286004)(10290500003)(55016002)(2900100001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0069;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: 3JZ5wDy/2t70fJ18mLkRjDaH28IO4Ge1JO2YpEn+99NQN110ydfnCSV4O3V69107+jBFJlmDvQ35L2b7BjRYbsMU4YPv0iohrN3fUjq24NdXOzf7psTm/+DIGH4XGvsnZTcE2gSgJLTEbpQYYg8xcCs3WcUMCQamoNDSj/0+ptnDwyYCg3A8ITUgHucpJbXhOvpEmyWdATBXMh158bb3Jxr+sb0zilsxO7zt5wG42mJBOazL7tiotpWbScscW9gMqzzndtqFh6KBP/8xfZtzyueCpkUlir4eN9g/vhz05BtiNRfKqvEiW6MlFTHrzvUlC7IfxbHVARxHIU7gYaXkjw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459a910f-dff4-48c7-f225-08d58a801e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:22:00.4729 (UTC)
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

If there is a pending work, we just need to add the new dr into
the dr_list.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 0dc2ecdbbe45..50cdefe3f6d3 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1789,6 +1789,7 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 	struct hv_dr_state *dr;
 	struct hv_dr_work *dr_wrk;
 	unsigned long flags;
+	bool pending_dr;
 
 	dr_wrk = kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
 	if (!dr_wrk)
@@ -1812,11 +1813,21 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
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
