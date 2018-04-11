Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-946353-1523406998-2-15436585900444168380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523406997; b=E/rsiBEFLnGkZ4UzCdRiL7eeYX2VbLuTwnocaj01WMW5YrmPkf
    rbUl2FGnygMhWm5g0giUPdWfWI7lwZ50skadHXbl5zPqvelrdeJgxUGGpIGAvx2X
    VRLNuknI7k96H0IeshAHopCKz7cvubKXgwT3MC0C+eXaAx8DF8QnwchKteDyqaZK
    of0xqLHzP3htnQbhYjky8uZVqQVgMJrrlrCkv6FcTki6c8HvAlV8Yf/mr5LZzE/u
    TS5Ke5YsiRL76TwGA+4v+sq3q0/f+w+y8NkMym7n76bgsXpL6O8V3R20D03n6Yqr
    bx88i/C9nDQP5bVzme8VZTTPOu75Tihyt+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :content-id:mime-version:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523406997; bh=ivLzW
    r5/LtTtglzcR3cT/gS0wqwxTVYv2MOrSDvQFIA=; b=si65OV7AuRhghr1x2aPw/
    1k4GytFLlJPa9nHcb8zrfIxXrNHW8WAow+lYJ1c2DbDGBOaP/ga5/28bRvMbFSYL
    CrmHZm7sQQS/pjqtr6PH5EOplbAxkK3utfuI7ozZ/4UOQw5YqtqOzzLvVAQfgkhJ
    HH8CxWPonXAY6hdiCZVtJjgKwmdWrTzeaYDJra24MDQ5D1i5bbriTMZF6XrYru87
    FvIQxNdyMpz/vy9YHxtr7N6YjWDy/FrlIoYz6pGVtg7x0X3r1wHLukc8mhIF4UVH
    1DuX+5nhIgDChNNtoQ8Eiy+gfPBDEA4r0Dv2CXL6ihnV5gIHQ7PXio4sq/X6IkKy
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jYVDDHZ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jYVDDHZ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLZzFemF9Exi1iEVKadRZLQIng9Mb/YYAzV9XPm+1L1IGyLIG5qexGR+5s2huv0FuesllXy7lInYw4ZAtfOKGqa+qgmNLLv7msrK/6YDHuWK+lYRHdPX
    A7YVrsRdCjzmP9SmHbkFE0Te4OvXGtYKq/2JPEt8MwfDDkdeAc3p5lgdputr3mx34TBeHnKaFsxa4n+F0EapxX6B3h3XOrXyeo/AXVUR3BTeWkm2C2IbQEH9
    716BW+ROBELQHAtYLia92w==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=R4fxTKrshSIA:10 a=304C54EdYA4A:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=DDOyTI_5AAAA:8 a=UTXK74XPGfO0bhJ49ZAA:9 a=6chyz0xCCkWptBpD:21
    a=KmwFACWX7IlZZmkk:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <helgaas@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: [PATCH v6] PCI: hv: Make sure the bus domain is really unique
