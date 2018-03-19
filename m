Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsAZpi05NuUqtIeupEZanjaFW5WBP5KtwJRi9WygECqsE8CeOB7ttq1NB6WeEasdP03/JWU
ARC-Seal: i=1; a=rsa-sha256; t=1521475495; cv=none;
        d=google.com; s=arc-20160816;
        b=m/GSvTLbevnuRjnmtiu5n+XkK3wzICddGJ6cMPEIQjsfEMW1s5m1tujuEvMpAvB9nl
         w5H9Ar8CUkjvrfmr4M3sxtWN2+0Ehc4OMurkD8A5bB3l1V5JRi/wDC5o9EgHonBfQ0a/
         3XM6mft6tIlAYPxfqzgF7PhBztfuBvW+7hJy+tD0frdMweyFnMUdcz+vgcxHGl3YWBkr
         NT0UW2gHY8rprROvEvbhq4nReGOnFawVcZkqaHEiZ+QqWEB3FW6B8AXhLUKkg1DPNSIk
         kCpanJEohCEp7WI6BtL6MpBr74qqItIXNoYnOFbGkLvp2eJNLqrxK7fOSoaVrbpOSw8Q
         Y1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=2R5Ivr5nh8VINZPfiRyASFSiATce8srrxWt7w2Fiyec=;
        b=HQa85WkW1cq9Zk3cTEWATjX9AT2Aphidd4Z7Kgc3mgOjmAdNkxuSWzBigYGqxGIZx/
         vdOvoV2JHVIXgMM6dJzWGp0C28YoP/qa9TngreW/RMKWFcT7H7fbF9OgXedkoJa24c3h
         Vt4s0TFreZ7YjM2Rg/g9dQumFMDbFUN+sMH0cRmvH02kq258DYS6QIK/5fshJFX8U7Gs
         i1C9t1B8puGvUwn6joQEGNv4EqB8T3poDFTWskcPKle5c/qUFEu3Q89Pej1jHaGBAkRk
         xmMa1ZAlF5T476A2PPyQZCd5hty3RBKcSzJoKbdPl9MM3jB/m/tUFlW6Ru+TdRs+tXpv
         nolQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=YLZQNInR;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.131 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=YLZQNInR;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.131 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 235/281] coresight: Fix reference count for
 software sources
Thread-Topic: [PATCH AUTOSEL for 4.9 235/281] coresight: Fix reference count
 for software sources
Thread-Index: AQHTv5uwCHVkpfh/zkuXXWlIgkmLfw==
Date: Mon, 19 Mar 2018 16:02:32 +0000
Message-ID: <20180319155742.13731-235-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:0yFRmo9PxaafYJnlIqWze4Fxbh6MBDC5cb8QVxEnoC11rI/wplj/t6EAK7epW5sMF0hSYhs4+cI8BGlr59qzJ47gyB+7gLF3byFUnE+oYQGRq4lPg6KTBnpSMl4sU6OOhcc97oQLCQdFWHL1Rqm66xn/hzQdV+fAJg7pqilFrWzCSNXToVIk9oBheI2+ZutJLIez5t7scfdpnjt6kAia/xVAb7PosBL6v8yqV8GMKJoM1btyrzCLzScwrO/F5fin;20:Yo9QfllPXzZuBZE9jdm/BL/CoO6lGRGJyLTNA8aMRairkaBAZ29mnwXRZBJdDOJt4jhKMLA9S5UpuF3+l3d7FvgZdGieBfjmyN1Le6nqo3F/Jkd3sYubpBTiNprhBfO7ULHCcYooow3lm82XPxyqDTganCuSKP0pyI9ExvNuP90=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d13b3e39-ae8f-4075-0bab-08d58db32716
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805326BF8C65CE67D845F3DFBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(278428928389397)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(54906003)(3280700002)(316002)(66066001)(22452003)(10290500003)(4326008)(6512007)(72206003)(478600001)(25786009)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(26005)(1076002)(8936002)(3846002)(2950100002)(86362001)(186003)(305945005)(575784001)(3660700001)(5660300001)(6116002)(6666003)(6506007)(59450400001)(102836004)(81156014)(81166006)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sqJuoba578+XrwLcq7n+nv4/bg5VJk3Z/TXtNrk1YU5KuLy1ByerY8UILY9+9wifjQdBGY6BvBt4nmBEGJxgfkMW7vFlbO+SVb7IkpPON3Wd+WKk8uK0ST8yamRcXEC14lZkAGWodEUGDViuifHOqKu2mT4FWNcgiogjMwuEOg4iaEQ2Bwkq5ZIQjPtoe5JUTbY27QlAX2BZMZPH97BjLdjQwP8qV0vzf5cWePtrmoHex7SP44m75asLSLZAiAjKKBXGtLfVdRMFl2fr/xwqzjVQs9zUNQ586xUyq8bDERosk64F2ESVV2xs1NYXl1w8HOI/VKfKFtW9nxZpDTQNnQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13b3e39-ae8f-4075-0bab-08d58db32716
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:32.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382689006532280?=
X-GMAIL-MSGID: =?utf-8?q?1595382689006532280?=
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
2.14.1
