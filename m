Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE94ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCC3208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Sk4b4SRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCC3208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbeIQIjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:39:37 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:15104
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731002AbeIQIbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNhTo553GCVDbdmogVfpjKVgqB/Wj45DTPlXLX8k9zQ=;
 b=Sk4b4SRtbmV6TktH03Mar7mw6VTN+TRyqVF2Gy4Wf4kEczfvYFuiAq4rded+yBUHaUa+/wOpcURFXT4R3GboZ1UEz0ZxrUepmN0f4o+QKKyVb81lrcs87YFizT4rpVfyibXwVONdqq+71PAwy97KrjVaEveHU+FZjB/CXIyV6Qw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:06:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 46/57] HID: hid-ntrig: add error handling for
 sysfs_create_group
Thread-Topic: [PATCH AUTOSEL 4.9 46/57] HID: hid-ntrig: add error handling for
 sysfs_create_group
Thread-Index: AQHUTjMbrXc6LwMIWUyDehndjjK83A==
Date:   Mon, 17 Sep 2018 03:04:11 +0000
Message-ID: <20180917030340.378-46-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:eN3Wj/BhhZQ81MEtfZaRJ1WrrHmg7Vfk85WuNf42M1TdVkxtjsCpHDqf444rWXE2BQV/lC4+CH7Rs1HRYG1rxIy0+l6lglg/+Zj6RESr0qLuEowtY/fPo4BTP/XRuc/RHUpjgpCepeXVVviqddY4HKveyt7mg0GXLUXMT/gwT3UuJVbE7/7OYKDfudmw9BQ+ckb+HUQvv0L1QF2aosKentRbGYngFu3OaH9kJ8ZleE8D2IJ5EAkWuP5cDWCWwJGoF+klJqCPn7/+PF4oh+3Zg9/fJDoFsfcUqbHuonE9GyP4RfiHISarnBkniNg5Q+6XJekBJvawGTQNWhIz8Ua1f2EhekFQ6Ns8+iq3t9YIXq10MBh/kMfpAtEgG/ThfthJtZd8uROqeOrWtZckcriNGhme6wCZh7OROA87cEG5jg08ThU/in0OAtw0ISdc7pzdoXhwUbi9niUglUraMCcK2g==;5:QrrALxEjnIN5xMczVDRATkh2fWLQ1R+k1JHCNkflMN7n8i4QYtd4HI5AnID9agpQ6mKw7b3a08tbOvkYdVkFocRCeT43rQ+gpaXC4nKARuVfLF7Y+N67qlmBDmtwVtmp9TV2yrjmlojos8C+dkP/5tKS/KGv6D3+aJbzu5rIIEY=;7:vXeLSi6XVHLlKOIZFnuv55iTjzgYtfGD1mKOVdduh1U7fuLs2jbOpmzTisggdr10Htq2DKez1lByVFhHltJ9BcKIx9/niYZQGLSjzP6AhNqsUkd28hU/6dtbE8jhbBTH46mH/gKu2fEn+GbUwnrJhLMPfEZJjksBBiQTSO9CcCmKoHkDV+lsoACMWDs328uZgQB+xbjHj3AHdMkDSSTDzqUGO6RBRaiDHPooUJM5JRL1vZrbq/ZXEO+wgSZ90Ynl
x-ms-office365-filtering-correlation-id: c4db0095-ff81-4fed-952c-08d61c4a8c86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB07423F904678D88F619E895DFB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(53936002)(4326008)(3846002)(39060400002)(217873002)(25786009)(2616005)(1076002)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: WBXDXOlvHQFW3GZC086mDzMoxLm/gy5pHZhPj3qXXV2GuWww4UiSV7hMI4P9/oavmIF/DArIECkBgrqXo/09kV/mndJ9udhr0PhE/kFbVj7KHuzaceveit/WNYSlzkWHMsayzrni89YDfZI3cL5N/2P7eIpJIdMYqql5HDVWKbh7tOdovD20uD6igpl1e0bKzTCJke/fwcDSZOHhUteGeRWEzab6zsglQYrFtZYraeEnRtcx/iBc97EVGAcSsIz9XuCdvj9CvU2u/Gz3k6Wobz64Ai13ojPv8A/mGuA2ll5ES+ENHC5o+ERRtktBMg5A8W8V24C9wX6R1KmL4Pn2kZkevS/eeB1o5U+Kwz/fofA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4db0095-ff81-4fed-952c-08d61c4a8c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:11.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 44d4d51de9a3534a2b63d69efda02a10e66541e4 ]

When sysfs_create_group fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling sysfs_create_group.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-ntrig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 1b0084d4af2e..28373dab60ae 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -955,6 +955,8 @@ static int ntrig_probe(struct hid_device *hdev, const s=
truct hid_device_id *id)
=20
 	ret =3D sysfs_create_group(&hdev->dev.kobj,
 			&ntrig_attribute_group);
+	if (ret)
+		hid_err(hdev, "cannot create sysfs group\n");
=20
 	return 0;
 err_free:
--=20
2.17.1
