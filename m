Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497744-2-2251956616713493789
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497743; b=VKjRrWFra/BCnaxw+oBiUPocpo5bdnSAW7IMKezOwPbt7Hq
    w0O9AXIe2eo8jVDw3Bp3SeCsL75EisAYEWmy7TdRM56tYppcNdAO9I+aS0wJ4reL
    i9SZzN9EVgnO5xLlcPQeOJIovMqaoBlKIQTPnDozWQigUk9wY8uoVial6+SCvLsc
    onBIUaMovhiKM3SLuCT4khg46pNxL/racKDYpcibwwuq+Iayw6H7RO5HpK+6ZKCF
    MUOYmX4UK7g1q+Qn6NX4sBto2oUTXa1u0DAZ1Dyfcg+Y3G8XrkoDHF1WFI7/6alO
    stzk64RiE7IDFtNJ78PK1CUefVaj48/y7ySI75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497743; bh=rGaDXg
    dBtsPkY3VzCtukOahGszqXeRijNiRcdjAUSEg=; b=Bk+CoMCWYx8zgRwvpD0bBm
    EPgXmogMbXdfNg0StdR+hDP+rjW50OncAN1scMek4JjNPopyhgEm3JKRsxiDIWoB
    p597Col6PLGyeEp+9rbCQZrwqNgu/LAG7aFJGT2dCM42SM+2FxHT6+2VuHSiVsT8
    yrANyJ+JSOm/S25PWR3D9rwC4muLuW5jj53SrSCZgm2TQkNI8ntZanV3LWOtb3Cn
    JTD/2Wj8SZS/Airblv39Iwac1vkwhiE/txk1EoCzjB2Q/LniCvgQD6E5pn75PxVP
    c81Q4TmLgoc6PnTClLB9x4sIW9/NATivSlJ0w2EM/1DdXj2q00V/9/Kf60e3OqWg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M9en1ts0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedvkeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M9en1ts0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedvkeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934250AbeCSWPl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:15:41 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:20557
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934031AbeCSPt6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bart Van Assche <bart.vanassche@wdc.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 097/124] block, scsi: Fix race between SPI
 domain validation and system suspend
Thread-Topic: [PATCH AUTOSEL for 4.15 097/124] block, scsi: Fix race between
 SPI domain validation and system suspend
Thread-Index: AQHTv5nE8nV7gGTxw06Jq9cRZcVU8g==
Date: Mon, 19 Mar 2018 15:48:47 +0000
Message-ID: <20180319154645.11350-97-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:z+iUAXy35ebk7FH52QU37RNikJu7gHpWQT3tMzw5Wq9RZ8Z9BvTmZgImzXpLdgfRM4JNXM0mbJl2/ABEVm37i3vf60eXjrOcs5wHxAWKEA4EmXxLv9wx2V47QGJ3gtebBk8VEhbGKDdZQJVGVIrC2S/OX3esPpvHcI5MQlMSnFjKCB0ZkjTDeiF0zY3jnkRfG1whdbfawAc+pofI68z//A3HqFn94fIakdYseQFeeYXvGd3RfHw2s4PULs4mTvFH;20:LcO4J18hTilERCq7LPfwXouEk0jjn6q4GDBFYWb+MEgLHlsa/zjxbwDM3AE4oSGecv8BFzC5NNcMZ9uF/fA1QBkaaMZ04/0WJcDT0pci6EiTU3KGAGrJQztCMn97pjK6W+TRkd9hqc/rrygKxXjG08UE7+WbDpUjUU9PrFkVIno=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92deab7b-64ea-476b-758e-08d58db10655
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098186978A7BC4540BBAB508FBD40@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(66066001)(6486002)(26005)(110136005)(5660300001)(54906003)(15650500001)(3280700002)(6512007)(68736007)(102836004)(6436002)(107886003)(10290500003)(53936002)(186003)(59450400001)(72206003)(14454004)(36756003)(6666003)(2950100002)(316002)(6506007)(22452003)(478600001)(10090500001)(106356001)(105586002)(99286004)(7736002)(3660700001)(86362001)(575784001)(76176011)(305945005)(86612001)(2501003)(97736004)(5250100002)(4326008)(3846002)(6116002)(1076002)(8936002)(25786009)(81156014)(81166006)(8676002)(2900100001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: L/86IAIVapNARxbkR1MjY4FKr+D2HoOjAMEUI6rQx7ab1UfWS7TboNf7PyYM/PweYSIyQlKO3IiiaisyeO8jkNN6YCQPxhub8uRLD7YWEN54tfLobPhlhCAfdIfOM2L8Ot4K3Ap6nXm2hTNfIpMIAFR5CfiUyu+UhgtsVRigaE0zJB0p49h+TO/5I2szVMgEeoEOZyR7vyEANJg9fhHXKsKxHkHSB6MVkAxLOoKQsGuS4ZYwPiBWqijRSg6c2KX/RfA0LUkjqvAzIu82+J9nSdjYLFgVysXOaYA6KA3Xrz+4f0cyd7e6++WoX0dTNzDCHlAxa8KWIDZTGMP+/cD3NQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92deab7b-64ea-476b-758e-08d58db10655
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:48.0943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 203f8c250e2195371d418b1e8466e4caf1a0ed51 ]

Avoid that the following warning is reported when suspending a system
that is using the mptspi driver:

WARNING: CPU: 0 PID: 4187 at drivers/scsi/scsi_lib.c:2960 scsi_device_quies=
ce+0x20/0xb0
EIP: scsi_device_quiesce+0x20/0xb0
Call Trace:
 spi_dv_device+0x65/0x5f0 [scsi_transport_spi]
 mptspi_dv_device+0x4d/0x170 [mptspi]
 mptspi_dv_renegotiate_work+0x49/0xc0 [mptspi]
 process_one_work+0x190/0x2e0
 worker_thread+0x37/0x3f0
 kthread+0xcb/0x100
 ret_from_fork+0x19/0x24

Fixes: 3a0a529971ec (block, scsi: Make SCSI quiesce and resume work reliabl=
y)
Reported-by: Woody Suwalski <terraluna977@gmail.com>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
[ rjw : Subject ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/scsi_transport_spi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transpor=
t_spi.c
index 10ebb213ddb3..871ea582029e 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <scsi/scsi.h>
 #include "scsi_priv.h"
 #include <scsi/scsi_device.h>
@@ -1009,11 +1010,20 @@ spi_dv_device(struct scsi_device *sdev)
 	u8 *buffer;
 	const int len =3D SPI_MAX_ECHO_BUFFER_SIZE*2;
=20
+	/*
+	 * Because this function and the power management code both call
+	 * scsi_device_quiesce(), it is not safe to perform domain validation
+	 * while suspend or resume is in progress. Hence the
+	 * lock/unlock_system_sleep() calls.
+	 */
+	lock_system_sleep();
+
 	if (unlikely(spi_dv_in_progress(starget)))
-		return;
+		goto unlock;
=20
 	if (unlikely(scsi_device_get(sdev)))
-		return;
+		goto unlock;
+
 	spi_dv_in_progress(starget) =3D 1;
=20
 	buffer =3D kzalloc(len, GFP_KERNEL);
@@ -1049,6 +1059,8 @@ spi_dv_device(struct scsi_device *sdev)
  out_put:
 	spi_dv_in_progress(starget) =3D 0;
 	scsi_device_put(sdev);
+unlock:
+	unlock_system_sleep();
 }
 EXPORT_SYMBOL(spi_dv_device);
=20
--=20
2.14.1
