Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3351567-1527034728-2-16967732060612658815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527034728; b=TAMNcDgsT99O/T71xPtkPxr4ahA9HY+WCgjbtcL8Ezh7QabUOP
    SbEdQJs7DPLgDm3ZKS7xbaBYIXi7gFm/4NX32zsKDuosCIBjoOZ1B25nGo3yFrhQ
    vEwVGNFAiykpjBTn8K1rwQgUygjfVMv9iYTST2j++pM9eidlUopqQQXc2C6GFauN
    LQ+cGIRojHmB6D08Z9VfojRNaUSeK5NlMZvRbziDwB1bga9njA1vzDttX1iBx7cr
    poi4xRsWm3t/pIbLCE6+9jzGYYMpovOfXci8Yc01DlsFnygROLBtkc79RoqEleR6
    oNmdUX7z/OaLK521wiQL5OrSVox5mVJ7Zobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1527034728; bh=HkDs1
    Y0CbjhwlTEDR0LLTO97DgZKgARronToYqnhsUI=; b=nlYTU+EPjcUZDpA9EZvcT
    0f0cNornX6vsH+BT27tdb/s3e2+THyCSkgjwpFGy7Cq/aFxVu2mrmCZoAKyGsIox
    K00MUlD95wM48MIouZb7r5hgAKRfTXlXX2FI236JmzsJzzqLYTpz/mNIj+rAc0kA
    XMz04kNasFQu3VoBEj6pkR2e4a58ePp4wM6Ix8JdMM1V3yQ7tr+2ixxxXcd5dkF5
    AzWtzyDtpIKtHJTRxkcicnJi/d16sO6XNTEiPxyvGPESoi/w26DtTT7lOSrHZ7/u
    0eDnVzq2NMpBMmY9Xo6dK80gOMT5qn3kksEkaieHUWdb3rYUGPExL9cFcXv0Arz7
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=Br/8bhwA
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
    header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=Br/8bhwA
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
      header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIxOSeaGMYPTXSg4Jq5809RoachDJToP8xz3rtUAiAl1/vlcSSUQHUxqj9dmBHzyJZFWbi1VaCBjcgavFOzYdWHhNWX8JLD902GEPCli0nHxkC2hett2
    T1HaWv0ChqQbKfmLZXI4+cvenqdQNlR6RiK0/Sac67ZWTsB2IhYygxfZ4IdsYdo3uN3tBUZmxDomO9gIxTxSFyVQt6xewdNnfC/lXsxNt0JfV1cwy0zebRiA
    pr7dBcl2aNKTxg4dRPY9Sg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=R4fxTKrshSIA:10 a=fz0NQnzBqbwA:10
    a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8
    a=Gel54KBtRYK0cI_Ge6AA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Thread-Topic: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Thread-Index: AdPyKucLHxE0xn3+RTSKXedSJeHHcg==
Date: Wed, 23 May 2018 00:18:20 +0000
Message-ID: <KL1P15301MB0006EE546A7C2567B61EA783BF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-23T00:18:18.8931354Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:8:5df6:5a7b:7ee7:e115]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0040;
 7:aKCsiOyaGACIdnbVMDDjvqS+75osiU1dVp1JuMLJSGKBbxFmWJ2YRyOVawVHDwEJADuqPe1Db3+a1+rMHruczJ/I4Lo8YK/xRmypFXrOTYVAVhMvlRaIWFMysDzpXB1WWUqGYJctHfltc+mRID0mNCPLXIrqAqSY+OzCjVnUKklUyrC0ugBa14gUK2FuaKjBldoem6RxSO2gvvlTo/yylW6Ybl6oSxIXxrSoUdxmvG9b3v4MLNXFZuokH3o6OHXu;
 20:sXnsl7eqT8/8oy1mcD8RwQnzUHAXjOayQhaygswhbVWTKTj547+T/qXldewMARCRKCvhGV4yVRYhmtDeXobx25KX82gV7Kotlyp4ob2G4pVulvyGLvmeOVHSo83c9OKCwagmZWjhgr8ymxgGvrTp4BsLNrIYvsuMDjiTu/Nl7YE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0040;
