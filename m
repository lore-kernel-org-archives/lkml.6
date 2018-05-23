Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-685316-1527109949-2-12925684280500401112
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527109948; b=QYroz3JQqKDDnj3CYzJN2rGxAyWARrrjeN1VycqP8SzJPM33Th
    ZfuQ2Li6WWESM/mX1FXUbhipBlEVoHxelILdHDvaLs8n2m7m9qmRzaqIU+fOLi/5
    EfAY2fSX4dk9Iq2PqjQ51oyow8RX4dPOxqVc7NitDfjCHzrQ2M2HAK+NnJEriGv+
    cjX9DA7xR3C65tJreG7tDtCyc+iPaF07Nr5J5HzQ7HQpc/k4z3t4/3kSIO4j9sr5
    VX7KDPOLq68l+jq6+c/APx0wMSz42zWaBy++bx8GRQJ1bbmUNx/5NcES3+qDro3Y
    ZDcsdDeL3ieGxLQrG2DHMIMQfj0pz0KGwhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1527109948; bh=P2H7b
    6o6FW5rJ13UmIHUOo0M6lGP4O6GX42Dyi7J60A=; b=S13OOIqV7JiOhwFYDyuzS
    20BMzDSpdL9dzpHlPRmRXTkVmMpD03IfhzB2FZlDNqJQOOC83uisiw96GxdXcvG5
    QsZaSWTsor4SkNEsKyXkx8sHO31WfjOYN0xwlFbWjF4Drtvo/TAivcB1tJsWgePD
    2jSXjGgvS3oVcoclumGurWeMdyRvMvcrn5HyP3ENWxHlcuMG7OdvwL81+rf3gnOa
    nTRZcC/6dGHP6VXz5hIPBGrQvWY31Ci8kJjODycL2RfBcXYoTU60yaJ1Ph7acJ7g
    goq8Ft+WPyPHBstACyva4ClF+poVF41aPrzcolrBfP1bEq4kwHXWbBBYQJuYHiYz
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=E7LeCU3N
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
    header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=E7LeCU3N
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
      header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIpR77r0QZpJgwjyWgtEmRgIimiq5NAf2wO7C3eMrq25LMFMtwNbm5s4sVBFXMXIXw/e93UNLqWZ8wSkpFD8dmC5wKr7GPwCVWKvIVs9ycMnZ553Osqb
    1dNahB46ivyBvwix2Y3enoEVZpFuKpE3JfHgf6fV3eM7oYS/TRQn5bmq+RAotMhYyNqauodeBO0GQQebnPFZfOgx4GvzqFUilWs2pqkveehOC/l1s7jQIJKt
    nOWJCMmtzDJ8OdlvKX2Jnw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=R4fxTKrshSIA:10 a=CnFd4b561RcA:10
    a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8 a=phMLXdxRgCC-7T-bQB8A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>, 'Bjorn Helgaas'
 <bhelgaas@google.com>, "'linux-pci@vger.kernel.org'"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "'olaf@aepfle.de'" <olaf@aepfle.de>,
 "'apw@canonical.com'" <apw@canonical.com>, "'jasowang@redhat.com'"
 <jasowang@redhat.com>
Subject: [PATCH] PCI: hv: Do not wait forever on a device that has disappeared
Thread-Topic: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Thread-Index: AdPy2mt/5cq5najeS4qpn1DMFXGqNw==
Date: Wed, 23 May 2018 21:12:01 +0000
Message-ID: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-23T21:11:58.7383302Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:8:b100:aa00:9dfd:2063]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0021;
 7:dnd8TaN8iPGdnlCzhqg3FiiGK+maepdMVLSdnlynP0vmVp3nOMGbJm3XtiCdJ576SfNIt63q2+Grg+Ku37Pujyfrlu7H6ByE91HD8uD4pO9Cm5LnxN1aHLfd7moUBVPlRNMgF3wyPHkeevV/wu7pb4iOzwCZDe9czExYBttL24AcjpUMKmvzVKUjhioEDy8lk5qr5+Ffy+DXORANsPihcajlHKvJCdHa/AciTRWxeeTDhYe8IvSQbsAILCtBcJfE;
 20:AY3uiIpMm9dzAL3/M9furAtqs+fDLtAfXr2/fnsf85D3f4oBeij4hKdI2ZZPotwOHdxtvE+t7R+uDRPJlO8+Sw3Nio+9LbEGw7mm4imLJkM8U/ZN8zsYEgsquzdXiOVZYGEnNvQXZWCqo33W3sHGN+UOCHsU3WuOqu9MjpYtnTg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0021;