Thread-Topic: [PATCH v6] PCI: hv: Make sure the bus domain is really unique
Thread-Index: AQHT0S0fJyMCYMl+qE6vYyIvqHbDPQ==
Date: Wed, 11 Apr 2018 00:36:25 +0000
Message-ID: <9496B0D1-CC19-42F4-BE50-DEA4EFC8D615@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:5::67d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1083;
 7:Y+4+fME6bQkykhrq7m3FRVgG+baCQO1DJCaa/g84VOzKgser4GDoRQ/a0nhW2W93Yi464LjhHzHuGmiu6r1FGeNNYk5iukuQjXoUqJpr3QAP3YFCN+x6qUx9ebPR0kxRyldDTCiSZbCUkj42nKPvGtqRRRQFkvs9fbX5wbUNvHtzTkE6bg6tZn0mTyiwcP205xkB0miD0sXvQwg+kqhWC+znqwZTBUEV2YROK+xaS/TEQJk04gsqYPGUCOdQ/v8n;
 20:NXbei0Pir1Q3OgXLKxeBvQBj69RrbknWYCl1Q2Wm39xlOuw31lyTZ/PAP9NGIGc2YP+AZuCBNydzBBTU+dpZUhIPYWPmYZzMCPSPCl06IEmtCynWE6TKJMJUPhd+YG2R7aqt3Fzek1M42PJ+Ap3qt6MED8S47qnH9A/XF1yEZQ0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1083B977E8EFBA09BE55F577F6BD0@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:MW2PR2101MB1083; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39380400002)(396003)(39860400002)(366004)(40224003)(189003)(199004)(7736002)(3280700002)(3660700001)(486006)(68736007)(2906002)(36756003)(476003)(2616005)(4326008)(99286004)(86362001)(106356001)(59450400001)(6506007)(102836004)(25786009)(81156014)(6486002)(81166006)(14454004)(8936002)(8676002)(305945005)(33656002)(186003)(5250100002)(105586002)(46003)(54906003)(110136005)(316002)(22452003)(6436002)(97736004)(6512007)(10290500003)(6116002)(5660300001)(478600001)(72206003)(2900100001)(83716003)(82746002)(1511001)(6636002)(53936002)(10090500001)(86612001)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1083;
 H:MW2PR2101MB1129.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: e2Vy6Ycm5tIA5BlkFXLq772MOJeQHkkn41SV3N5lMgDO/QcRL6lxOO9xIdkEkM0aO3IT4jHN+uvgQQ+mLhooTxV4BCw5uSMlfgWCvUF3RSdqhyM4F76zZIl+/umU6Gd3eQpyjbfBc53aMK5mYtIUjnuTI3Twrbo1ACAQbBxwz133ICb7GvOEImxWGvPMFTxfy8pvmgXJFaqBgau+2OdbxWPcQoskjoSzCMJNcIdrBG8Co6qYrLqYhzet2TFiw6ZphNxf1bUAkmus2vC9iIkoXuxon3A5DdFMqmc1EIlgR8mNL4UrYpHJq23HFCm2eKAx+eq3PeQaPLNqzNktbQi02x9nA491YbVHPrKJFP4Z8ty/+nMR7xHHrIKlSJ2xeiGSXuqKsCUBuO2gISGcA9ieOQ83UjPp9t7jJoupxL0saJc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <7A3619E39EA95F4FA5A203B0BA22C9A5@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 12363a75-03b9-4759-6a1f-08d59f44425b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12363a75-03b9-4759-6a1f-08d59f44425b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 00:36:25.9710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>, Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual
PCI bus to the guest, Hyper-V always provides unique PCI domain.

commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
overrode unique domain with the serial number of the first device added
to the virtual PCI bus. The reason for that patch is to have a consistent
and short name for the device. But commit 4a9b0933bdfc ("PCI: hv: Use
device serial number as PCI domain") will not guarantee unique domain id.
For example, if the serial number of the device is 0 and there exists a
PCI bus with domain 0 already, this will cause the PCI bus registration
with kernel fails.

commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
domain") need to be reverted.

Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
domain") so we can reliably support multiple devices being assigned to
a guest.

Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
Cc: stable@vger.kernel.org

---
Changes in v6:
* fix the commit comment. [Lorenzo Pieralisi, Bjorn Helgaas]
---
 drivers/pci/host/pci-hyperv.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 2faf38eab785..ac67e56e451a 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 	get_pcichild(hpdev, hv_pcidev_ref_childlist);
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 
-	/*
-	 * When a device is being added to the bus, we set the PCI domain
-	 * number to be the device serial number, which is non-zero and
-	 * unique on the same VM.  The serial numbers start with 1, and
-	 * increase by 1 for each device.  So device names including this
-	 * can have shorter names than based on the bus instance UUID.
-	 * Only the first device serial number is used for domain, so the
-	 * domain number will not change after the first device is added.
-	 */
-	if (list_empty(&hbus->children))
-		hbus->sysdata.domain = desc->ser;
 	list_add_tail(&hpdev->list_entry, &hbus->children);
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 	return hpdev;
-- 
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
