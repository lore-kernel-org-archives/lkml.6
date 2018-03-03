Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2835548-1520036556-2-10745562236380254922
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
    t=1520036555; b=LXpoQ5seob5KMJz2qakroybLjsvmoWsECgdA3BaKKZGHZGD
    aMQBZ6PaaBDSD70PjKwtSEd0AFjJY1sQhGP6P1Zp215gogUnotXsX7yftG5TII3x
    nC9yY/MdPElGAL8A4YD8x7fXjPz730uwDAvI9egs68GydJdm/2Vct1tsv44xDTpx
    28K3/kHCaTt0kYM2fqFhDWolkmzi6T8CFD0oE3QaDuRPEtam3RgWKxiau+L2pI5d
    Q+B5kCm9ulzS/vuzG7AdIbwa1tkcARGajAPA4NVVW8FUq8Ax1W8685d4VcTR2eQX
    rBUZchWK54oI9Hi7ADwX9/e0KIOPMrcogLk6xHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520036555; bh=F
    Vg4YdkUqfWvyDMM6SJyHwU5fqlBntaSFPkkjE2qYWE=; b=I/PGLBZIU3E+haCPS
    UTZziLFdLJD46aUgevvMY7d1I2CjPLenxAWLAGvBx/coWVNGoWYl7wZAV0qwPU+d
    Y5l5qtACQrXSQmSVUj03fhUGncy46zfjK84mCbDAQej23FuP/2U1dGVoO7OBzDs+
    WI37aAwlJqE77PTlcNDYDDY9YosvGRHxYc/0PN68Q3LM6NSYQfl9BV0yBQhQSthF
    gnE0C7UOWGfv1eyVitIx2XUZEIqGbNjAaeyFBt2E2bP6LGa/IFh58BxVekupIsFs
    7TJjN5KfMOpcaelv7pv8FQRo/QQ4e1+/9RG79RJ2JBRUnIUIOglyM4cesK6ztgmk
    frrBA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q3eFV/gC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q3eFV/gC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, KY Srinivasan
 <kys@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: do not mark HV_PCIE as perf_device
Thread-Topic: [PATCH] Drivers: hv: vmbus: do not mark HV_PCIE as perf_device
Thread-Index: AQHTsoWxPZWSmwkLCUq7k/Ya55+f/A==
Date: Sat, 3 Mar 2018 00:22:19 +0000
Message-ID: <20180303002155.20689-2-decui@microsoft.com>
References: <20180303002155.20689-1-decui@microsoft.com>
In-Reply-To: <20180303002155.20689-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0054;
 7:AT9yozJGd/S3oRs2k7J1pl0+lCe+OSmF1zRRcxtbC/7CBH6licyG42mbXHBTb2KAIaz1qJp6GDOYDaojMamVaFFKc3artO07DaqWQEOkKOzc/ypY5GTzfjB1hxHmrEVPow9XHJx68yQ7aA1f17yFUWV8L5iEc6p1w1JjRXfw0jbIbHEgU3dr7HP+ZOnF9tOBrEecgDtE2dGCIxnvbQYDk1o7mnS84wBHEbvfYo8Y5kZv/Whp4IvnkJQu0+dy3Ax3
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54cee319-d0ed-400b-545a-08d5809cd3eb
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);
 SRVR:KL1P15301MB0054;
x-ms-traffictypediagnostic: KL1P15301MB0054:
x-microsoft-antispam-prvs: <KL1P15301MB005452A1F364E3130C9459C8BFC40@KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);
 SRVR:KL1P15301MB0054; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0054;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(5660300001)(2906002)(4326008)(6116002)(1857600001)(8936002)(86362001)(2501003)(8676002)(6506007)(2900100001)(6436002)(14454004)(3660700001)(86612001)(305945005)(36756003)(99286004)(316002)(97736004)(25786009)(110136005)(1511001)(102836004)(54906003)(81166006)(10090500001)(81156014)(59450400001)(3280700002)(26005)(186003)(77096007)(6512007)(6636002)(76176011)(478600001)(2950100002)(3846002)(1076002)(22452003)(10290500003)(106356001)(66066001)(6486002)(50226002)(68736007)(7736002)(105586002)(53936002)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0054;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: 1EGDnBgh2MawakXFQO/CW2ZtSmIjFUIAYrqT1Eucb6AglYdXgi22tOUe4v4OgfltD4pcsDhyTLlpTW5yEfAbqmBD3flhJ9zy1pE+l1p+yMMeEx9CyrAbEbjBKXcWUQqWLOpdlkaDQxL8Ypm4J7HQr0U5H6cx/ldPQEGf9SI1n+o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cee319-d0ed-400b-545a-08d5809cd3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 00:22:19.6137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0054
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
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

The pci-hyperv driver's channel callback hv_pci_onchannelcallback() is not
really a hot path, so we don't need to mark it as a perf_device, meaning
with this patch all HV_PCIE channels' target_cpu will be CPU0.

This patch can help to avoid a potential ABBA deadlock in the busy loop
of Hyper-V PCI driver's hv_compose_msi_msg().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index c21020b69114..55ee5e87073a 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -71,7 +71,7 @@ static const struct vmbus_device vmbus_devs[] = {
 	/* PCIE */
 	{ .dev_type = HV_PCIE,
 	  HV_PCIE_GUID,
-	  .perf_device = true,
+	  .perf_device = false,
 	},
 
 	/* Synthetic Frame Buffer */
-- 
2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