x-ms-traffictypediagnostic: KL1P15301MB0021:
x-microsoft-antispam-prvs: <KL1P15301MB0021904D5B27D17C848C0CA3BF6B0@KL1P15301MB0021.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(244540007438412)(89211679590171); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
 SRVR:KL1P15301MB0021; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0021;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(7696005)(86612001)(305945005)(2900100001)(102836004)(1511001)(6506007)(59450400001)(99286004)(186003)(4326008)(25786009)(77096007)(1857600001)(97736004)(486006)(476003)(46003)(10290500003)(86362001)(74316002)(53936002)(7736002)(68736007)(8676002)(6436002)(8936002)(14454004)(8990500004)(6116002)(105586002)(10090500001)(106356001)(3660700001)(81166006)(5660300001)(81156014)(316002)(2906002)(22452003)(9686003)(3280700002)(110136005)(54906003)(478600001)(55016002)(7416002)(33656002)(491001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0021;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: vNnyFo4LwHCRzQVh0xjWaWuJs2/RIetSEQ8ohCzGSCKvWgSxh08vzEhjc1qQUtcoRW2Nqj1zFcho+XGowT5JZjHmNTFn5A2tP9LiikJqQ7DX5m0ewIlKR/a/saa97+ZryF1UkCYRaOtxSlDq/xoL37mTNTjRutRo21hsrALBDiVxCBrhv3arGhUuIHuOYGj4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4d1f28d9-5139-4dcd-0c9d-08d5c0f1d446
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1f28d9-5139-4dcd-0c9d-08d5c0f1d446
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 21:12:01.8750 (UTC)
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
Cc: "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
 "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "'driverdev-devel@linuxdriverproject.org'"
 <driverdev-devel@linuxdriverproject.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Before the guest finishes the device initialization, the device can be
removed anytime by the host, and after that the host won't respond to
the guest's request, so the guest should be prepared to handle this
case.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 46 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index ad6a64d..248765f 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -556,6 +556,26 @@ static void put_pcichild(struct hv_pci_dev *hv_pcidev,
 static void get_hvpcibus(struct hv_pcibus_device *hv_pcibus);
 static void put_hvpcibus(struct hv_pcibus_device *hv_pcibus);
 
+/*
+ * There is no good way to get notified from vmbus_onoffer_rescind(),
+ * so let's use polling here, since this is not a hot path.
+ */
+static int wait_for_response(struct hv_device *hdev,
+			     struct completion *comp)
+{
+	while (true) {
+		if (hdev->channel->rescind) {
+			dev_warn_once(&hdev->device, "The device is gone.\n");
+			return -ENODEV;
+		}
+
+		if (wait_for_completion_timeout(comp, HZ / 10))
+			break;
+	}
+
+	return 0;
+}
+
 /**
  * devfn_to_wslot() - Convert from Linux PCI slot to Windows
  * @devfn:	The Linux representation of PCI slot
@@ -1569,7 +1589,8 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 	if (ret)
 		goto error;
 
-	wait_for_completion(&comp_pkt.host_event);
+	if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
+		goto error;
 
 	hpdev->desc = *desc;
 	refcount_set(&hpdev->refs, 1);
@@ -2070,15 +2091,16 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
 				sizeof(struct pci_version_request),
 				(unsigned long)pkt, VM_PKT_DATA_INBAND,
 				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+		if (!ret)
+			ret = wait_for_response(hdev, &comp_pkt.host_event);
+
 		if (ret) {
 			dev_err(&hdev->device,
-				"PCI Pass-through VSP failed sending version reqquest: %#x",
+				"PCI Pass-through VSP failed to request version: %d",
 				ret);
 			goto exit;
 		}
 
-		wait_for_completion(&comp_pkt.host_event);
-
 		if (comp_pkt.completion_status >= 0) {
 			pci_protocol_version = pci_protocol_versions[i];
 			dev_info(&hdev->device,
@@ -2287,11 +2309,12 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	ret = vmbus_sendpacket(hdev->channel, d0_entry, sizeof(*d0_entry),
 			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	if (!ret)
+		ret = wait_for_response(hdev, &comp_pkt.host_event);
+
 	if (ret)
 		goto exit;
 
-	wait_for_completion(&comp_pkt.host_event);
-
 	if (comp_pkt.completion_status < 0) {
 		dev_err(&hdev->device,
 			"PCI Pass-through VSP failed D0 Entry with status %x\n",
@@ -2331,11 +2354,10 @@ static int hv_pci_query_relations(struct hv_device *hdev)
 
 	ret = vmbus_sendpacket(hdev->channel, &message, sizeof(message),
 			       0, VM_PKT_DATA_INBAND, 0);
-	if (ret)
-		return ret;
+	if (!ret)
+		ret = wait_for_response(hdev, &comp);
 
-	wait_for_completion(&comp);
-	return 0;
+	return ret;
 }
 
 /**
@@ -2405,11 +2427,11 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 				size_res, (unsigned long)pkt,
 				VM_PKT_DATA_INBAND,
 				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+		if (!ret)
+			ret = wait_for_response(hdev, &comp_pkt.host_event);
 		if (ret)
 			break;
 
-		wait_for_completion(&comp_pkt.host_event);
-
 		if (comp_pkt.completion_status < 0) {
 			ret = -EPROTO;
 			dev_err(&hdev->device,
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
