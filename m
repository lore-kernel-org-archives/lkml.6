Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4/8qBnAgKwMhLsUIJDFlqOZxZ/xqQopHMGZQrSOuro3ChlUDma+DxWgpsWCHGcK8AiqkQWs
ARC-Seal: i=1; a=rsa-sha256; t=1523233604; cv=none;
        d=google.com; s=arc-20160816;
        b=lXSsErb9064WklrE2po93YUJkA+GMvTrNzHPDqTA/NiOSFWrw0Ebr8mi0s7boFYq8r
         6Nqahy35X0FvJQ8L8LqtjPOjVCIeE6Qy5AO6j5NLqbfxVLfvEdRzgybwGSqh5I6K4VqR
         AF6CI3ImDbaLzm/txWD1x0yLgYuBTh3AkvkTEv446YGyoxaHgg/F3eCXwoNuH5sW8DkR
         oO8cbzGP6SBuRv+XUDIBRHW39W3EZNEqOJVkm8gZiKUypyoXXFaC7ERP6oBL7ucgRpUO
         mYMjp4wpjPuwi7ZLrNp+qO7BcSYrUsnVwwH9R5FFA3IbaCSOyHH0n2UGGQDo7NdoRKbo
         Z0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=2ryWCcpzvTqVZnEp2VrgJ+OXBI5PJDwrMzQXP0zoAnI=;
        b=xWxCHNawFLV1Zn9tSWrjR0V977YbFniKcR0HXSR5tML8UM/hJt42pljF5On4L7uy7s
         gC3JssUeIrLue288G3pKW/UR0xoDX1qwFuCXnXpEWD8EMSdR4rNtovz2SAur0XuRnr8a
         jFEuVRmpg2mFw/V53lpioplmao8KMc7qmypvL9A6tNXIBfN3AoEv/gF+pXWvtySasacG
         sD+w2UqJUEsP/qgPJ//S3kwO61UAO2aib0Gz8TEtsvNJ5RVlszft8VMrP26l8z352VNR
         9x4lecIYWfYuyYSxH/qdA5UoGCe4i5vzMJQf511cnaqxR41oEdJS0QqQkMgsHQFWlLxq
         wmaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XSfElTo1;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.132 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XSfElTo1;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.132 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 021/293] coresight: Fix reference count for
 software sources
Thread-Topic: [PATCH AUTOSEL for 4.9 021/293] coresight: Fix reference count
 for software sources
Thread-Index: AQHTz5juRR8fuS0wuUGF4s8gRqbvOw==
Date: Mon, 9 Apr 2018 00:23:06 +0000
Message-ID: <20180409002239.163177-21-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:xKyHSLUFDRUue0yZ19MRDLvH3bsBLphjpfxnrvx+pC/yr1NeXMtDtFca+YiAMrAjWIeNXC6hgVJ/rOUT8y4fGNo8yUsihWrstnwH8RJUrdVyYHOD2ds2QJCxq0BKhNzdWIMvdx8QZ6I8u7zMXYpDU0r1YJnzP1L8hq3gstA+k1n89V3jOCFmpEVcL0Q7nY6au0yew7U0ky5bRq5U3w//tmAzWifVr7HEXjvTbV892HstQrOEpBm989tA4Oy99axw;20:pYKNQpSeMwOEhAsfTU+IAApghoEypNfo43Xg5/hYtK8aeyUQ7hraxnEqYd6P1g09tWpoim5B3dyYfz6fjJgmBL0me3a2SGOwRs/jTENOUkoEE6K/MjSNYKaeSIBVO5VHP8Vkg+gacqPdgiNJW/2sDIvH5//u37MKiQgCBMgeDdw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: af7c97e1-1ea3-4500-08c5-08d59db09165
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885BD7C274E2148A119B1F8FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(278428928389397)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(575784001)(3846002)(305945005)(86362001)(59450400001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: TLAdVloJdDxUUlSiKGjDyaOTJITyjx874i5TIuY6noDlI6DPjZr5xXSCnQYYjonj88q/VOQ+if7hum8DfWIWa/QZWXYXQ+rfZFMQEp3EDazAAmPx+FbY0UQ90yqxt7hizZv81GhGMRd4llMM4lfSfz4C5vZDoF9elYjCHMYQokBytsC3defmQiyCi1jvbuaTDSEFnOKt5lEnJnSqL37DmxXMzbzPf2yx0mTfUM6UBBy/fjSCFlTQ3sGSGj4MHCdczm8ZE3vLNISFHae4lp0wHB5bBuDiH3yuISn36Xra9GxmgCIJoJiv+3JYaKtMz80gxUAtgvkvYVpJydYBZNUXpOTlLVC2FeQ2Z5fWwfOrVrK2BW1YJLT37b7mfcA96hDhzykPREBa6GpW5rO93JteRoUTqXKbCLT38ZQOH02qH8M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7c97e1-1ea3-4500-08c5-08d59db09165
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:06.2529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597226199791438153?=
X-GMAIL-MSGID: =?utf-8?q?1597226199791438153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 022aa1a81b778789ee7cf3124595854276a0330d ]

For software sources (i.e STM), there could be multiple agents
generating the trace data, unlike the ETMs. So we need to
properly do the accounting for the active number of users
to disable the device when the last user goes away. Right
now, the reference counting is broken for sources as we skip
the actions when we detect that the source is enabled.

This patch fixes the problem by adding the refcounting for
software sources, even when they are enabled.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Reported-by: Robert Walker <robert.walker@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/coresight.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/co=
resight/coresight.c
index 7bf00a0beb6f..4383324ec01c 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -498,6 +498,9 @@ int coresight_enable(struct coresight_device *csdev)
 {
 	int cpu, ret =3D 0;
 	struct list_head *path;
+	enum coresight_dev_subtype_source subtype;
+
+	subtype =3D csdev->subtype.source_subtype;
=20
 	mutex_lock(&coresight_mutex);
=20
@@ -505,8 +508,16 @@ int coresight_enable(struct coresight_device *csdev)
 	if (ret)
 		goto out;
=20
-	if (csdev->enable)
+	if (csdev->enable) {
+		/*
+		 * There could be multiple applications driving the software
+		 * source. So keep the refcount for each such user when the
+		 * source is already enabled.
+		 */
+		if (subtype =3D=3D CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE)
+			atomic_inc(csdev->refcnt);
 		goto out;
+	}
=20
 	path =3D coresight_build_path(csdev);
 	if (IS_ERR(path)) {
@@ -523,7 +534,7 @@ int coresight_enable(struct coresight_device *csdev)
 	if (ret)
 		goto err_source;
=20
-	switch (csdev->subtype.source_subtype) {
+	switch (subtype) {
 	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
 		/*
 		 * When working from sysFS it is important to keep track
--=20
2.15.1
