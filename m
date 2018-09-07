Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0619C32783
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C7F2087B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hADcWcwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C7F2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeIGFOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:19 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728506AbeIGFOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEHhMDcZCmoUT3QlcTABTeYIzwiyWLFEzDvzV+UA27U=;
 b=hADcWcwBwmnzGSuMqbgEneZ6ntdG8xhv/yhAyW32tbS4sDFZcSu1ny8BBCR3VSMRa/cOdzzEItI+WlQbJ+7teOEgyLI9MY/cVIXBTUA7tvdvoeA5lr/GEaQB7Q7IOWqb7LGIuWbIiw1QFuwuuFM2BGG4ffqVbix+RyKPls72XcM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:35:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:35:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jeff Crukley <jcrukley@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 09/88] ALSA: usb-audio: Add support for Encore
 mDSD USB DAC
Thread-Topic: [PATCH AUTOSEL 4.18 09/88] ALSA: usb-audio: Add support for
 Encore mDSD USB DAC
Thread-Index: AQHURkK/ns9p/ncm7EuG7fuuL2T+Jw==
Date:   Fri, 7 Sep 2018 00:35:59 +0000
Message-ID: <20180907003547.57567-9-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:tghyqPC6CHWucJjMakx7n9LN6twZp93Up6kwW+qit7VdhyZt7+FV9rDPbB0Q65X/DD0MqnjMLZPLc9QrOg5fFKeXPMFqA9rUkHuYyfthBsni75SEdT5Q5sOhUYbFhLz0JZyEJqOmg93b1IzTdbPJbetRhCajSWf9O1i3Z5+NIwsf17xTHOsHzHmuPnOsdrsW1KzPz2tlCFH4HR4JjPz+p10ByW/G+nzOvTakUt6gFhxoHifnlXfF9lZCOmQruHu2QPwULDDwQbZtEBmMC7jAlfuiJvvGVfOqMpQsv3p1Wp7Y07LgVNM+hRfE40TEj5pL4ORtLknpWdKF2c7ofJnB9DZ9VG5GRwBBYqhK8ijEe5y+muj2Jjc4abSz8fZeYaH+zGxND0ySGa9iiQ2plDXO858qYPI90b6v6oeZmKhLfZ4ole50UDgP7alvHld4iARXdjOD4lQWHQ0LkMkG484iSA==;5:E/zeeddV5QBnHME85c5NX5iXHAZ1UZRyV5kdU0YNbMj0UUcdb7uV912c3Ka0I2PcUfLLeqhr7tC1P1YOvUya2pd4nVqkxxLe9hquyfZuq0OkMS3kxUaJyffGlyzXzKZll78wJxVQJPh2s2Ng4q2ZVxDCZ+syK4kmMgrFBREzM04=;7:KB7Am+2K0zWQKT3Wgc3xf07/RND+qghO0azvrSr4Udvhgmi9wBELgrcGjtLaAUrYIW6HqfVYA+I7yAeRaL5BnTGkGg780390Z5zIp9CYEgFlsaURBaLL3JRpmrByUfRBT/aNddXgFGcLoa/OjAGyalKgN9ej8yCTNry53ifLC5TchPLQRsz7Iwl4KFyJmmoy08yE69Ucvi4Lw7u/svbCmtwxcG+8lRXMq9svzLo7DyyqzmuBSYBVc6TyVLHjfWC0
x-ms-office365-filtering-correlation-id: d5c196e9-9e9a-4072-4602-08d61459e21f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773ED3B0334B41A9461594DFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(39060400002)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +u6tigRMdqK6KtJvOEuE0vkvzIGmr/HmR1fnkuGwAwOurCSUghLsIwfycUL9ZM8jlhZvzVHT8iMeo/2RbKHW3wRxu0jbYNG/IGd7gVDSb0qYKYGm8Uj21junTGWu/H+2gcE/5p7AVrlMT5vBESb+LKbzDashDwl6EqC4Dfhi51V0pfhuImQIu/KZxLomNbDMSvP+UsC6M5GY6iTM34Ns4RP8UU1+5cKYFpJA4frhwRz12SCweBn06mJw2gbIZMui+Jawwh60IXjZLMkFlRk3Lu1glVZQoeVXp9fyztgE1tA6Bp9OMx3m0uekFolgYSAqr+hhP62qdo5Yl4zGB56cCJY8+8lJF3BrWHk5F3A/tR8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c196e9-9e9a-4072-4602-08d61459e21f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:35:59.5827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Crukley <jcrukley@gmail.com>

[ Upstream commit b080dc5bd0dfc0b33c6cfc31f909c93d5e63c186 ]

This patch adds native DSD playback support for the Encore mDSD USB DAC by
specifying the vendor and product ID's

Signed-off-by: Jeff Crukley <jcrukley@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 02b6cc02767f..6fbafce0aa6b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1373,6 +1373,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_us=
b_audio *chip,
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
=20
+	case USB_ID(0x16d0, 0x09dd): /* Encore mDSD */
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
 	case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
 	case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
--=20
2.17.1
