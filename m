Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521496637-2-1469996242495256573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521496637; b=aXelZX0eo0igEpYfTXaCkvrYmb3bcYTcALjYIIzUH1zVZ47
    EoPj4yVd+5mcN6921nqdAnj7bkct6bfyS3MOthMhHNbXBouV8+qMEy6pkae6xHUA
    oltOECcKKo1NL6pgrqitY3DxOWZzxhqs/YUVKHGZFqS5PasGTevyvgYt+0JVl0Gx
    NKSsmi8DYNA4J3UTsTq9GUD560Whdt8TS1+d/jBQN7QPz2H8e2gdbqZOCClaD/zD
    gFuOx09/r1WxrWsH5ROSPYkDyW1tyG0qMig22BEe36F5sas8c34NoBMlyEje+Bs0
    i0TvFBYrqWC3c/dveo9lNcuB+k7d88UR6gl5bEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496637; bh=x4zWib
    xeCShfESBJj5p5W8aorLu94phBxMljjXWfsDA=; b=eYthlIVENTwS/gorFp50wj
    wDjwuT5+dpzRjJ3cVrron9sKFKgI1ewMAVqM07O10lAfeB9sxw42bgj0LCkiWiOv
    TxlhgcmdnzvM7wGc/mw4dZPrCgXgKxlZGerPlrxl4D7kZ7PlMYroUfwlV9TpiMkD
    0gKMXjCIQvbsPy93RdBKvxlX7eYjo2CQWRHIsZO2tqDViHL3N6cCD7wK9DAi9EEz
    HMc/d63BuWQDEsiLVsktknq8kUcLqsGOgRXbS8UslzUbtX8sC3UGvdzTN/eI8TQj
    ZJMFnKUCfH8hmE0CpcpKrTHbesNkCulB3hMhD8doKPn+jDW8SdhacpeaWENlLHgg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RznTZESw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdejheenucevlhhushhtvghrufhiiigvpeefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RznTZESw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdejheenucevlhhushhtvghrufhiiigvpeefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972094AbeCSV4m (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:56:42 -0400
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:22624
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934575AbeCSP4m (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 80/97] scsi: megaraid_sas: unload flag should
 be set after scsi_remove_host is called
Thread-Topic: [PATCH AUTOSEL for 4.14 80/97] scsi: megaraid_sas: unload flag
 should be set after scsi_remove_host is called
Thread-Index: AQHTv5rQmGwpHI5gmkitAuYnwOzp7Q==
Date: Mon, 19 Mar 2018 15:56:16 +0000
Message-ID: <20180319155411.12348-80-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1064;7:yUyY6Bjk4elgvF8UtMoHZycCBSFtTWSxXgp2ykjeb88yKUZAIbGE/6kPtaxaIR5FpzVf2rVytaUAMqv6epo3/k/8DU3U6I5xn1qP7dSZfN0tAGzTZ09O7qz+ZnOFCcyFviHtOLXOMbTlJLdXgwfolvoeXjlNffy9MxYxJIKj7A6C5iWdYBg6ucRYMVX3PrQcB+HnnIS44Np0oRS6ePdd/Dvd5mbxuVuvQh7VWuAg+w4s6eL/hXCYguuYzuytkdHo;20:RrQYllcQ6GL4t/aAe0JcQuo0+81O5dXWhN7zLmJfmT1MCZ7eDfJq8m6dBO4qMD/nRI8C3o5MMeOFM7b686cEnHZES21V/u1mwfaU9/irlxlIclpINxWlo3hJ2dgg0KwjOVPUE/cB2Rkp7zsDM2FSxss/O3pu3Zqubk/fuOkiUXs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9931a6e-28d7-435b-dbba-08d58db2011d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106460C9FA6AEB206734794FFBD40@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1064;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(6666003)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: UozCc8vC4h2F7G1mhzP9nfV560p+xT78tyGrzhO9PG8/6XCxkPADXU9DAhK/gybXkYlxPXJldLV8s5rAz3Wqfhi89ki+YIId7OsZ+oFoqHKSAKhotbmJM4AF6BuQuApd4dfH5BqZsF7KvPr3qwxfP2SzHCis7dWUYFvhctvXP3sz9oV4w8NXTiJOkwVEf8hA6sZZx5eqFXSzHsCsHndT0jtYdvc0oD/wMQD/gUhfESkbWuwQvHJnfbSTToma2RGoZTopTY29DGyW8mQ5d9M/s+bixcFVo3sq2CzPmrmSq6QNuGdspI6JTE+JUYJ9og+7V0pL49wHgMoRLW1tCzavUw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9931a6e-28d7-435b-dbba-08d58db2011d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:16.9198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

[ Upstream commit f3f7920b3910171b2999c7dc2335eb9f583e44f2 ]

Issue - Driver returns DID_NO_CONNECT when unload is in progress,
indicated using instance->unload flag. In case of dynamic unload of
driver, this flag is set before calling scsi_remove_host(). While doing
manual driver unload, user will see lots of prints for Sync Cache
command with DID_NO_CONNECT status.

Fix - Set the instance->unload flag after scsi_remove_host(). Allow
device removal process to be completed and do not block any command
before that.  SCSI commands (like SYNC_CACHE) are received (as part of
scsi_remove_host) by driver during unload will be submitted further down
to the drives.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megar=
aid/megaraid_sas_base.c
index e518dadc8161..4beb4dd2bee8 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6605,7 +6605,6 @@ static void megasas_detach_one(struct pci_dev *pdev)
 	u32 pd_seq_map_sz;
=20
 	instance =3D pci_get_drvdata(pdev);
-	instance->unload =3D 1;
 	host =3D instance->host;
 	fusion =3D instance->ctrl_context;
=20
@@ -6616,6 +6615,7 @@ static void megasas_detach_one(struct pci_dev *pdev)
 	if (instance->fw_crash_state !=3D UNAVAILABLE)
 		megasas_free_host_crash_buffer(instance);
 	scsi_remove_host(instance->host);
+	instance->unload =3D 1;
=20
 	if (megasas_wait_for_adapter_operational(instance))
 		goto skip_firing_dcmds;
--=20
2.14.1