x-ms-traffictypediagnostic: KL1P15301MB0040:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-microsoft-antispam-prvs: <KL1P15301MB00402135D72888CDF4E94EB0BF6B0@KL1P15301MB0040.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);
 SRVR:KL1P15301MB0040; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0040;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(8990500004)(6116002)(8676002)(81166006)(3660700001)(81156014)(106356001)(105586002)(110136005)(6436002)(9686003)(53936002)(54906003)(102836004)(2201001)(486006)(476003)(2501003)(86612001)(86362001)(575784001)(1857600001)(97736004)(8936002)(186003)(10090500001)(46003)(77096007)(1511001)(68736007)(7696005)(478600001)(10290500003)(33656002)(59450400001)(6506007)(99286004)(4326008)(7416002)(25786009)(74316002)(305945005)(7736002)(2900100001)(14454004)(3280700002)(316002)(2906002)(55016002)(5660300001)(22452003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0040;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: IRu+CKHRiurG1AidSSoFy5sV4cWabnIkKxdsvgTMu4uPuu2aceIHwWM5qxx9AEmQdycOrwCcrbJ9liMqZui3NyQa3VxNz7f2eJ1MrWcGYDrronX97QbChHtx27rPcqIFjOIkCThkhN2UJE1RXX4xRWnKBMn2ERDdEifwRj/oeC6wQI9gXRdWJ7j8QoRU0kQo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4c35535f-548e-4252-a2ac-08d5c042b0fb
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c35535f-548e-4252-a2ac-08d5c042b0fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 00:18:20.8295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0040
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
Cc: "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
uses local_bh_disable()/enable(), because hv_pci_onchannelcallback() can
also run in tasklet context as the channel event callback.

With CONFIG_PROVE_LOCKING=y in the latest mainline, or
old kernels that don't have commit f71b74bca637 ("irq/softirqs: Use lockdep
to assert IRQs are disabled/enabled"), it turns out can we trigger a warning
at the beginning of __local_bh_enable_ip(), because the upper layer
irq code can call hv_compose_msi_msg() with local irqs disabled.

Let's fix the warning by switching to local_irq_save()/restore(). This
is not an issue because hv_pci_onchannelcallback() is not slow, and it
not a hot path.

Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: <stable@vger.kernel.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---

A trimmed version of the warning is:

  IRQs not enabled as expected
  WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip+0xb0/0xe0
  Call Trace:
   hv_compose_msi_msg+0x209/0x462 [pci_hyperv]
   irq_chip_compose_msi_msg+0x41/0x50
   msi_domain_activate+0x1a/0x40
   __irq_domain_activate_irq+0x59/0x90
   irq_domain_activate_irq+0x25/0x40
   __setup_irq+0x3ec/0x730
  request_threaded_irq+0xfa/0x1a0
  mlx4_init_eq_table+0x3c3/0x5f0 [mlx4_core]
  mlx4_setup_hca+0x1db/0x750 [mlx4_core]
  mlx4_load_one+0xad2/0x13b0 [mlx4_core]
  mlx4_init_one+0x578/0x710 [mlx4_core]
  local_pci_probe+0x1e/0x50
  work_for_cpu_fn+0x10/0x20
  process_one_work+0x1d4/0x5a0
  worker_thread+0x1cb/0x3d0
  kthread+0xf5/0x130

 drivers/pci/host/pci-hyperv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 50cdefe..ad6a64d 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1051,6 +1051,7 @@ static u32 hv_compose_msi_req_v2(
  */
 static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
+	unsigned long flags;
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct hv_pcibus_device *hbus;
 	struct hv_pci_dev *hpdev;
@@ -1148,14 +1149,14 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		 * the channel callback directly when channel->target_cpu is
 		 * the current CPU. When the higher level interrupt code
 		 * calls us with interrupt enabled, let's add the
-		 * local_bh_disable()/enable() to avoid race.
+		 * local_irq_save()/restore() to avoid race.
 		 */
-		local_bh_disable();
+		local_irq_save(flags);
 
 		if (hbus->hdev->channel->target_cpu == smp_processor_id())
 			hv_pci_onchannelcallback(hbus);
 
-		local_bh_enable();
+		local_irq_restore(flags);
 
 		if (hpdev->state == hv_pcichild_ejecting) {
 			dev_err_once(&hbus->hdev->device,
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
